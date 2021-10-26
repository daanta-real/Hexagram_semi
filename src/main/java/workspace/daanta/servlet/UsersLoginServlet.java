package workspace.daanta.servlet;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import beans.UsersDao;
import beans.UsersDto;
import util.HexaLibrary;
import util.UsersUtils;

@SuppressWarnings("serial")
@WebServlet("/jsp/users/login.nogari")
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

			// 1. 입력값 존재여부 검사
			System.out.print("[회원 로그인] 1. 입력값 존재여부 검사..");
			boolean filledReqs = HexaLibrary.isExists(usersId) && HexaLibrary.isExists(usersPw);
			if(!filledReqs) throw new Exception();
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
			boolean isMatched = false;
			try { isMatched = UsersUtils.isValid(usersId, usersPw); }
			catch (Exception e) { isMatched = false; }
			System.out.println("　　▷ 확인 결과: " + isMatched);
			// 4. 최종 처리: 세션 부여

			if(!isMatched) {
				System.out.println("　　▷ 로그인 실패. usersId 혹은 usersPw가 맞지 않습니다. 로그인 페이지로 돌아갑니다.");
				resp.sendRedirect(req.getContextPath() + "/jsp/users/login.jsp?error"); // 로그인페이지로 이동
			} else {
				System.out.print("[회원 로그인] 4. 모든 확인 완료. 세션 부여..");
				HttpSession session = req.getSession();
				UsersDto loggedInDto = dao.get(usersId);
				int usersIdx = loggedInDto.getUsersIdx();
				String usersGrade = loggedInDto.getUsersGrade();
				session.setAttribute("usersIdx"  , usersIdx  );
				session.setAttribute("usersId"   , usersId   );
				session.setAttribute("usersGrade", usersGrade);
				System.out.println("세션 부여 완료. \n"
					+ "　　usersId = '"    + session.getAttribute("usersId"   ) + "', "
					+ "　　usersGrade = '" + session.getAttribute("usersGrade") + "', "
					+ "　　usersIdx = '"   + session.getAttribute("usersIdx"  ) + "'"
				);
				resp.sendRedirect(req.getContextPath());
			}
		}
		catch(Exception e) {
			System.out.println("\n[회원 로그인] 에러가 발생했습니다.");
			e.printStackTrace();
			resp.sendError(500);
		}

	}
}