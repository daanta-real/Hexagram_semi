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

		//관광지 수정 Servlet(첨부파일이 있어 첨부파일을 등록하면서 등록되어있던 첨부파일을 삭제한다)
		try {			
			
			//경로 설정
			String savePath = Settings.PATH_FILES;
			//파일 전송 크기 설정
			int maxSize = 5 * 1024 * 1024;
			//인코딩 설정
			String encoding = "UTF-8";
			//작명정책 객체 선언 (같은 이름의 파일명 방지 처리)
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			//jsp에서 multipart로 전달된 form을 multipartRequest 요청 해석 및 파일 저장
			MultipartRequest mRequest = new MultipartRequest(req, savePath, maxSize, encoding, policy);

			//등록
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
			
			//만약 전달된 attach가 null이 아니라면 (첨부파일이 있다면 첨부파일을 삭제한다)
			if(mRequest.getFile("attach") != null) {
				ItemFileDao itemFileDao = new ItemFileDao();
				//기존에 첨부된 파일 단일조회
				ItemFileDto itemFileOrigin = itemFileDao.find2(itemDto.getItemIdx());
				//경로 설정
				File dir = new File(Settings.PATH_FILES);
				//파일 경로, 파일 단일조회를 하여 저장된 이름으로 파일은 선택
				File target = new File(dir,itemFileOrigin.getItemFileSaveName());
				//저장된 파일을 삭제
				target.delete();
				//파일 정보를 삭제
				itemFileDao.delete(itemFileOrigin.getItemFileIdx());
				
				ItemFileDto itemFileDto = new ItemFileDto();
				itemFileDto.setItemIdx(itemDto.getItemIdx());
				itemFileDto.setItemFileUploadname(mRequest.getOriginalFileName("attach"));
				itemFileDto.setItemFileSaveName(mRequest.getFilesystemName("attach"));
				itemFileDto.setItemFileType(mRequest.getContentType("attach"));
				itemFileDto.setItemFileSize(mRequest.getFile("attach").length());
				//새로운 파일 등록
				itemFileDao.insert(itemFileDto);
			}
			
			//관광지 수정
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
		//예외가 발생하면 500번으로 던진다
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
