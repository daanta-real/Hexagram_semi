package workspace.daanta.servlet;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import workspace.daanta.util.Library;

@SuppressWarnings("serial")
@WebServlet("/usersLogout")
public class UsersLogoutServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 0. 준비
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/plain;charset=utf-8");
			HttpSession session = req.getSession();
			String sessionId = (String) session.getAttribute("id");

			// 1. 기 로그아웃 검사: 이미 로그아웃되어 session의 id가 없으면 에러처리
			System.out.print("1. 로그아웃 검사(이미 로그아웃 되어있는지 검사)..");
			if (!Library.isExists(sessionId)) throw new Exception();
			System.out.println("로그아웃되어 있지 않습니다.");

			// 2. 로그아웃 처리
			System.out.println("2. 로그아웃 처리..");
			session.invalidate();
			System.out.println("완료.");

		} catch (Exception e) {
			System.out.println("에러");
			e.printStackTrace();
		}
	}

}
