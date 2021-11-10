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
<script>
	window.addEventListener("load", function(){
		//입력한 비밀번호와 재확인 비밀번호 일치 여부에 따른 메세지 보여주기
		document.querySelector("input[name=reInputPw]").addEventListener("blur", function(e){
			var usersPw = document.querySelector("input[name=usersPw]");
			var noticePw = document.querySelector(".noticePw");
			if(usersPw.value.length > 0 && this.value.length > 0){
				if(usersPw.value == this.value){
					noticePw.textContent = "";
					console.log("비번 & 재확인비번 일치");
					e.preventDefault();	
				}else{
					noticePw.textContent = "비밀번호가 일치하지 않습니다. 다시 확인해 주세요";
					console.log("비번 & 재확인비번 불일치");
					e.preventDefault();	
				}			
			}else{
				noticePw.textContent = "입력해주세요";
			}
		});
	});
</script>
<!-- 페이지 내용 시작 -->
<%String root = request.getContextPath();%>
<h1>회원 가입</h1>
<form method='post' action='<%=root%>/users/join.nogari'>
<table border=1>
<tbody>       
	<tr><th>아이디</th><td><input type='text' name='usersId' placeholder='입력하세요'></td></tr>
	<tr><th>비번</th><td><input type='password' name='usersPw' placeholder='입력하세요'></td></tr>
	<tr>
		<th>비번확인</th>
		<td>
			<input type='password' name='reInputPw' placeholder='비밀번호 재확인'>
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