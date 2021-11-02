<%@page import="beans.UsersDto"%>
<%@page import="beans.UsersDao"%>
<%@page import="beans.ItemReplyDao"%>
<%@page import="java.util.List"%>
<%@page import="beans.ItemReplyDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String root = request.getContextPath();
int itemIdx = Integer.parseInt(request.getParameter("itemIdx"));// 해당 인덱스 글에 댓글을 보여주겠다.
int usersIdx = (int)request.getSession().getAttribute("usersIdx");//해당 접속 회원이 대댓글을 쓰겠다.(동일 인물이라면 작성자 처리!!!)
//해당 인덱스 글 번호의 ,, 댓글 목록을 불러온다
ItemReplyDao itemReplyDao = new ItemReplyDao();
List<ItemReplyDto> list = itemReplyDao.list(itemIdx);

//이 댓글을 단 회원의 아이디를 가져오기 위해 단일조회를 한다.
UsersDao usersDao = new UsersDao();


%>

<h3 align="center">[댓글 목록]</h3>
<table align="center" border="1" width="800">
	<thead>
		<tr>
			<th>댓글 번호</th>
			<th>작성자 아이디</th>
			<th>작성 시간</th>
			<th>내 용</th>
		</tr>
	</thead>

	<tbody>
		<%for (ItemReplyDto itemReplyDto : list) {%>
		
			<%
			int itemReplyIdx = itemReplyDto.getItemReplyIdx();
			UsersDto usersDto = usersDao.get(itemReplyDto.getUsersIdx());
			%>
			
			<%if(itemReplyDto.getItemReplyTargetIdx()==0){ %>
					<tr>
						<td><%=itemReplyDto.getItemReplyIdx()%></td>
						<td>
							<a href="list.jsp/itemReplyIdx=<%=itemReplyDto.getItemReplyIdx()%>&itemIdx=<%=itemIdx%>">
								<%=itemReplyDto.getUsersIdx() == 0 ? "탈퇴한 회원" : usersDto.getUsersId()%>
							</a>
						</td>
						<td><%=itemReplyDto.getItemReplyTime()%></td>
						<td><%=itemReplyDto.getItemReplyDetail()%></td>
					</tr>	
			
			<jsp:include page="/jsp/item_reply/target_list.jsp">
				<jsp:param name="itemReplyIdx" value="<%=itemReplyIdx%>"/>
				<jsp:param name="itemIdx" value="<%=itemIdx%>"/>
			</jsp:include>
			

			<%}%>
		<%}%>
	</tbody>
</table>
<br>