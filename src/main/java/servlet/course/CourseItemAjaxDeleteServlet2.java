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

@WebServlet(urlPatterns = "/course/ajax_delete_item2.nogari")
public class CourseItemAjaxDeleteServlet2 extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse response) throws ServletException, IOException {
	
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
				response.getWriter().write(String.valueOf(courseItemList.size()-1));
			 }else {
				 response.getWriter().write("NNNNN");
			 }
		
			
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			response.sendError(500);
		}
	
	}
}
