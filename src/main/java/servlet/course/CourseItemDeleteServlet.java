package servlet.course;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.CourseItemDao;
import beans.CourseItemDto;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/course/delete_course_item.nogari2")
public class CourseItemDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {

			//ajax 배우기전 Servlet(현재는 사용하지 않음 urlPatterns 뒤에 2를 붙혀 접근하지 못하도록 설정)

			int itemIdx = Integer.parseInt(req.getParameter("itemIdx"));
			int courseSequnce = Integer.parseInt(req.getParameter("courseSequnce"));
			String city = req.getParameter("city");
			if(city.length() != 4) city = city.substring(0,2);


			CourseItemDao courseItemDao = new CourseItemDao();
			CourseItemDto courseItemDto = new CourseItemDto();
			courseItemDto.setCourseIdx(courseSequnce);
			courseItemDto.setItemIdx(itemIdx);

			courseItemDao.deleteItem(courseItemDto);

			resp.sendRedirect("insert.jsp?courseSequnce="+courseSequnce+"&city="+URLEncoder.encode(city,"UTF-8"));
			return;

		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			resp.sendError(500);
		}

	}
}
