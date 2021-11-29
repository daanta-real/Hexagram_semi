<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 비밀번호 변경</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
<% String root = request.getContextPath(); %>

<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/sub_title.css">
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/detail.css">
<style type="text/css">
td > label { display: flex; align-items:center; margin: auto 0.4rem auto 0.2rem; word-break: keep-all; min-width:2rem; }
.bottomButtonsLayer { display:flex; width:100%; }
</style>

<!-- 비밀번호 토글 스크립트 -->
<script type='text/javascript' src="<%=root%>/resource/js/togglePw.js"></script>

<!-- 변경할 비밀번호 정규식 검사 인라인 스크립트 -->
<script type='text/javascript'>
window.addEventListener("load", () => {

    // 변경할 PW 정규표현식 검사
    document.querySelector(".form-regexCheck input[name=pwUpdate]").addEventListener("blur", function(){
        
    	var form  = document.querySelector('.form-regexCheck');
    	// 정규식 검사 실패, 중복, 미입력시 submit 버튼 비활성화
		// submit.disabled = true; 이면 비활성화
		// submit.disabled = false; 이면 활성화
		var submit = form.querySelector("input[type=submit]"); 
        
		var regex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[-_~!@#$%^&*=+/,.;’”?])[a-zA-Z0-9-_~!@#$%^&*=+/,.;’”?]{4,20}$/;
        var pwUpdate = form.querySelector("input[name=pwUpdate]").value;
        var message = document.getElementById("pwUpdateMsgDiv");
        if(pwUpdate != ""){
            if(regex.test(pwUpdate)){
                console.log("비밀번호 정규표현식 검사 통과");
                message.textContent = "";
                submit.disabled = false;
            }else{
                console.log("비밀번호 정규표현식 검사 실패");
                message.textContent = "비밀번호는 영문, 숫자, 특수문자 _-~!@#$%^&*=+/,.;’”? 하나씩 포함되야 합니다";
                submit.disabled = true;
            }		
        }else{
            console.log("비밀번호 미입력");
            message.textContent = "비밀번호를 입력해 주세요";
            submit.disabled = true;
        }
    });
    
});
</script>

</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>

<%String sessionId = (String)session.getAttribute("usersId"); %>
<!-- 페이지 내용 시작 -->
<div class="sub_title">비밀번호 변경</div>
<form class="form-regexCheck" action="<%=root%>/users/modifyPassword.nogari" method="post">
<input type="hidden" name="usersId" value="<%=sessionId%>">
	<table class='boardContainer'>
		<tbody class='boardBox'>
			<tr class='row'>
				<th>내 아이디</th>
				<td><%=sessionId %></td>
			</tr>
			<tr class='row'>
				<th>현재 비밀번호</th>
				<td>
					<input type="password" name="usersPw" required />
					<label>
						<input type="checkbox" class="togglePw" />
						<span>보기</span>
					</label>
				</td>
			</tr>
			<tr class='row'>
				<th>변경할 비밀번호</th>
				<td>
					<input type="password" name="pwUpdate" required />
				</td>
			</tr>
			<tr><th colspan=2 id='pwUpdateMsgDiv' class="message"></th></tr>
		</tbody>
		<tfoot>
			<tr class='row' style='display:flex;'>
				<td colspan="2" align="center" class='bottomButtonsLayer flexCol'>
					<input type='submit' class='bottomLongBtn' value="변경">
					<a class='bottomLongBtn' href = "<%=root %>/users/detail.jsp">취소</a>
				</td>
			</tr>
		</tfoot>
	</table>
</form>

<!-- 변경 실패1. 현재 비밀번호가 일치하지 않을 경우 errorCode가 noMatch-->
<!-- 변경 실패2. 변경할 비번이 현재 비번과 일치하면 errorCode가 noChange-->
<%if(request.getParameter("errorCode") != null) {%>
	<%if(request.getParameter("errorCode").equals("noMatch")) {%>
		<h5> <font color="red">현재 비밀번호가 일치하지 않습니다. 다시 입력해 주세요.</font> </h5>
	<%} else if(request.getParameter("errorCode").equals("noChange")) {%>
		<h5> <font color="red"> 현재 비밀번호와 동일한 비밀번호로 변경할 수 없습니다. 다시 입력해 주세요.</font> </h5>
	<%}
  }%>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>