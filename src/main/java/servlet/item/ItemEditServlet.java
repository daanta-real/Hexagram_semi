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
@WebServlet(urlPatterns = "/item/edit.nogari")
public class ItemEditServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {

			ItemDto itemDto = new ItemDto();
			itemDto.setItemIdx(Integer.parseInt(req.getParameter("itemIdx")));
			itemDto.setItemType(req.getParameter("itemType"));
			itemDto.setItemName(req.getParameter("itemName"));
			itemDto.setItemAddress(req.getParameter("itemAddress"));
			itemDto.setItemDetail(req.getParameter("itemDetail"));
			itemDto.setItemTags(req.getParameter("itemTages"));
			itemDto.setItemPeriods(req.getParameter("itemPeriods"));
			itemDto.setItemTime(req.getParameter("itemTime"));
			itemDto.setItemHomepage(req.getParameter("itemHompage"));
			itemDto.setItemParking(req.getParameter("itemParking"));

			ItemDao itemDao = new ItemDao();
			itemDao.update(itemDto);

			resp.sendRedirect(req.getContextPath() + "/item/detail.jsp?itemIdx="+itemDto.getItemIdx());

		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
