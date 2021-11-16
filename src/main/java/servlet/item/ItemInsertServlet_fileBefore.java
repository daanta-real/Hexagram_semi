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
@WebServlet (urlPatterns = "/item/insert.nogari2")
public class ItemInsertServlet_fileBefore extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//파일 첨부 전 관광지 등록 Servlet (사용하지 않음)
		try {
			//현재 회원이 작성
			int usersIdx = (int)req.getSession().getAttribute("usersIdx");
			
			ItemDao itemDao = new ItemDao();
			ItemDto itemDto = new ItemDto();
			
			//itemIdx 번호 생성
			int sequnceNo = itemDao.getSequence();
			
			itemDto.setItemIdx(sequnceNo);
			itemDto.setUsersIdx(usersIdx);
			itemDto.setItemType(req.getParameter("itemType"));
			itemDto.setItemName(req.getParameter("itemName"));
			itemDto.setItemDetail(req.getParameter("itemDetail"));
			itemDto.setItemPeriod(req.getParameter("itemPeriod"));
			itemDto.setItemTime(req.getParameter("itemTime"));
			itemDto.setItemHomepage(req.getParameter("itemHomepage"));
			itemDto.setItemParking(req.getParameter("itemParking"));
			itemDto.setItemAddress(req.getParameter("itemAddress"));
			
			//글 등록.
			itemDao.insertWithSequence(itemDto);
			
			resp.sendRedirect("detail.jsp?itemIdx="+sequnceNo);
			
		}
		catch(Exception e){
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
