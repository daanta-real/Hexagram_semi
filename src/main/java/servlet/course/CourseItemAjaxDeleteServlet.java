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

@WebServlet(urlPatterns = "/course/ajax_delete_item.nogari")
public class CourseItemAjaxDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	
		try {
			
			//코스 게시물 등록시 course_item에 추가된 관광지를 삭제하기 위한 Servlet
			
			//입력
			//itemIdx : 파라미터로 받은 itemIdx 변수에 저장
			//courseIdx : 파라미터로 받은 courseIdx 변수에 저장
			int itemIdx = Integer.parseInt(req.getParameter("itemIdx"));
			int courseIdx = Integer.parseInt(req.getParameter("courseSequnce"));
			
			//course_item에 저장된 목록을 보기위해 목록 출력
			CourseItemDao courseItemDao = new CourseItemDao();
			List<CourseItemDto> courseItemList = courseItemDao.getByCourse(courseIdx);
			
			CourseItemDto courseItemDto = new CourseItemDto();
			courseItemDto.setCourseIdx(courseIdx);
			courseItemDto.setItemIdx(itemIdx);
			
			//목록을 삭제
			courseItemDao.deleteItem(courseItemDto);
			
			//브라우저에 출력된 아이템 수에서 -1되어 출력된다
			resp.getWriter().write(String.valueOf(courseItemList.size()-1));

			
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
