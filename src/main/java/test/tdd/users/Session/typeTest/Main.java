package test.tdd.users.Session.typeTest;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/junsungTest/Session/typeTest.nogari")
public class Main extends HttpServlet {

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		// 1. request의 인코딩을 UTF-8로 강제
		req.setCharacterEncoding("UTF-8");
		System.out.println("[필터 작동 - 인코딩] request의 인코딩을 UTF-8로 설정합니다.");

		// 2. response의 인코딩을 UTF-8로 강제
		resp.setContentType("text/html;charset=utf-8");
		System.out.println("[필터 작동 - 인코딩] response의 인코딩을 UTF-8로 설정합니다.");

		// 3. 세션값 설정
		HttpSession session = req.getSession();
		String a = session.getAttribute("usersIdx")  .getClass().getName();
		String b = session.getAttribute("usersId")   .getClass().getName();
		String c = session.getAttribute("usersGrade").getClass().getName();

		// 세션값 별 클래스명 획득하기
		System.out.println(a);
		System.out.println(b);
		System.out.println(c);

	}

}
