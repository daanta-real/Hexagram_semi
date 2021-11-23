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

// 2. 해당 idx의 DTO 조회
int usersIdx = Integer.parseInt(request.getParameter("usersIdx")); // 조회할 idx
UsersDao usersDao = new UsersDao();
UsersDto usersDto = usersDao.get(usersIdx);

%>

<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 회원 상세 정보</TITLE>
<%/*템플릿*/%>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
<%/*CSS들*/%>
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/sub_title.css">
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/detail.css">
<%/*회원탈퇴 시 확인창 띄워주는 script*/%>
<script type="text/javascript" src="admin_users_delete.js"></script>
</HEAD>

<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->

<div class="sub_title">회원 상세 정보</div>

<!-- 회원 정보 변경 성공시 success파라미터 -->
<%if(request.getParameter("success") != null) {%>
<h5 color=red>회원 정보 변경에 성공하였습니다</h5>
<%} %>

<!-- 본 정보 출력 테이블 -->
<table class='boardContainer'>

	<tbody class='boardBox'>
		<tr class='row'>
			<th>회원번호</th>
			<td><%=usersDto.getUsersIdx() %></td>
		</tr>
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
			<td><%=HexaLibrary.nvl(usersDto.getUsersPhone())%></td>
		</tr>
		<tr class='row'>
			<th>보유 포인트</th>
			<td><%=usersDto.getUsersPoint() %> point</td>
		</tr>
	</tbody>
	
	<tfoot class='boardBox'><tr><td colspan=2>
		<a href="<%=root%>/admin/users/edit.jsp?usersIdx=<%=usersIdx%>">회원 정보 변경하기</a>
		<a href="<%=root%>/admin/users/list.jsp">회원 목록으로 돌아가기</a>
		<a href="#" onclick="deleteConfirm('<%=usersDto.getUsersId()%>');">탈퇴시키기</a>
		<%--<a href="<%=root%>/admin/users/unregister.nogari?usersId=<%=usersDto.getUsersId() %>"></a>--%>
	</td></tr></tfoot>
</table>

	
<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>