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
import util.users.GrantChecker;
import util.users.UsersUtils;

@SuppressWarnings("serial")
@WebServlet(urlPatterns="/users/modify.nogari")
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
			String usersId    = req.getParameter("usersId"   );
			String usersPw    = req.getParameter("usersPw"   );
			String usersNick  = req.getParameter("usersNick" );
			String usersEmail = req.getParameter("usersEmail");
			String usersPhone = req.getParameter("usersPhone");
			String usersGrade = req.getParameter("usersGrade");
			System.out.println("usersId = '" + usersId + "', usersPw = '" + usersPw
				+ "', usersNick = '" + usersNick + "', usersEmail = '" + usersEmail
				+ "', usersPhone = '" + usersPhone + "', usersGrade = '" + usersGrade + "' '");

			// 1. 입력값 검사: id는 무조건 있어야 되고, 추가로
			System.out.print("[회원 수정] 1. 입력값 존재여부 검사..");
			// id는 무조건 있어야 되고
			boolean filledReqs = usersId != null && !usersId.equals("");
			// pw/nick/email/grade/phone 다섯중 하나 이상도 있어야 됨
			filledReqs = filledReqs && (
				   usersPw    != null && !usersPw.equals("")
				|| usersNick  != null && !usersNick.equals("")
				|| usersEmail != null && !usersEmail.equals("")
				|| usersGrade != null && !usersGrade.equals("")
				|| usersPhone != null && !usersPhone.equals("")
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
			if(usersPhone != null) dto.setUsersPhone(usersPhone);
			UsersDao dao = new UsersDao();
			System.out.println(dto);

			// 3. 권한 검사: 해당 ID를 조작할 권한이 있는 상황인지 확인
			System.out.print("[회원 수정] 3. 권한 확인(요청자 id = '" + sessionId + "', 요청자 등급 = '" + sessionGrade + "').. ");
			// 수정 자체의 권한 확인
			boolean isGranted = GrantChecker.isGranted(sessionId, sessionGrade, usersId);
			if(isGranted) {
				System.out.println("권한 확인 완료.");
			} else {
				System.out.println("권한 확인 실패. 권한이 부족합니다.");
				throw new Exception();
			}
			// 추거) grade를 수정하는 경우
			boolean modifyingGrade = usersGrade != null && !usersGrade.equals("");
			if(modifyingGrade) { // grade에 수정이 있는 경우에 한해, 세션이 관리자 유저인지 추가로 확인.
				System.out.print("[회원 수정] 3 추가. 등급 수정이 요청되어, 요청자가 관리자 권한인지 추가로 확인하겠습니다.");
				boolean isAdmin = sessionGrade != null && sessionGrade.equals(UsersUtils.GRADE_ADMIN);
				if(!isAdmin) {
					System.out.println("회원등급을 수정하려 하셨지만, 요청자가 관리자가 아닙니다. (권한='" + sessionGrade + "')");
					throw new Exception();
				}
			}
			System.out.println("[회원 수정] 모든 권한 확인 완료.");

			// 4. 수정 실행
			System.out.print("[회원 수정] 4. 실제 수정 실행..");
			boolean isSucceed = dao.update(dto);
			System.out.println("수정 요청 실시함.");

			// 5. 결과 출력
			System.out.print("[회원 수정] 5. 최종 결과: ");
			if(isSucceed) {
				System.out.println("수정 성공.");
				resp.sendRedirect(req.getContextPath()+"/users/modify_success.jsp");
			} else {
				System.out.println("수정 실패.");
				//변경 실패시 다시 변경 페이지로 이동
				resp.sendRedirect(req.getContextPath()+"/users/modify.jsp?fail");
			}

		}
		catch(Exception e) {
			System.out.println("\n[회원 수정] 에러가 발생했습니다.");
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}