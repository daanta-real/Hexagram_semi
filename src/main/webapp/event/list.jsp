<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="beans.EventDao" %>
<%@ page import="beans.EventDto" %>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 이벤트 게시판</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<% String root = request.getContextPath(); %>
<!-- 페이지 내용 시작 -->
<%--입력:검색분류(column), 검색어(keyword)--%>
<%
	String column=request.getParameter("column");
	String keyword=request.getPatameter("keyword");
%>

<%--처리--%>
<%
	boolean search
		=  column  != null && !column.isEmpty()
		&& keyword != null && !keyword.isEmpty();

	EventDao eventDao = new EventDao();
	List<EventDto> list;
	if(search){
		list=eventDao.search(column,keyword);
	}
	else{
		list=eventDao.list();
	}
%>

<%--출력--%>

<h2>이벤트 게시판</h2>

<table border="1" width="90%">
	<thead>
		<tr>
			<th>번호</th>
			<th>width="45%>제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
	</thead>
	<tbody align="center">
		<%for(EventDto eventDto:list){ %>
		<tr>
			<td><%=eventDto.getEventIdx()%></td>
			<td align="left">
				<a href="detail.jsp?eventIdx=<%=eventDto.getEventIdx()%>"><%=eventDto.getEventName()%></a>
			</td>
			<td><%=eventDto.getUsersIdx()%></td>
			<td><%=eventDto.getEventDate()%></td>
			<td><%=eventDto.getEventCountView()%></td>
		</tr>
        <%}%>
	</tbody>
</table>

<br>
<a href="write.jsp">글쓰기</a><%--위치수정필요--%>

<!-- 페이지 네비게이터 -->
<br><br>
[이전] 1 2 3 4 5 6 7 8 9 10 [다음]
<br><br>

<!-- 검색창 -->
<form action="list.jsp" method="get">

	<select name="column">
		<%if(column !=null&&column.equals("event_name")){%>
		<option value="event_name" selected>제목</option>
		<%}else{%>
		<option value="event_name">제목</option>
		<%}%>
		
		<%if(column !=null&&column.equals("event_detail")){%>
		<option value="event_detail" selected>내용</option>
		<%}else{%>
		<option value="event_detail">내용</option>
		<%}%>
		
		<%if(column !=null&&column.equals("users_idx")){%>
		<option value="users_idx" selected>작성자</option>
		<%}else{%>
		<option value="users_idx">작성자</option>
		<%}%>	
		
	</select>
	
	<%if(keyword==null){%>
	<input type="search" name="keyword" placeholder="검색어 입력" required>
	<%}else{%>
	<input type="search" name="keyword" placeholder="검색어 입력" required value="<%=keyword%>">
	<%}%>
	
	<input type="submit" value="검색">
	
</form>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>