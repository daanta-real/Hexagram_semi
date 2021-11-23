<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="beans.UsersDto"%>
<%@page import="beans.UsersDao"%>

<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 회원 정보 변경</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>

<% String root = request.getContextPath(); %>
<script type='text/javascript'>
var sysurl = "<%=root%>";
</script>
<%/*CSS들*/%>
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/sub_title.css">
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/detail.css">
<style type='text/css'>
:root {
	--board-grid-columns: 6rem 11rem; 
}

.boardContainer > .boardBox > .row > td > label > input,
.boardContainer > .boardBox > .row > td > label > span {
	position:relative; max-width:4rem; cursor:pointer;
}
.boardContainer > .boardBox > .row > td > select {
	width:100%; border:0; padding:0.3rem 0.3rem; outline:none;
	position:relative; max-width:10rem;
}
.boardContainer > .boardBox > .row > td input {
	position:relative; width:100%; max-width:10rem;
	margin:0.1rem; border:0; padding:0 0.3rem; outline:none;
}
</style>
</HEAD>
<BODY>

<!-- 비밀번호 정규식 검사 스크립트 -->
<script type='text/javascript' src="<%=root%>/resource/js/regexPw.js"></script>
<!-- 닉네임 정규식 검사 스크립트 -->
<script type='text/javascript' src="<%=root%>/resource/js/regexNick_ajax.js"></script>
<!-- 이메일 정규식 검사 스크립트 -->
<script type='text/javascript' src="<%=root%>/resource/js/regexEmail_ajax.js"></script>
<!-- 폰번호 정규식 검사 스크립트 -->
<script type='text/javascript' src="<%=root%>/resource/js/regexPhone.js"></script>
<!-- 비밀번호 토글 스크립트 -->
<script type='text/javascript' src="<%=root%>/resource/js/togglePw.js"></script>

<!-- 회원의 원래 정보는 그대로 보여 주고 수정할 수 있도록 처리 -->
<!-- 회원상세정보 불러오기. 파라미터로 전달한 조회할 회원의 usersIdx -->
<%
int usersIdx = Integer.parseInt(request.getParameter("usersIdx"));	
	UsersDao usersDao = new UsersDao();
	UsersDto usersDto = usersDao.get(usersIdx);
%>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->
<div class="sub_title">회원 정보 변경</div>
<form class="form-regexCheck" action="<%=root%>/admin/users/edit.nogari" method="post">
<input type="hidden" name="usersIdx" value="<%=usersDto.getUsersIdx()%>">
<input type="hidden" name="usersId" value="<%=usersDto.getUsersId()%>">
	<table class='boardContainer'>
		<tbody class='boardBox'>
			<tr class='row'>
				<th>회원No.</th>
				<td><%=usersDto.getUsersIdx() %></td>
			</tr>
			<tr class='row'>
				<th>아이디</th>
				<td class='flexCol'><%=usersDto.getUsersId() %></td>
			</tr>
			<tr class='row'>
				<th>비번</th>
				<td class='flexCol'>
					<input type="password" name="usersPw" required value="<%=usersDto.getUsersPw()%>">
					<div class="usersPw message"></div>
					<label><input type="checkbox" class="togglePw"><span>보기</span></label>
				</td>
			</tr>
			
			<tr class='row'>
				<th>닉네임</th>
				<td class='flexCol'>
					<input type="text" name="usersNick"  required value="<%=usersDto.getUsersNick() %>">
					<div class="message"></div>
				</td>
			</tr>
			<tr class='row'>
				<th>이메일</th>
				<td class='flexCol'>
					<input type="email" name="usersEmail"  required value="<%=usersDto.getUsersEmail() %>">	
					<div class="message"></div>
				</td>
			</tr>
			<tr class='row'>
				<th>전화번호</th>
				<td class='flexCol'>
					<input type="tel" name="usersPhone" value="<%=usersDto.getUsersPhone() %>">
					<div class="message"></div>
				</td>
			</tr>
			<tr class='row'>
				<th>회원등급</th>
				<td>
					<select name="usersGrade">
					<%if(usersDto.getUsersGrade().equals("준회원")) {%>
						<option selected>준회원</option>
						<option>정회원</option>
						<option>관리자</option>
					<%}else if(usersDto.getUsersGrade().equals("정회원")) {%>
						<option>준회원</option>
						<option selected>정회원</option>
						<option>관리자</option>
					<%}else if(usersDto.getUsersGrade().equals("관리자")) {%>	
						<option>준회원</option>
						<option>정회원</option>
						<option selected>관리자</option>
					<%} %>
					</select>
				</td>
			</tr>
			<tr class='row'>
				<th>가입일</th>
				<td><%=usersDto.getUsersJoin() %></td>
			</tr>
			<tr class='row'>
				<th>보유 포인트</th>
				<td><%=usersDto.getUsersPoint() %>point</td>
			</tr>
		</tbody>
		<tfoot class='boardBox'>			
			<tr>
				<td colspan="2">
					<button type="submit">변경하기</button>
					<a href="<%=root%>/admin/users/list.jsp">회원목록으로 돌아가기</a>
				</td>
			</tr>
		</tfoot>
	</table>
</form>



<!-- 회원 정보 변경 실패시 fail파라미터 -->
 <%if(request.getParameter("fail") != null) {%>
    	<h5>
		 	<font color="red">회원 정보 변경에 실패하였습니다</font>
		 </h5>
 <%} %>
<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>