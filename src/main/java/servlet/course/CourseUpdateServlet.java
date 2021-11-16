package servlet.course;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.CourseDao;
import beans.CourseDto;
import beans.CourseItemDao;
import beans.CourseItemDto;

@WebServlet(urlPatterns = "/course/update_course.nogari")
public class CourseUpdateServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//필터적용전
			req.setCharacterEncoding("UTF-8");
			
			int courseOriginSequnce = Integer.parseInt(req.getParameter("courseOriginSequnce")); //기존
			int courseIdx = Integer.parseInt(req.getParameter("courseSequnce")); //신규 업데이트 할 내용.
			int usersIdx = (int)req.getSession().getAttribute("usersIdx");
			String courseName = req.getParameter("courseName");
			String courseDetail = req.getParameter("courseDetail");
			
			CourseItemDao courseItemDao = new CourseItemDao();
			List<CourseItemDto>updateList = courseItemDao.getByCourse(courseIdx);//신규(즉 업데이트할)것을 덮어쓰기 위해 준비.
			
			courseItemDao.delete(courseOriginSequnce);//기존 코스의 데이터 모두 삭제
			
			for(CourseItemDto courseItemInsertDto : updateList) {
				CourseItemDto courseItemDto = new CourseItemDto();
				courseItemDto.setItemIdx(courseItemInsertDto.getItemIdx());
				courseItemDto.setCourseIdx(courseOriginSequnce);
				
				courseItemDao.insert(courseItemDto); //다시 기존 코스 번호에 덮어써준다(변경 내역을)
			}
			
			CourseDao courseDao = new CourseDao();
			CourseDto courseDto = new CourseDto();
			
			courseDto.setCourseIdx(courseOriginSequnce);
			courseDto.setUsersIdx(usersIdx);
			courseDto.setCourseName(courseName);
			courseDto.setCourseDetail(courseDetail);
			
			courseDao.update(courseDto);
			//새로 만든 시퀀스에 대한 정보는 덮어쓰기 이후 삭제해주면 된다.
			courseItemDao.delete(courseIdx);
			
			
			
//			추후에 detail.jsp로 보낼것!!!!!
			resp.sendRedirect("detail.jsp?courseIdx="+courseOriginSequnce);
			
		}catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
