package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.users.Sessioner;

// 관리자 페이지 대상.
@WebFilter( urlPatterns = {
	"/admin/*",
	"/event/write.jsp",
	"/event/insert.nogari",
	"/item/edit.jsp","/item/edit.nogari",
	"/item/insert.jsp","/item/insert.nogari", //누구나 등록하지 못하게 설정
	"/item/delete.nogari"
	//아이템 항목들 => 403번 에러 발동하게 수정해야함..?
} )
public class AdminFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

		try {

			// 0. 변수준비
			HttpServletRequest req = (HttpServletRequest)request;
			HttpSession session = req.getSession();
			System.out.println("[필터 작동 - 관리자 검사] from " + req.getRequestURL().toString());

			// 1. 등급 검사 - grade가 정확히 관리자여야만 함.
			boolean isAdmin = Sessioner.isAdmin(session);

			// 2. 세션 검사 결과에 따른 작동
			// 관리자가 아닐 경우
			if(!isAdmin) {
				System.out.println("[필터 작동 - 관리자 검사] 관리자가 아닙니다. (등급: '" + (String) session.getAttribute("usersGrade") + "') 관리자 필터 통과 실패.");
				throw new Exception();
			}
			// 관리자일 경우 다음 필터로 넘김
			else {
				System.out.println("[필터 작동 - 관리자 검사] 관리자가 맞습니다. 관리자 필터 통과.");
				chain.doFilter(request, response);
			}

		} catch(Exception e) {

			System.out.println("[필터 작동 - 관리자 검사] 처리 중에 에러 발생. 로그인 필요하여 로그인 화면으로 이동합니다.");
			e.printStackTrace();
			((HttpServletResponse)response).sendError(401);

		}

	}

}
