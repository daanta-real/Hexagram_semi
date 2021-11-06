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
@WebServlet(urlPatterns="/users/modifyPassword.nogari")
public class UsersModifyPasswordServlet extends HttpServlet{

	@Override
	//비밀번호 변경처리 서블릿
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {

			// 1. 변수 준비 (id, pw, 변경할pw)
			HttpSession session = req.getSession();
			String sessionId = (String) session.getAttribute("usersId");
			String usersPw = req.getParameter("usersPw");
			String pwUpdate = req.getParameter("pwUpdate");
			System.out.println("[비밀번호 변경] usersId = " + sessionId + ", usersPw = " + usersPw + ", pwUpdate = " + pwUpdate);

			// 2. DAO/DTO 준비
			UsersDao usersDao = new UsersDao();
			UsersDto usersDto = new UsersDto();
			usersDto.setUsersId(sessionId);
			usersDto.setUsersPw(usersPw);
			System.out.println("[비밀번호 변경] 기존 ID/PW DTO 준비: " + usersDto);

			// 3. 비밀번호 변경 가능 검사
// ★ 1) 변경 전후 비번이 똑같은지 조회: 작업 생략 (DB PW 암호화 이후에 반영 가능)
			// 입력한 아이디/비번이 DB 것과 일치하는지 조회
			boolean isValid = HashChecker.idPwMatch(usersDto, usersDao);
			System.out.println("[비밀번호 변경] 입력 ID/PW DB상 존재여부 조회 결과: " + usersDto);

			// 4. 비밀번호 심사 결과에 따른 비번 변경 반영
			if(isValid) {
				System.out.println("[비밀번호 변경] 비밀번호 변경이 가능한 것으로 확인되었습니다.");
				// 비밀번호 변경에 성공하면 성공 페이지로 이동
				usersDao.updatePw(sessionId, pwUpdate);
				System.out.println("[비밀번호 변경] 비밀번호 변경이 성공하였습니다. 성공 페이지로 이동합니다.");
				resp.sendRedirect(req.getContextPath()+"/users/modify_success.jsp");

			} else {
				// 변경 실패 시 다시 비밀번호변경 페이지로 이동
				System.out.println("[비밀번호 변경] 비밀번호 변경이 불가능합니다.");
				resp.sendRedirect(req.getContextPath()+"/users/modifyPassword.jsp?fail");
			}

		}

		catch(Exception e) {

			System.out.println("[비밀번호 변경] 에러 발생");
			e.printStackTrace();
			resp.sendError(500);

		}

	}
}
