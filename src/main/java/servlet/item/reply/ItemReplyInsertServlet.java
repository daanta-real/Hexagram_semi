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

		//댓글 등록 Servlet
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

			//대댓글일 경우 itemReplyTargetIdx를 파라미터값으로 받는다(만약 null이 아니라면 - 대댓글이라면)
			if(req.getParameter("itemReplyTargetIdx") != null) {
				//파라미터로 받은 상위 댓글번호를 int 변수에 저장
				int itemReplyTargetIdx = Integer.parseInt(req.getParameter("itemReplyTargetIdx"));
				//저장된 값으로 댓글 단일 조회
				ItemReplyDto itemReplyParent = itemReplyDao.get(itemReplyTargetIdx);

				//상위 번호와 그룹 번호를 확인하여 댓글 차수 1증가
				itemReplyDto.setItemReplySuperno(itemReplyTargetIdx);
				itemReplyDto.setItemReplyGroupno(itemReplyParent.getItemReplyGroupno());
				itemReplyDto.setItemReplyDepth(itemReplyParent.getItemReplyDepth()+1);

				//대댓글 추가
				itemReplyDao.insertTarget(itemReplyDto);

			}

			//대댓글이 아닐경우 댓글로 등록
			else {
				itemReplyDao.insert(itemReplyDto);
			}



			//게시물 댓글 수 증가(목록 페이지에서 제목옆에 댓글수를 표시하기 위해 댓글 갱신 메소드를 이용하여 댓글을 갯수를 갱신한다)
			ItemDao itemDao = new ItemDao();
			itemDao.countReply(itemIdx);

			resp.sendRedirect(req.getContextPath()+"/item/detail.jsp?itemIdx="+Integer.parseInt(req.getParameter("itemIdx")));
			return;

		}catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
}
}
