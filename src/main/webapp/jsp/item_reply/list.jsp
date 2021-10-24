<%@page import="beans.ItemReplyDao"%>
<%@page import="java.util.List"%>
<%@page import="beans.ItemReplyDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String root = request.getContextPath();
int item_idx = Integer.parseInt(request.getParameter("item_idx"));// 해당 인덱스 글에 댓글을 보여주겠다.
int users_idx = (int)request.getSession().getAttribute("users_key");//해당 접속 회원이 대댓글을 쓰겠다.(동일 인물이라면 작성자 처리!!!)

//해당 인덱스 글 번호의 ,, 댓글 목록을 불러온다
ItemReplyDao itemReplyDao = new ItemReplyDao();
List<ItemReplyDto> list = itemReplyDao.list(item_idx);

int number = 1;
//댓글 순서 번호 부여
%>

<h3>댓글 목록</h3>
<table border="1" width="900">
	<thead>
		<th>댓글 번호</th>
		<th>작성자 아이디</th>
		<th>작성 시간</th>
		<th>내 용</th>
		<th>대 댓글 목록</th>
		<th>대 댓글 달기</th>
	</thead>

	<tbody>
		<%for (ItemReplyDto itemReplyDto : list) {%>
		<tr>
		
			<td><%=number++%></td>
			<td><%=itemReplyDto.getUsers_idx() == 0 ? "탈퇴한 회원" : itemReplyDto.getUsers_idx()%></td>
			<td><%=itemReplyDto.getItem_reply_time()%></td>
			<td><%=itemReplyDto.getItem_reply_detail()%></td>
			
			<td>
			<%
			List<ItemReplyDto> listTarget = itemReplyDao.listTarget(itemReplyDto.getItem_idx());
			%>
			<%if(listTarget.isEmpty()){%>
			대댓글이 없습니다.
			<%}else{ %>
					<%for (ItemReplyDto itemReplyTargetDto : listTarget) {%>
						<table border="1" width="400">
								<thead>
									<tr>
										<th>작성자 아이디</th>
										<th>작성 시간</th>
										<th>내 용</th>
									</tr>
							</thead>
							<tbody>
									<tr>
										<td><%=itemReplyTargetDto.getUsers_idx() == 0 ? "탈퇴한 회원" : itemReplyDto.getUsers_idx()%></td>
										<td><%=itemReplyTargetDto.getItem_reply_time()%></td>
										<td><%=itemReplyTargetDto.getItem_reply_detail()%></td>
									</tr>
							</tbody>
						</table>
				<%} %>
			<%} %>
			</td>
			
			<td>
				<form
					action="<%=request.getContextPath()%>/jsp/item_reply/insert_target.nogari" method="post">
					<!--    	대댓글 내용 전송 -->
					<table>
						<tbody>
							<tr width="400">
								<th>대댓글 입력</th>
								<td><textarea name="item_reply_detail" align="center"
										placeholder="대댓글 입력" required rows="2" cols="50"></textarea></td>
							</tr>
						</tbody>
					</table>
					<!--    	관광지 idx 전송 -->
					<input type="hidden" name="item_idx" value="<%=item_idx%>">
					<!--    	대댓글 쓸 유저 idx 전송 -->
					<input type="hidden" name="users_idx" value="<%=users_idx%>">
					<!-- 		리스트로 보여줄때 해당 댓글에 대한 번호정보가 필요하므로, 현재 댓글 idx 번호를 전송한다. -->
					<input type="hidden" name="item_reply_target_idx" value="<%=itemReplyDto.getItem_reply_idx()%>">
	
					<!-- 회원이 로그인 되어 있을 경우에만 댓글 작성가능 // 로그인 후 작성이란 멘트는 대댓글이라서 빼버림-->
					<%if (request.getSession().getAttribute("users_key") != null) {%>
					<input type="submit" value="대댓글 작성">
					<%} %>
				</form>
			</td>
			
		</tr>
		
		<%}%>
	</tbody>
</table>
<br>