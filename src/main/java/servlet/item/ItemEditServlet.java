package servlet.item;

import java.io.File;
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
@WebServlet(urlPatterns = "/item/edit.nogari")
public class ItemEditServlet extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		try {
			String savePath = Settings.PATH_FILES;
			int maxSize = 5 * 1024 * 1024;
			String encoding = "UTF-8";
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			MultipartRequest mRequest = new MultipartRequest(req, savePath, maxSize, encoding, policy);


			ItemDto itemDto = new ItemDto();
			itemDto.setItemType(mRequest.getParameter("itemType"));
			itemDto.setItemName(mRequest.getParameter("itemName"));
			itemDto.setItemDetail(mRequest.getParameter("itemDetail"));
			itemDto.setItemPeriod(mRequest.getParameter("itemPeriod"));
			itemDto.setItemTime(mRequest.getParameter("itemTime"));
			itemDto.setItemHomepage(mRequest.getParameter("itemHomepage"));
			itemDto.setItemParking(mRequest.getParameter("itemParking"));
			itemDto.setItemAddress(mRequest.getParameter("itemAddress"));
			itemDto.setItemIdx(Integer.parseInt(mRequest.getParameter("itemIdx")));

			ItemDao itemDao = new ItemDao();

			if(mRequest.getFile("attach") != null) {
				ItemFileDao itemFileDao = new ItemFileDao();
				ItemFileDto itemFileOrigin = itemFileDao.find2(itemDto.getItemIdx());
				File dir = new File(Settings.PATH_FILES);
				File target = new File(dir,itemFileOrigin.getItemFileSaveName());
//				저장된 파일을 삭제
				target.delete();
//				파일 정보를 삭제
				itemFileDao.delete(itemFileOrigin.getItemFileIdx());

				ItemFileDto itemFileDto = new ItemFileDto();
				itemFileDto.setItemIdx(itemDto.getItemIdx());
				itemFileDto.setItemFileUploadname(mRequest.getOriginalFileName("attach"));
				itemFileDto.setItemFileSaveName(mRequest.getFilesystemName("attach"));
				itemFileDto.setItemFileType(mRequest.getContentType("attach"));
				itemFileDto.setItemFileSize(mRequest.getFile("attach").length());
//				새로운 파일 등록
				itemFileDao.insert(itemFileDto);
			}

			boolean result = itemDao.update(itemDto);
			//수정 성공시 상세 페이지로 이동
			if(result) {
				resp.sendRedirect("detail.jsp?itemIdx="+itemDto.getItemIdx());
			}
			//수정 실패시 에러페이지 500번으로
			else {
				resp.sendError(500);
			}

		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
