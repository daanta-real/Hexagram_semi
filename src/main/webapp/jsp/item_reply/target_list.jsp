<%@page import="beans.UsersDto"%>
<%@page import="beans.UsersDao"%>
<%@page import="beans.ItemReplyDto"%>
<%@page import="java.util.List"%>
<%@page import="beans.ItemReplyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    
<%
String root = request.getContextPath();
int itemIdx = Integer.parseInt(request.getParameter("itemIdx"));// 해당 인덱스 글에 댓글을 보여주겠다.
int itemReplyIdx = Integer.parseInt(request.getParameter("itemReplyIdx"));

//해당 인덱스 글 번호의 ,, 댓글 목록을 불러온다
ItemReplyDao itemReplyDao = new ItemReplyDao();
List<ItemReplyDto> list = itemReplyDao.listTarget(itemReplyIdx);

//이 댓글을 단 회원의 아이디를 가져오기 위해 단일조회를 한다.
UsersDao usersDao = new UsersDao();
%>

<%if(!list.isEmpty()){%>
				<tr>
						<td colspan="4">
						
<table align="center" width="700">
	<thead>
		<tr>
			<th>댓글 번호</th>
			<th>작성자 아이디</th>
			<th>작성 시간</th>
			<th>내 용</th>
		</tr>
	</thead>

	<tbody align = "center">
		<%for (ItemReplyDto itemReplyDto : list) {%>
		
			<%
			UsersDto usersDto = usersDao.get(itemReplyDto.getUsersIdx());
			%>
		<tr>
			<td>
			<%=itemReplyDto.getItemReplyIdx()%>
			</td>
			<td><%=itemReplyDto.getUsersIdx() == 0 ? "탈퇴한 회원" : usersDto.getUsersId()%></td>
			<td><%=itemReplyDto.getItemReplyTime()%></td>
			<td><%=itemReplyDto.getItemReplyDetail()%></td>
		</tr>
		
		
		<%}%>
	</tbody>
</table>
	
	</td>
					</tr>
<%} %>