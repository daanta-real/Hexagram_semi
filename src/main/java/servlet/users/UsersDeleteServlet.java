package servlet.users;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.UsersDao;
import beans.UsersDto;
import util.users.GrantChecker;
import util.users.Sessioner;

@SuppressWarnings("serial")
@WebServlet("/users/unregister.nogari")
public class UsersDeleteServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 0. 변수준비
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=utf-8");
			HttpSession session = req.getSession();
			String sessionId    = (String)session.getAttribute("usersId");    // 내가 로그인한 내 ID
			String sessionGrade = (String)session.getAttribute("usersGrade"); // 내 회원등급
			String targetId     = req.getParameter("targetId");               // 내가 탈퇴시킬 대상 ID
			String inputPw      = req.getParameter("usersPw");                // 내가 탈퇴시킬 대상의 비밀번호
			System.out.println("[회원 탈퇴] 0. 변수준비.. "
				+ "내 세션Id: '" + sessionId + "' / 내 회원등급: '" + sessionGrade + "' / 탈퇴시킬 대상 ID: '" + targetId);

			// 1. 로그인했는지 검사: 필터에서 먼저 체크하므로 여기서 검사할 필요 없다.

			// 2. 입력값 검사: 탈퇴할 id값(targetID)이 들어와 있어야 됨
			System.out.print("[회원 탈퇴] 1. id 빈값 여부 확인..");
			if(targetId == null || targetId.equals("")) throw new Exception();
			System.out.println("id가 빈값이 아닌 것을 확인했습니다. 계속 진행합니다.");

			// 3. 권한 검사: 관리자면 무조건 권한 OK. 그러나 관리자가 아닐 경우 {} 안의 추가 검사 구문을 수행해야 함
			boolean isAdmin = sessionGrade.equals(GrantChecker.GRADE_ADMIN);
			if(!isAdmin) {
				// 내가 나에 대해 요청한 것이 아니면 차단
				if(!sessionId.equals(targetId)) throw new Exception();
				// 내가 탈퇴시킬 비번이 아니면
				if()
			}

			// 대상ID나 대상PW값이 null이거나 빈값이면 Setter를 실행하는 과정에서 에러난다.
			UsersDao dao = new UsersDao();
			UsersDto targetDto = new UsersDto();
			targetDto.setUsersId(targetId);
			targetDto.setUsersPw(inputPw);

			// 2. 권한 검사
			// 아래 둘 중 하나여야 한다. 내가 관리자거나, 내가 내 아이디 요청한 거거나.
			boolean isGranted = GrantChecker.isGranted(sessionId, sessionGrade, targetId);

			// 2. 권한 검사: 해당 ID를 조작할 권한이 있는 상황인지 확인
			System.out.print("[회원 탈퇴] 2. 권한 확인..");
			if(!isGranted) throw new Exception();
			System.out.println("권한 확인 완료.");

			// 3. 전송
			//추가. 비밀번호 일치여부 검사
			// targetId 로 조회한 dto의 getUsersPw와 입력한 pw(파라미터 usersPw)일치여부 검사
			UsersDto dto = dao.get(targetId);
			System.out.print("[회원 탈퇴] 3. 탈퇴 실행..(" + targetId + ")");
			//입력한 비밀번호(inputPw)와 dto의 getUsersPw가 서로 일치하고 탈퇴되는게 성공
			boolean isSucceed = dto.getUsersPw().equals(inputPw) && dao.delete(targetId);
			System.out.println("　　▷ 탈퇴 요청 실시함.");

			// 4. 결과를 세션에 반영
			System.out.print("[회원 탈퇴] 4. 최종 결과: ");
			if(isSucceed) {
				Sessioner.logout(session);
				System.out.println("탈퇴 성공.");
				resp.sendRedirect(req.getContextPath()+"/users/unregister_success.jsp");
			} else {
				System.out.println("탈퇴 실패.");
				resp.sendRedirect(req.getContextPath()+"/users/unregister.jsp?fail");
			}

		}

		catch(Exception e) {

			System.out.println("\n[회원 탈퇴] 에러가 발생했습니다.");
			e.printStackTrace();
			resp.sendError(500);

		}
	}
}