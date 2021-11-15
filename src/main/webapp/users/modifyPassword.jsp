<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 비밀번호 변경</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<!-- 페이지 제목 css -->
<link rel="stylesheet" type="text/css" href="/Hexagram_semi/resource/css/users/sub_title.css">
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<% String root = request.getContextPath(); %>

<%String sessionId = (String)session.getAttribute("usersId"); %>
<!-- 페이지 내용 시작 -->
<div class="sub_title">비밀번호 변경</div>
<form action="<%=root%>/users/modifyPassword.nogari" method="post">
<input type="hidden" name="usersId" value="<%=sessionId%>">
	<table>
		<tbody>
			<tr>
				<th>내 아이디</th>
				<td><%=sessionId %></td>
			</tr>
			<tr>
				<th>현재 비밀번호</th>
				<td><input type="password" name="usersPw" required></td>
			</tr>
			<tr>
				<th>변경할 비밀번호</th>
				<td><input type="password" name="pwUpdate" required></td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2">
					<input type="submit" value="변경">
					<a href = "<%=root %>/users/detail.jsp">
						<input type="button" value="취소">
					</a>
				</td>
			</tr>
		</tfoot>
	</table>
</form>

<!-- 비밀번호 변경실패시 fail파라미터 확인하고 메세지 보여주기-->
<%if(request.getParameter("fail") != null) {%>
	<h5> <font color="red">변경할 수 없는 비밀번호입니다. 다시 입력해 주세요</font> </h5>
<%} %>


<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>