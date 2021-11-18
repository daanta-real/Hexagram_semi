package servlet.event;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.EventDao;
import beans.EventReplyDao;


@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/event_reply/delete.nogari")
public class EventReplyDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try{
			int eventReplyIdx = Integer.parseInt(req.getParameter("eventReplyIdx"));
			int eventIdx = Integer.parseInt(req.getParameter("eventIdx"));

			EventReplyDao eventReplyDao = new EventReplyDao();
			eventReplyDao.delete(eventReplyIdx);

			EventDao eventDao = new EventDao();
			eventDao.countReply(eventIdx);

			resp.sendRedirect(req.getContextPath()+"/event/detail.jsp?eventIdx="+eventIdx);
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}