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
<%String root = request.getContextPath();%>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script type="text/javascript" src="<%=root%>/resource/js/join_id_check.js"></script>
<script type="text/javascript" src="<%=root%>/resource/js/join_pw_recheck.js"></script>
<!-- 페이지 내용 시작 -->
<h1>회원 가입</h1>
<!-- 
		비밀번호 입력값 일치여부 검사시 템플릿안에 로그인에도 name=usersPw가 있어서 값을 못받아 오기때문에
		form에 id=joinForm 을 부여하여 선택자 지정시킴  
 -->
<form id="joinForm" method='post' action='<%=root%>/users/join.nogari'>
<table border=1>
<tbody>       
	<tr><th>아이디</th><td><input type='text' name='usersId' placeholder='입력하세요'><div></div></td></tr>
	<tr><th>비번</th><td><input type='password' name='usersPw' placeholder='입력하세요'></td></tr>
	<tr>
		<th>비번확인</th>
		<td>
			<input type='password' id='reInputPw' placeholder='비밀번호 재확인'>
			<div class="noticePw"></div>
		</td>
	</tr>
	<tr><th>닉네임</th><td><input type='text' name='usersNick' placeholder='입력하세요'></td></tr>
	<tr><th>이메일</th><td><input type='email' name='usersEmail' placeholder='입력하세요'></td></tr>
	<tr><th>폰번호</th><td><input type='tel' name='usersPhone' placeholder='입력하세요'></td></tr>
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