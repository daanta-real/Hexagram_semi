<%@page import="beans.UsersDto"%>
<%@page import="beans.UsersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 회원 정보 상세</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<!-- 테이블 css -->
<link rel="stylesheet" type="text/css" href="/Hexagram_semi/resource/css/users/table.css">
<!-- 페이지 제목 css -->
<link rel="stylesheet" type="text/css" href="/Hexagram_semi/resource/css/users/sub_title.css">
<style>
.table{width:20%;}
</style>
 <!-- jquery CDN을 불러오는 코드-->
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!-- 회원탈퇴 시 확인창을 불러오는 script -->
<script type="text/javascript" src="/Hexagram_semi/resource/js/users/admin_users_delete.js"></script>
<BODY>
<% String root = request.getContextPath(); %>

<!-- 회원상세정보 불러오기. 파라미터로 전달한 조회할 회원의 usersIdx -->
<%
	int usersIdx = Integer.parseInt(request.getParameter("usersIdx"));	
	UsersDao usersDao = new UsersDao();
	UsersDto usersDto = usersDao.get(usersIdx);
%>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->
<div class="sub_title">회원 상세 정보</div>
<table class="table">
	<tbody>
		<tr>
			<th>회원번호</th>
			<td><%=usersDto.getUsersIdx() %></td>
		</tr>
		<tr>
			<th>아이디</th>
			<td><%=usersDto.getUsersId() %></td>
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
<!-- 회원 정보 변경 성공시 success파라미터 -->
 <%if(request.getParameter("success") != null) {%>
    	<h5>회원 정보 변경에 성공하였습니다</h5>
  <%} %>
    
	<a href="<%=root%>/admin/users/edit.jsp?usersIdx=<%=usersIdx%>">
		<input type="button" value="회원정보 변경하기">
	</a>
	<a href="<%=root%>/admin/users/list.jsp">
		<input type="button" value="회원목록으로 돌아가기">
	</a>
		<button onclick="deleteConfirm('<%=usersDto.getUsersId()%>');">탈퇴</button>
<%-- 	
	<a href="<%=root%>/admin/users/unregister.nogari?usersId=<%=usersDto.getUsersId() %>"></a> 
--%>
	
<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>