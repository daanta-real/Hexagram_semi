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

	//댓글 삭제 Servlet (댓글 작성자만 가능)
	try{

		//이것도 필터에서 본인만 가능하게 설정해준다. 수정 삭제 등 (게시글 작성자만 수정이 가능하도록)
		int itemReplyIdx = Integer.parseInt(req.getParameter("itemReplyIdx"));
		int itemIdx = Integer.parseInt(req.getParameter("itemIdx"));

		ItemReplyDao itemReplyDao = new ItemReplyDao();
		itemReplyDao.delete(itemReplyIdx);

		//게시물 댓글 감소 최신화 시키기
		ItemDao itemDao = new ItemDao();
		itemDao.countReply(itemIdx);

		//완료후 (댓글 삭제한 게시글로 이동)
		resp.sendRedirect(req.getContextPath()+"/item/detail.jsp?itemIdx="+itemIdx);
		return;

	}catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
		resp.sendError(500);
	}
	}
}