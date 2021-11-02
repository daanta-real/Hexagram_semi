<%@page import="beans.UsersDto"%>
<%@page import="beans.UsersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 내 정보 변경</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<% String root = request.getContextPath(); %>
<!--세션에 저장된 아이디 -->
<%String sessionId = (String)session.getAttribute("usersId"); %>	

<!-- 회원상세정보 불러와서 원래 정보 보여주기 -->
<%
UsersDao usersDao = new UsersDao();
UsersDto usersDto = usersDao.get(sessionId);
%>
<!-- 페이지 내용 시작 -->
<form action="<%=root %>/users/modify.nogari" method="post">
<input type="hidden" name="usersId" value="<%=usersDto.getUsersId()%>">
<input type="hidden" name="usersPw" value="<%=usersDto.getUsersPw()%>">
	<table border="0">
		<thead>
			<tr>
				<th align="center" colspan="2">내 정보 변경 페이지</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th>아이디</th>
				<td><%=usersDto.getUsersId() %></td>
			</tr>
			<tr>
				<th>닉네임 변경</th>
				<td>
					<input type="text" name="usersNick" value="<%=usersDto.getUsersNick() %>">
				</td>
			</tr>
			<tr>
				<th>이메일 변경</th>
				<td>
					<input type="text" name="usersEmail" value="<%=usersDto.getUsersEmail() %>">
				</td>
			</tr>
			<tr>
				<th>전화번호 변경</th>
				<td>
					<input type="text" name="usersPhone" value="<%=usersDto.getUsersPhone() %>">
				</td>
			</tr>
			<tr>
				<th>회원등급</th>
				<td><%=usersDto.getUsersGrade() %></td>
			</tr>
			<tr>
				<th>가입일</th>
				<td><%=usersDto.getUsersJoin() %></td>
			</tr>
			<tr>
				<th>보유 포인트</th>
				<td><%=usersDto.getUsersPoint() %> point</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<!-- 취소 시 회원정보 페이지로 이동 -->
				<td align="center" colspan="2">
					<a href = "<%=root %>/users/detail.jsp">
						<input type="button" value="취소">
					</a>
					<input type="submit" value="변경">
				</td>
			</tr>
		</tfoot>
	</table>	
</form>

<!-- 변경실패시 fail파라미터 확인하고 메세지 보여주기-->
<%if(request.getParameter("fail") != null) {%>
	<h5>
		<font color="red">회원정보 변경에 실패하였습니다. 입력정보를 다시 확인해 주세요</font>
	</h5>
<%} %>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>