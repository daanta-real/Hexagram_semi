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
@WebServlet(urlPatterns = "/jsp/item_reply/target_insert.nogari")
public class ItemReplyInsertTargetServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			try {
				//댓글 내용 받기
				String itemReplyDetail = req.getParameter("itemReplyDetail");
				//게시글 번호 받기
				int itemIdx = Integer.parseInt(req.getParameter("itemIdx"));
				//회원 번호 받기
				int usersIdx = Integer.parseInt(req.getParameter("usersIdx"));
				//대댓글 대상 댓글 번호 받기.
				int itemReplyTargetIdx = Integer.parseInt(req.getParameter("itemReplyTargetIdx"));

				ItemReplyDao itemReplyDao = new ItemReplyDao();
				ItemReplyDto itemReplyDto = new ItemReplyDto();

				itemReplyDto.setItemIdx(itemIdx);
				itemReplyDto.setUsersIdx(usersIdx);
				itemReplyDto.setItemReplyDetail(itemReplyDetail);
				itemReplyDto.setItemReplyTargetIdx(itemReplyTargetIdx);
				//Dto에 4가지의 정보를 담아서 대댓글 추가 작업 시행.

				itemReplyDao.insertTarget(itemReplyDto);

				resp.sendRedirect(req.getContextPath()+"/jsp/item/detail.jsp?itemIdx="+Integer.parseInt(req.getParameter("itemIdx")));

			}catch (Exception e) {
				e.printStackTrace();
				resp.sendError(500);
			}
	}
}
