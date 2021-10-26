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
@WebServlet("/usersModify")
public class UsersModifyServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 0. 설정
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=utf-8");
			HttpSession session = req.getSession();
			String sessionId    = (String) session.getAttribute("usersId"   );
			String sessionGrade = (String) session.getAttribute("usersGrade");
			System.out.print("[회원 수정] ");
			String usersId    = req.getParameter("id"   );
			String usersPw    = req.getParameter("pw"   );
			String usersNick  = req.getParameter("nick" );
			String usersEmail = req.getParameter("email");
			String usersGrade = req.getParameter("grade");
			System.out.println("usersId = '" + usersId + "', usersPw = '" + usersPw
				+ "', usersNick = '" + usersNick + "', usersEmail = '" + usersEmail
				+ "', usersGrade = '" + usersGrade + "'");

			// 1. 입력값 검사: id는 무조건 있어야 되고, 추가로
			System.out.print("[회원 수정] 1. 입력값 존재여부 검사..");
			// id는 무조건 있어야 되고
			boolean filledReqs = HexaLibrary.isExists(usersId);
			// pw/nick/email/grade 넷중 하나 이상도 있어야 됨
			filledReqs = filledReqs && (
				HexaLibrary.isExists(usersPw)
				|| HexaLibrary.isExists(usersNick)
				|| HexaLibrary.isExists(usersEmail)
				|| HexaLibrary.isExists(usersGrade)
			);
			if(!filledReqs) throw new Exception();
			System.out.println("필요 입력값 모두 존재.");

			// 2. DTO 제작 및 DAO 선언
			System.out.print("[회원 수정] 2. DTO 내용: ");
			UsersDto dto = new UsersDto();
			if(usersId    != null) dto.setUsersId   (usersId   );
			if(usersPw    != null) dto.setUsersPw   (usersPw   );
			if(usersNick  != null) dto.setUsersNick (usersNick );
			if(usersEmail != null) dto.setUsersEmail(usersEmail);
			if(usersGrade != null) dto.setUsersGrade(usersGrade);
			UsersDao dao = new UsersDao();
			System.out.println(dto);

			// 3. 권한 검사: 해당 ID를 조작할 권한이 있는 상황인지 확인
			System.out.print("[회원 수정] 3. 권한 확인..");
			// 수정 자체의 권한 확인
			boolean isGranted = UsersUtils.isGranted(sessionId, sessionGrade, usersId);
			// grade를 수정하는 경우, 세션이 관리자 유저 세션인지 추가로 확인 필요함
			if(usersGrade != null) isGranted = isGranted
				&& (sessionGrade != null && sessionGrade.equals("관리자")
			);
			if(!isGranted) throw new Exception();
			System.out.println("권한 확인 완료.");

			// 4. 수정 실행
			System.out.print("[회원 수정] 4. 실제 수정 실행..");
			boolean isSucceed = dao.update(dto);
			System.out.println("수정 요청 실시함.");

			// 5. 결과 출력
			System.out.print("[회원 수정] 5. 최종 결과: ");
			if(isSucceed) {
				System.out.println("수정 성공.");
			} else {
				System.out.println("수정 실패.");
				throw new Exception();
			}

		}
		catch(Exception e) {
			System.out.println("\n[회원 수정] 에러가 발생했습니다.");
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}