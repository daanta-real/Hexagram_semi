package servlet.event;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.EventDao;
import beans.EventDto;

@SuppressWarnings("serial")
@WebServlet (urlPatterns = "/event/insert.nogari2")
public class EventInsertServlet_fileBefore extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//현재 회원이 작성
			int usersIdx = (int)req.getSession().getAttribute("usersIdx");
			
			EventDao eventDao = new EventDao();
			EventDto eventDto = new EventDto();
			
			//eventIdx 번호 생성
			int sequnceNo = eventDao.getSequence();
			
			eventDto.setEventIdx(sequnceNo);
			eventDto.setUsersIdx(usersIdx);
			eventDto.setEventName(req.getParameter("eventName"));
			eventDto.setEventDetail(req.getParameter("eventDetail"));;
			
			eventDao.insertWithSequence(eventDto);
			
			resp.sendRedirect("detail.jsp?eventIdx="+sequnceNo);
			
		}
		catch(Exception e){
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
