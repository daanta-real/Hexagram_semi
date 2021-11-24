package servlet.users.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.UsersDao;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/admin/users/unregister.nogari")
public class AdminUsersDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 1. 변수 준비
			String usersId = req.getParameter("usersId");
			System.out.println("[관리자 - 회원탈퇴] 시도. 아이디 : " + usersId);

			// 2. 탈퇴 처리
			UsersDao usersDao = new UsersDao();
			boolean isDeleteSucceed = usersDao.delete(usersId);

			// 3. 탈퇴 성패에 따른 대응
			//    1) 탈퇴 실패 시 예외 던짐
			if(!isDeleteSucceed) throw new Exception();
			//    2) 탈퇴 성공 시 회원목록 페이지로 돌아가기
			System.out.println("[관리자 - 회원탈퇴] 성공.");
			resp.sendRedirect(req.getContextPath()+"/admin/users/list.jsp?delete&usersId=" + usersId);
			return;

		}

		catch(Exception e) {

			System.out.println("[관리자 - 회원탈퇴] 오류가 발생했습니다.");
			e.printStackTrace();
			resp.sendError(500);
		}

	}
}
