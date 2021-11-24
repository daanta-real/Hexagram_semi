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
import util.users.Sessioner;

@SuppressWarnings("serial")
@WebServlet (urlPatterns = "/event/insert.nogari")
public class EventCreateServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 1. 변수 준비
			System.out.println("[이벤트 - 신규] 1. 변수 준비");
			String savePath = Settings.PATH_FILES;
			int maxSize = 5 * 1024 * 1024;
			String encoding = "UTF-8";
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			MultipartRequest mRequest = new MultipartRequest(req, savePath, maxSize, encoding, policy);
			String eventName = mRequest.getParameter("eventName");
			String eventDetail = mRequest.getParameter("eventDetail");
			if(eventName == null || eventName.equals("") || eventDetail == null || eventDetail.equals("")) {
				System.out.println("\n[이벤트 - 신규] 글 제목 혹은 글 내용이 입력되지 않았습니다.");
				throw new Exception();
			}
			System.out.println("[이벤트 - 신규] 1. 변수 준비 완료.");

			// 2. DAO/DTO 생성 후 각종 값 넣기
			System.out.print("[이벤트 - 신규] 2. DAO/DTO 생성..");
			EventDao eventDao = new EventDao();
			EventDto eventDto = new EventDto();
			int nextSeq = eventDao.getNextSequence();
			eventDto.setEventIdx(nextSeq);
			eventDto.setUsersIdx(Sessioner.getUsersIdx(req));
			eventDto.setEventName(eventName);
			eventDto.setEventDetail(eventDetail);
			System.out.println(" 완료. DTO 내용: " + eventDto);

			// 글 삽입
			System.out.println("[이벤트 - 신규] 3. 글 삽입.");
			eventDao.insert(eventDto);
			System.out.println("[이벤트 - 신규] 3. 글 삽입 완료(board_event)");

			// 파일이 있을 경우, 파일도 삽입
			if(mRequest.getFile("attach") != null) {

				System.out.println("[이벤트 - 신규] 3-2. 파일이 발견되어 파일을 삽입합니다.");
				EventFileDto eventFileDto = new EventFileDto();
				eventFileDto.setEventIdx(nextSeq);
				eventFileDto.setEventFileUploadName(mRequest.getOriginalFileName("attach")); // 업로드한 사람한테 보이는 가짜 이름
				eventFileDto.setEventFileSaveName(mRequest.getFilesystemName("attach")); // 서버에 저장되는 실제 이름
				eventFileDto.setEventFileType(mRequest.getContentType("attach"));
				eventFileDto.setEventFileSize(mRequest.getFile("attach").length());
				System.out.println("[이벤트 - 신규] 3-2. 파일 정보: " + eventFileDto);

				System.out.print("[이벤트 - 신규] 3-3. 파일 업로드.. ");
				EventFileDao eventFileDao = new EventFileDao();
				eventFileDao.insert(eventFileDto);
				System.out.println("성공.");

			}
			System.out.println("[이벤트 - 신규] 3. 글 삽입 끝.");

			System.out.println("[이벤트 - 신규] 4. 글 등록이 모두 끝났습니다. 상세보기로 이동합니다.");
			resp.sendRedirect("detail.jsp?eventIdx=" + nextSeq);
			return;

		}

		catch(Exception e){

			System.out.println("[이벤트 - 신규] 새 데이터 등록 중 에러가 발생했습니다.");
			e.printStackTrace();
			resp.sendError(500);

		}

	}
}
