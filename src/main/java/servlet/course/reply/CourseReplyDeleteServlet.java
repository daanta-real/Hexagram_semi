package servlet.course.reply;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.CourseDao;
import beans.CourseReplyDao;

@WebServlet(urlPatterns = "/course_reply/delete.nogari")
public class CourseReplyDeleteServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			//코스 게시물 댓글 수정 Servlet
			
			//입력 : 변수 저장 (courseIdx, courseReplyIdx)
			int courseIdx = Integer.parseInt(req.getParameter("courseIdx"));
			int courseReplyIdx = Integer.parseInt(req.getParameter("courseReplyIdx"));
			
			//처리
			CourseReplyDao courseReplyDao = new CourseReplyDao();
			boolean success = courseReplyDao.delete(courseReplyIdx);
			
			//삭제 완료시 게시글 페이지로 이동
			resp.sendRedirect(req.getContextPath() + "/course/detail.jsp?courseIdx=" + courseIdx);
			
			//삭제가 완료되면 댓글수를 갱신해준다
			CourseDao courseDao = new CourseDao();
			courseDao.countCourseReply(courseIdx);
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
