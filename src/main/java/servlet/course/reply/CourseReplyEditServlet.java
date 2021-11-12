package servlet.course.reply;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.CourseReplyDao;
import beans.CourseReplyDto;

@WebServlet (urlPatterns = "/course_reply/edit.nogari")
public class CourseReplyEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			int courseIdx = Integer.parseInt(req.getParameter("courseIdx"));
			
			CourseReplyDto courseReplyDto = new CourseReplyDto();
			courseReplyDto.setCourseReplyDetail(req.getParameter("courseReplyDetail"));
			courseReplyDto.setCourseReplyIdx(Integer.parseInt(req.getParameter("courseReplyIdx")));
			
			
			CourseReplyDao courseReplyDao = new CourseReplyDao();
			
			courseReplyDao.update(courseReplyDto);
			
			resp.sendRedirect(req.getContextPath() + "/course/detail.jsp?courseIdx=" + courseIdx);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
