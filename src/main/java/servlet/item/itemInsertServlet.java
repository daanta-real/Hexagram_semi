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
@WebServlet (urlPatterns = "/jsp/item/insert.nogari")
public class itemInsertServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			
			//등록 서블릿.


		}
		catch(Exception e){
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
