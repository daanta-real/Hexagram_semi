package servlet.item.reply;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.ItemDao;
import beans.ItemReplyDao;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/item_reply/delete.nogari")
public class ItemReplyDeleteServlet extends HttpServlet {
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try{
		//이것도 필터에서 본인만 가능하게 설정해준다. 수정 삭제 등
		int itemReplyIdx = Integer.parseInt(req.getParameter("itemReplyIdx"));
		int itemIdx = Integer.parseInt(req.getParameter("itemIdx"));
		
		ItemReplyDao itemReplyDao = new ItemReplyDao();
		itemReplyDao.delete(itemReplyIdx);
		
//		게시물 댓글 감소 최신화 시키기
		ItemDao itemDao = new ItemDao();
		itemDao.countReply(itemIdx);
		
		resp.sendRedirect(req.getContextPath()+"/item/detail.jsp?itemIdx="+itemIdx);
	}catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
		resp.sendError(500);
	}
	}
}
