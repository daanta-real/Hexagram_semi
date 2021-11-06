<%@page import="beans.UsersDto"%>
<%@page import="beans.UsersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - [여기다가 타이틀이름 쓰세요. []는 제거하시구요~]</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<BODY>
<% String root = request.getContextPath(); %>
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
<form action="<%=root%>/admin/users/edit.nogari" method="post">
<input type="hidden" name="usersIdx" value="<%=usersDto.getUsersIdx()%>">
<input type="hidden" name="usersId" value="<%=usersDto.getUsersId()%>">
	<table>
		<tbody>
			<tr>
				<th>회원No.</th>
				<td><%=usersDto.getUsersIdx() %></td>
			</tr>
			<tr>
				<th>아이디</th>
				<td><%=usersDto.getUsersId() %></td>
			</tr>
			<tr>
				<th>비번</th>
				<td>
					<input type="password" name="usersPw" value="<%=usersDto.getUsersPw()%>" required>
				</td>
			</tr>
			<tr>
				<th>닉네임</th>
				<td>
					<input type="text" name="usersNick" value="<%=usersDto.getUsersNick() %>" required>
				</td>
			</tr>
			<tr>
				<th>이메일</th>
				<td>
					<input type="email" name="usersEmail" value="<%=usersDto.getUsersEmailNull() %>">	
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
					<input type="tel" name="usersPhone" value="<%=usersDto.getUsersPhoneNull() %>">
				</td>
			</tr>
			<tr>
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
			<tr>
				<th>가입일</th>
				<td><%=usersDto.getUsersJoin() %></td>
			</tr>
			<tr>
				<th>보유 포인트</th>
				<td><%=usersDto.getUsersPoint() %>point</td>
			</tr>
			<tr>
				<th colspan="2" align="center">
					<a href="<%=root%>/admin/users/edit.jsp?usersIdx=<%=usersIdx%>">
						<input type="submit" value="변경하기 완료">
					</a>
				</th>
			</tr>
		</tbody>
	</table>
</form>

<!-- 회원 정보 변경 실패시 fail파라미터 -->
 <%if(request.getParameter("fail") != null) {%>
    	<h5>
		 	<font color="red">회원 정보 변경에 실패하였습니다</font>
		 </h5>
    <%} %>

	<a href="<%=root%>/admin/users/list.jsp">
		<input type="button" value="회원목록으로 돌아가기">
	</a>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>