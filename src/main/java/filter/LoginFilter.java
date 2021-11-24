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

// 로그인한 사용자만 접근 필요한 경우 사용하는 필터
@WebFilter( urlPatterns = {
	"/admin/*",
	"/users/register_success.jsp",
	"/users/unregister.jsp",
	"/users/unregister.nogari",
	"/users/detail.jsp",
	"/users/modify.jsp",
	"/users/modify.nogari",
	"/users/modify_success.jsp",
	"/users/modifyPassword.jsp",
	"/users/modifyPassword.nogari",
	"/users/logout.nogari",
	"/items/insert.jsp"
} )
public class LoginFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

		try {

			// 0. 변수준비
			HttpServletRequest req = (HttpServletRequest)request;
			HttpSession session = req.getSession();
			System.out.println("[필터 작동 - 로그인 검사] from " + req.getRequestURL().toString());

			// 1. 세션 검사
			boolean isLoggedIn = Sessioner.isLoggedIn(session);

			// 2. 세션 검사 결과에 따른 작동
			// 로그인 상태가 아닐 경우
			if(!isLoggedIn) {
				System.out.println("[필터 작동 - 로그인 검사] 로그인되지 않아 로그인 검사 필터를 통과하지 못했습니다. (세션ID:'" + Sessioner.getUsersId(session) + "') 로그인 필터 통과 실패.");
				throw new Exception();
			}
			// 세션이 있을 경우
			else {
				System.out.println("[필터 작동 - 로그인 검사] 로그인 확인됨. 로그인 필터 통과.");
				chain.doFilter(request, response);
			}

		} catch(Exception e) {

			System.out.println("[필터 작동 - 로그인 검사] 처리 중에 에러 발생");
			e.printStackTrace();
			((HttpServletResponse)response).sendError(401); // 로그인페이지로 이동

		}

	}

}
