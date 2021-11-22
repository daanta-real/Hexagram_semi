<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 비밀번호 변경</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<% String root = request.getContextPath(); %>
<!-- 페이지 제목 css -->
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/sub_title.css">

<!-- 비밀번호 토글 스크립트 -->
<script type='text/javascript' src="<%=root%>/resource/js/togglePw.js"></script>

<!-- 변경할 비밀번호 정규식 검사 인라인 스크립트 -->
<script type='text/javascript'>
window.addEventListener("load", () => {

    // 변경할 PW 정규표현식 검사
    document.querySelector(".form-regexCheck input[name=pwUpdate]").addEventListener("blur", function(){

        var form  = document.querySelector('.form-regexCheck');
        var regex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[-_~!@#$%^&*=+/,.;’”?])[a-zA-Z0-9-_~!@#$%^&*=+/,.;’”?]{4,20}$/;
        var pwUpdate = form.querySelector("input[name=pwUpdate]").value;
        var message = form.querySelector("input[name=pwUpdate]+.message");
        if(pwUpdate != ""){
            if(regex.test(pwUpdate)){
                console.log("비밀번호 정규표현식 검사 통과");
                message.textContent = "";
            }else{
                console.log("비밀번호 정규표현식 검사 실패");
                message.textContent = "비밀번호는 영문, 숫자, 특수문자 _-~!@#$%^&*=+/,.;’”? 하나씩 포함되야 합니다";
            }		
        }else{
            console.log("비밀번호 미입력");
            message.textContent = "비밀번호를 입력해 주세요";
        }
    });
    
});
</script>

<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>

<%String sessionId = (String)session.getAttribute("usersId"); %>
<!-- 페이지 내용 시작 -->
<div class="sub_title">비밀번호 변경</div>
<form class="form-regexCheck" action="<%=root%>/users/modifyPassword.nogari" method="post">
<input type="hidden" name="usersId" value="<%=sessionId%>">
	<table>
		<tbody>
			<tr>
				<th>내 아이디</th>
				<td><%=sessionId %></td>
			</tr>
			<tr>
				<th>현재 비밀번호</th>
				<td><input type="password" name="usersPw" required><label><input type="checkbox" class="togglePw"><span>보기</span></label></td>
			</tr>
			<tr>
				<th>변경할 비밀번호</th>
				<td>
					<input type="password" name="pwUpdate" required>
					<div class="message"></div>
				</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="변경">
					<a href = "<%=root %>/users/detail.jsp">
						<input type="button" value="취소">
					</a>
				</td>
			</tr>
		</tfoot>
	</table>
</form>

<!-- 변경 실패1. 현재 비밀번호가 일치하지 않을 경우 notEquals 파라미터 확인하고 메세지 보여주기-->
<%if(request.getParameter("notEquals") != null) {%>
	<h5> <font color="red">현재 비밀번호가 일치하지 않습니다. 다시 입력해 주세요</font> </h5>
<%} %>
<!-- 변경 실패2. 현재 비밀번호와 변경할 비밀번호가 동일하면 equalsFail 파라미터 확인하고 메세지 보여주기-->
<%-- <%if(request.getParameter("equalsFail") != null) {%> --%>
<!-- 	<h5> <font color="red">.동일한 비밀번호로 변경할 수 없습니다. 다시 입력해 주세요</font> </h5> -->
<%-- <%} %> --%>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>