package servlet;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import system.Settings;

@SuppressWarnings("serial")
@WebServlet(urlPatterns = "/img.nogari")
public class ImageServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {

			// * 요구 패러미터들
			// img_type: 이미지 타입 ('image/png' 등)
			// img_src: 이미지 이름 ('skull.jpg' 등)

			// 1. 변수 설정
			System.out.println("[이미지 출력] 1. 이름 설정");
			String type = request.getParameter("img_type");
			response.setContentType(type); // 파일 타입명
			byte[] bytes = new byte[1024]; // 한 번에 읽어올 파일 버퍼(1024 바이트)
			System.out.println("[이미지 출력] 1. 이름 설정 완료 (" + type + ")");

			// 2. 이미지 이름 설정
			// 2-1) 요청 이미지 주소에 ".."가 들어가 있으면 안 됨
			//    이름 형식에 대해서는 최초 업로드 시에도 따로 검사해야 하나, 시간 부족 문제로 구현을 생략하며
			//    우선 여기에서는 .. 만 검사하는 것임
			System.out.print("[이미지 출력] 2. 이미지 이름 설정.. ");
			String src = request.getParameter("img_src");
			if(Pattern.matches("\\.\\.", src)) {
				System.out.println("실패하였습니다.");
				throw new Exception();
			} else {
				System.out.println("성공 (" + src + ")");
			}

			// 2-2) 이미지 주소 형성 및 저장
			System.out.print("[이미지 출력] 2-2. 파일 경로 확인.. ");
			String path = Settings.PATH_FILES + "/" + src;
			//String imagePath = "C://........경로경로...../이미지이름.파일확장자이름";
			System.out.println("완료 (" + path + ")");

			// 3. in 스트림 설정
			// 3-1) InputStream을 이용, path의 파일을 1byte씩 읽음
			//      그리고 이것을 BufferedInputStream에 넣음 - buffer단위로 읽어오게끔 함
			System.out.print("[이미지 출력] 3-1. in 스트림 설정.. ");
			BufferedInputStream in = new BufferedInputStream(new FileInputStream(path));
			System.out.println("완료.");
			// 3-2) 버퍼(in)에 있는 데이터를 1024바이트(by) 만큼 계속해서 읽어오되, 읽을 데이터가 더 이상 없을 경우 반복문 종료
			System.out.print("[이미지 출력] 3-2. 실제 이미지 데이터 출력.. ");
			ServletOutputStream out = response.getOutputStream(); // 출력을 위한 OutputStream 객체
			while(in.read(bytes) != -1) out.write(bytes); // 버퍼 바이트 크기만큼씩 출력함
			System.out.println("완료.");

			// 4. 스트림 모두 닫고 종료
			System.out.println("[이미지 출력] 4. 이미지 출력이 정상적으로 완료되었습니다.");
			in.close();
			out.close();

		}

		catch (Exception e) {

			System.out.println("[이미지 출력] 오류가 발생했습니다.");
			e.printStackTrace();
			response.sendError(500);

		}
	}

}
