import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/usersUnregister")
public class ServletUserDelete extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException { try {

		req.setCharacterEncoding("UTF-8");
		System.out.println("[회원 삭제]");

		// 값 받아옴
		String id = req.getParameter("id");

		// 빈값쳐내기
		if(id == null || id.trim().length() == 0) { System.out.println("id 값이 입력되지 않았습니다."); return; }
		// 값 검사: 양식에 맞지 않는 값은 쳐내기
		// 작성 예정

		// 전송
		System.out.println("회원삭제 요청: " + id);
		System.out.println("회원삭제 결과: " + new UsersDao().delete(id));

	} catch (ClassNotFoundException | SQLException e) { e.printStackTrace(); } }
}