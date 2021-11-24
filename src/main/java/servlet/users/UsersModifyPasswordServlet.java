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

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/users/modifyPassword.nogari")
public class UsersModifyPasswordServlet extends HttpServlet{

	@Override
	//비밀번호 변경처리 서블릿
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {

			// 1. 변수 준비 (id, pw, 변경할pw)
			System.out.print("[비밀번호 변경] 1. 변수 준비.. ");
			HttpSession session = req.getSession();
			String sessionId = (String) session.getAttribute("usersId");
			String currPw = req.getParameter("usersPw");
			String newPw = req.getParameter("pwUpdate");
			UsersDao usersDao = new UsersDao();
			System.out.println("입력받은 값: usersId = " + sessionId + ", usersPw = " + currPw + ", pwUpdate = " + newPw);


			// 2. 검사 - 비번 변경을 요청할 자격이 있는지 검사
			System.out.print("[비밀번호 변경] 2. 검사 - 비밀번호 변경 요청 자격 확인.. ");
			boolean isFormReady
				 = sessionId != null && !sessionId.equals("") // 1) 로그인되어 있어야 한다.
				&& currPw != null    && !currPw.equals("")    // 2) 현재 암호가 입력되어야 한다.
				&& newPw != null     && !newPw.equals("")     // 3) 변경될 암호도 입력되어야 한다.
				&& !currPw.equals(newPw);                     // 4) 현재 암호와 변경될 암호가 똑같이 입력되어서는 안 된다.
			if(!isFormReady) {
				System.out.println("비밀번호 변경에 필요한 양식들이 제대로 입력되지 않았습니다.");
				throw new Exception();
			} else {
				System.out.println("OK.");
			}

			// 3. 검사 - 현재 ID/비번 정합성 검사
			System.out.print("[비밀번호 변경] 3. 검사 - ID & PW 정합성 확인.. ");
			boolean isValidIdPw = HashChecker.idPwMatch(sessionId, currPw);
			if(!isValidIdPw) {
				System.out.println("오류. 비번이 일치하지 않습니다.");
				resp.sendRedirect(req.getContextPath() + "/users/modifyPassword.jsp?notEquals");
				return;
			} else {
				System.out.println("OK.");
			}

			// 4. 검사 - 변경할 비번이 제약조건에 맞는 것인지 검사
			System.out.print("[비밀번호 변경] 4. 검사 - 변경할 비번이 DB 제약조건에 맞는지 확인.. ");
			boolean isValidNewPw = UsersDto.isValidUsersPw(newPw);
			if(!isValidNewPw) {
				System.out.println("오류. 새 비번이 제약조건에 맞지 않습니다.");
				throw new Exception();
			} else {
				System.out.println("OK.");
			}

			// 5. 비밀번호 심사 결과에 따른 비번 변경 반영
			System.out.print("[비밀번호 변경] 5. 모든 검사를 통과하여 비밀번호 변경을 실시합니다.. ");
			try {
				// 비밀번호 변경에 성공하면 성공 페이지로 이동
				// ※ 실제 컬럼에 들어가는 $문자열은 여기서 만드는 게 아니다. 아래 요청한 DAO 안에서 알아서 만든다.
				usersDao.updatePw(sessionId, newPw);
				System.out.println("비밀번호 변경이 성공하였습니다. 성공 페이지로 이동합니다.");
				resp.sendRedirect(req.getContextPath() + "/users/modify_success.jsp");
				return;
			} catch(Exception e) {
				// 변경 실패 시 다시 비밀번호변경 페이지로 이동
				System.out.println("비밀번호 변경 과정에서 에러가 발생하였습니다.");
			}

		}

		catch(Exception e) {

			System.out.println("[비밀번호 변경] 에러 발생");
			e.printStackTrace();
			resp.sendError(500);

		}

	}
}
