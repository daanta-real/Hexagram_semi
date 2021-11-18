package servlet.event;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.EventReplyDao;
import beans.EventReplyDto;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/event_reply/update.nogari")
public class EventReplyUpdateServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//업데이트 대상 댓글 내용 받기
			String eventReplyDetail = req.getParameter("eventReplyDetail");
			//업데이트 대상 댓글 번호 받기
			int eventReplyIdx = Integer.parseInt(req.getParameter("eventReplyIdx"));
			//업데이트 후 돌아갈 게시물 번호 받기
			int eventIdx = Integer.parseInt(req.getParameter("eventIdx"));
			
			EventReplyDao eventReplyDao = new EventReplyDao();
			EventReplyDto eventReplyDto = new EventReplyDto();
			
			eventReplyDto.setEventReplyIdx(eventReplyIdx);
			eventReplyDto.setEventReplyDetail(eventReplyDetail);
			
			eventReplyDao.update(eventReplyDto);
			
			//댓글 업데이트 후 원래의 게시판으로 돌아간다.
			resp.sendRedirect(req.getContextPath()+"/event/detail.jsp?eventIdx="+eventIdx);
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
