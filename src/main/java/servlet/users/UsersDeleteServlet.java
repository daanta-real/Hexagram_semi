package servlet.users;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.UsersDao;
import util.HexaLibrary;
import util.UsersUtils;

@SuppressWarnings("serial")
@WebServlet("/usersUnregister")
public class UsersDeleteServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 0. 설정
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=utf-8");
			HttpSession session = req.getSession();
			String sessionId = (String)session.getAttribute("usersId");
			String sessionGrade = (String)session.getAttribute("usersGrade");
			String targetId = req.getParameter("targetId");
			System.out.println("[회원 탈퇴] 0. 세션Id: '" + sessionId + "' / 내 회원등급: '" + sessionGrade + "' / 탈퇴요청대상 ID: '" + targetId);

			// 1. 입력값 검사: 지울 id값이 들어와 있어야 됨
			System.out.print("[회원 탈퇴] 1. id 빈값 여부 확인..");
			if(!HexaLibrary.isExists(sessionId)) throw new Exception();
			System.out.println("id가 빈값이 아닌 것을 확인했습니다. 계속 진행합니다.");

			// 2. 권한 검사: 해당 ID를 조작할 권한이 있는 상황인지 확인
			System.out.print("[회원 탈퇴] 2. 권한 확인..");
			UsersDao dao = new UsersDao();
			// 아래 둘 중 하나여야 한다. 내가 관리자거나, 내가 내 아이디 요청한 거거나.
			boolean isGranted = UsersUtils.isGranted(sessionId, sessionGrade, targetId);
			if(!isGranted) throw new Exception();
			System.out.println("권한 확인 완료.");

			// 3. 전송
			System.out.print("[회원 탈퇴] 3. 탈퇴 실행..(" + targetId + ")");
			boolean isSucceed = dao.delete(targetId);
			System.out.println("　　▷ 탈퇴 요청 실시함.");

			// 4. 결과를 세션에 반영
			System.out.print("[회원 탈퇴] 4. 최종 결과: ");
			if(isSucceed) {
				HexaLibrary.removeSession(session);
				System.out.println("탈퇴 성공.");
			} else {
				System.out.println("탈퇴 실패.");
				throw new Exception();
			}

		}
		catch(Exception e) {
			System.out.println("\n[회원 탈퇴] 에러가 발생했습니다.");
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}