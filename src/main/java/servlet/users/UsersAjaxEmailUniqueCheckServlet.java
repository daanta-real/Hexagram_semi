package servlet.users;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.UsersDao;
import beans.UsersDto;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/users/email_check.nogari")
public class UsersAjaxEmailUniqueCheckServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 회원 가입 시 닉네임 중복 검사를 회신함. AJAX 형태로만 이용할 것

			// 1. 변수 준비: usersNick
			String usersEmail = req.getParameter("usersEmail");
			System.out.println("[회원가입 - 이메일 중복검사] 1. 대상 Email: " + usersEmail);
			
			// 2. 요청 usersEmail의 DTO가 있는지 판단함
			UsersDao dao = new UsersDao();
			UsersDto dto = dao.getByEmail(usersEmail);
			System.out.println("[회원가입 - 이메일 중복검사] " + usersEmail + "의 DTO: " + dto);
			boolean idExists = dto != null; // DTO 검색 성공 시 기 사용중인 이메일이 있는 것 = 요청된 이메일이 중복

			// 3. 해당 DTO 존재여부에 따라 결과 회신
			System.out.print("[회원가입 - 이메일 중복검사] 이메일 조회 결과..");
			if(idExists) {
				System.out.println("중복 이메일임. 사용 불가능.");
				resp.getWriter().write("USED");
			} else {
				System.out.println("중복 이메일 아님. 사용 가능.");
				resp.getWriter().write("CAN_USE");
			}

		}

		catch(Exception e) {

			e.printStackTrace();
			resp.sendError(500);

		}
	}
}
