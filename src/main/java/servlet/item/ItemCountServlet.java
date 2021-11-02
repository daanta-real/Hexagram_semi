package servlet.item;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.ItemDao;
import beans.ItemDto;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/item/count.nogari")
public class ItemCountServlet extends HttpServlet{
@Override
protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	try{


		//조회수 증가 서블릿


	}catch (Exception e) {
		e.printStackTrace();
		resp.sendError(500);
	}
	}
}
