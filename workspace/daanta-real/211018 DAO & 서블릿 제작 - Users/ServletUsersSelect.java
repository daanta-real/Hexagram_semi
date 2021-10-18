import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/usersList")
public class ServletUsersSelect extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException { try {

		System.out.println("[회원 목록]");

		List<UsersDto> usersDto = new UsersDao().select();
		for(UsersDto dto_one: usersDto) System.out.println(dto_one);

	} catch (ClassNotFoundException | SQLException e) { e.printStackTrace(); } }
}