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
import beans.EventFileDao;
import beans.EventFileDto;
import system.Settings;

@SuppressWarnings("serial")
@WebServlet (urlPatterns = "/event/insert.nogari")
public class EventInsertServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			String savePath = Settings.PATH_FILES;
			int maxSize = 5 * 1024 * 1024;
			String encoding = "UTF-8";
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			MultipartRequest mRequest = new MultipartRequest(req, savePath, maxSize, encoding, policy);

			int usersIdx = (int)req.getSession().getAttribute("usersIdx");

			EventDao eventDao = new EventDao();
			EventDto eventDto = new EventDto();

			int sequnceNo = eventDao.getSequence();

			eventDto.setEventIdx(sequnceNo);
			eventDto.setUsersIdx(usersIdx);
			eventDto.setEventName(mRequest.getParameter("eventName"));
			eventDto.setEventDetail(mRequest.getParameter("eventDetail"));

			eventDao.insertWithSequence(eventDto);

			if(mRequest.getFile("attach") != null) {
				
				EventFileDto eventFileDto = new EventFileDto();
				eventFileDto.setEventNo(sequnceNo);
				eventFileDto.setEventFileUploadName(mRequest.getOriginalFileName("attach"));
				eventFileDto.setEventFileSaveName(mRequest.getFilesystemName("attach"));
				eventFileDto.setEventFileType(mRequest.getContentType("attach"));
				eventFileDto.setEventFileSize(mRequest.getFile("attach").length());


				EventFileDao eventFileDao = new EventFileDao();
				eventFileDao.insert(eventFileDto);
			}

			resp.sendRedirect("detail.jsp?eventIdx="+sequnceNo);

		}
		catch(Exception e){
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
