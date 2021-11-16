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
@WebServlet(urlPatterns="/users/join_id_check.nogari")
public class UsersCreateAjaxIdUniqueCheckServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			//회원가입시 아이디 중복검사 처리
			//요청정보 : usersId의 파라미터
			String usersId = req.getParameter("usersId");
			System.out.println("[회원가입] 아이디 중복검사 요청. usersId="+usersId);

			//처리 : 요청정보인 usersId로 조회
			UsersDao dao = new UsersDao();
			UsersDto dto = dao.get(usersId);

// ※ 제약조건이 추가됨에 따라 이 부분에 추가 작업 필요하다.

			//출력 : UsersDto 존재여부에 따른 결과값 보내기
			if(dto == null) {
				//조회결과 dto가 존재하지 않으면 아이디 사용가능
				System.out.println("[회원가입] 아이디 조회결과."+usersId+" 사용가능");
				resp.getWriter().write("CAN_USE");
			}else {
				//조회결가 dto가 존재한다면 이미 사용중인 아이디(중복)
				System.out.println("[회원가입] 아이디 조회결과."+usersId+" 아이디 중복. 사용 불가능");
				resp.getWriter().write("USED");
			}

		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
