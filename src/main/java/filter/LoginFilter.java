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

// 모든 JSP 파일, 모든 서블릿 파일 대상. (각종 설정파일 등 제외)
@WebFilter( urlPatterns = {
	"/users/tableInitializer.jsp",
	"/users/join_success.jsp",
	"/items/insert.jsp"
} )
public class LoginFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

		try {

			// 0. 변수준비
			HttpServletRequest req = (HttpServletRequest)request;
			System.out.println("[필터 작동 - 로그인 검사] from " + req.getRequestURL().toString());

			// 1. 세션 검사
			String sessionId = (String) req.getSession().getAttribute("usersId");
			boolean hasSession = sessionId != null && !sessionId.equals("");

			// 2. 세션 검사 결과에 따른 작동
			// 세션이 없을 경우
			if(!hasSession) {
				System.out.println("[필터 작동 - 로그인 검사] 로그인되지 않아 로그인 검사 필터를 통과하지 못했습니다. (세션ID:'" + sessionId + "') 로그인 필터 통과 실패.");
				((HttpServletResponse) response).sendError(401); // 로그인페이지로 이동
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
