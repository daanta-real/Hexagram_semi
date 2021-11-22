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

import beans.UsersDao;
import beans.UsersDto;
import util.users.Sessioner;
@WebFilter(urlPatterns = {
		"/item_reply/insert.nogari",
		"/course_reply/insert.nogari"
})
public class ReplySelfFilter implements Filter{
	//댓글 작성자가 현재 접속한 사람과 같은지 확인하는 필터임(코스 , 아이템 , 이벤트 공통 사항임) - 즉 회원이 다른경로로 혹은 비회원이 직접 접근할떄 막아주는 역할
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;
		try {
			
			int usersIdx = Integer.parseInt(req.getParameter("usersIdx")); // 댓글 작성한 사람을 받는다.
			String usersId  = Sessioner.getUsersId(req.getSession());//현재 접속 회원 아이디 확인
			
			//관리자인가?
			boolean isManager = usersId != null && usersId.equals(Sessioner.GRADE_ADMIN);
			
			if(usersId == null){
				resp.sendError(401); //비회원이라면 허가되지 않음
			}else {
				UsersDao usersDao = new UsersDao();
				UsersDto usersDto = usersDao.get(usersIdx); //전달 받은 댓글 작성자 인덱스에 있는 정보를 통해 회원의 정보 추출
				
				if(usersDto.getUsersId().equals(usersId) || isManager) {
					chain.doFilter(request, response); //전달받은 글쓴이와 현재 접속자가 동일할때 통과 또는 관리자라면!
				}else {
					resp.sendError(403);//회원이지만 본인이 다른 경로를 통해서(주소를 통해서) 왔을 경우 오류를 보여준다.
				}
			
			}
		}catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}

}
