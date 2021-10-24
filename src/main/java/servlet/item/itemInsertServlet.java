package servlet.item;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.ItemDao;
import beans.ItemDto;

@WebServlet (urlPatterns = "/jsp/item/insert.nogari")
public class itemInsertServlet extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
				
			//입력
			ItemDto itemDto = new ItemDto();
			itemDto.setUsers_idx((int)req.getSession().getAttribute("users_key"));
			itemDto.setItem_type(req.getParameter("item_type"));
			itemDto.setItem_name(req.getParameter("item_name"));
			itemDto.setItem_address(req.getParameter("item_address"));
			itemDto.setItem_detail(req.getParameter("item_detail"));
			itemDto.setItem_tags(req.getParameter("item_tags"));
			itemDto.setItem_period(req.getParameter("item_period"));
			itemDto.setItem_time(req.getParameter("item_time"));
			itemDto.setItem_homepage(req.getParameter("item_homepage"));
			itemDto.setItem_parking(req.getParameter("item_parking"));
			
			//처리
			ItemDao itemDao = new ItemDao();
			boolean success = itemDao.insert(itemDto);
			
			if(success) {
				//등록 성공이라면
				resp.sendRedirect("insert_success.jsp");
			}
			else {
				//실패라면
				resp.sendRedirect("insert.jsp?error");
			}
		
					
		}
		catch(Exception e){
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
