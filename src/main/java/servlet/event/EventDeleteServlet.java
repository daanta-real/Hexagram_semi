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

			// 1. 값 획득 및 검사
			System.out.print("[이벤트 삭제] 1. idx값 획득 및 검사.. ");
			String eventIdxStr = req.getParameter("eventIdx");
			if(eventIdxStr == null) {
				System.out.println("[이벤트 삭제] 삭제할 eventIdx가 입력되지 않았습니다.");
				throw new Exception();
			}
			Integer eventIdx = Integer.parseInt(eventIdxStr);
			System.out.println("완료. 삭제할 eventIdx = " + eventIdx);

			// 2. 관련 DAO 준비
			System.out.print("[이벤트 삭제] 2. 관련 DAO 준비.. ");
			EventDao eventDao = new EventDao();
			EventFileDao eventFileDao = new EventFileDao();
			System.out.println("완료.");

			// 3. event_file에 등록된 관련파일 삭제
			System.out.println("[이벤트 삭제] 3. event_file 데이터에 등록된 관련파일 삭제.. ");
			EventFileDto fileDto = eventFileDao.get(eventIdx); // 파일DTO 획득
			System.out.println("　　- 파일 DTO 정보: " + fileDto);
			File dir = new File(Settings.PATH_FILES);
			System.out.print("　　- 전체 경로: " + Settings.PATH_FILES);
			File target = new File(dir, fileDto.getEventFileSaveName()); // 실제 HDD 세이브명의 실제 파일 객체 획득
			System.out.print("/" + fileDto.getEventFileSaveName() + " 이다.");
			target.delete();
			System.out.println(" → 삭제 완료.");

			// 4. 삭제 - event 테이블의 데이터row 삭제
			System.out.print("[이벤트 삭제] 4. event 데이터 삭제.. ");
			eventDao.delete(eventIdx);
			System.out.println("완료.");

			// 참고로 event_file의 데이터row는 별도 삭제코드 작성 불요함
			// (CASCADE 조건으로 인해, event쪽 삭제할 때 자동 삭제됨)
			// 또한 이러한 이유 때문에, event_file의 실제 파일을 먼저 지우고 그 다음에 event를 삭제해야 한다.

			// 완료 시 목록보기로 이동
			System.out.print("[이벤트 삭제] 모든 작업이 완료되었습니다. 목록보기로 이동합니다.");
			resp.sendRedirect(req.getContextPath() + "/event/list.jsp");
			return;

		}
		catch(Exception e) {

			System.out.println("\n[이벤트 삭제] 이벤트 삭제 중 에러가 발생하였습니다.");
			e.printStackTrace();
			resp.sendError(500);

		}
	}
}
