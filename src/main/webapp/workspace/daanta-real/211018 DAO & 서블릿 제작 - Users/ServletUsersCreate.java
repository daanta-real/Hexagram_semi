import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/usersJoin")
public class ServletUsersCreate extends HttpServlet {
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
		dto.setId(id);
		dto.setPw(pw);
		dto.setNick(nick);
		dto.setEmail(email);
		dto.setGrade(grade);

		// 전송
		System.out.println("회원가입 요청: " + dto);
		System.out.println("회원가입 결과: " + new UsersDao().insert(dto));

	} catch (ClassNotFoundException | SQLException e) { e.printStackTrace(); } }
}