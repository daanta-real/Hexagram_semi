<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/resource/template/header.jsp">
	<jsp:param name="pageTitle" value="메인" />
</jsp:include>
<SECTION CLASS="flexCenter flexCol">
<!-- 페이지 내용 시작 -->
<%String root = request.getContextPath();%>

<h1>회원 로그인</h1>
<form method='post' action='<%=root%>/users/login.nogari'>
<table border=1>
<tbody>
	<tr><th>아이디</th><td><input type='text' name='usersId' placeholder='입력하세요'></td></tr>
	<tr><th>비번</th><td><input type='password' name='usersPw' placeholder='입력하세요'></td></tr>
</tbody>
<tfoot><tr><td colspan=2 align=center>
	<button type=submit>로그인</button>
<%if(request.getParameter("error") != null) {%>
	<h5>
		<font color="red">로그인 정보가 일치하지 않습니다</font>
	</h5>
<%}%>
</td></tr></tfoot>
</table>
</form>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>