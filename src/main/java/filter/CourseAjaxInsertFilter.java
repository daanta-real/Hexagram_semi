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
public class CourseAjaxInsertFilter implements Filter{
	//목적 : 코스가 생성되기 전이기 떄문에 임시로 발급된 코스 번호에 대해서 등록, 수정할시에,
	//누구든 침범하여서 그 정보를 수정할 수 있다.
	//특히 add 나 update의 경우 생성시 or 생성 도중 나간경우 껍데기 courseIdx가 생성이 되는데 이부분에 대해서도 필터로 확실한 처리를 해주어야 한다.
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		try {
			req.setCharacterEncoding("UTF-8");
			//최초 시퀀스를 생성한 사람의 아이디를 넘겨받는다.
			String usersFilterId = req.getParameter("usersFilterId");
			//현재 접속한 사람을 확인한다.
			String usersId = Sessioner.getUsersId(req.getSession());
			//관리자인가?
			boolean isManager = usersId != null && usersId.equals(Sessioner.GRADE_ADMIN);

			if(usersId == null) {
				resp.sendError(401); // 비회원이라면
			}else if(usersFilterId.equals(usersId) || isManager) {
				chain.doFilter(request, response); //글 작성자이거나, 관리자라면 아이템-코스에 대한 추가,수정,삭제 권한을 가진다.
			}else {
				resp.sendError(403); //로그인도 되어있고 회원이지만 본인 글이 아니라면 권한 부족
			}

		}catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}

	}

}
