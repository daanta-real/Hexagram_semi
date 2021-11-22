<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%String root = request.getContextPath();%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 로그인</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<%/*템플릿*/%>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
<%/*CSS들*/%>
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/sub_title.css">
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/detail.css">
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->

<div class="sub_title">회원 로그인</div>
<form method='post' action='<%=root%>/users/login.nogari'>
<table class='boardContainer'>

	<tbody class='boardBox'>
	
		<tr class='row'>
			<th>아이디</th>
			<td>
				<input type='text' name='usersId' placeholder='입력하세요' required />
			</td>
		</tr>
		
		<tr class='row'>
			<th>비번</th>
			<td>
				<input type='password' name='usersPw' placeholder='입력하세요' required class='pw' />
				<label></label>
			</td>
		</tr>
		
	</tbody>
	
	<tfoot class='boardBox'><tr><td colspan=2 align=center>
	
		<button type=submit>로그인</button>
	
		<!-- 로그인 실패시 error 파라미터 서블릿에서 전달 -->
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