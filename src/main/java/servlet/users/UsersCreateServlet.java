package servlet.users;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.UsersDao;
import beans.UsersDto;
import util.users.Sessioner;

@SuppressWarnings("serial")
@WebServlet("/users/register.nogari")
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
			System.out.println("[회원 가입] 0. 변수정보");
			System.out.println("usersId = " + usersId);
			System.out.println("usersPw = " + usersPw);
			System.out.println("usersNick = " + usersNick);
			System.out.println("usersEmail = " + usersEmail);
			System.out.println("usersPhone = " + usersPhone);
			System.out.println("[회원 가입] 0. 변수정보 끝");

			// 1. 회원등록에 쓸 DTO 준비
			// ※ [PW 관련] DTO 내의 PW는 평문이다. $문자열이 아니다. $문자열은 DAO의 INSERT/UPDATE계열에서만 만들어진다.
			System.out.print("[회원 가입] 1. 등록정보 작성 시도: ");
			UsersDto inputDto = new UsersDto();
			System.out.print("usersId..")   ; inputDto.setUsersId(usersId)      ; System.out.print("성공. ");
			System.out.print("usersPw..")   ; inputDto.setUsersPw(usersPw)      ; System.out.print("성공. ");
			System.out.print("usersNick..") ; inputDto.setUsersNick(usersNick)  ; System.out.print("성공. ");
			System.out.print("usersEmail.."); inputDto.setUsersEmail(usersEmail); System.out.print("성공. ");
			System.out.print("usersPhone.."); inputDto.setUsersPhone(usersPhone); System.out.println("성공. ");
			System.out.println("[회원 가입] 1. 등록정보 작성 성공: " + inputDto);

			// 2. 회원등록에 쓸 DAO를 준비하고, 시퀀스 따내서 DTO에 미리 넣는다.
			UsersDao dao = new UsersDao();
			Integer seqNo = dao.getNextSequence();
			inputDto.setUsersIdx(seqNo);
			System.out.println("[회원 가입] 2. 생성된 시퀀스 번호: " + seqNo);

			// 3. 회원 생성 요청
			System.out.println("[회원 가입] 3. 회원가입 요청.. ");
			boolean isSucceed = dao.insert(inputDto);
			if(!isSucceed) throw new Exception(); // 실패 시 예외부로

			// 4. 자동 로그인 처리
			System.out.println("[회원 가입] 4. 가입에 성공했습니다.");
			// 로그인 처리를 하려면 idx, id, grade 세 개를 Sessioner에 넘겨야 하는데,
			// idx와 id는 위에 만든 게 있지만, grade는 정보가 없다.
			// 따라서 DB에 추가로 접속해 해당 유저의 grade를 조회해야 함.
			UsersDto newDto = dao.get(seqNo);
			Sessioner.login(req.getSession(), newDto);
			resp.sendRedirect(req.getContextPath() + "/users/register_success.jsp");

		}

		catch(Exception e) {

			System.out.println("[회원 가입] 에러가 발생했습니다.");
			e.printStackTrace();
			resp.sendError(500);

		}
	}
}