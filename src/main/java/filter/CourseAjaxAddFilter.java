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

import beans.CourseDao;
import util.users.Sessioner;

@WebFilter(urlPatterns = {
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
				//회원이라면
				
				//이 부분은 등록 시에 반드시 시쿼스 생성 서블릿을 거쳐와야한다는 것을 의미한다.
				
				// 수정 부분도 임시 코스 번호가 생성된다는 점은 같지만, 필터를 많이 쓰고 DB에 많이 들리게 되면 성능저하가 발생 할 수 있으므로,
				// 수정에서는 기존 코스번호를 통해서 현재 회원과 비교를 할 수 있으므로 등록 부분만 이 필터를 적용키로 한다.
				
				//임시 생성한 시퀀스 번호를 받는다
				int courseSequnce = Integer.parseInt(req.getParameter("courseSequnce"));
				
				CourseDao courseDao = new CourseDao();
				
				//현재까지 생성된 시퀀스 번호를 확인한다(등록이나 수정을 할때마다 발급되므로 실시간으로 현재 시퀀스 번호가 바뀔 수 있다.)
				//하지만 이 생성된 번호들 보다는 큰 값을 주소에 넣어서 마음대로 처리하는 것들을 방지해줄 수 있다.
				int currSequnce = courseDao.getCurrSequence();
				if(courseSequnce>currSequnce) { //임시번호가 즉 코스가 등록되기 전까지 전달되는 코스번호가 DB에서 생성하여 발급된 번호보다 클 경우
					resp.sendError(500);
				}else {
					chain.doFilter(request, response); //임시 번호가 현재 번호보다 같거나 작을경우(작을 경우는 다른 사람들이 동시에 코스 등록이나 수정을 했을 경우에 발생할 가능성이 있다.) 
				}

			}

		}catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}

	}

}
