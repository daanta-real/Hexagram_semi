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
@WebServlet(urlPatterns = "/event/download.nogari")
public class EventFileDownServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {

			// 1. 변수 준비
			System.out.println("[파일 다운로드] 1. 변수 준비");
			String fileIdxStr = req.getParameter("eventFileIdx");
			if(fileIdxStr == null) throw new Exception(); // 입력값 없으면 에러 뿜기
			Integer fileIdx = Integer.parseInt(fileIdxStr);

			// 2. 파일 단일조회
			System.out.print("[파일 다운로드] 2. 파일 단일 조회..");
			EventFileDao dao = new EventFileDao();
			EventFileDto dto = dao.get(fileIdx);
			System.out.println(" 완료. 조회된 파일 정보: " + dto);

			// 3. 파일 정보 설정
			System.out.println("[파일 다운로드] 3. 파일 정보 설정");
			File dir = new File(Settings.PATH_FILES);
			String fileName = dto.getEventFileSaveName();
			File target = new File(dir, fileName);
			FileInputStream in = new FileInputStream(target);
			int bufferSize = 8192;
			byte[] buffer = new byte[bufferSize];
			long fileSize = dto.getEventFileSize();
			System.out.println("[파일 다운로드] 3. 파일 정보 설정 완료, 파일명 = " + fileName);

			// 4. 헤더 설정 and 한글 파일명 변환 처리
			System.out.print("[파일 다운로드] 4. 다운로드를 위한 헤더 설정..");
			String orgName = URLEncoder.encode(dto.getEventFileUploadName(), "UTF-8");
			orgName = orgName.replace("+", "%20");
			resp.setHeader("Content-Type", "application/octet-stream");
			resp.setHeader("Content-Disposition", "attachment; fileName=" + orgName);
			resp.setHeader("Content-Encoding", "UTF-8");
			resp.setHeader("Content-Length", String.valueOf(fileSize));
			System.out.println(" 완료.");

			// 5. 출력(다운로드)
			System.out.println("[파일 다운로드] 5. 스트림 출력 시작.");
			int totalSent = 0, sentPerc = -1, newSentPerc = 0;
			while(true) {

				// 파일 버퍼 전송
				int size = in.read(buffer);
				if(size == -1) break;
				resp.getOutputStream().write(buffer, 0, size);

				// 전송률 출력
				totalSent += bufferSize;
				newSentPerc = (int) (100f * totalSent / fileSize);
				if(sentPerc != newSentPerc) {
					sentPerc = newSentPerc;
					if(sentPerc > 100) sentPerc = 100;
					System.out.println(sentPerc + "%");
				}

			}
			System.out.print("[파일 다운로드] 5. 전송 완료.");

			// 6. 정상 종료
			System.out.print("[파일 다운로드] 6. 파일이 정상적으로 전송 완료되었습니다.");
			in.close();

		}

		catch (Exception e){

			System.out.println("[파일 다운로드] 다운로드에 실패하였습니다.");
			e.printStackTrace();
			resp.sendError(500);

		}
	}
}
