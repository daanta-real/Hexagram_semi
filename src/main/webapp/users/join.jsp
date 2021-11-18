<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 회원 가입</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
<%String root = request.getContextPath();%>

<!-- 페이지 제목 css -->
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/sub_title.css">

<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.js"></script>

<!-- 회원가입 검사 스크립트 -->
<script type='text/javascript' src="join_check.js"></script>

</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>

<SECTION>
<!-- 페이지 내용 시작 -->
<div class="sub_title">회원 가입</div>
<!-- 
		비밀번호 입력값 일치여부 검사시 템플릿안에 로그인에도 name=usersPw가 있어서 값을 못받아 오기때문에
		form에 id=joinForm 을 부여하여 선택자 지정시킴  
 -->
<form id="joinForm" method='post' action='<%=root%>/users/join.nogari'>
<table>
<tbody>       
	<tr><th>아이디</th><td><input type='text' name='usersId' placeholder='입력하세요' required><div class="message"></div></td></tr>
	<tr><th>비번</th><td><input type='password' name='usersPw' placeholder='입력하세요' required><div class="message"></div></td></tr>
	<tr>
		<th>비번확인</th>
		<td>
			<input type='password' id='reInputPw' placeholder='비밀번호 재확인' required>
			<div class="noticePw"></div>
		</td>
	</tr>
	<tr><th>닉네임</th><td><input type='text' name='usersNick' placeholder='입력하세요' required><div class="message"></div></td></tr>
	<tr><th>이메일</th><td><input type='email' name='usersEmail' placeholder='입력하세요'><div class="message"></div></td></tr>
	<tr><th>폰번호</th><td><input type='tel' name='usersPhone' placeholder='입력하세요'><div class="message"></div></td></tr>
</tbody>
<tfoot><tr><td colspan=2 align=center>
	<input type=submit value="가입하기">
	&nbsp;&nbsp;
	<input type='button' value='초기화' id="reset">
</td></tr></tfoot>
</table>
</form>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>