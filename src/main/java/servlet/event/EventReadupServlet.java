package servlet.event;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.EventDao;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/event/readup.nogari")
public class EventReadupServlet extends HttpServlet{
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try {
		EventDao eventDao = new EventDao();

		int eventIdx = Integer.parseInt(req.getParameter("eventIdx"));
		if(req.getSession().getAttribute("usersIdx") != null) {
			int usersIdx = (int)req.getSession().getAttribute("usersIdx");
//		현재 회원이 원하는 이벤트 게시물에 들어갔을때를 확인하기 위해서 두가지의 정보가 필요하다
			//본인이 작성한 글이 아니면 클릭했을떄 조회수를 올려라!
			eventDao.readUp(eventIdx,usersIdx);

		}else {
			//비회원이라도 그냥 올려라
			eventDao.readUp(eventIdx);
		}


		//넘겨받은 코스번호의 상세페이지로 이동.
		resp.sendRedirect("detail.jsp?eventIdx="+eventIdx);
		return;

	}catch (Exception e) {
		e.printStackTrace();
		resp.sendError(500);
	}
}
}
