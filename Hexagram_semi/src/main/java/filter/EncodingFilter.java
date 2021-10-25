package filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

// 모든 JSP 파일, 모든 서블릿 파일 대상. (각종 설정파일 등 제외)
@WebFilter( urlPatterns = {"*.jsp", "*.nogari"} )
public class EncodingFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest)request;
		System.out.println("필터 작동 - 인코딩. 해당page: " + req.getRequestURL().toString());

		// 인코딩을 UTF-8로 강제
		request.setCharacterEncoding("UTF-8");

		// 다음 필터로 넘김
		chain.doFilter(request, response);
	}

}
