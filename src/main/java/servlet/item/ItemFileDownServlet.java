package servlet.item;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.ItemFileDao;
import beans.ItemFileDto;
import system.Settings;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/item/file/download.nogari")
public class ItemFileDownServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//파일 다운로드Servlet (디테일 페이지 및 목록페이지에서 출력하기 위한 Servlet)
		try {
			
			//입력 : (파일 조회를 위해 등록된 파일 번호를 받는다)
			int itemFileIdx = Integer.parseInt(req.getParameter("itemFileIdx"));

			//처리
			//파일 단일조회
			ItemFileDao itemFileDao = new ItemFileDao();
			ItemFileDto itemFileDto = itemFileDao.get(itemFileIdx);

			//파일 정보 설정
			File dir = new File(Settings.PATH_FILES);
			//전송될 파일(경로, 저장된 파일 이름)
			File target = new File(dir,itemFileDto.getItemFileSaveName());
			//파일 전송을 위해 Stream 선언
			FileInputStream in = new FileInputStream(target);
			//전송될 크기
			byte[]buffer = new byte[8192];

			//3. 헤더 설정 and 한글 파일명 변환 처리
			String uploadName = URLEncoder.encode(itemFileDto.getItemFileUploadname(),"UTF-8");
			uploadName = uploadName.replace("+", "%20");
			resp.setHeader("Content-Type", "application/octet-stream");
			resp.setHeader("Content-Disposition", "attachment; fileName="+uploadName);
			resp.setHeader("Content-Encoding", "UTF-8");
			resp.setHeader("Content-Length", String.valueOf(itemFileDto.getItemFileSize()));

			//출력(다운로드)
			while(true) {
				//다운로드 받을 크기는 위에 적용된 buffer(전송될 크기)를 읽어
				int size = in.read(buffer);
				//크기가 0이하가 되면 멈추고
				if(size == -1) break;
				//Stream을 이용하여 전송
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
