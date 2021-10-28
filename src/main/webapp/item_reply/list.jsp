<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="beans.UsersDto"%>
<%@page import="beans.UsersDao"%>
<%@page import="beans.ItemReplyDao"%>
<%@page import="java.util.List"%>
<%@page import="beans.ItemReplyDto"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 댓글 목록</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->

<%
String root = request.getContextPath();
int itemIdx = Integer.parseInt(request.getParameter("itemIdx"));// 해당 인덱스 글에 댓글을 보여주겠다.
int usersIdx = (int)request.getSession().getAttribute("usersIdx");//해당 접속 회원이 대댓글을 쓰겠다.(동일 인물이라면 작성자 처리!!!)


//해당 인덱스 글 번호의 ,, 댓글 목록을 불러온다
ItemReplyDao itemReplyDao = new ItemReplyDao();
List<ItemReplyDto> list = itemReplyDao.list(itemIdx);

//이 댓글을 단 회원의 아이디를 가져오기 위해 단일조회를 한다.
UsersDao usersDao = new UsersDao();


int number = 1;
//댓글 순서 번호 부여
%>

<h3 align="center">[댓글 목록]</h3>
<table style="align:center; width:1400px;" border="1">
	<thead><tr>
		<th>댓글 번호</th>
		<th>작성자 아이디</th>
		<th>작성 시간</th>
		<th>내 용</th>
		<th>대 댓글 목록</th>
		<th>대 댓글 달기</th>
	</tr></thead>

	<tbody>
		<%for (ItemReplyDto itemReplyDto : list) {%>
		
			<%
			int reply = itemReplyDto.getItemReplyIdx();
			UsersDto usersDto = usersDao.get(itemReplyDto.getUsersIdx());
			%>
			
			<%if(itemReplyDto.getItemReplyTargetIdx()==0){ %>
		<tr>
			<td><%=number++%></td>
			<td><%=itemReplyDto.getUsersIdx() == 0 ? "탈퇴한 회원" : usersDto.getUsersId()%></td>
			<td><%=itemReplyDto.getItemReplyTime()%></td>
			<td><%=itemReplyDto.getItemReplyDetail()%></td>
			<%
			List<ItemReplyDto> listTarget = itemReplyDao.listTarget(reply);
			%>
			<%if(listTarget.isEmpty()){%>
			<td>대댓글이 없습니다.</td>
			<%}else{ %>
			<td>
					<%for (ItemReplyDto itemReplyTargetDto : listTarget) {%>
										<%
										UsersDto usersDtoTarget = usersDao.get(itemReplyTargetDto.getUsersIdx());
										%>
						<table border="1" style="width:300px;">
								<thead>
									<tr>
										<th>작성자 아이디</th>
										<th>작성 시간</th>
										<th>내 용</th>
									</tr>
							</thead>
							<tbody>
									<tr>
										<td><%=itemReplyTargetDto.getUsersIdx() == 0 ? "탈퇴한 회원" : usersDtoTarget.getUsersId()%></td>
										<td><%=itemReplyTargetDto.getItemReplyTime()%></td>
										<td><%=itemReplyTargetDto.getItemReplyDetail()%></td>
									</tr>
							</tbody>
						</table>
				<%} %>
			<%} %>
			</td>
			
			<td>
				<form
					action="<%=request.getContextPath()%>/item_reply/insert_target.nogari" method="post">
					<!--    	대댓글 내용 전송 -->
					<table>
						<tbody>
							<tr width="500">
								<th>대댓글 입력</th>
								<td><textarea name="item_reply_detail" align="center"
										placeholder="대댓글 입력" required rows="2" cols="50"></textarea></td>
							</tr>
						</tbody>
					</table>
					<!--    	관광지 idx 전송 -->
					<input type="hidden" name="itemIdx" value="<%=itemIdx%>">
					<!--    	대댓글 쓸 유저 idx 전송 -->
					<input type="hidden" name="usersIdx" value="<%=usersIdx%>">
					<!-- 		리스트로 보여줄때 해당 댓글에 대한 번호정보가 필요하므로, 현재 댓글 idx 번호를 전송한다. -->
					<input type="hidden" name="item_reply_targetIdx" value="<%=itemReplyDto.getItemReplyIdx()%>">
	
					<!-- 회원이 로그인 되어 있을 경우에만 댓글 작성가능 // 로그인 후 작성이란 멘트는 대댓글이라서 빼버림-->
					<%if (request.getSession().getAttribute("users_key") != null) {%>
					<input type="submit" value="대댓글 작성">
					<%} %>
				</form>
			</td>

		</tr>
		
		<%}%>
		<%}%>
	</tbody>
</table>
<br>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>