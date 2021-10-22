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

@SuppressWarnings("serial")
@WebServlet("/usersModify")
public class UsersModifyServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 0. 설정
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=utf-8");
			System.out.println("[회원 수정]");
			String id    = req.getParameter("id"   );
			String pw    = req.getParameter("pw"   );
			String nick  = req.getParameter("nick" );
			String email = req.getParameter("email");
			String grade = req.getParameter("grade");

			// 1. 입력값 검사: id는 무조건 있어야 되고, 추가로
			System.out.print("1. 입력값 존재여부 검사..");
			// id는 무조건 있어야 되고
			boolean filledReqs = Library.isExists(id);
			// pw/nick/email/grade 넷중 하나 이상도 있어야 됨
			filledReqs = filledReqs && (Library.isExists(pw) || Library.isExists(nick) || Library.isExists(email) || Library.isExists(grade));
			if(!filledReqs) throw new Exception();
			System.out.println("필요 입력값 모두 존재.");

			// 2. DTO 제작 및 DAO 선언
			System.out.print("2. DTO 내용: ");
			UsersDto dto = new UsersDto();
			if(id    != null) dto.setUsersId   (id   );
			if(pw    != null) dto.setUsersPw   (pw   );
			if(nick  != null) dto.setUsersNick (nick );
			if(email != null) dto.setUsersEmail(email);
			if(grade != null) dto.setUsersGrade(grade);
			UsersDao dao = new UsersDao();
			System.out.println(dto);

			// 3. 권한 검사: 해당 ID를 조작할 권한이 있는 상황인지 확인
			System.out.print("3. 권한 확인..");
			// 수정 자체의 권한 확인
			boolean isGranted = UsersUtils.chkIsGranted(req, dao, id);
			// grade를 수정하는 경우, 세션이 관리자 유저 세션인지 추가로 확인 필요함
			if(grade != null) isGranted = isGranted && UsersUtils.chkIsAdmin(req, dao);
			if(!isGranted) throw new Exception();
			System.out.println("권한 확인 완료.");

			// 4. 수정 실행
			System.out.println("4. 실제 수정 실행..");
			boolean isSucceed = dao.update(dto);
			System.out.println("　　▷ 수정 요청 실시함.");

			// 5. 결과 출력
			System.out.print("5. 최종 결과: ");
			if(isSucceed) {
				System.out.println("수정 성공.");
			} else {
				System.out.println("수정 실패.");
				throw new Exception();
			}

		} catch(Exception e) {
			System.out.println(" ▷ 에러");
			e.printStackTrace();
		}
	}
}