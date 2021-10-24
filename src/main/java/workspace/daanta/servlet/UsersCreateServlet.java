package workspace.daanta.servlet;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import workspace.daanta.beans.UsersDao;
import workspace.daanta.beans.UsersDto;

@SuppressWarnings("serial")
@WebServlet("/users/join.nogari")
public class UsersCreateServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException { try {

		System.out.println("[회원 가입]");

		// 값 받아옴
		String usersId = req.getParameter("usersId");
		String usersPw = req.getParameter("usersPw");
		String usersNick = req.getParameter("usersNick");
		String usersEmail = req.getParameter("usersEmail");

		// 값 검사: 양식에 맞지 않는 값은 쳐내기
		// 작성 예정

		// 삽입할 DTO 준비
		UsersDto dto = new UsersDto();
		dto.setUsersId(usersId);
		dto.setUsersPw(usersPw);
		dto.setUsersNick(usersNick);
		dto.setUsersEmail(usersEmail);

		// 전송
		System.out.println("회원가입 요청: " + dto);
		boolean isSucceed = new UsersDao().insert(dto);
		System.out.println("회원가입 결과: " + isSucceed);

		// 후처리
		if(isSucceed) {
			// 세션 부여하고 가입성공 페이지로 보냄
			req.getSession().setAttribute("id", usersId);
			resp.sendRedirect(req.getContextPath() + "jsp/users/join_success.jsp");
		}
		else resp.sendError(500);

	} catch (Exception e) { e.printStackTrace(); } }
}