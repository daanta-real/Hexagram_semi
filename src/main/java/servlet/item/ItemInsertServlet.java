package servlet.item;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import beans.ItemDao;
import beans.ItemDto;
import beans.ItemFileDao;
import beans.ItemFileDto;
import system.Settings;

@SuppressWarnings("serial")
@WebServlet (urlPatterns = "/item/insert.nogari")
public class ItemInsertServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//관광지 등록 Servlet(첨부파일 추가)
		try {
			
			//Multipart 요청 처리 준비(파일 업로드)
			String savePath = Settings.PATH_FILES;
			//전송 속도 (byte로 지정) 5MB
			int maxSize = 5 * 1024 * 1024;
			String encoding = "UTF-8";
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			MultipartRequest mRequest = new MultipartRequest(req, savePath, maxSize, encoding, policy);

			//현재 회원이 작성
			int usersIdx = (int)req.getSession().getAttribute("usersIdx");

			ItemDao itemDao = new ItemDao();
			ItemDto itemDto = new ItemDto();

			//itemIdx 번호 생성
			int sequnceNo = itemDao.getSequence();

			itemDto.setItemIdx(sequnceNo);
			itemDto.setUsersIdx(usersIdx);
			itemDto.setItemType(mRequest.getParameter("itemType"));
			itemDto.setItemName(mRequest.getParameter("itemName"));
			itemDto.setItemDetail(mRequest.getParameter("itemDetail"));
			itemDto.setItemPeriod(mRequest.getParameter("itemPeriod"));
			itemDto.setItemTime(mRequest.getParameter("itemTime"));
			itemDto.setItemHomepage(mRequest.getParameter("itemHomepage"));
			itemDto.setItemParking(mRequest.getParameter("itemParking"));
			itemDto.setItemAddress(mRequest.getParameter("itemAddress"));

			//글 등록.
			itemDao.insertWithSequence(itemDto);

			//첨부파일이 있다면 등록 처리
			if(mRequest.getFile("attach") != null) {
				ItemFileDto itemFileDto = new ItemFileDto();
				itemFileDto.setItemIdx(sequnceNo);
				itemFileDto.setItemFileUploadname(mRequest.getOriginalFileName("attach"));
				itemFileDto.setItemFileSaveName(mRequest.getFilesystemName("attach"));
				itemFileDto.setItemFileType(mRequest.getContentType("attach"));
				itemFileDto.setItemFileSize(mRequest.getFile("attach").length());


				ItemFileDao itemFileDao = new ItemFileDao();
				itemFileDao.insert(itemFileDto);
			}

			resp.sendRedirect("detail.jsp?itemIdx="+sequnceNo);

		}
		catch(Exception e){
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
