<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%String root = request.getContextPath();%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 회원 가입</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>

<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/sub_title.css">
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/detail.css">
<style type='text/css'>
.bottomLongBtn { width:100%; }
.multiline { display:flex; flex-direction:column; align-items: flex-start; }
td > label { display: flex; align-items:center; margin: auto 0.4rem auto 0.2rem; word-break: keep-all; }

</style>

<!-- 인라인 -->
<script type='text/javascript'>
var sysurl = "<%=root%>";
</script>

<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!-- 아이디 정규식 & 중복 검사 스크립트-->
<script type='text/javascript' src="<%=root%>/resource/js/regexId_ajax.js"></script>
<!-- 비밀번호 일치 검사 스크립트 -->
<script type='text/javascript' src="<%=root%>/resource/js/checkPwEquals.js"></script>
<!-- 비밀번호 정규식 검사 스크립트 -->
<script type='text/javascript' src="<%=root%>/resource/js/regexPw.js"></script>
<!-- 닉네임 정규식 & 중복 검사 스크립트 -->
<script type='text/javascript' src="<%=root%>/resource/js/regexNick_ajax.js"></script>
<!-- 이메일 정규식 & 중복 검사 스크립트 -->
<script type='text/javascript' src="<%=root%>/resource/js/regexEmail_ajax.js"></script>
<!-- 폰번호 정규식 검사 스크립트 -->
<script type='text/javascript' src="<%=root%>/resource/js/regexPhone.js"></script>
<!-- 비밀번호 토글 스크립트 -->
<script type='text/javascript' src="<%=root%>/resource/js/togglePw.js"></script>
<!-- 초기화(새로고침) 스크립트 -->
<script type='text/javascript' src="<%=root%>/resource/js/resetAll.js"></script>

</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>

<SECTION>
<!-- 페이지 내용 시작 -->
<div class="sub_title">회원 가입</div>
<!-- 
	비밀번호 입력값 일치여부 검사시 템플릿안에 로그인에도 name=usersPw가 있어서 값을 못받아 오기때문에
	form에 class=form-regexCheck 를 부여하여 선택자 지정시킴  
 -->
<form class="form-regexCheck" method='post' action='<%=root%>/users/register.nogari'>
<table class='boardContainer'>
<tbody class='boardBox'>       
	<tr class='row'>
		<th>아이디</th>
		<td class="flexCenter flexCol"><input type='text' name='usersId' placeholder='입력하세요' required><div class="message"></div></td>
	</tr>
	<tr class='row'>
		<th>비번</th>
		<td class="flexCenter flexCol">
			<div style="display: flex; flex-direction: row; word-break: keep-all;">
				<input type='password' name='usersPw' placeholder='입력하세요' required>
				<label style="word-break: keep-all; display: flex; flex-direction: row; min-width: 2rem; align-items: center; margin: auto 0.4rem auto 0.2rem;"><input type="checkbox" class="togglePw" /><span>보기</span></label>
			</div>
			<div class="usersPw message"></div>
		</td>
	</tr>
	<tr class='row'><th>비번확인</th><td class='multiline'><input type='password' id='reInputPw' placeholder='비밀번호 재확인' required><div class="noticePw"></div></td></tr>
	<tr class='row'><th>닉네임</th><td class='multiline'><input type='text' name='usersNick' placeholder='입력하세요' required><div class="message"></div></td></tr>
	<tr class='row'><th>이메일</th><td class='multiline'><input type='email' name='usersEmail' placeholder='입력하세요' required><div class="message"></div></td></tr>
	<tr class='row'><th>폰번호</th><td class='multiline'><input type='tel' name='usersPhone' placeholder='입력하세요'><div class="message"></div></td></tr>
</tbody>
<tfoot class='boardBox'><tr><td colspan=2 align=center class='flexCenter flexCol' style='width:100%;'>
	<input type='submit' class='bottomLongBtn' value='회원가입'>
	<span class='bottomLongBtn reset'>초기화</span>
</td></tr></tfoot>
</table>
</form>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>