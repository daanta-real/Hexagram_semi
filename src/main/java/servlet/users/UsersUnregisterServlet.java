package servlet.users;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.UsersDao;
import beans.UsersDto;
import util.UsersUtils;

@WebServlet(urlPatterns="/users/unregister.nogari")
public class UsersUnregisterServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//회원탈퇴 처리 서블릿
	try {
		//입력값: 아이디(세션), 비밀번호(파라미터)
		String sessionId = (String)req.getSession().getAttribute("usersId");
		String usersPw = req.getParameter("usersPw");
		System.out.println("usersId = '" + sessionId + "', usersPw = '" + usersPw);
		
		//입력한 아이디와 비밀번호가 일치하는 회원인지 확인
		UsersDto usersDto;
		usersDto = UsersUtils.getValidDto(sessionId, usersPw);
		boolean canUnregister = usersDto.getUsersPw().equals(usersPw);
		
		//회원삭제 기능 
		UsersDao usersDao = new UsersDao();
		boolean unregister = usersDao.delete(sessionId);  
		
		if(usersDto != null && canUnregister) {
			System.out.println("[회원탈퇴] 가능. 세션 삭제");
			//아이디,비번이 일치하는 회원이 맞다면 탈퇴
			unregister = true;
			//세션에 저장된 값 삭제(=로그아웃)
			req.getSession().removeAttribute("usersIdx");
			req.getSession().removeAttribute("usersId");
			req.getSession().removeAttribute("usersGrade");
			//탈퇴 완료 페이지로 이동
			resp.sendRedirect(req.getContextPath()+"/users/unregister_success.jsp");
			System.out.println("[회원탈퇴] 완료");
		}
		else if(usersDto != null && !canUnregister) {
			//회원탈퇴실패시 회원탈퇴입력 페이지로 다시 이동
			unregister = false;
			System.out.println("[회원탈퇴] 실패");
			resp.sendRedirect(req.getContextPath()+"/users/unregister.jsp?fail");
		}
		else {
			//회원탈퇴실패시 회원탈퇴입력 페이지로 다시 이동
			unregister = false;
			System.out.println("[회원탈퇴] 실패");
			resp.sendRedirect(req.getContextPath()+"/users/unregister.jsp?fail");
		}
	}
	catch(Exception e) {
		System.out.println("[회원탈퇴] 에러발생");
		e.printStackTrace();
		resp.sendError(500);
	}
	}
}
