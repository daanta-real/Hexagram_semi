<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="util.HexaLibrary" %>

<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="util.users.Sessioner" %>

<%@ page import="beans.UsersDto"%>
<%@ page import="beans.UsersDao"%>

<%

// 1. 변수준비
String root = request.getContextPath();
Sessioner sessioner = new Sessioner(session);

// 2. 해당 id의 DTO 조회
String usersId = sessioner.getUsersId();
UsersDao usersDao = new UsersDao();
UsersDto usersDto = usersDao.get(usersId);

%>

<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 마이페이지</TITLE>
<%/*템플릿*/%>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
<%/*CSS들*/%>
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/sub_title.css">
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/detail.css">
</HEAD>

<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->

<div class="sub_title">내 정보</div>
<table class='boardContainer'>
	<tbody class='boardBox'>
		<tr class='row'>
			<th>아이디</th>
			<td><%=usersDto.getUsersId() %></td>
		</tr>
		<tr class='row'>
			<th>가입일</th>
			<td><%=usersDto.getUsersJoin() %></td>
		</tr>
		<tr class='row'>
			<th>회원등급</th>
			<td><%=usersDto.getUsersGrade() %></td>
		</tr>
		<tr class='row'>
			<th>닉네임</th>
			<td><%=usersDto.getUsersNick() %></td>
		</tr>
		<tr class='row'>
			<th>이메일</th>
			<td><%=usersDto.getUsersEmail() %></td>
		</tr>
		<tr class='row'>
			<th>전화번호</th>
			<td><%=HexaLibrary.nvl(usersDto.getUsersPhone()) %></td>
		</tr>
		<tr class='row'>
			<th>보유 포인트</th>
			<td><%=usersDto.getUsersPoint() %> points</td>
		</tr>
	</tbody>
	<tfoot class='boardBox'>
		<tr>
			<td colspan=2>
				<a href="<%=root%>/users/modifyPassword.jsp">비밀번호 변경하기(click..!)</a>
				<a href="<%=root%>/users/modify.jsp">내 정보 변경하기(click!..)</a>
				<a href="<%=root%>/users/unregister.jsp">회원탈퇴하기(ㅠㅠclick..!)</a>
			</td>
		</tr>
	</tfoot>
</table>			
<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>