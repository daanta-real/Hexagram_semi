package servlet.course;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.CourseItemDao;
import beans.CourseItemDto;
import beans.ItemDao;
import beans.ItemDto;

@WebServlet(urlPatterns = "/course/insert_course_item.nogari")
public class CourseItemInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");

			
			int itemIdx = Integer.parseInt(req.getParameter("itemIdx"));
			int courseSequnce = Integer.parseInt(req.getParameter("courseSequnce"));
			String city = req.getParameter("city");
			
			CourseItemDao courseItemDao = new CourseItemDao();
			CourseItemDto courseItemDto = new CourseItemDto();
			courseItemDto.setCourseIdx(courseSequnce);
			courseItemDto.setItemIdx(itemIdx);
			
			
//			데이터를 넣기전에 중복된 값인지 체크해서 에러를 발생시켜줘야한다. 있다면 데이터를 추가시키지 않는다.
		    List<CourseItemDto> courseItemList = courseItemDao.getByCourse(courseSequnce);
		    
		    if(!courseItemList.isEmpty()) {
		    	
		    	CourseItemDto itemIdxBox = new CourseItemDto();
		    	itemIdxBox.setItemIdx(itemIdx);
		    	
		    	boolean isContainItem = courseItemList.indexOf(itemIdxBox) >= 0;
		    	
		    	//같은 도시명인지 확인을 해줘야 한다.
		    	ItemDao itemDao = new ItemDao();
		    	
		    	ItemDto itemDtoCheck = itemDao.get(courseItemList.get(0).getItemIdx());
		    	ItemDto itemDto = itemDao.get(itemIdx);
		    	
		    	boolean isSameCity = itemDto.getItemAddress().substring(0, 2).equals(itemDtoCheck.getItemAddress().substring(0, 2));

		    	if(!isContainItem && isSameCity) {
			    	courseItemDao.insert(courseItemDto);
//					코스 아이템 DB에 생성된 코스번호로 아이템을 추가한다.
					resp.sendRedirect("insert.jsp?courseSequnce="+courseSequnce);
//					정상적으로 중복확인을 하였다면 추가 후에 에러없이 insert.jsp에 다시 코스번호를 전달한다.
		    	}else {
		    		resp.sendRedirect("insert.jsp?error&courseSequnce="+courseSequnce);
		    	}
//		    	리스트 첫번째에 들어간 도시명이랑 같은지만 비교해주자.
		    
		    }else {
		    	courseItemDao.insert(courseItemDto);
				resp.sendRedirect("insert.jsp?courseSequnce="+courseSequnce);
		    }

//		    딜리트 까지만.
//		    코스 추가코드는 내일
			
		}catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
		
	}
}
