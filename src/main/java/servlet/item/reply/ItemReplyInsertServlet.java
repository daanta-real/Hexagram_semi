package servlet.item.reply;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.ItemDao;
import beans.ItemReplyDao;
import beans.ItemReplyDto;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/item_reply/insert.nogari")
public class ItemReplyInsertServlet extends HttpServlet {
@Override
protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//댓글 내용 받기
			String itemReplyDetail = req.getParameter("itemReplyDetail");
			//게시글 번호 받기
			int itemIdx = Integer.parseInt(req.getParameter("itemIdx"));
			//회원 번호 받기
			int usersIdx = (int)req.getSession().getAttribute("usersIdx");

			ItemReplyDao itemReplyDao = new ItemReplyDao();
			ItemReplyDto itemReplyDto = new ItemReplyDto();
			
			int itemReplyIdx = itemReplyDao.getSequenceNo();
			
			itemReplyDto.setItemReplyIdx(itemReplyIdx);
			itemReplyDto.setItemIdx(itemIdx);
			itemReplyDto.setUsersIdx(usersIdx);
			itemReplyDto.setItemReplyDetail(itemReplyDetail);
			//Dto에 3가지의 정보를 담아서 댓글 추가 작업 시행.

			itemReplyDao.insert(itemReplyDto);
			
//			게시물 댓글 수 추가
			ItemDao itemDao = new ItemDao();
			itemDao.countReply(itemIdx);
			
			resp.sendRedirect(req.getContextPath()+"/item/detail.jsp?itemIdx="+Integer.parseInt(req.getParameter("itemIdx")));

		}catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
}
}
