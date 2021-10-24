package servlet.item;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.ItemDao;
import beans.ItemDto;

@WebServlet(urlPatterns = "/jsp/item/count.nogari")
public class ItemCountServlet extends HttpServlet{
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try{
		
		int item_idx = Integer.parseInt(req.getParameter("item_idx"));
		
		ItemDao itemDao = new ItemDao();
		ItemDto itemDto = itemDao.get(item_idx);
		
		itemDto.setItem_count(itemDto.getItem_count()+1);
		itemDao.updateCount(itemDto);
		//조회수 1증가 시킴.
		
		resp.sendRedirect(req.getContextPath()+"/jsp/item/detail.jsp?item_idx="+item_idx);
		
	}catch (Exception e) {
		e.printStackTrace();
		resp.sendError(500);
	}
	}
}
