package servlet.users;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.UsersDao;
import beans.UsersDto;

@SuppressWarnings("serial")
@WebServlet("/users/list.nogari")
public class UsersSelectServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 0. 변수준비
			req.setCharacterEncoding("UTF-8");
			resp.setContentType("text/plain;charset=utf-8");
			System.out.println("[회원 목록]");

			// 1. 권한 확인 여기선 하지 않음.
			// 권한에 따라 기능이 갈리는 페이지가 아니므로, 관리자필터에서 접근 가능여부를 판정함.

			// 2. 목록 출력
			System.out.print("[회원 목록] 2. 목록 출력..");
			List<UsersDto> usersDto = new UsersDao().select();
			PrintWriter out = resp.getWriter();
			for (UsersDto dto_one : usersDto) {
				out.println(dto_one);
				System.out.println(dto_one);
			}
			System.out.println("목록 출력 완료.");

		}
		catch(Exception e) {
			System.out.println("\n[회원 목록] 에러가 발생했습니다.");
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}