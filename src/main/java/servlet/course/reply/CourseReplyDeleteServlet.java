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
			int courseIdx = Integer.parseInt(req.getParameter("courseIdx"));
			int courseReplyIdx = Integer.parseInt(req.getParameter("courseReplyIdx"));
			
			CourseReplyDao courseReplyDao = new CourseReplyDao();
			
			boolean success = courseReplyDao.delete(courseReplyIdx);
			
			
			resp.sendRedirect(req.getContextPath() + "/course/detail.jsp?courseIdx=" + courseIdx);
			
			CourseDao courseDao = new CourseDao();
			courseDao.countCourseReply(courseIdx);
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
