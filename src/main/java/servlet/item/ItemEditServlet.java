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
			itemDto.setItemType(req.getParameter("itemType"));
			itemDto.setItemName(req.getParameter("itemName"));
			itemDto.setItemDetail(req.getParameter("itemDetail"));
			itemDto.setItemPeriod(req.getParameter("itemPeriod"));
			itemDto.setItemTime(req.getParameter("itemTime"));
			itemDto.setItemHomepage(req.getParameter("itemHomepage"));
			itemDto.setItemParking(req.getParameter("itemParking"));
			itemDto.setItemAddress(req.getParameter("itemAddress"));
			itemDto.setItemIdx(Integer.parseInt(req.getParameter("itemIdx")));
			
			ItemDao itemDao = new ItemDao();
			boolean result = itemDao.update(itemDto);
			
			//수정 성공시 상세 페이지로 이동
			if(result) {
				resp.sendRedirect("detail.jsp?itemIdx="+itemDto.getItemIdx());	
			}
			//수정 실패시 에러페이지 500번으로
			else {
				resp.sendError(500);
			}

		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
