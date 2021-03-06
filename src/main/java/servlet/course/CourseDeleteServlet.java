package servlet.course;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.CourseDao;
import beans.CourseItemDao;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/course/delete.nogari")
public class CourseDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			//코스 게시물 삭제 Servlet

			//파라미터로 받은 courseIdx를 변수에 저장
			int courseIdx = Integer.parseInt(req.getParameter("courseSequnce")); // 필터의 파라미터 이름을 동일하게 해주기위해서 파라미터 명을 courseSequnce로 하였다.

			//처리
			CourseDao courseDao = new CourseDao();
			CourseItemDao courseItemDao = new CourseItemDao();

			//삭제(courseItem, course둘다 삭제한다.)
			courseItemDao.delete(courseIdx);
			courseDao.delete(courseIdx);

			//목록 페이지로 이동
			resp.sendRedirect("list.jsp");
			return;

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
