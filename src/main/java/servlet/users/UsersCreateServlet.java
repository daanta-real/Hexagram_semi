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
@WebServlet("/users/join.nogari")
public class UsersCreateServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			System.out.println("[회원 가입]");

			// 값 받아옴
			String usersId = req.getParameter("usersId");
			String usersPw = req.getParameter("usersPw");
			String usersNick = req.getParameter("usersNick");
			String usersEmail = req.getParameter("usersEmail");
			String usersPhone = req.getParameter("usersPhone");

			// 값 검사: 양식에 맞지 않는 값은 쳐내기
			// 작성 예정

			// 삽입할 DTO 준비
			UsersDto dto = new UsersDto();
			dto.setUsersId(usersId);
			dto.setUsersPw(usersPw);
			dto.setUsersNick(usersNick);
			dto.setUsersEmail(usersEmail);
			dto.setUsersPhone(usersPhone);

			// 전송
			System.out.println("[회원 가입] 회원가입 요청: " + dto);
			boolean isSucceed = new UsersDao().insert(dto);
			System.out.println("[회원 가입] 회원가입 결과: " + isSucceed);

			// 후처리
			if(isSucceed) {
				System.out.println("[회원 가입] 가입에 성공했습니다.");/*

				회원가입과 동시에 세션 부여해보려 했으나, 시퀀스 넘버 획득방법 없어 추가 실패함. 나중에 DAO 작업하면 다시 시도하겠음
				// 세션 부여하고 가입성공 페이지로 보냄
				HttpSession session = req.getSession();
				session.setAttribute("id", usersId);
				session.setAttribute("usersId"   , usersId);
				session.setAttribute("usersGrade", "준회원");*/
				resp.sendRedirect(req.getContextPath() + "/users/join_success.jsp");
			}
			else throw new Exception();

		}
		catch(Exception e) {
			System.out.println("\n[회원 가입] 에러가 발생했습니다.");
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}