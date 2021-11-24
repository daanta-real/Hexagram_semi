package servlet.event;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.EventDao;
import beans.EventFileDao;
import beans.EventFileDto;
import system.Settings;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/event/delete.nogari")
public class EventDeleteServlet extends HttpServlet {
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int usersIdx = Integer.parseInt(req.getParameter("usersIdx"));

			EventDao eventDao = new EventDao();

			EventFileDao eventFileDao = new EventFileDao();
			EventFileDto eventFileOrigin = eventFileDao.delete(usersIdx);
			File dir = new File(Settings.PATH_FILES);
			File target = new File(dir,eventFileOrigin.getEventFileSaveName());
//			저장된 파일을 삭제
			target.delete();
//			파일 정보를 삭제
			eventFileDao.delete(eventFileOrigin.getEventFileIdx());

			eventDao.delete(usersIdx);

			resp.sendRedirect(req.getContextPath() + "/event/list.jsp");
			return;

		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
