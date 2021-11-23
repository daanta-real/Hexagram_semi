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

import beans.CourseItemDao;
import util.users.Sessioner;

@WebFilter(urlPatterns = {
		"/course/insert_last.jsp",
		"/course/insert_course.nogari"
})
public class CourseAjaxCountItemFilter implements Filter{
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		try {
			//위의 두 insert파트는 적어도 아이템_코스 항목이 3개이상 8개 이하라는 것이 검증되어야 통과가 될 수 있다.
			req.setCharacterEncoding("UTF-8");
			//현재 발급되었고, 코스를 생성하기 전 코스_아이템에 등록된 아이템의 갯수를 파악하기 위해 인자를 받는다.
			int courseSequnce = Integer.parseInt(req.getParameter("courseSequnce"));

			CourseItemDao courseItemDao = new CourseItemDao();
			//해당 코스 번호에 등록된 갯수를 파악한다.
			int count = courseItemDao.getCount(courseSequnce);
			
			if(count >= 3 && count <= 8) {
				chain.doFilter(request, response);
				//아이템-코스에 등록된 수가 3개 이상 8개 이하라면 통과.
			}else {
				resp.sendError(500);
				//그렇지 않다면 에러 발생.
			}

		}catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}

	}

}
