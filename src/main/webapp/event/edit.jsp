<%@page import="java.beans.EventDto"%>
<%@page import="java.beans.EventDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 입력 --%>
<%
	int eventNo = Integer.parseInt(request.getParameter("eventNo"));
%>

<%-- 처리 --%>
<%
	EventDao eventDao = new EventDao();
	EventDto eventDto = eventDao.get(eventNo);
%>

<%-- 출력 --%>
<jsp:include page="/template/header.jsp"></jsp:include>

<h2>게시글 수정</h2>

<form action="edit.kh" method="post">
<input type="hidden" name="eventNo" value="<%=eventDto.getEventNo()%>">

<table border="0">
	<tbody>
		<tr>
			<th>제목</th>
			<td><input type="text" name="eventTitle" required value="<%=eventDto.getEventTitle()%>"></td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea name="eventContent" required 
					rows="10" cols="60"><%=eventDto.getEventContent()%></textarea>
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

<jsp:include page="/template/footer.jsp"></jsp:include>