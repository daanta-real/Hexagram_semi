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
@WebFilter( urlPatterns = {"*.jsp", "*.nogari"} )
public class EncodingFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

		try {

			// 0. 변수준비
			System.out.println("[필터 작동 - 인코딩] from " + ((HttpServletRequest) request).getRequestURL().toString());

			// 1. request의 인코딩을 UTF-8로 강제
			request.setCharacterEncoding("UTF-8");
			System.out.println("[필터 작동 - 인코딩] request의 인코딩을 UTF-8로 설정합니다.");

			// 2. response의 인코딩을 UTF-8로 강제
			response.setContentType("text/html;charset=utf-8");
			System.out.println("[필터 작동 - 인코딩] response의 인코딩을 UTF-8로 설정합니다.");

			// 3. 다음 필터로 넘김
			System.out.println("[필터 작동 - 인코딩] 인코딩 설정을 완료하였습니다. 인코딩 필터 통과.");
			chain.doFilter(request, response);

		} catch(Exception e) {

			System.out.println("[필터] 처리 중에 에러 발생");
			e.printStackTrace();
			((HttpServletResponse)response).sendError(500);

		}

	}

}
