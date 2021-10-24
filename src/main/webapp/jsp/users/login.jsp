<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp">
	<jsp:param name="pageTitle" value="메인" />
</jsp:include>
<%String root = request.getContextPath();%>
<!-- 페이지 내용 시작 -->

<h1>회원 가입</h1>
<form method='post' action='<%=root%>/jsp/users/login.nogari'>
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
<jsp:include page="/template/footer.jsp"></jsp:include>