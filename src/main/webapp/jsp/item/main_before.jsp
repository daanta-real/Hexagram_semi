<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp">
	<jsp:param name="pageTitle" value="메인" />
</jsp:include>
<!-- 페이지 내용 시작 -->
<%
String root = request.getContextPath();
%>

<h1>Test 전 로그인 Page</h1>
<form action="<%=root%>/jsp/item/login.nogari" method="post">
	<table>
		<tbody>
			<tr>
				<th>아이디 입력</th>

				<td><input type="text" name="users_id" placeholder="아이디 입력" required autocomplete="off"></td>

			</tr>
			<tr>
				<th>비밀번호 입력</th>
				<td><input type="password" name="users_pw" placeholder="아이디 입력" required autocomplete="off"></td>
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
<jsp:include page="/template/footer.jsp"></jsp:include>