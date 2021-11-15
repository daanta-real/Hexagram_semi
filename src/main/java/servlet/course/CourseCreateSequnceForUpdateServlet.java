package servlet.course;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.CourseDao;
import beans.CourseItemDao;
import beans.CourseItemDto;
import beans.ItemDto;

@WebServlet(urlPatterns = "/course/udpate_sequence.nogari")
public class CourseCreateSequnceForUpdateServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			try {
				
				 CourseDao courseDao = new CourseDao();
				 
				 int courseSequnce = courseDao.getSequence(); //새로 생성한 번호
				 int courseOriginSequnce = Integer.parseInt(req.getParameter("courseOriginSequnce")); //기존 번호
				 
				 //넘기기전에 새로 생성한 번호에 기존 번호의 목록을 넣어준다(추후에 새로운 번호는 무조건 삭제되지만, 덮어쓸건지는 완료후에 결정토록 하겠다.)
				 
				 CourseItemDao courseItemDao = new CourseItemDao();
				 List<CourseItemDto> originList = courseItemDao.getByCourse(courseOriginSequnce);//기존의 아이템 목록을 가져오기 위함
				 
				 for(CourseItemDto courseItemDto : originList) {
					 CourseItemDto courseItemUpdateDto = new CourseItemDto();
					 courseItemUpdateDto.setCourseIdx(courseSequnce);
					 courseItemUpdateDto.setItemIdx(courseItemDto.getItemIdx());
					 
					 courseItemDao.insert(courseItemUpdateDto);
					 //있는 것 만큼 담아준다.
				 }
				 
				 
				 resp.sendRedirect("update.jsp?courseSequnce="+courseSequnce+"&courseOriginSequnce="+courseOriginSequnce);
				
			}catch (Exception e) {
				e.printStackTrace();
				resp.sendError(500);
			}
	}
}
