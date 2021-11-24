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
import beans.CourseDto;
import beans.UsersDao;
import beans.UsersDto;
import util.users.Sessioner;

@WebFilter(urlPatterns = {
		"/course/delete.nogari"
})
public class CourseDeleteFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		try {
			req.setCharacterEncoding("UTF-8");
			//해당 코스번호를 받는다.
			int courseIdx = Integer.parseInt(req.getParameter("courseSequnce"));
			
			CourseDao courseDao = new CourseDao();
			//코스에 대한 상세정보를 가져온다.=> usersIdx를 알아내기 위해서.
			CourseDto courseDto = courseDao.get(courseIdx);

			String usersId = Sessioner.getUsersId(req.getSession());
			//현재 접속한 사람이 관리자인지 확인한다.
			boolean isManager = usersId != null && Sessioner.getUsersGrade(req.getSession()).equals(Sessioner.GRADE_ADMIN);
			
			if(courseDto == null) {
				resp.sendError(404); //대상 게시글이 없으면 404(잘못된 번호)
			}else if(usersId == null) {
				resp.sendError(401); // 비회원이라면
			}else {
				UsersDao usersDao = new UsersDao();
				UsersDto usersDto = usersDao.get(courseDto.getUsersIdx());
				
				if(usersId.equals(usersDto.getUsersId())||isManager) {
					chain.doFilter(request, response); //본인 아이디와 일치한다면, 또는 관리자라면 통과
				}else {
					resp.sendError(403); //로그인도 되어있고 회원이지만 본인 글이 아니라면 권한 부족
				}
			}
		
		}catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}

}
