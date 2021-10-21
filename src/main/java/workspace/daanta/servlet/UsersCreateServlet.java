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
@WebServlet("/usersJoin")
public class UsersCreateServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException { try {

		System.out.println("[회원 가입]");

		// 값 받아옴
		String id    = req.getParameter("id");
		String pw    = req.getParameter("pw");
		String nick  = req.getParameter("nick");
		String email = req.getParameter("email");
		String grade = req.getParameter("grade");

		// 값 검사: 양식에 맞지 않는 값은 쳐내기
		// 작성 예정

		// 삽입할 DTO 준비
		UsersDto dto = new UsersDto();
		dto.setUsersId(id);
		dto.setUsersPw(pw);
		dto.setUsersNick(nick);
		dto.setUsersEmail(email);
		dto.setUsersGrade(grade);

		// 전송
		System.out.println("회원가입 요청: " + dto);
		System.out.println("회원가입 결과: " + new UsersDao().insert(dto));

	} catch (Exception e) { e.printStackTrace(); } }
}