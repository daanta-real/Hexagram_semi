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
@WebServlet (urlPatterns = "/item/insert.nogari")
public class itemInsertServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {



			//입력
			ItemDto itemDto = new ItemDto();
			ItemDao itemDao = new ItemDao();
			int getSequenceNo = itemDao.getSequenceNo();

			itemDto.setItemIdx(getSequenceNo);
			itemDto.setUsersIdx((int)req.getSession().getAttribute("usersIdx"));
			itemDto.setItemType(req.getParameter("itemType"));
			itemDto.setItemName(req.getParameter("itemName"));
			itemDto.setItemAddress(req.getParameter("itemAddress"));
			itemDto.setItemDetail(req.getParameter("itemDetail"));
			itemDto.setItemTags(req.getParameter("itemTags"));
			itemDto.setItemPeriods(req.getParameter("itemPeriod"));
			itemDto.setItemTime(req.getParameter("itemTime"));
			itemDto.setItemHomepage(req.getParameter("itemHomepage"));
			itemDto.setItemParking(req.getParameter("itemParking"));

			//처리

			boolean success = itemDao.insert(itemDto);

			if(success) {
				//등록 성공이라면
				resp.sendRedirect(req.getContextPath() + "/item/detail.jsp?itemIdx=" + getSequenceNo);
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
