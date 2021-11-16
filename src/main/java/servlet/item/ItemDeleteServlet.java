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
import system.Settings;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/item/delete.nogari")
public class ItemDeleteServlet extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//관광지 삭제 Servlet (첨부파일을 삭제하면서 관광지글을 삭제 한다)
		try {
			
			//관광지 삭제를 위해 itemIdx값을 파라미터로 받는다
			int itemIdx = Integer.parseInt(req.getParameter("itemIdx"));
			//Dao 변수 선언
			ItemDao itemDao = new ItemDao();
			//첨부파일 삭제를 위해 itemFileDao 변수 선언
			ItemFileDao itemFileDao = new ItemFileDao();
			//첨부파일 단일 조회
			ItemFileDto itemFileOrigin = itemFileDao.find2(itemIdx);
			//파일 경로
			File dir = new File(Settings.PATH_FILES);
			//파일 경로, 파일 단일조회를 하여 저장된 이름으로 파일은 선택
			File target = new File(dir,itemFileOrigin.getItemFileSaveName());
			//저장된 파일을 삭제
			target.delete();
			//파일 정보를 삭제
			itemFileDao.delete(itemFileOrigin.getItemFileIdx());
			//관광지 삭제 완료
			itemDao.delete(itemIdx);
			//완료시 목록 페이지로 이동
			resp.sendRedirect(req.getContextPath() + "/item/list.jsp");
		}
		//예외가 발생하면 500번으로 던진다
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
