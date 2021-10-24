package workspace.daanta.servlet;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.UsersUtils;
import workspace.daanta.beans.UsersDao;
import workspace.daanta.beans.UsersDto;

@SuppressWarnings("serial")
@WebServlet("/usersList")
public class UsersSelectServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 0. 변수준비
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/plain;charset=utf-8");
			System.out.println("[회원 목록]");
			UsersDao dao = new UsersDao();

			// 1. 목록을 조회할 수 있는 사람은 관리자뿐임. 따라서 세션id가 관리자등급 id인지 확인
			System.out.print("1. 권한 확인..");
			boolean isGranted = UsersUtils.chkIsAdmin(req, dao);
			if (!isGranted) throw new Exception();
			System.out.println("정상 권한 확인.");

			// 2. 목록 출력
			System.out.print("2. 목록 출력..");
			List<UsersDto> usersDto = new UsersDao().select();
			PrintWriter out = resp.getWriter();
			for (UsersDto dto_one : usersDto) {
				out.println(dto_one);
				System.out.println(dto_one);
			}
			System.out.println("목록 출력 완료.");

		} catch (Exception e) {
			System.out.println("에러");
			e.printStackTrace();
		}
	}
}