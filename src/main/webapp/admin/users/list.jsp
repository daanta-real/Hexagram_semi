<%@page import="beans.Pagination"%>
<%@page import="beans.UsersDto"%>
<%@page import="java.util.List"%>
<%@page import="beans.UsersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 회원관리</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<% String root = request.getContextPath(); %>

<%
	//회원 목록 페이징
	Pagination pn = new Pagination(request);
	pn.setPageSize(20);
	pn.usersCalculater();	
%>
<!-- 페이지 내용 시작 -->

 <!-- 검색 -->
    <form action="<%=request.getContextPath()%>/admin/users/list.jsp" method="post">
	     <select name="column">
	    	<option value="">항목선택</option>
			<%if(pn.columnIs("users_id")) {%>
	    	<option value="users_id" selected>아이디</option>
	    	<%}else {%>
	    	<option value="users_id">아이디</option>
	    	<%} %>
	    	<%if(pn.columnIs("users_nick")) {%>
	    	<option value="users_nick" selected>닉네임</option>
	    	<%}else {%>
	    	<option value="users_nick">닉네임</option>
	    	<% }%>
	    	<%if(pn.columnIs("users_email")) {%>
	    	<option value="users_email" selected>이메일</option>
	    	<%}else {%>
	    	<option value="users_email">이메일</option>
	    	<%} %>
	    	<%if(pn.columnIs("users_phone")) {%>
	    	<option value="users_phone" selected>전화번호</option>
	    	<%}else {%>
	    	<option value="users_phone">전화번호</option>
	    	<% }%>
	    	<%if(pn.columnIs("users_grade")) {%>
	    	<option value="users_grade" selected>회원등급</option>
	    	<%}else {%>
	    	<option value="users_grade">회원등급</option>
	    	<% }%>
	    </select>
	    <input type="text" name="keyword" placeholder="검색어입력" required value="<%=pn.getKeywordString() %>">
	    <input type="submit" value="검색">
	</form>

<!-- 회원목록 -->
<!-- 회원 탈퇴 리다이렉트 delete파라미터 -->
 <%if(request.getParameter("delete") != null) {%>
 	<h5>아이디 <%=request.getParameter("usersId") %> 회원 탈퇴 완료</h5>
 <%} %>
<table border="1" width="70%">
	<thead>
		<tr>
			<th>회원번호</th>
			<th>아이디</th>
			<th>닉네임</th>
			<th>이메일</th>
			<th>회원등급</th>			
			<th>회원관리</th>
		</tr>
	</thead>
	<tbody>
	<%for(UsersDto usersDto : pn.getUsersList()) {
		String usersEmail = usersDto.getUsersEmail(); if(usersEmail == null || usersEmail.equals("")) usersEmail = " "; 
	%>
		<tr>
			<td align="center"><%=usersDto.getUsersIdx() %></td>
			<!-- 회원 아이디를 누르면 회원 상세정보 페이지로 이동 -->
			<td>
				<a href="detail.jsp?usersIdx=<%=usersDto.getUsersIdx()%>">
					<%=usersDto.getUsersId() %>
				</a>
			</td>
			<td><%=usersDto.getUsersNick() %></td>
			<td><%=usersEmail%></td>
			<td align="center"><%=usersDto.getUsersGrade() %></td>
			<th align="center">
				<a href="detail.jsp?usersIdx=<%=usersDto.getUsersIdx()%>">상세</a> |
				<a href="edit.jsp?usersIdx=<%=usersDto.getUsersIdx()%>">수정</a> |
				<a href="unregister.nogari?usersId=<%=usersDto.getUsersId()%>">탈퇴</a>
			</th>
		</tr>
	<%} %>
	</tbody>
</table>

<!-- 페이지 네비게이터 검색 / 목록-->
<DIV>
<%if(pn.isPreviousAvailable()) {%>
	<%if(pn.searchUsers()) {%>
		<a href="list.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword()%>&page=<%=pn.getStartBlock()-1 %>">&lt;</a>
	<%} else{ %>
		<a href="list.jsp?page=<%=pn. getPreviousBlock()%>">&lt;</a>
	<%} %>
<%} else{ %>
	<a>&lt;</a>
<%} %>

<%for(int i = pn.getStartBlock() ; i <= pn.getRealLastBlock() ; i++) {%>
	<%if(pn.searchUsers()) { %>
		<a href="list.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&page=<%=i %>"><%=i %></a>
	<%}else{ %>
		<a href="list.jsp?page=<%=i %>"><%=i %></a>
	<%} %>
<%} %>

<%if(pn.isNextAvailable()) {%>
	<%if(pn.searchUsers()) {%>
		<a href="list.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&page=<%=pn.getNextBlock() %>">&gt;</a>
	<%} else{ %>
		<a href="list.jsp?page=<%=pn.getNextBlock()%>">&gt;</a>
	<%} %>
<%} else{%>
	<a>&gt;</a>
<%} %>
</DIV>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>