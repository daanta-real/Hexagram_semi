package servlet.course.like;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.CourseLikeDao;
import beans.CourseLikeDto;

@WebServlet(urlPatterns = "/course/check_ajax_course_like.nogari")
public class CourseLikeAjaxCheckServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//코스는 detail에서 넘겨받는다.
			int courseIdx = Integer.parseInt(req.getParameter("courseIdx"));
			
			//유저는 현재 접속한 회원을 받는다. 필터 없이 이곳에서 회원 세션이 null이라면 오류를 바로 발생시켜준다(else)
			int usersIdx;
			if(req.getSession().getAttribute("usersIdx")!=null) {
				usersIdx = (Integer) req.getSession().getAttribute("usersIdx"); //회원이 있다면 usersIdx 정수 변수를 받고

				CourseLikeDao courseLikeDao = new CourseLikeDao();
				CourseLikeDto courseLikeDto = courseLikeDao.get(usersIdx, courseIdx); //현재 회원이 현재 게시물에 대한 좋아요 이력을 알아본다.
	
				if(courseLikeDto==null) {//만약 접속한 회원이 해당 게시물에 좋아요한 이록이 없다면,
					courseLikeDao.insert(usersIdx, courseIdx);//해당 게시글에 현재 회원의 정보를 좋아요DB에 추가한뒤,
					int countLike = courseLikeDao.countLike(courseIdx); //좋아요 개수를 반환한다.
					resp.getWriter().write(String.valueOf(countLike)); //정수이므로 문자열로 반환한다.
				}else {//만약 접속한 회원이 해당 게시물에 좋아요한 이록이 있다면, NNNNN을 반환한다
					courseLikeDao.delete(usersIdx, courseIdx);//해당 게시글에 현재 회원의 정보를 좋아요DB에 삭제한뒤,
					resp.getWriter().write("NNNNN");//반환한다.
				}				
			}else {
				resp.sendError(401);//로그인이 안된 회원 에러보내기.
			}

		}catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
