package servlet.item;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.ItemDao;

@WebServlet(urlPatterns = "/item/readup.nogari")
public class ItemReadupServlet extends HttpServlet{
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try {
		ItemDao itemDao = new ItemDao();
//		현재 회원이 원하는 코스 게시물에 들어갔을때를 확인하기 위해서 두가지의 정보가 필요하다
		
		int itemIdx = Integer.parseInt(req.getParameter("itemIdx"));
		if(req.getSession().getAttribute("usersIdx") != null) {
			int usersIdx = (int)req.getSession().getAttribute("usersIdx");
			itemDao.readUp(itemIdx,usersIdx);
			//본인이 작성한 글이 아니면 클릭했을 때 조회수를 올려라!	
		}else {
			itemDao.readUp(itemIdx);
			//비회원이라도 조회수 올려라!
		}	
		
		resp.sendRedirect("detail.jsp?itemIdx="+itemIdx);
		//넘겨받은 아이템번호의 상세페이지로 이동.
	}catch (Exception e) {
		e.printStackTrace();
		resp.sendError(500);
	}
}
}
