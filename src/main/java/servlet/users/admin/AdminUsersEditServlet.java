package servlet.users.admin;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.UsersDao;
import beans.UsersDto;

//관리자 - 회원 정보 변경 처리
@SuppressWarnings("serial")
@WebServlet(urlPatterns="/admin/users/edit.nogari")
public class AdminUsersEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 0. 변수준비
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/plain;charset=utf-8");
			UsersDao usersDao = new UsersDao();
			UsersDto usersDto = new UsersDto();
			System.out.println("[관리자 - 회원 정보 변경]");

			// 1. DTO 준비
			usersDto.setUsersId(req.getParameter("usersId"));
			usersDto.setUsersPw(req.getParameter("usersPw"));
			usersDto.setUsersNick(req.getParameter("usersNick"));
			usersDto.setUsersEmail(req.getParameter("usersEmail"));
			usersDto.setUsersPhone(req.getParameter("usersPhone"));
			usersDto.setUsersGrade(req.getParameter("usersGrade"));
			System.out.println("[관리자 - 회원 정보 변경] " + usersDto);

			// 2. UPDATE문 실행
			boolean isSucceed = usersDao.update(usersDto);
			System.out.println("[관리자 - 회원 정보 변경] 실제 수정 실행");

			// 3. 정보 수정 성공시 해당회원의 상세 페이지로 이동
			int usersIdx = Integer.parseInt(req.getParameter("usersIdx")); // 리다이렉트를 위한 usersIdx 파라미터
			String redirectTo = req.getContextPath()+"/admin/users/detail.jsp?usersIdx=" +  usersIdx;
			//정보 수정 실패시 정보 변경 페이지로 fail파라미터 전달
			redirectTo += isSucceed ? "&success" : "&fail";
			System.out.println("[관리자 - 회원 정보 변경] 회원 정보 수정 성공? (" + isSucceed + ")");
			resp.sendRedirect(redirectTo);

		}
		catch(Exception e) {
			System.out.println("\n[관리자 - 회원 정보 변경] 에러가 발생했습니다.");
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
