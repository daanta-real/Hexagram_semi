package servlet.item.reply;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.ItemReplyDao;
import beans.ItemReplyDto;

@WebServlet(urlPatterns = "/jsp/item_reply/insert_target.nogari")
public class ItemReplyInsetTargetServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			try {
				//댓글 내용 받기
				String item_reply_detail = req.getParameter("item_reply_detail");
				//게시글 번호 받기
				int item_idx = Integer.parseInt(req.getParameter("item_idx"));
				//회원 번호 받기
				int users_idx = Integer.parseInt(req.getParameter("users_idx"));
				//대댓글 대상 댓글 번호 받기.
				int item_reply_target_idx = Integer.parseInt(req.getParameter("item_reply_target_idx"));
				
				ItemReplyDao itemReplyDao = new ItemReplyDao();
				ItemReplyDto itemReplyDto = new ItemReplyDto();
				
				itemReplyDto.setItem_idx(item_idx);
				itemReplyDto.setUsers_idx(users_idx);
				itemReplyDto.setItem_reply_detail(item_reply_detail);
				itemReplyDto.setItem_reply_target_idx(item_reply_target_idx);
				//Dto에 4가지의 정보를 담아서 대댓글 추가 작업 시행.
				
				itemReplyDao.insertTarget(itemReplyDto);
				
				//새로고침 시에 조회수 추가 방지용 count 파라미터를 전달한다.
				resp.sendRedirect(req.getContextPath()+"/jsp/item_reply/list.jsp?count");
				
			}catch (Exception e) {
				e.printStackTrace();
				resp.sendError(500);
			}
	}
}
