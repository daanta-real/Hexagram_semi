package servlet.users;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.UsersDao;

@WebServlet(urlPatterns="/admin/users/unregister.nogari")
public class AdminUsersDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//회원 탈퇴 처리를 위한  usersId 파라미터 값
			String usersId = req.getParameter("usersId");
			
			//탈퇴 처리
			UsersDao usersDao = new UsersDao();
			boolean isDelete = usersDao.delete(usersId);
			
			//탈퇴 성공시 회원목록 페이지로 돌아가기
			if(isDelete) {
				resp.sendRedirect(req.getContextPath()+"/admin/users/list.jsp?delete&usersId="+usersId);
			}
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}
}
