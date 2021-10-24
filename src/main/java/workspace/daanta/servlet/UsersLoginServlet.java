package workspace.daanta.servlet;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.UsersUtils;
import workspace.daanta.beans.UsersDao;
import workspace.daanta.beans.UsersDto;
import workspace.daanta.util.Library;

@SuppressWarnings("serial")
@WebServlet("/usersLogin")
public class UsersLoginServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 0. 준비
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/plain;charset=utf-8");
			System.out.println("[회원 로그인]");
			String id = req.getParameter("id");
			String pw = req.getParameter("pw");
			System.out.println("id: [" + id + "] / pw: [" + "]");

			// 1. 입력값 존재여부 검사
			System.out.print("1. 입력값 존재여부 검사..");
			boolean filledReqs = Library.isExists(id) && Library.isExists(pw);
			if(!filledReqs) throw new Exception();
			System.out.println("정상.");

			// 2. DTO/DAO 제작
			System.out.println("2. DTO/DAO 설정..");
			UsersDto dto = new UsersDto();
			dto.setUsersId(id);
			dto.setUsersPw(pw);
			UsersDao dao = new UsersDao();
			System.out.println("　　DTO: " + dto);
			System.out.println("　　DAO: " + dao);
			System.out.println("　　▷ 완료.");

			// 3. id/pw 일치하는 값 있는지 검사
			System.out.print("3. ID/PW 일치 검사..");
			boolean isMatched = UsersUtils.idPwMatch(dto);
			System.out.println(" 확인 결과: " + isMatched);
			if(!isMatched) {
				System.out.println("수정 실패.");
				throw new Exception();
			}

			// 4. 최종 처리: 세션 부여
			System.out.print("4. 모든 확인 완료. 세션 부여..");
			req.getSession().setAttribute("id", id);
			System.out.println("세션 부여 완료. (id = " + req.getSession().getAttribute("id") + ")");

		} catch (Exception e) {
			System.out.println("에러");
			e.printStackTrace();
		}
	}
}