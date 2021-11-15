<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 로그인</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<!-- 테이블 css -->
<link rel="stylesheet" type="text/css" href="/Hexagram_semi/resource/css/users/table.css">
<!-- 페이지 제목 css -->
<link rel="stylesheet" type="text/css" href="/Hexagram_semi/resource/css/users/sub_title.css">
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->
<%String root = request.getContextPath();%>

<div class="sub_title">회원 로그인</div>
<form method='post' action='<%=root%>/users/login.nogari'>
<table class="table">
<tbody>
	<tr><th>아이디</th><td><input type='text' name='usersId' placeholder='입력하세요'></td></tr>
	<tr><th>비번</th><td><input type='password' name='usersPw' placeholder='입력하세요'></td></tr>
</tbody>
<tfoot><tr><td colspan=2 align=center>
	<button type=submit>로그인</button>
<%if(request.getParameter("error") != null) {%>
	<h5><font color="red">로그인 정보가 일치하지 않습니다</font></h5>
<%}%>
</td></tr></tfoot>
</table>
</form>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>