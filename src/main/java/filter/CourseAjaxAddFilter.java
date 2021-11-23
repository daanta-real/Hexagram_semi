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

import util.users.Sessioner;

@WebFilter(urlPatterns = {
		"/course/insert_sequence.nogari",
		"/course/insert.jsp",
		"/course/ajax_item_add.nogari",
		"/course/ajax_delete_item.nogari",
		"/course/insert_last.jsp",
		"/course/insert_course.nogari"
})
public class CourseAjaxAddFilter implements Filter{
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		try {
			req.setCharacterEncoding("UTF-8");

			//현재 접속한 사람을 확인한다.
			String usersId = Sessioner.getUsersId(req.getSession());
			if(usersId == null) {
				resp.sendError(401); // 비회원이라면 일단 차단
			}else {
				chain.doFilter(request, response); //비 회원이 아니라면 통과
			}

		}catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}

	}

}
