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
<%
	int EventIdx=Integer.parseInt(request.getParameter("eventIdx"));
%>

<%--처리--%>
<%
	EventDao eventDao=new EventDao();
	EventDto eventDto=eventDao.get(eventIdx);
%>

<%--출력--%>
<jsp:include page="/resource/template/header_head.jsp"/></jsp:include>

<h2>게시글 수정</h2>

<form action="edit.nagari" method="post">
<input type="hidden" name="eventIdx" value="<%=eventDto.getEventIdx()%>">

<table border="0">
	<tbody>
		<tr>
			<th>제목</th>
			<td><input type="text" name="eventName" required vaule="<%=eventDto.getEventName() %>"></td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea name="eventDetail" required rows="10" cols="60"><%=eventDto.getEventDetail()%></textarea>
			</td>
		</tr>
	</tbody>
	<tfoot>
		<tr>
			<td colspan="2" align="right">
				<input type="submit" value="수정">
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