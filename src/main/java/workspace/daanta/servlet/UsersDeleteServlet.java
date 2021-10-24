package workspace.daanta.servlet;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.UsersUtils;
import workspace.daanta.beans.UsersDao;
import workspace.daanta.util.Library;

@SuppressWarnings("serial")
@WebServlet("/usersUnregister")
public class UsersDeleteServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 0. 설정
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/html;charset=utf-8");
			System.out.println("[회원 삭제]");
			String id = req.getParameter("id");
			System.out.println("0. 삭제 요청한 id: " + id);

			// 1. 입력값 검사: 지울 id값이 들어와 있어야 됨
			System.out.print("1. id 빈값 여부 확인..");
			if(!Library.isExists(id)) throw new Exception();
			System.out.println("id가 빈값이 아닌 것을 확인했습니다. 계속 진행합니다.");

			// 2. 권한 검사: 해당 ID를 조작할 권한이 있는 상황인지 확인
			System.out.print("2. 권한 확인..");
			UsersDao dao = new UsersDao();
			boolean isGranted = UsersUtils.chkIsGranted(req, dao, id);
			if(!isGranted) throw new Exception();
			System.out.println("권한 확인 완료.");

			// 3. 전송
			System.out.print("3. 삭제 실행..");
			boolean isSucceed = dao.delete(id);
			System.out.println("　　▷ 삭제 요청 실시함.");

			// 4. 결과 출력
			System.out.print("4. 최종 결과: ");
			if(isSucceed) {
				System.out.println("삭제 성공.");
			} else {
				System.out.println("삭제 실패.");
				throw new Exception();
			}

		} catch (Exception e) {
			System.out.println("에러");
			e.printStackTrace();
		}
	}
}