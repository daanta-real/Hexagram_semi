<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 회원 가입</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->
<%String root = request.getContextPath();%>

<h1>회원 가입</h1>
<form method='post' action='<%=root%>/users/join.nogari'>
<table border=1>
<tbody>       
	<tr><th>아이디</th><td><input type='text' name='usersId' placeholder='입력하세요'></td></tr>
	<tr><th>비번</th><td><input type='password' name='usersPw' placeholder='입력하세요'></td></tr>
	<tr><th>닉네임</th><td><input type='text' name='usersNick' placeholder='입력하세요'></td></tr>
	<tr><th>이메일</th><td><input type='email' name='usersEmail' placeholder='입력하세요'></td></tr>
</tbody>
<tfoot><tr><td colspan=2 align=center>
	<button type=submit>가입하기</button>
	&nbsp;&nbsp;
	<input type='reset' value='초기화' />
</td></tr></tfoot>
</table>
</form>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>