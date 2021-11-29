package servlet.event.reply;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.EventDao;
import beans.EventReplyDao;
import beans.EventReplyDto;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/event_reply/insert.nogari")
public class EventReplyInsertServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//댓글 내용 받기
			String eventReplyDetail = req.getParameter("eventReplyDetail");
			//게시글 번호 받기
			int eventIdx = Integer.parseInt(req.getParameter("eventIdx"));
			//회원 번호 받기
			int usersIdx = (int)req.getSession().getAttribute("usersIdx");

			EventReplyDao EventReplyDao = new EventReplyDao();
			EventReplyDto eventReplyDto = new EventReplyDto();

			int eventReplySeq = EventReplyDao.getSequenceNo();

			eventReplyDto.setEventReplyIdx(eventReplySeq);
			eventReplyDto.setEventIdx(eventIdx);
			eventReplyDto.setUsersIdx(usersIdx);
			eventReplyDto.setEventReplyDetail(eventReplyDetail);


			if(req.getParameter("eventReplyIdx") != null) {
				int eventReplyIdx = Integer.parseInt(req.getParameter("eventReplyIdx"));
				EventReplyDto eventReplyParent = EventReplyDao.get(eventReplyIdx);

				eventReplyDto.setEventReplySuperno(eventReplyIdx);
				eventReplyDto.setEventReplyGroupno(eventReplyParent.getEventReplyGroupno());
				eventReplyDto.setEventReplyDepth(eventReplyParent.getEventReplyDepth()+1);

				EventReplyDao.insertTarget(eventReplyDto);
			}
			else {
				EventReplyDao.insert(eventReplyDto);
			}



//			게시물 댓글 수 추가
			EventDao eventDao = new EventDao();
			eventDao.countReply(eventIdx);

			resp.sendRedirect(req.getContextPath()+"/event/detail.jsp?eventIdx="+eventIdx);
			return;

		}catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
}
}
