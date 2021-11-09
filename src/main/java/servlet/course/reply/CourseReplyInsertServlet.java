package servlet.course.reply;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.CourseDao;
import beans.CourseReplyDao;
import beans.CourseReplyDto;

@WebServlet (urlPatterns = "/course_reply/insert.nogari")
public class CourseReplyInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//입력 받기
			//회원 번호usersIdx
			int usersIdx = (int) req.getSession().getAttribute("usersIdx");
			//코스 번호 courseIdx
			int courseIdx = Integer.parseInt(req.getParameter("courseIdx"));
			//댓글 내용 courseReplyDetail
			String courseReplyDetail = req.getParameter("courseReplyDetail");
			
			CourseReplyDto courseReplyDto = new CourseReplyDto();
			courseReplyDto.setUsersIdx(usersIdx);
			courseReplyDto.setCourseIdx(courseIdx);
			courseReplyDto.setCourseReplyDetail(courseReplyDetail);
			
			CourseReplyDao courseReplyDao = new CourseReplyDao();
			courseReplyDao.insert(courseReplyDto);
			
			//댓글 등록 후 게시글의 댓글 수 조정
			CourseDao courseDao = new CourseDao();
			courseDao.countCourseReply(courseIdx);
			
			resp.sendRedirect(req.getContextPath() + "/course/detail.jsp?courseIdx=" + courseIdx);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
