package servlet.course;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.CourseDao;
import beans.CourseDto;

@WebServlet(urlPatterns = "/course/insert_course.nogari")
public class CourseInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//필터적용전
			req.setCharacterEncoding("UTF-8");
			
			int courseIdx = Integer.parseInt(req.getParameter("courseSequnce"));
			int usersIdx = (int)req.getSession().getAttribute("usersIdx");
			String courseName = req.getParameter("courseName");
			String courseDetail = req.getParameter("courseDetail");
					
			CourseDao courseDao = new CourseDao();
			CourseDto courseDto = new CourseDto();
			
			courseDto.setCourseIdx(courseIdx);
			courseDto.setUsersIdx(usersIdx);
			courseDto.setCourseName(courseName);
			courseDto.setCourseDetail(courseDetail);
			
			courseDao.insertWithSequence(courseDto);
			
//			추후에 detail.jsp로 보낼것!!!!!
			resp.sendRedirect("detail.jsp?courseIdx="+courseIdx);
			
		}catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
