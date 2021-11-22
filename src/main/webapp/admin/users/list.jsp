<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="java.util.List"%>

<%@page import="beans.UsersDao"%>
<%@page import="beans.UsersDto"%>

<%@page import="beans.Pagination"%>

<%
String root = request.getContextPath();
%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 회원 목록</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>

<!-- 페이지 제목 css -->
<link rel="stylesheet" type="text/css" href="/<%=root%>/resource/css/users/sub_title.css">
<!-- 게시판 공통 css -->
<link rel="stylesheet" type="text/css" href="/<%=root%>/resource/css/users/board.css">

<style>
:root {--board-grid-columns: 5rem 5rem 5rem 7rem 5rem 7rem;}
.btn{
	color: var(--board-color-title-font);
	background-color: var(--board-color-title-bg);
	font-size: 1rem;
	border: none;
	margin: 0.1rem;
}
.search-btn{	font-size: 1.5rem;	}
.selectBox{	  padding: 0.4rem;	margin: 0.3rem;	}
</style>

<!-- 회원탈퇴 시 확인창을 불러오는 script -->
<script type="text/javascript" src="admin_users_delete.js"></script>

<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>

<!-- 페이지 내용 시작 -->


<%
// 1. 변수 준비
UsersDao usersDao = new UsersDao();
Pagination<UsersDao, UsersDto> pn = new Pagination<>(request, usersDao);
boolean isSearchMode = pn.isSearchMode();
System.out.println(
	  "[회원 목록] 컬럼(" + request.getParameter("column") + ")"
	+ ", 키워드(" + request.getParameter("keyword") + ")"
	+ ", 검색모드 여부(" + isSearchMode + ")"
);
pn.setPageSize(20);
pn.calculate();
System.out.println("[회원 목록] 페이지네이션 정보: " + pn);
%>
<!-- 검색 -->
 <div class='boardContainer'>
 	<div class='boardBox row'>
    <form action="<%=request.getContextPath()%>/admin/users/list.jsp" method="post">
	     <select name="column" class="selectBox">
	    	<option value="">항목선택</option>
			<%
			if(pn.columnValExists("users_id")) {
			%>
	    	<option value="users_id" selected>아이디</option>
	    	<%
	    	}else {
	    	%>
	    	<option value="users_id">아이디</option>
	    	<%
	    	}
	    	%>
	    	<%
	    	if(pn.columnValExists("users_nick")) {
	    	%>
	    	<option value="users_nick" selected>닉네임</option>
	    	<%
	    	}else {
	    	%>
	    	<option value="users_nick">닉네임</option>
	    	<%
	    	}
	    	%>
	    	<%
	    	if(pn.columnValExists("users_email")) {
	    	%>
	    	<option value="users_email" selected>이메일</option>
	    	<%
	    	}else {
	    	%>
	    	<option value="users_email">이메일</option>
	    	<%
	    	}
	    	%>
	    	<%
	    	if(pn.columnValExists("users_phone")) {
	    	%>
	    	<option value="users_phone" selected>전화번호</option>
	    	<%
	    	}else {
	    	%>
	    	<option value="users_phone">전화번호</option>
	    	<%
	    	}
	    	%>
	    	<%
	    	if(pn.columnValExists("users_grade")) {
	    	%>
	    	<option value="users_grade" selected>회원등급</option>
	    	<%
	    	}else {
	    	%>
	    	<option value="users_grade">회원등급</option>
	    	<%
	    	}
	    	%>
	    </select>
	    <input type="text" name="keyword" placeholder="검색어입력" required value="<%=pn.getKeywordString()%>">
	    <input type="submit" value="검색" class='btn search-btn'>
	</form>
	</div>
<!-- 회원목록 -->
<!-- 회원 탈퇴 리다이렉트 delete파라미터 -->
 <%
 if(request.getParameter("delete") != null) {
 %>
 	<div class="sub_title">아이디 <%=request.getParameter("usersId")%> 회원 탈퇴 완료</div>
 <%
 }
 %>
	 <div class='boardBox title'>
	     <div class='row'>
	         <div>회원번호</div>
	         <div>아이디</div>
	         <div>닉네임</div>
	         <div>이메일</div>
	         <div>회원등급</div>
	         <div>회원관리</div>
	     </div>
	 </div>
	 <div class='boardBox body'>
	<%
	List<UsersDto> list = pn.getResultList();
			System.out.println("출력할 회원 수: " + list.size());
			
			for(UsersDto usersDto : list) {
	%>
	 	<div class='row'>
	 		<div><%=usersDto.getUsersIdx() %></div>
	 		<div>
	 			<a href="detail.jsp?usersIdx=<%=usersDto.getUsersIdx()%>">
					<%=usersDto.getUsersId() %>
				</a>
			</div>
	 		<div><%=usersDto.getUsersNick() %></div>
	 		<div><%=usersDto.getUsersEmail()%></div>
	 		<div><%=usersDto.getUsersGrade() %></div>
	 		<div>
	 			<a href="detail.jsp?usersIdx=<%=usersDto.getUsersIdx()%>"><button class='btn'>상세</button></a>
				<a href="edit.jsp?usersIdx=<%=usersDto.getUsersIdx()%>"><button class='btn'>수정</button></a>
				<button onclick="deleteConfirm('<%=usersDto.getUsersId()%>');" class='btn'>탈퇴</button>
	 		</div>
	 	</div>
	<%} %>
	 </div>

	<!-- 페이지 네비게이터 검색 / 목록-->
	<div class='boardBox page'>
		<div class='el'>
		<%if(pn.hasPreviousBlock()) {%>
			<%if(isSearchMode) {%>
				<a href="list.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword()%>&page=<%=pn.getStartBlock()-1 %>">◀</a>
			<%} else{ %>
				<a href="list.jsp?page=<%=pn.getPreviousBlock()%>">◀</a>
			<%} %>
		<%} else{ %>
			<a>◀</a>
		<%} %>
		</div>
		<%for(int i = pn.getStartBlock() ; i <= pn.getRealLastBlock() ; i++) {%>
		<div class='el'>
			<%if(isSearchMode) { %>
				<a href="list.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&page=<%=i %>"><%=i %></a>
			<%}else{ %>
				<a href="list.jsp?page=<%=i %>"><%=i %></a>
			<%} %>
		</div>
		<%} %>
		<div class='el'>
		<%if(pn.hasNextBlock()) {%>
			<%if(isSearchMode) {%>
				<a href="list.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&page=<%=pn.getNextBlock() %>">▶</a>
			<%} else{ %>
				<a href="list.jsp?page=<%=pn.getNextBlock()%>">▶</a>
			<%} %>
		<%} else{%>
			<a>▶</a>
		<%} %>
		</div>
	</div>
 </div>
<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>