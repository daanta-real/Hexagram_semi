<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - [여기다가 타이틀이름 쓰세요. []는 제거하시구요~]</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<% String root = request.getContextPath(); %>
<!-- 페이지 내용 시작 -->

<%--입력--%>

<%--처리--%>

<%--출력--%>
<jsp:include page="/resource/template/header_head.jsp"/></jsp:include>

<h2>게시글 작성</h2>

<form action="write.nagari" method="post">

<table border="0">
	<tbody>
		<tr>
			<th>제목</th>
			<td><input type="text" name="eventName" required></td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea name="eventDetail" required rows="10" cols="60"></textarea>
			</td>
		</tr>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="2" align="right">
				<input type="submit" value="등록">
			</td>
		</tr>
	</tfoot>
</table>
</form>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>