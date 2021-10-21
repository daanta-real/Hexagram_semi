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
@WebServlet("/usersDetail")
public class UsersGetServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException { try {

		System.out.println("[회원 상세]");

		UsersDto dto = new UsersDao().get(req.getParameter("id"));
		System.out.println(dto);

	} catch (Exception e) { e.printStackTrace(); } }
}