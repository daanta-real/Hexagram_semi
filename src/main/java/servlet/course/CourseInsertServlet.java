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
			
			//코스 등록 Servlet
			
			//필터적용전
			req.setCharacterEncoding("UTF-8");
			
			//입력
			//최초 시퀀스를 만든사람만이 등록이 가능하도록 설정.
			String usersFilterId = req.getParameter("usersFilterId");
			//courseIdx : 파라미터로 받은 courseIdx 번호
			//usersIdx : 글 작성자의 번호를 세션으로 받는다
			//courseName : 파라미터로 받은 코스 게시물 제목
			//courseDetail : 파라미터로 받은 코스 게시물 내용
			int courseIdx = Integer.parseInt(req.getParameter("courseSequnce"));
			int usersIdx = (int)req.getSession().getAttribute("usersIdx");
			String courseName = req.getParameter("courseName");
			String courseDetail = req.getParameter("courseDetail");
					
			//처리
			CourseDao courseDao = new CourseDao();
			CourseDto courseDto = new CourseDto();
			courseDto.setCourseIdx(courseIdx);
			courseDto.setUsersIdx(usersIdx);
			courseDto.setCourseName(courseName);
			courseDto.setCourseDetail(courseDetail);
			
			//등록
			courseDao.insertWithSequence(courseDto);
			
			//작성한 게시글로 이동
			resp.sendRedirect("detail.jsp?courseIdx="+courseIdx);
			
		}catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
