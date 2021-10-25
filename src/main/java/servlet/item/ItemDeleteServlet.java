package servlet.item;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.ItemDao;

@WebServlet(urlPatterns = "/jsp/item/delete.nogari")
public class ItemDeleteServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		try {
			
			int itemIdx = Integer.parseInt(req.getParameter("itemIdx"));
			
			ItemDao itemDao = new ItemDao();
			
			itemDao.delete(itemIdx);
			
			resp.sendRedirect(req.getContextPath() + "/jsp/item/list.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
