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
		"/course/udpate_sequence.nogari",
		"/course/update.jsp",
		"/course/ajax_item_update.nogari",
		"/course/ajax_delete_update_item.nogari",
		"/course/update_last.jsp",
		"/course/update_course.nogari"
})
public class CourseAjaxUpdateFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		try {
			req.setCharacterEncoding("UTF-8");
			//최초 수정 시퀀스를 생성한 사람의 아이디를 넘겨받는다.
			String usersFilterId = req.getParameter("usersFilterId");

			//현재 접속한 사람을 확인한다.
			String usersId = Sessioner.getUsersId(req.getSession());

			//현재 접속한 사람이 관리자인지 확인한다.
			boolean isManager = usersId != null && usersId.equals(Sessioner.GRADE_ADMIN);

			if(usersId == null) {
				resp.sendError(401); // 비회원이라면
			}else {

				if(usersId.equals(usersFilterId) || isManager) {
					chain.doFilter(request, response);
					//현재 접속자가 최초로 수정 시퀀스를 부여받아 글 수정을 하며, 또는 관리자라면 아이템-코스에 대한 수정,삭제 권한을 가진다.

				}else{
					resp.sendError(403); //로그인도 되어있고 회원이지만 본인 최촐 시퀀스를 부여받아 진행하지 않았다면 권한 에러,

				}
				}


		}catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}

	}

}
