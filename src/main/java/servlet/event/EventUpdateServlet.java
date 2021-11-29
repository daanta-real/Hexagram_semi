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
@WebServlet (urlPatterns = "/event/update.nogari")
public class EventUpdateServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			// 1. 변수 준비
			System.out.println("[이벤트 - 수정] 1. 변수 준비");
			String savePath = Settings.PATH_FILES;
			int maxSize = 5 * 1024 * 1024;
			String encoding = "UTF-8";
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			MultipartRequest mRequest = new MultipartRequest(req, savePath, maxSize, encoding, policy);
			Integer eventIdx = Integer.parseInt(mRequest.getParameter("eventIdx"));
			Integer usersIdx = Integer.parseInt(mRequest.getParameter("usersIdx"));
			String eventName = mRequest.getParameter("eventName");
			String eventDetail = mRequest.getParameter("eventDetail");
			if(eventIdx == null
				|| usersIdx == null
				|| eventName == null || eventName.equals("")
				|| eventDetail == null || eventDetail.equals("")) {
				System.out.println("\n[이벤트 - 수정] 글 제목 혹은 글 내용이 입력되지 않았습니다.");
				throw new Exception();
			}
			System.out.println("[이벤트 - 수정] 1. 변수 준비 완료.");

			// 2. DAO/DTO 생성 후 각종 값 넣기
			System.out.print("[이벤트 - 수정] 2. DAO/DTO 생성..");
			EventDao eventDao = new EventDao();
			EventDto eventDto = new EventDto();
			eventDto.setEventIdx(eventIdx);
			eventDto.setEventName(eventName);
			eventDto.setEventDetail(eventDetail);
			System.out.println(" 완료. DTO 내용: " + eventDto);

			// 글 수정
			System.out.println("[이벤트 - 수정] 3. 글 수정.");
			eventDao.update(eventDto);
			System.out.println("[이벤트 - 수정] 3. 글 수정 완료(event)");

			// 파일이 있을 경우, (기존 파일이 있다면 삭제하고) 파일을 삽입
			if(mRequest.getFile("attach") != null) {

				EventFileDao eventFileDao = new EventFileDao();
				System.out.println("[이벤트 - 수정] 3-1. 새로운 첨부파일이 발견되었습니다. 기존 파일을 조회합니다.");
				EventFileDto eventFileDto_prev = eventFileDao.get(eventIdx);
				if(eventFileDto_prev != null) {
					System.out.print("[이벤트 - 수정] 3-1. 기존 첨부파일이 발견되었습니다("
						+ "fileIdx: " + eventFileDto_prev.getEventFileIdx() + ", name: " + eventFileDto_prev.getEventFileSaveName() + "). 이를 삭제합니다.. ");
					eventFileDao.delete(eventFileDto_prev.getEventFileIdx());
					System.out.println("삭제 완료.");
				} else {
					System.out.println("[이벤트 - 수정] 3-1. 새로운 파일이 조회되지 않았습니다.");
				}

				System.out.println("[이벤트 - 수정] 3-2. 파일 삽입을 실시합니다.");
				EventFileDto eventFileDto = new EventFileDto();
				eventFileDto.setEventIdx(eventIdx);
				eventFileDto.setEventFileUploadName(mRequest.getOriginalFileName("attach")); // 업로드한 사람한테 보이는 가짜 이름
				eventFileDto.setEventFileSaveName(mRequest.getFilesystemName("attach")); // 서버에 저장되는 실제 이름
				eventFileDto.setEventFileType(mRequest.getContentType("attach"));
				eventFileDto.setEventFileSize(mRequest.getFile("attach").length());
				System.out.println("[이벤트 - 수정] 3-2. 파일 정보 준비 완료: " + eventFileDto);

				System.out.print("[이벤트 - 수정] 3-3. 파일 업로드.. ");
				eventFileDao.insert(eventFileDto);
				System.out.println("성공.");

			}
			System.out.println("[이벤트 - 수정] 3. 글 수정 끝.");

			System.out.println("[이벤트 - 수정] 4. 글 수정이 모두 끝났습니다. 상세보기로 이동합니다.");
			resp.sendRedirect("detail.jsp?eventIdx=" + eventIdx);
			return;

		}

		catch(Exception e){

			System.out.println("[이벤트 - 수정] 새 데이터 등록 중 에러가 발생했습니다.");
			e.printStackTrace();
			resp.sendError(500);

		}

	}
}
