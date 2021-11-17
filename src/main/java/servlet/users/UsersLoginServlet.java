
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
@WebServlet("/users/login.nogari")
public class UsersLoginServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 0. 준비
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/plain;charset=utf-8");
			System.out.println("[회원 로그인]");
			String usersId = req.getParameter("usersId");
			String usersPw = req.getParameter("usersPw");
			System.out.println("　　▷ 입력된 usersId: [" + usersId + "] / 입력된 usersPw: [" + usersPw + "]");

			// 1. 입력값 존재여부 검사 (usersId, usersPw 둘다)
			System.out.print("[회원 로그인] 1. 입력값 존재여부 검사..");
			boolean filledReqs = usersId != null && !usersId.equals("")
							  && usersPw != null && !usersPw.equals("");
			if(!filledReqs) {
				System.out.println("　　▷ 일부 입력값이 존재하지 않습니다.");
				throw new Exception();
			}
			System.out.println("정상.");

			// 2. DTO/DAO 제작
			System.out.println("[회원 로그인] 2. DTO/DAO 설정..");
			UsersDto dto = new UsersDto();
			dto.setUsersId(usersId);
			dto.setUsersPw(usersPw);
			UsersDao dao = new UsersDao();
			System.out.println("　　DTO: " + dto);
			System.out.println("　　DAO: " + dao);
			System.out.println("　　▷ 완료.");

			// 3. id/pw 일치하는 값 있는지 검사
			System.out.println("[회원 로그인] 3. ID/PW 일치 검사..");
			boolean isLoginValid = HashChecker.idPwMatch(dto, dao);
			System.out.print("　　▷ 확인 결과: " + isLoginValid);

			// 4. 최종 처리: 세션 부여
			// 로그인 실패 시
			if(!isLoginValid) {
				System.out.println("　　▷ 로그인 실패. usersId 혹은 usersPw가 맞지 않습니다.");
				throw new Exception();
			}
			// 로그인 성공 시
			else {
				System.out.println("[회원 로그인] 4. 모든 확인 완료. 세션 부여..");

				// 입력한 id에 해당하는 DTO 가져옴
				UsersDto foundDto = dao.get(usersId);
				if(foundDto == null) {
					System.out.println("　　▷ ID와 PW에 해당하는 DTO를 찾지 못했습니다.");
					throw new Exception();
				} else {
					System.out.println("　　▷ ID와 PW에 해당하는 DTO를 찾았습니다. 상세: " + foundDto);
				}

				// 세션 부여
				HttpSession session = req.getSession();
				Sessioner.login(session, foundDto);
				System.out.println("　　▷ 세션 부여 완료.");
				resp.sendRedirect(req.getContextPath()+"/index.jsp");
			}
		}
		catch(Exception e) {
			System.out.println("\n[회원 로그인] 에러가 발생했습니다.");
			e.printStackTrace();
			resp.sendRedirect(req.getContextPath() + "/users/login.jsp?error"); // 로그인페이지로 이동
		}

	}
}

