import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/usersModify")
public class ServletUsersModify extends HttpServlet {
@Override
protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException { try {

	// 설정
	req.setCharacterEncoding("UTF-8");
	System.out.println("[회원 수정]");
	String id    = req.getParameter("id");
	String pw    = req.getParameter("pw");
	String nick  = req.getParameter("nick");
	String email = req.getParameter("email");
	String grade = req.getParameter("grade");

	// DTO 제작 및 DAO 선언
	System.out.print("1. DTO 내용: ");
	UsersDto dto = new UsersDto();
	if(id    != null) dto.setId   (id   );
	if(pw    != null) dto.setPw   (pw   );
	if(nick  != null) dto.setNick (nick );
	if(email != null) dto.setEmail(email);
	if(grade != null) dto.setGrade(grade);
	UsersDao dao = new UsersDao();
	System.out.println(dto);

	// 입력값 검사: id랑 pw는 반드시 있어야 하고, nick/email/grade 셋중 하나 있어야 됨
	System.out.print("2. 입력값 존재여부 검사..");
	boolean filledReqs
		=  (id != null && pw != null)
		&& (nick != null || email != null || grade != null);
	if(!filledReqs) throw new Exception();
	System.out.println("필요 입력값 모두 존재.");

	// id/pw 일치 검사
	System.out.println("3. ID & PW 일치 검사..");
	boolean idPwMatch = dao.idPwMatch(dto);
	if(!idPwMatch) throw new Exception();
	System.out.println("　　▷ 일치함.");

	// 수정 실행
	System.out.println("4. 실제 수정 실행..");
	boolean isSucceed = dao.update(dto);
	System.out.println("　　▷ 수정 요청 실시함.");

	// 결과출력
	resp.setContentType("text/html;charset=utf-8");
	System.out.print("5. 최종 결과: ");
	if(isSucceed) {
		System.out.println("수정 성공.");
	} else {
		System.out.println("수정 실패.");
		throw new Exception();
	}

} catch(Exception e) { System.out.println(" ▷ 에러"); e.printStackTrace(); } }
}