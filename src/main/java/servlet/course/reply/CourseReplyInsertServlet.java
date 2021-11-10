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
			//회원 번호 세션으로 받기(usersIdx)
			int usersIdx = (int) req.getSession().getAttribute("usersIdx");
			//코스 번호 파라미터로 받기 (courseIdx)
			int courseIdx = Integer.parseInt(req.getParameter("courseIdx"));
			//댓글 내용 파라미터로 받기 (courseReplyDetail)
			String courseReplyDetail = req.getParameter("courseReplyDetail");
			//댓글인지 대댓글인지 판정 : 파라미터에 댓글 번호가 온다면
			boolean reReply = req.getParameter("courseReplyIdx") != null;
			
			CourseReplyDao courseReplyDao = new CourseReplyDao();
			
			
			//시퀀스 번호 먼저 받기
			int courseReplySeq = courseReplyDao.getSequenceNo();
			
			//파라미터 값 댓글 등록
			CourseReplyDto courseReplyDto = new CourseReplyDto();
			courseReplyDto.setCourseReplyIdx(courseReplySeq);
			courseReplyDto.setUsersIdx(usersIdx);
			courseReplyDto.setCourseIdx(courseIdx);
			courseReplyDto.setCourseReplyDetail(courseReplyDetail);
			
			//대댓글일 경우 
			if(reReply) {
				int courseReplyIdx = Integer.parseInt(req.getParameter("courseReplyIdx"));
				//상위 댓글의 모든 정보를 불러온다 정보를(댓글 단일조회) 
				CourseReplyDto superDto = courseReplyDao.get(courseReplyDto.getCourseReplySuperno());
				
				//등록될 글의 정보를 계산
				courseReplyDto.setCourseReplySuperno(courseReplyIdx);
				courseReplyDto.setCourseReplyGroupno(superDto.getCourseReplyGroupno());
				courseReplyDto.setCourseReplyDepth(superDto.getCourseReplyDepth()+1);
				
				//대댓글 등록
				courseReplyDao.insertTarget(courseReplyDto);
			}
			else {
				//새 댓글 등록
				courseReplyDao.insert(courseReplyDto);
			}
			
			
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
