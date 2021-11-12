<%@page import="beans.UsersDto"%>
<%@page import="beans.UsersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 마이페이지</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<BODY>
<%String root = request.getContextPath(); %>

<!--세션에 저장된 아이디 -->
<%String usersId = (String)session.getAttribute("usersId"); %>	

<!-- 회원상세정보 불러오기 -->
<%
UsersDao usersDao = new UsersDao();
UsersDto usersDto = usersDao.get(usersId);
%>

<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>

<!-- 페이지 내용 시작 -->

<table width="60%">
	<tbody>
		<tr>
			<th>아이디</th>
			<td><%=usersDto.getUsersId() %></td>
		</tr>
		<tr>
			<th>비밀번호</th>
			<th align="left">
				<a href="<%=root%>/users/modifyPassword.jsp">
					비밀번호 변경하기(클릭..!)
				</a>
			</th>
		</tr>
		<tr>
			<th>닉네임</th>
			<td><%=usersDto.getUsersNick() %></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><%=usersDto.getUsersEmail() %></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td><%=usersDto.getUsersPhone() %></td>
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
</table>
	<a href="<%=root%>/users/modify.jsp">내 정보 변경하기(click!)</a>
	<a href="<%=root%>/users/unregister.jsp">회원탈퇴하기(ㅠㅠclick!)</a>				
<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>