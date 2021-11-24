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
@WebServlet(urlPatterns="/users/modify.nogari")
public class UsersModifyServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 0. 설정
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=utf-8");
			HttpSession session = req.getSession();
			String sessionId    = (String) session.getAttribute("usersId"   ); // 내 ID
			String sessionGrade = (String) session.getAttribute("usersGrade"); // 내 등급 (수정 권한 판정용)
			String targetId   = req.getParameter("usersId"   ); // 수정하고자 하는 ID (내가 될 수도 있고 다른 사람이 될 수도 있고)
			String usersPw    = req.getParameter("usersPw"   );
			String usersNick  = req.getParameter("usersNick" );
			String usersEmail = req.getParameter("usersEmail");
			String usersPhone = req.getParameter("usersPhone");
			String usersGrade = req.getParameter("usersGrade");
			System.out.println("[회원 수정] usersId(targetId) = '" + targetId + "', usersPw = '" + usersPw
				+ "', usersNick = '" + usersNick + "', usersEmail = '" + usersEmail
				+ "', usersPhone = '" + usersPhone + "', usersGrade = '" + usersGrade + "' '");

			// 1. 입력값 검사: id는 무조건 있어야 되고, 추가로
			System.out.print("[회원 수정] 1. 입력값 존재여부 검사..");
			// id는 무조건 있어야 되고
			boolean filledReqs = targetId != null && !targetId.equals("");
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
			if(targetId   != null) dto.setUsersId   (targetId  );
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
			boolean isGranted = Sessioner.isGranted(session, targetId);
			if(!isGranted) {
				System.out.println("권한 확인 실패. 권한이 부족합니다.");
				throw new Exception();
			} else {
				System.out.println("권한 확인 완료.");
			}

			// 4. 권한 검사: 추가적으로, grade를 수정하는 경우, 등급이 관리자인지도 확인함.
			boolean hasGradeModifying = usersGrade != null && !usersGrade.equals("");
			if(hasGradeModifying) {
				System.out.print("[회원 수정] 4. 등급 수정이 요청되어, 요청자가 관리자 권한인지 추가로 확인하겠습니다.");
				boolean isAdmin = Sessioner.isAdmin(session);
				if(!isAdmin) {
					System.out.println("회원등급을 수정하려 하였지만, 요청자가 관리자가 아닙니다.");
					throw new Exception();
				} else {
					System.out.println("등급 수정 권한이 있음이 확인되었습니다.");
				}
			}
			System.out.println("[회원 수정] 4. 모든 권한 확인 완료.");

			// 5. 수정 실행 및 결과 출력
			System.out.print("[회원 수정] 5. 실제 수정 실행..");
			boolean isSucceed = dao.update(dto);
			System.out.print("[회원 수정] 5. 최종 결과: ");
			if(isSucceed) {
				System.out.println("수정 성공.");
				resp.sendRedirect(req.getContextPath()+"/users/modify_success.jsp");
				return;
			} else {
				System.out.println("수정 실패.");
				//변경 실패시 다시 변경 페이지로 이동
				resp.sendRedirect(req.getContextPath()+"/users/modify.jsp?fail");
				return;
			}

		}
		catch(Exception e) {
			System.out.println("\n[회원 수정] 에러가 발생했습니다.");
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}