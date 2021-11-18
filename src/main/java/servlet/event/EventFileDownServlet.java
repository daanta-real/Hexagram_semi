package servlet.event;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.EventFileDao;
import beans.EventFileDto;
import system.Settings;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/event/file/download.nogari")
public class EventFileDownServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			//입력 :
			int eventFileNo = Integer.parseInt(req.getParameter("eventFileNo"));

			//처리
			//1. 파일 단일조회
			EventFileDao eventFileDao = new EventFileDao();
			EventFileDto eventFileDto = eventFileDao.get(eventFileNo);

			//2. 파일 정보 설정
			File dir = new File(Settings.PATH_FILES);
			File target = new File(dir,eventFileDto.getEventFileSaveName());
			FileInputStream in = new FileInputStream(target);
			byte[]buffer = new byte[8192];

			//3. 헤더 설정 and 한글 파일명 변환 처리
			String uploadName = URLEncoder.encode(eventFileDto.getEventFileUploadName(),"UTF-8");
			uploadName = uploadName.replace("+", "%20");
			resp.setHeader("Content-Type", "application/octet-stream");
			resp.setHeader("Content-Disposition", "attachment; fileName="+uploadName);
			resp.setHeader("Content-Encoding", "UTF-8");
			resp.setHeader("Content-Length", String.valueOf(eventFileDto.getEventFileSize()));

			//4. 출력(다운로드)
			while(true) {
				int size = in.read(buffer);
				if(size == -1) break;
				resp.getOutputStream().write(buffer, 0, size);
			}

			in.close();

		}
		catch (Exception e){
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
