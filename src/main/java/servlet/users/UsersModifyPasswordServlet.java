package servlet.users;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.UsersDao;
import beans.UsersDto;

@WebServlet(urlPatterns="/users/modifyPassword.nogari")
public class UsersModifyPasswordServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//비밀번호 변경처리 서블릿
	try {
		//입력값 : usersId, usersPw, pwUpdate
		HttpSession session = req.getSession();
		String sessionId = (String) session.getAttribute("usersId");
		String usersPw = req.getParameter("usersPw");
		String pwUpdate = req.getParameter("pwUpdate");
		System.out.println("usersId = " + sessionId
									+ ", usersPw = " + usersPw
									+ ", pwUpdate = " + pwUpdate);
		
		//비밀번호 검사
		UsersDao usersDao = new UsersDao();
		UsersDto usersDto;
		//아이디에 해당하는 회원정보가 있는지 조회
		usersDto = usersDao.get(sessionId);
		//입력한 현재비밀번호와 세션아이디로 조회한 비밀번호가 일치하고
		//현재 비밀번호와 변경할 비밀번호가 다르다면 비밀번호 변경 가능
		boolean pwValid = usersDto.getUsersPw().equals(usersPw)
									&& !usersDto.getUsersPw().equals(pwUpdate);
		boolean updatePw = usersDao.updatePw(usersDto, pwUpdate);
		
		if(pwValid) {
			System.out.println("[비밀번호변경] 가능");
			updatePw = true;
			//비밀번호 변경성공하면 성공페이지로 이동
			resp.sendRedirect(req.getContextPath()+"/users/modify_success.jsp");
		}
		else {
			System.out.println("[비밀번호변경] 불가능");
			updatePw = false;
			//변경 실패시 다시 비밀번호변경 페이지로 이동
			resp.sendRedirect(req.getContextPath()+"/users/modifyPassword.jsp?fail");
		}
		
	}
	catch(Exception e) {
		System.out.println("[비밀번호변경] 에러 발생");
		e.printStackTrace();
		resp.sendError(500);
	}
	}
}
