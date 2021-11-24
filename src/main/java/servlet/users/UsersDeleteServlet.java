package servlet.users;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.UsersDao;
import util.users.HashChecker;
import util.users.Sessioner;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/users/unregister.nogari")
public class UsersDeleteServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 0. 변수준비
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=utf-8");
			HttpSession session = req.getSession();
			String sessionId    = Sessioner.getUsersId(session);    // 내가 로그인한 내 ID
			String sessionGrade = Sessioner.getUsersGrade(session); // 내 회원등급
			String inputPw      = req.getParameter("usersPw");      // 탈퇴 확인용 비밀번호
			UsersDao dao = new UsersDao();
			System.out.println("[회원 탈퇴 - 유저가 요청] 0. 변수준비.. "
				+ "내 세션Id: '" + sessionId + "' / 내 회원등급: '" + sessionGrade + "'");

			// 로그인했는지 검사 생략. 필터가 체크하므로 여기서 할 필요 없다.

			// 1. 내 아이디 PW 일치여부 검사
			System.out.print("[회원 탈퇴 - 유저가 요청] 1. PW 일치 검사.. ");
			boolean isValid = HashChecker.idPwMatch(sessionId, inputPw, dao);
			System.out.println("확인 결과: " + isValid);
			if(!isValid) {
				System.out.println("PW가 일치하지 않습니다. 탈퇴 불가.");
				resp.sendRedirect(req.getContextPath()+"/users/unregister.jsp?fail");
				return;
			}
			System.out.println("PW가 일치합니다. 탈퇴를 진행합니다.");

			// 2. 전송
			System.out.print("[회원 탈퇴 - 유저가 요청] 2. 탈퇴 실행..(" + sessionId + ").. ");
			boolean isSucceed = dao.delete(sessionId);
			if(!isSucceed)  {
				System.out.println("탈퇴 실패.");
				resp.sendRedirect(req.getContextPath()+"/users/unregister.jsp?fail");
				return;
			}
			System.out.println("탈퇴 성공.");

			// 3. 결과를 세션에 반영
			System.out.println("[회원 탈퇴 - 유저가 요청] 3. 탈퇴 결과를 세션에 반영.. ");
			Sessioner.logout(session);
			System.out.println("탈퇴 결과 세션 반영 완료.");

			// 4. 탈퇴 성공 페이지로 리다이렉트 실시
			System.out.print("[회원 탈퇴 - 유저가 요청] 4. 탈퇴 성공 페이지로 리다이렉트 실시.");
			resp.sendRedirect(req.getContextPath()+"/users/unregister_success.jsp");
			return;

		}

		catch(Exception e) {

			System.out.println("\n[회원 탈퇴] 에러가 발생했습니다.");
			e.printStackTrace();
			resp.sendError(500);

		}
	}
}