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

@WebServlet(urlPatterns = "/course/ajax_item_add.nogari")
public class CourseAjaxItemAddServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			//코스 등록시 course_item에 먼저 등록하기 위한 Servlet
			
			//insert.jsp의  $(".item-add-btn").on("click", function(){})의 옵션으로 통신 
			int itemIdx = Integer.parseInt(req.getParameter("itemIdx"));
			int courseIdx = Integer.parseInt(req.getParameter("courseIdx"));
			String usersFilterId = req.getParameter("usersFilterId"); //최초 시퀀스를 만든사람만이 삭제가 가능하도록 설정.
			
			//등록 처리
			CourseItemDao courseItemDao = new CourseItemDao();
			CourseItemDto courseItemDto = new CourseItemDto();
			//파라미터로 받은 courseIdx값
			courseItemDto.setCourseIdx(courseIdx);
			//파라미터로 받은 itemIdx값
			courseItemDto.setItemIdx(itemIdx);
			ItemDao itemDao = new ItemDao();
			
			//데이터를 넣기전에 중복된 값인지 체크해서 에러를 발생시켜줘야한다. 있다면 데이터를 추가시키지 않는다.
		    List<CourseItemDto> courseItemList = courseItemDao.getByCourse(courseIdx);

		    
		    //만약 데이터가 있다면 (개수 확인)
		    if(!courseItemList.isEmpty()) {
		    	
		    	//만약 데이터의 개수가 8개 이상이라면
			    if(courseItemList.size()>=8) {
			    	//선택수량이 8개를 초과할 경우 추가안되게 함(브라우저에 NNNNO를 출력).
			    	resp.getWriter().write("NNNNO");
			    }
			    
			    //데이터 개수가 0개 이상 8개 이하라면 등록 시작
			    else {
			    	CourseItemDto itemIdxBox = new CourseItemDto();
			    	//등록 할 itemIdx값을 추가한다
			    	itemIdxBox.setItemIdx(itemIdx);
			    	//itemIdx의 개수를 체크
			    	boolean isContainItem = courseItemList.indexOf(itemIdxBox) >= 0;
			    	
			    	//같은 도시명인지 확인을 위해 중복되지 않은 데이터로 itemDao 단일조회
			    	ItemDto itemDtoCheck = itemDao.get(courseItemList.get(0).getItemIdx());
			    	//등록시 지역선택과 같은 지역인지 확인을 위해 파라미터로 받은 itemidx로 단일 조회
			    	ItemDto itemDto = itemDao.get(itemIdx);
			    	
			    		//중복되지 않은 데이터에서 도시명을 subString로 꺼낸다.
			    		String cityCheck = itemDtoCheck.getAdressCity();
			    		if(cityCheck.length() != 4) {
			    			cityCheck = itemDtoCheck.getAdressCity().substring(0,2);
			    		}
		    	
			    		//지역선택에서 선택된 값에서 도시명을 꺼낸다. 
			    		String city = itemDto.getAdressCity();
			    		if(city.length() != 4) {
			    			city = itemDto.getAdressCity().substring(0,2);
			    		}
		    	
		    			//위에서 꺼낸 두개의 도시명을 비교
		    			boolean isSameCity = cityCheck.equals(city);

		    			//만약 추가된 아이템중 동일한 관광지가 추가된다면
		    			if(isContainItem) {
		    				//브라우저에 NNNNC를 출력
		    				resp.getWriter().write("NNNNC");
		    			}
		    			//만약 처음선택한 지역과 다른 지역을 선택한다면
		    			else if(!isSameCity){
		    				//브라우저에 NNNNS를 출력
		    				resp.getWriter().write("NNNNS");
		    			}
		    			else {
		    				//동일한 지역을 선택했고, 모두 다른 관광지라면 추가
		    				courseItemDao.insert(courseItemDto);
		    				//데이터를 추가하면 브라우저에 List 사이즈를 숫자로 보여준다
		    				resp.getWriter().write(String.valueOf(courseItemList.size()+1));
		    			}
			    }
		    }
		    //제일 처음 등록된 데이터가 없을때 브라우저에 숫자를 출력해준다
		    else {
		    	courseItemDao.insert(courseItemDto);
				resp.getWriter().write(String.valueOf(courseItemList.size()+1));
		    }
		 
		}
		//예외는 던지기
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
