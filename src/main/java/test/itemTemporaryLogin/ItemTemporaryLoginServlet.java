package test.itemTemporaryLogin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/item/login.nogari")
public class ItemTemporaryLoginServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			/*UsersDao usersDao = new UsersDao();
			UsersDto usersDto = usersDao.login(req.getParameter("usersId"),req.getParameter("usersPw"));


			if(usersDto != null) {
				req.getSession().setAttribute("usersID", usersDto.getUsersId());
				req.getSession().setAttribute("usersIdx", usersDto.getUsersIdx());
				req.getSession().setAttribute("usersGrade", usersDto.getUsersGrade());

				resp.sendRedirect(req.getContextPath()+"/item/main.jsp");
			}else {
				resp.sendRedirect(req.getContextPath()+"/item/main_before.jsp?error");
			}*/


		}catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
