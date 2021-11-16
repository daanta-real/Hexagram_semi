package servlet.course;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.CourseItemDao;
import beans.CourseItemDto;

@WebServlet(urlPatterns = "/course/ajax_delete_update_item.nogari")
public class CourseItemAjaxDeleteForUpdateServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		try {
			//코스게시물 수정시 관광지 삭제에 필요한 Servlet
			
			//입력
			//itemIdx : 파라미터로 받은 itemIdx 변수에 저장
			//courseIdx : 파라미터로 받은 courseIdx 변수에 저장
			int itemIdx = Integer.parseInt(req.getParameter("itemIdx"));
			int courseIdx = Integer.parseInt(req.getParameter("courseIdx"));
			
			//처리
			CourseItemDao courseItemDao = new CourseItemDao();
			//수정해야 할 courseIdx를 받아 목록을 조회
			List<CourseItemDto> courseItemList = courseItemDao.getByCourse(courseIdx);
			
			//만약 courseItem이 3개 이상이라면
			if(courseItemList.size() > 3) {
			CourseItemDto courseItemDto = new CourseItemDto();
			courseItemDto.setCourseIdx(courseIdx);
			courseItemDto.setItemIdx(itemIdx);
			
			//관광지를 삭제 할 수 있다.
			courseItemDao.deleteItem(courseItemDto);
			//관광지를 삭제하면 브라우저에 삭제된 개수에서 -1하여 출력
			resp.getWriter().write(String.valueOf(courseItemList.size()-1));
			}
			
			//3개 이하로 삭제할 경우 브라우저에 NNNNN을 출력 (삭제 할수 없다) 
			else {
				 resp.getWriter().write("NNNNN");
			 }	
		}
		
		//예외는 던진다
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
