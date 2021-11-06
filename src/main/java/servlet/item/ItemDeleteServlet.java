package servlet.item;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.ItemDao;
import beans.ItemFileDao;
import beans.ItemFileDto;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/item/delete.nogari")
public class ItemDeleteServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {

			int itemIdx = Integer.parseInt(req.getParameter("itemIdx"));

			ItemDao itemDao = new ItemDao();
			
			ItemFileDao itemFileDao = new ItemFileDao();
			ItemFileDto itemFileOrigin = itemFileDao.find2(itemIdx);
			File dir = new File("c:/image");
			File target = new File(dir,itemFileOrigin.getItemFileSaveName());
//			저장된 파일을 삭제
			target.delete();
//			파일 정보를 삭제
			itemFileDao.delete(itemFileOrigin.getItemFileIdx());
			
			itemDao.delete(itemIdx);

			resp.sendRedirect(req.getContextPath() + "/item/list.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
