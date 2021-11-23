package servlet.course;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.CourseDao;
import util.users.Sessioner;

@WebServlet(urlPatterns = "/course/insert_sequence.nogari")
public class CourseCreateSequnceForInsertServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
			try {

				//코스 등록 전 시퀀스 번호 받는 Servlet
				
				// 새글을 작성할때 코스게시판의 가장 큰 글보다 큰(쓰레기 작성글들을)것 들을 삭제해주는 작업.
				// 코스를 작성할때 코스의 sequence번호를 미리 생성하는 방식이며 , 등록 및 수정시에 ajax방식으로 직접적으로 코스_아이템DB에 접근하여 등록을 수행해주기 때문이다.
				CourseDao courseDao = new CourseDao();
				
				int getMaxIdx = courseDao.getMaxIdx();
				courseDao.getMaxIdxDelete(getMaxIdx);
				
				 //따라서 게시판이 등록되기 전에 코스_아이템 DB에 만들어진 코스 시퀀스번호에 등록후에 최종 등록을 하는 시스템임
				 int courseSequnce = courseDao.getSequence();
				 
				 //등록을 위해서 insert.jsp로 이동함
				 resp.sendRedirect("insert.jsp?courseSequnce="+courseSequnce);
				
			}catch (Exception e) {
				e.printStackTrace();
				resp.sendError(500);
			}
	}
}
