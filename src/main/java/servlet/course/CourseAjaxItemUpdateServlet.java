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
import beans.ItemDao;
import beans.ItemDto;

@WebServlet(urlPatterns = "/course/ajax_item_update.nogari")
public class CourseAjaxItemUpdateServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//insert.jsp의  $(".item-add-btn").on("click", function(){})의 옵션으로 통신 
			int itemIdx = Integer.parseInt(req.getParameter("itemIdx"));
			int courseIdx = Integer.parseInt(req.getParameter("courseIdx"));
			
			CourseItemDao courseItemDao = new CourseItemDao();
			CourseItemDto courseItemDto = new CourseItemDto();
			courseItemDto.setCourseIdx(courseIdx);
			courseItemDto.setItemIdx(itemIdx);
			ItemDao itemDao = new ItemDao();
			
//			데이터를 넣기전에 중복된 값인지 체크해서 에러를 발생시켜줘야한다. 있다면 데이터를 추가시키지 않는다.
		    List<CourseItemDto> courseItemList = courseItemDao.getByCourse(courseIdx);

		    

		    if(!courseItemList.isEmpty()) {
			    if(courseItemList.size()>=8) {
			    	resp.getWriter().write("NNNNO");
			    	//선택수량이 6개를 초과할 경우 추가안되게 함.
			    }else {
		    	CourseItemDto itemIdxBox = new CourseItemDto();
		    	itemIdxBox.setItemIdx(itemIdx);    	
		    	boolean isContainItem = courseItemList.indexOf(itemIdxBox) >= 0;
		    	
		    	//같은 도시명인지 확인을 해줘야 한다.
		    	
		    	ItemDto itemDtoCheck = itemDao.get(courseItemList.get(0).getItemIdx());
		    	ItemDto itemDto = itemDao.get(itemIdx);
		    	
		    	String cityCheck = itemDtoCheck.getAdressCity();
		    	if(cityCheck.length() != 4) {
		    		cityCheck = itemDtoCheck.getAdressCity().substring(0,2);
		    	}
		    	String city = itemDto.getAdressCity();
		    	if(city.length() != 4) {
		    		city = itemDto.getAdressCity().substring(0,2);
		    	}
		    	
		    	boolean isSameCity = cityCheck.equals(city);

		    	if(isContainItem) {
		    		resp.getWriter().write("NNNNC");
		    	}else if(!isSameCity){
		    		resp.getWriter().write("NNNNS");
		    	}else {
		    		courseItemDao.insert(courseItemDto);
			    	resp.getWriter().write(String.valueOf(courseItemList.size()+1));
		    	}
		    }
		    }else {
		    	courseItemDao.insert(courseItemDto);
				resp.getWriter().write(String.valueOf(courseItemList.size()+1));
		    }
		  
		}catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
