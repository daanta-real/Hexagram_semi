package servlet.item;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.ItemDao;
import beans.ItemDto;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/jsp/item/count.nogari")
public class ItemCountServlet extends HttpServlet{
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try{

		int itemIdx = Integer.parseInt(req.getParameter("itemIdx"));

		ItemDao itemDao = new ItemDao();
		ItemDto itemDto = itemDao.get(itemIdx);

		itemDto.setItemCount(itemDto.getItemCount()+1);
		itemDao.updateCount(itemDto);
		//조회수 1증가 시킴.

		resp.sendRedirect(req.getContextPath()+"/jsp/item/detail.jsp?itemIdx="+itemIdx);

	}catch (Exception e) {
		e.printStackTrace();
		resp.sendError(500);
	}
	}
}
