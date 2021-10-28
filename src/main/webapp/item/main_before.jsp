<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 로그인 (Deprecated)</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->

<%
String root = request.getContextPath();
%>

<h1>Test 전 로그인 Page</h1>
<form action="<%=root%>/item/login.nogari" method="post">
	<table>
		<tbody>
			<tr>
				<th>아이디 입력</th>
				<td><input type="text" name="usersId" placeholder="아이디 입력" required autocomplete="off"></td>
			</tr>
			<tr>
				<th>비밀번호 입력</th>
				<td><input type="password" name="usersPw" placeholder="아이디 입력" required autocomplete="off"></td>
			</tr>
			<tr colspan="2">
				<td align="center"><input type="submit" value="로그인"></td>
			</tr>
		</tbody>
	</table>
</form>

<%if(request.getParameter("error") != null) {%>
<font color="red">잘못된 정보입니다. 다시 입력해주세요.</font>
<%} %>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>