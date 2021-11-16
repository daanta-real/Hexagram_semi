package servlet.course;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.CourseDao;
import beans.CourseItemDao;

@WebServlet(urlPatterns = "/course/delete.nogari")
public class CourseDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			int courseIdx = Integer.parseInt(req.getParameter("courseIdx"));
			
			CourseDao courseDao = new CourseDao();
			CourseItemDao courseItemDao = new CourseItemDao();
			
			courseItemDao.delete(courseIdx);
			courseDao.delete(courseIdx);
			
			resp.sendRedirect("list.jsp");
		}catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
