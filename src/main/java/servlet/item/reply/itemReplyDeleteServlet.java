package servlet.item.reply;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.ItemReplyDao;

@WebServlet(urlPatterns = "/jsp/item/deleteReply.kh")
public class itemReplyDeleteServlet extends HttpServlet {
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try{
		//이것도 필터에서 본인만 가능하게 설정해준다. 수정 삭제 등
		int itemReplyIdx = Integer.parseInt(req.getParameter("itemReplyIdx"));
		int itemIdx = Integer.parseInt(req.getParameter("itemIdx"));
		ItemReplyDao itemReplyDao = new ItemReplyDao();
		itemReplyDao.delete(itemReplyIdx);
		
		resp.sendRedirect("detail.jsp?itemIdx="+itemIdx);
	}catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
		resp.sendError(500);
	}
	}
}
