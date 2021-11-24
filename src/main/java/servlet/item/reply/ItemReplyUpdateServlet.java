package servlet.item.reply;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.ItemReplyDao;
import beans.ItemReplyDto;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/item_reply/update.nogari")
public class ItemReplyUpdateServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//댓글 수정 Servlet
		try {

			//업데이트 대상 댓글 내용 받기
			String itemReplyDetail = req.getParameter("itemReplyDetail");
			//업데이트 대상 댓글 번호 받기
			int itemReplyIdx = Integer.parseInt(req.getParameter("itemReplyIdx"));
			//업데이트 후 돌아갈 게시물 번호 받기
			int itemIdx = Integer.parseInt(req.getParameter("itemIdx"));

			ItemReplyDao itemReplyDao = new ItemReplyDao();
			ItemReplyDto itemReplyDto = new ItemReplyDto();
			itemReplyDto.setItemReplyIdx(itemReplyIdx);
			itemReplyDto.setItemReplyDetail(itemReplyDetail);

			itemReplyDao.update(itemReplyDto);

			//댓글 업데이트 후 원래의 게시판으로 돌아간다.
			resp.sendRedirect(req.getContextPath()+"/item/detail.jsp?itemIdx="+itemIdx);
			return;

		}catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
