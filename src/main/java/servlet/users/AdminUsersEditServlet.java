package servlet.users;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import beans.UsersDao;
import beans.UsersDto;

//관리자 - 회원 정보 변경 처리 
@WebServlet(urlPatterns="/admin/users/edit.nogari")
public class AdminUsersEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			
			//변경 정보 파라미터값
			UsersDto usersDto = new UsersDto();
			usersDto.setUsersId(req.getParameter("usersId"));
			usersDto.setUsersPw(req.getParameter("usersPw"));
			usersDto.setUsersNick(req.getParameter("usersNick"));
			usersDto.setUsersEmail(req.getParameter("usersEmail"));
			usersDto.setUsersPhone(req.getParameter("usersPhone"));
			usersDto.setUsersGrade(req.getParameter("usersGrade"));
			System.out.println();
			
			//회원 정보 변경 기능 
			UsersDao usersDao = new UsersDao();
			boolean isUpdate = usersDao.update(usersDto);
			
			//리다이렉트를 위한 usersIdx 파라미터
			int usersIdx = Integer.parseInt(req.getParameter("usersIdx"));

			//정보 수정 성공시 해당회원의 상세 페이지로 이동
			if(isUpdate) {
				resp.sendRedirect(req.getContextPath()+"/admin/users/detail.jsp?usersIdx="+usersIdx+"&success");
			}
			//정보 수정 실패시 정보 변경 페이지로 fail파라미터 전달
			else {
				resp.sendRedirect(req.getContextPath()+"/admin/users/edit.jsp?usersIdx="+usersIdx+"&fail");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
