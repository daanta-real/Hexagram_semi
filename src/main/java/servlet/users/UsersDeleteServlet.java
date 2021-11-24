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
			String targetId     = req.getParameter("targetId");     // 내가 탈퇴시킬 대상 ID
			String inputPw      = req.getParameter("usersPw");      // 내가 탈퇴시킬 대상의 비밀번호
			System.out.println("[회원 탈퇴 - 유저가 요청] 0. 변수준비.. "
				+ "내 세션Id: '" + sessionId + "' / 내 회원등급: '" + sessionGrade + "' / 탈퇴시킬 대상 ID: '" + targetId);

			// 1. 로그인했는지 검사: 생략. 필터가 체크하므로 여기서 검사할 필요 없다.

			// 2. 입력값 검사: 탈퇴할 id값(targetID)이 들어와 있어야 됨
			System.out.println("[회원 탈퇴 - 유저가 요청] 1. 탈퇴할 id값 입력했는지 여부 확인..");
			if(targetId == null || targetId.equals("")) throw new Exception();
			System.out.println("　　▷ id가 빈값이 아닌 것을 확인했습니다. 계속 진행합니다.");

			// 3. 권한 검사
			System.out.print("[회원 탈퇴 - 유저가 요청] 2. 권한 검사..");
			boolean isGranted = Sessioner.isGranted(session, targetId);
			if(!isGranted) {
				System.out.println("권한이 없습니다.");
				throw new Exception();
			} else {
				System.out.println("권한이 있음이 확인되었습니다.");
			}

			// 4. 내 아이디 PW 검사
			// 내가 내 아이디에 요청한 상황일 경우 (즉 내가 내 아이디 탈퇴할 경우) 내 PW가 입력되어야 한다.
			// 이때, 내가 관리자냐 아니냐는 상관이 없다.
			if(sessionId.equals(targetId)) {

			}
			UsersDao dao = new UsersDao();
			UsersDto targetDto = new UsersDto();
			targetDto.setUsersId(targetId);
			targetDto.setUsersPw(inputPw);

			// 3. 전송
			//추가. 비밀번호 일치여부 검사
			// targetId 로 조회한 dto의 getUsersPw와 입력한 pw(파라미터 usersPw)일치여부 검사
			UsersDto dto = dao.get(targetId);
			System.out.print("[회원 탈퇴 - 유저가 요청] 3. 탈퇴 실행..(" + targetId + ")");
			
			// id/pw 일치하는 값 있는지 검사. 입력한 비밀번호를 암호화시킨 후 저장된 암호화 비번과 일치여부 확인
			System.out.println("[회원 탈퇴 - 유저가 요청] ID/PW 일치 검사..");
			boolean isValid = HashChecker.idPwMatch(targetId, inputPw, dao);
			System.out.print("　　▷ 확인 결과: " + isValid);
			
			boolean isSucceed = isValid && dao.delete(targetId);
			System.out.println("　　▷ 탈퇴 요청 실시함.");

			// 4. 결과를 세션에 반영
			System.out.print("[회원 탈퇴 - 유저가 요청] 4. 최종 결과: ");
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