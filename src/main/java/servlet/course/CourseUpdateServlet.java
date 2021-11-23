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
			int courseOriginSequnce = Integer.parseInt(req.getParameter("courseOriginSequnce")); //기존 코스 번호 (즉 사라지면 안되는 번호)
			int courseIdx = Integer.parseInt(req.getParameter("courseSequnce")); //신규 업데이트 할 내용.(임시 코스 번호 : 갱신된 내용을 전달하고 사라져야하는 번호)
			int usersIdx = (int)req.getSession().getAttribute("usersIdx");// 현재 사용자
			String courseName = req.getParameter("courseName"); //수정할 관광지 명칭
			String courseDetail = req.getParameter("courseDetail");	//수정한 관광지 내용
			
			CourseItemDao courseItemDao = new CourseItemDao();
			List<CourseItemDto>updateList = courseItemDao.getByCourse(courseIdx);//신규(즉 업데이트할)것을 덮어쓰기 위해 준비.
			//앞서서 courseSequnce를 통해서 기존의 내용을 복사해와서 사용자가 원하는 코스물로 변경된 결과값임.
			
			courseItemDao.delete(courseOriginSequnce);//기존 코스의 데이터 모두 삭제	=> 	신규 업데이트 할 내용.(임시 코스 번호에 있는)을 덮어써야하니까,
			
			for(CourseItemDto courseItemInsertDto : updateList) {
				CourseItemDto courseItemDto = new CourseItemDto();
				//갱신된 항목들의 관광지 항목을 하나하나 담아서
				courseItemDto.setItemIdx(courseItemInsertDto.getItemIdx());
				// 다시 기존 코스 번호로 설정한 뒤
				courseItemDto.setCourseIdx(courseOriginSequnce);
				
				courseItemDao.insert(courseItemDto); //기존 코스 번호에 변경 내역을 넣어준다.
			}
			//이제는 코스-아이템 부분의 데이터의 갱신화 및 기존 번호로의 덮어쓰기 과정이 완료되었고,
			
			CourseDao courseDao = new CourseDao();
			CourseDto courseDto = new CourseDto();
			
			courseDto.setCourseIdx(courseOriginSequnce);
			courseDto.setUsersIdx(usersIdx);
			courseDto.setCourseName(courseName);
			courseDto.setCourseDetail(courseDetail);
			
			//기존 코스 번호에 대한 제목/내용에 대한 수정이 따로 필요하다.
			//이에 대해서 업데이트 해주고
			courseDao.update(courseDto);
			//새로 만든 시퀀스에 대한 정보는 덮어쓰기 이후 삭제해주면 된다.
			courseItemDao.delete(courseIdx);//courseIdx:임시 생성 번호였음 24번째 줄
			
			
			
//			추후에 detail.jsp로 보낼것!!!!!
			resp.sendRedirect("detail.jsp?courseIdx="+courseOriginSequnce);//courseOriginSequnce기존 코스 번호.
			
		}catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
