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

import util.HexaLibrary;

// 관리자 페이지 대상.
@WebFilter( urlPatterns = {
	"/users/list.nogari"
} )
public class AdminFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

		// 준비
		HttpServletRequest req = (HttpServletRequest)request;
		System.out.println("[필터 작동 - 관리자 검사] from " + req.getRequestURL().toString());

		// 세션 검사 - grade가 정확히 관리자여야만 함.
		String sessionGrade = (String) req.getSession().getAttribute("usersGrade");
		if(!HexaLibrary.isExists(sessionGrade) && sessionGrade.equals("관리자")) {
			System.out.println("[필터] 관리자가 아닙니다. (등급: '" + sessionGrade + "') 관리자 필터 통과 실패.");
			((HttpServletResponse) response).sendError(401); // 로그인페이지로 이동
		}

		// 다음 필터로 넘김
		System.out.println("[필터] 관리자가 맞습니다. 관리자 필터 통과.");
		chain.doFilter(request, response);

	}

}
