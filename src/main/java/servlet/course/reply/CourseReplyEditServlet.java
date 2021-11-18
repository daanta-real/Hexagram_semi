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
			
			//코스 댓글 수정 Servlet
			
			//입력 : courseIdx
			int courseIdx = Integer.parseInt(req.getParameter("courseIdx"));
			
			//처리 : 파라미터로 수정 할 내용 받기
			CourseReplyDto courseReplyDto = new CourseReplyDto();
			courseReplyDto.setCourseReplyDetail(req.getParameter("courseReplyDetail"));
			courseReplyDto.setCourseReplyIdx(Integer.parseInt(req.getParameter("courseReplyIdx")));
			
			//댓글 수정
			CourseReplyDao courseReplyDao = new CourseReplyDao();
			courseReplyDao.update(courseReplyDto);
			
			//수정 완료 후 게시글 페이지로 이동
			resp.sendRedirect(req.getContextPath() + "/course/detail.jsp?courseIdx=" + courseIdx);
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
