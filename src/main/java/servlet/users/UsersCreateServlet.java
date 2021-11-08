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
import util.users.Sessioner;

@SuppressWarnings("serial")
@WebServlet("/users/join.nogari")
public class UsersCreateServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {

			// 0. 변수 준비
			System.out.println("[회원 가입] 0. 변수 준비");
			String usersId    = req.getParameter("usersId"   );
			String usersPw    = req.getParameter("usersPw"   );
			String usersNick  = req.getParameter("usersNick" );
			String usersEmail = req.getParameter("usersEmail");
			String usersPhone = req.getParameter("usersPhone");


			// 1. 값 검사: 양식에 맞지 않는 값은 쳐내기
			// 작성 예정


			// 2. 회원등록에 쓸 DTO 준비
			UsersDto dto = new UsersDto();
			dto.setUsersId(usersId);
			dto.setUsersPw(usersPw);
			dto.setUsersNick(usersNick);
			dto.setUsersEmail(usersEmail);
			dto.setUsersPhone(usersPhone);
			System.out.println("[회원 가입] 2. 등록정보: " + dto);

			// 3. 회원등록에 쓸 DAO를 준비하고, 시퀀스 따내서 DTO에 미리 넣는다.
			UsersDao dao = new UsersDao();
			Integer seqNo = dao.getNextSequence();
			dto.setUsersIdx(seqNo);
			System.out.println("[회원 가입] 3. 생성된 시퀀스 번호: " + seqNo);

			// 4. 회원 생성 요청
			System.out.println("[회원 가입] 4. 회원가입 요청.. ");
			boolean isSucceed = dao.insert(dto);

			// 5. 요청 결과에 따른 후처리
			if(isSucceed) {
				System.out.println("[회원 가입] 5. 가입에 성공했습니다.");
				HttpSession session = req.getSession();
				Sessioner.login(session, dto); // idx(시퀀스로 만들어논 것), id, grade 세 개 넘어감.
				resp.sendRedirect(req.getContextPath() + "/users/join_success.jsp");
			}
			else {
				throw new Exception();
			}

		}

		catch(Exception e) {

			System.out.println("\n[회원 가입] 에러가 발생했습니다.");
			e.printStackTrace();
			resp.sendError(500);

		}
	}
}