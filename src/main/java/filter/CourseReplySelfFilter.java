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

import beans.CourseReplyDao;
import beans.CourseReplyDto;
import beans.UsersDao;
import beans.UsersDto;
import util.users.Sessioner;

@WebFilter(urlPatterns = {
		"/course_reply/delete.nogari",
		"/course_reply/edit.nogari"
})
public class CourseReplySelfFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		try {
			req.setCharacterEncoding("UTF-8");
			int courseReplyIdx  = Integer.parseInt(req.getParameter("courseReplyIdx"));//해당 댓글 번호 받기
			CourseReplyDao courseReplyDao = new CourseReplyDao();
			CourseReplyDto courseReplyDto = courseReplyDao.get(courseReplyIdx);
			
			String usersId  = Sessioner.getUsersId(req.getSession());//현재 접속 회원 아이디 확인
			
			//관리자인가?
			boolean isManager = usersId != null && Sessioner.getUsersGrade(req.getSession()).equals(Sessioner.GRADE_ADMIN);
			
			if(courseReplyDto==null) {
				//댓글이 없다면,
				resp.sendError(404); //없음 표시
			}else if(usersId == null){
				resp.sendError(401); //비회원이라면 허가되지 않음
			}else {
				UsersDao usersDao = new UsersDao();
				UsersDto usersDto = usersDao.get(courseReplyDto.getUsersIdx()); //전달 받은 댓글 번호에 있는 정보를 통해 회원의 정보 추출
				
				if(usersDto.getUsersId().equals(usersId) || isManager) {
					chain.doFilter(request, response); //전달받은 댓글번호의 주인공과 현재 접속자가 동일할때 통과 또는 관리자라면!
				}else {
					resp.sendError(403);//회원이지만 본인의 댓글이 아니면 권한이 없음을 표시.
				}
				
			}
		}catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}

}
