package servlet.course;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.CourseDao;
import beans.CourseItemDao;
import beans.CourseItemDto;
import beans.ItemDto;
import util.users.Sessioner;

@WebServlet(urlPatterns = "/course/udpate_sequence.nogari")
public class CourseCreateSequnceForUpdateServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			try {
				//필터에서 이 부분을 거친사람을 확인하기 위해서 최초 생성한 유저의 정보를 넘겨준다.(추후 코스 생성및 코스-아이템 등록/삭제를 위한 필터처리용)
				String usersFilterId = req.getParameter("usersFilterId");
				
				//코스 수정시 시퀀스 번호 정리 Servlet
				
				CourseDao courseDao = new CourseDao();
				int getMaxIdx = courseDao.getMaxIdx();
				//새글을 작성 혹은 수정을할때 시퀀스 번호를 생성해주게 되는데, 
				//코스 작성 또은 수정시에 작성 완료를 하지 않고 나가게 되면 코스-아이템 db가 등록되어 쓰레기DB값들이 쌓이게 됨
				//이를 위해서 현재 코스 게시판에 최종 등록된 courseIdx를 확인해주고, 이 값보다 큰 courseIdx(임시 생성되었으나 최종등록되지 않은 것들)을 삭제해줘야 한다.
				
				courseDao.getMaxIdxDelete(getMaxIdx);
				//현재 코스 게시판의 courseIdx 번호보다 큰 courseIdx에 저장된 코스-아이템DB데이터를 모두 삭제해주는 메소드
					
				 int courseSequnce = courseDao.getSequence(); //새로 생성한 번호
				 int courseOriginSequnce = Integer.parseInt(req.getParameter("courseOriginSequnce")); //기존 번호
				 
				 
				 CourseItemDao courseItemDao = new CourseItemDao();
				 List<CourseItemDto> originList = courseItemDao.getByCourse(courseOriginSequnce);//기존의 코스-아이템 목록을 가져오기 위함
				 
				
				 for(CourseItemDto courseItemDto : originList) {
					 CourseItemDto courseItemUpdateDto = new CourseItemDto();
					 //기존 아이템 목록을 출력해서 새로 생성한 코스 시퀀스 임시 번호인 courseSequnce에다가
					 //셋팅을 해주고,
					 courseItemUpdateDto.setCourseIdx(courseSequnce);
					 courseItemUpdateDto.setItemIdx(courseItemDto.getItemIdx());
					 
					 //courseOriginSequnce기존에 담긴 것들을 그대로 복사해서 삽입해준다.
					// 사용자가 수정중 도중 나갈 수 있으므로 복사본을 만들어서 작업한다
					//복사본이 없다면 기존데이터에 수정 최종 단계 전에 관광지 항목들이 수정되므로 중간에 나가버려도 원본데이터의 변경이 일어난다.
					 courseItemDao.insert(courseItemUpdateDto);
				 }
				 
				 //업데이트jsp로 기존 번호와 임시 번호를 둘다 넘겨준다.
				 // case1 . 도중에 작성하다가 나간경우 : 복사본(임시번호)를 날려주기만 하면 된다.
				 // case2 . 복사본(임시번호)의 내용이 수정되고 최종 완료하였을 경우는 기존의 courseIdx(즉 courseOriginSequnce의 번호만 살리고 내부의 데이터를 모두 삭제 후,
				 // 수정된 복사본의 내용을 덮어쓴 후 수정된 복사본은 내용과 번호정보를 모두 삭제해준다.
				 resp.sendRedirect("update.jsp?courseSequnce="+courseSequnce+"&courseOriginSequnce="+courseOriginSequnce);
				
			}catch (Exception e) {
				e.printStackTrace();
				resp.sendError(500);
			}
	}
}
