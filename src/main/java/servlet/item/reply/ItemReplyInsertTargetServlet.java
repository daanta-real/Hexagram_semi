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
@WebServlet(urlPatterns = "/item_reply/target_insert.nogari")
public class ItemReplyInsertTargetServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			try {
				//댓글 내용 받기
				String itemReplyDetail = req.getParameter("itemReplyDetail");
				//게시글 번호 받기
				int itemIdx = Integer.parseInt(req.getParameter("itemIdx"));
				//회원 번호 받기
				int usersIdx = (int)req.getSession().getAttribute("usersIdx");
				//대댓글 대상 댓글 번호 받기.
				int itemReplyTargetIdx = Integer.parseInt(req.getParameter("itemReplyTargetIdx"));
				
				ItemReplyDao itemReplyDao = new ItemReplyDao();
				ItemReplyDto itemReplyParent = itemReplyDao.get(itemReplyTargetIdx);
				ItemReplyDto itemReplyDto = new ItemReplyDto();
	
				int itemReplyIdx = itemReplyDao.getSequenceNo();
				
				itemReplyDto.setItemReplyIdx(itemReplyIdx);
				itemReplyDto.setUsersIdx(usersIdx);
				itemReplyDto.setItemIdx(itemIdx);
				itemReplyDto.setItemReplyDetail(itemReplyDetail);
				itemReplyDto.setItemReplySuperno(itemReplyTargetIdx);
				itemReplyDto.setItemReplyGroupno(itemReplyParent.getItemReplyGroupno());
				itemReplyDto.setItemReplyDepth(itemReplyParent.getItemReplyDepth()+1);
				//itemReplyDto.setItemReplyTargetIdx(itemReplyTargetIdx);
				//Dto에 4가지의 정보를 담아서 대댓글 추가 작업 시행.

				itemReplyDao.insertTarget(itemReplyDto);
				
//				게시물 댓글 수 추가
				ItemDao itemDao = new ItemDao();
				itemDao.countReply(itemIdx);

				resp.sendRedirect(req.getContextPath()+"/item/detail.jsp?itemIdx="+Integer.parseInt(req.getParameter("itemIdx")));

			}catch (Exception e) {
				e.printStackTrace();
				resp.sendError(500);
			}
	}
}
