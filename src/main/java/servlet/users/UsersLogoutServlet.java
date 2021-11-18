package servlet.users;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.users.Sessioner;

@SuppressWarnings("serial")
@WebServlet("/users/logout.nogari")
public class UsersLogoutServlet extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 0. 준비
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/plain;charset=utf-8");
			HttpSession session = req.getSession();
			String sessionId = Sessioner.getUsersId(session);
			System.out.print("[회원 로그아웃] 0. 현재 sessionId = " + sessionId);

			// 1. 기 로그아웃 검사는 하지 않는다. 무조건 로그아웃시켜야 하는 경우도 있을 수 있으므로 없앴다.

			// 2. 로그아웃 처리
			System.out.print("[회원 로그아웃] 1. 로그아웃 처리..");
			Sessioner.logout(session);

			// 3. 로그아웃을 성공적으로 끝냈으면 메인 페이지로 리다이렉트
			System.out.println("[회원 로그아웃] 2. 세션 비우기 완료.");
			resp.sendRedirect(req.getContextPath()+"/index.jsp");

		}

		catch(Exception e) {

			System.out.println("[회원 로그아웃] 에러가 발생했습니다.");
			e.printStackTrace();
			resp.sendError(500);

		}
	}

}
