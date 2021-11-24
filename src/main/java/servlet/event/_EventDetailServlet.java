package servlet.event;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import beans.EventDao;
import beans.EventDto;
import system.Settings;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/event/detail.nogari")
public class _EventDetailServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String savePath = Settings.PATH_FILES;
			int maxSize = 5 * 1024 * 1024;
			String encoding = "UTF-8";
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			MultipartRequest mRequest = new MultipartRequest(req, savePath, maxSize, encoding, policy);

			int eventIdx = Integer.parseInt(req.getParameter("eventIdx"));

			EventDao eventDao = new EventDao();
			EventDto eventDto = eventDao.select(eventIdx);

			if(eventDto != null) {
				resp.getWriter().println("이벤트 번호 : "+eventDto.getEventIdx());
				resp.getWriter().println("회원명 : "+eventDto.getUsersIdx());
				resp.getWriter().println("이벤트 제목 : "+eventDto.getEventName());
				resp.getWriter().println("이벤트 내용 : "+eventDto.getEventDetail());
				resp.getWriter().println("날짜 : "+eventDto.getEventDate());
				resp.getWriter().println("조회 수 : "+eventDto.getEventCountView());
				resp.getWriter().println("댓글 수: "+eventDto.getEventCountReply());

			}

			boolean result = eventDao.update(eventDto);

			if(result) {
				resp.sendRedirect("detail.jsp?eventIdx="+eventDto.getEventIdx());
				return;
			}
			else throw new Exception();
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
