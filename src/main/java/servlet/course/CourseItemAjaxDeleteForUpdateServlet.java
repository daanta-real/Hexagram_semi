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

			
			int itemIdx = Integer.parseInt(req.getParameter("itemIdx"));
			int courseIdx = Integer.parseInt(req.getParameter("courseIdx"));
			
			CourseItemDao courseItemDao = new CourseItemDao();
			 List<CourseItemDto> courseItemList = courseItemDao.getByCourse(courseIdx);
			
			 
			 if(courseItemList.size() > 3) {
			CourseItemDto courseItemDto = new CourseItemDto();
			courseItemDto.setCourseIdx(courseIdx);
			courseItemDto.setItemIdx(itemIdx);
			
				courseItemDao.deleteItem(courseItemDto);
				resp.getWriter().write(String.valueOf(courseItemList.size()-1));
			 }else {
				 resp.getWriter().write("NNNNN");
			 }
		
			
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			resp.sendError(500);
		}
	
	}
}
