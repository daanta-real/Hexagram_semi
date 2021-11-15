package servlet.course;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.CourseDao;

@WebServlet(urlPatterns = "/course/insert_sequence.nogari")
public class CourseCreateSequnceForInsertServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			try {
				CourseDao courseDao = new CourseDao();
				
				int getMaxIdx = courseDao.getMaxIdx();
				courseDao.getMaxIdxDelete(getMaxIdx);
				//새글을 작성할때 코스게시판의 가장 큰 글보다 큰(쓰레기 작성글들을)것 들을 삭제해주는 작업.
				
				
				//코스 시퀀스를 만들어서 insert.jsp에 전달해준다.(단지 그 역할일 뿐인 줄 알았으나, 코스 아이템DB에 추가할때 외래키 문제가 생기기 때문에,,)
				
				//시퀀스를 만들때 코스를 만드는 개념(껍떼기 생성)으로 해주고
				
				//이후에 최종 아이템 선택이 완료 되었을때, 업데이트 개념으로 새글등록을 해주어야한다. 
				
				//이게 아니라면 아에 DB의 설정을 바꾸어 주어야 한다.
				//차라리기존 관광지idx 및 코스idx로 프라이머리키를 설정하게 될시에,

				//코스_관광지 데이터가 추가하여야 할때 참조할 외래키(코스idx)가 없기때문에(코스 게시판이 생성되기 전 상황임)
				//
				//sql구문의 parent key에러가 생김
				//
				//그래서 코스-관광지의 식별변호를 두고 코스idx를 비식별관계로 두어서 진행
				
				//사실 코스-관광지의 식별번호는 큰 의미가 없지만 단지 중복 데이터의 방지를 위함
				
				
				//최종 결론 : 코스 idx를 비식별로 두고 , 미리 생성한 코스 시퀀스를 통해서 관광지_코스 DB를 먼저 등록하고 추후에 이 시퀀스 번호로 최종 코스를 등록한다.
				//즉 기존하던대로 진행해도 괜찮다.
				 
				 
				 int courseSequnce = courseDao.getSequence();
				 
				 resp.sendRedirect("insert.jsp?courseSequnce="+courseSequnce);
				
			}catch (Exception e) {
				e.printStackTrace();
				resp.sendError(500);
			}
	}
}
