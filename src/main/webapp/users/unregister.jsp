<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import='util.users.Sessioner' %>
<% String root = request.getContextPath(); %>

<!DOCTYPE HTML>
<HTML>

<HEAD>
<TITLE>노가리투어 - 회원탈퇴</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/sub_title.css">
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/detail.css">
<style type='text/css'>
.bottomLongBtn { width:100%; }
</style>
</HEAD>

<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>

<% String sessionId = Sessioner.getUsersId(session); %>

<!-- 페이지 내용 시작 -->
<div class="sub_title">회원 탈퇴 비번 확인</div>
<form action="<%=root %>/users/unregister.nogari" method="post">
<input type="hidden" name="targetId" value="<%=sessionId%>">
	<table class='boardContainer'>
		<tbody class='boardBox'>
			<tr class='row'>
				<th>내 아이디</th>
				<td><%=sessionId %></td>
			</tr>
			<tr class='row'>
				<th>비밀번호 확인</th>
				<td>
					<input type="password" name="usersPw" required>
				</td>
			</tr>
		</tbody>
		<tfoot class='boardBox'>
			<tr>
				<td colspan="2" align="center">
					<input class='bottomLongBtn' type="submit" value="~_~탈퇴">
				</td>
			</tr>
		</tfoot>
	</table>	
</form>

<!-- 회원 탈퇴 실패시 fail파라미터 확인하고 메세지 보여주기-->
<%if(request.getParameter("fail") != null) {%>
	<h5>
		<font color="red">회원 탈퇴에 실패하였습니다. 비밀번호를 다시 확인해 주세요</font>
	</h5>
<%} %>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>