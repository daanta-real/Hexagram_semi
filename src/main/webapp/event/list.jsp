<%@page import="java.beans.Pagination"%>
<%@page import="java.beans.EventDto"%>
<%@page import="java.util.List"%>
<%@page import="java.beans.EventDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	//Pagination 모듈을 이용하여 계산을 처리하도록 위임
	Pagination pagination = new Pagination(request);
	//pagination.setPageSize(15);
	//pagination.setBlockSize(5);  
	pagination.calculate(); 
%>

<%=pagination.toString()%>

<%
	EventDao eventDao = new EventDao();
	List<EventDto> list;
	if(pagination.isSearch()){ 
		//list = eventDao.search(column, keyword);//모든검색결과
		list = eventDao.searchByRownum(
					pagination.getColumn(), pagination.getKeyword(),
					pagination.getBegin(), pagination.getEnd());//원하는 검색결과 구간
	}
	else{
		//list = eventDao.list();//모든목록
		list = eventDao.listByRownum(pagination.getBegin(), pagination.getEnd());//원하는 구간 목록
	}
%>

<%-- 출력 --%>
<jsp:include page="/template/header.jsp"></jsp:include>

<h2>회원 게시판</h2>
<h6>타인에 대한 무분별한 비판은 제재 대상입니다</h6>

<a href="write.jsp">글쓰기</a>
<br><br>

<table border="1" width="90%">
	<thead>
		<tr>
			<th>번호</th>
			<th width="45%">제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>조회수</th>
		</tr>
	</thead>
	<tbody align="center">
		<%for(EventDto eventDto : list){ %>
		<tr>
			<td><%=eventDto.getEventNo()%></td>
			<td align="left">
				<a href="detail.jsp?eventNo=<%=eventDto.getEventNo()%>"><%=eventDto.getEventTitle()%></a>
			</td>
			<td><%=eventDto.getEventWriter()%></td>
			<td><%=eventDto.getEventTime()%></td>
			<td><%=eventDto.getEventRead()%></td>
		</tr>
		<%} %>
	</tbody>
</table>

<br>
<a href="write.jsp">글쓰기</a>

<!-- 페이지 네비게이터 -->
<br><br>
<%if(pagination.isPreviousAvailable()){ %>
	<%if(pagination.isSearch()){ %>
		<!-- 검색용 링크 -->
		<a href="list.jsp?column=<%=pagination.getColumn()%>&keyword=<%=pagination.getKeyword()%>&p=<%=pagination.getPreviousBlock()%>">&lt;</a>
	<%} else { %>
		<!-- 목록용 링크 -->
		<a href="list.jsp?p=<%=pagination.getPreviousBlock()%>">&lt;</a>
	<%} %>
<%} else { %>
	 <a>&lt;</a>
<%} %> 

<%for(int i = pagination.getStartBlock(); i <= pagination.getRealLastBlock(); i++){ %>
	<%if(pagination.isSearch()){ %>
	<!-- 검색용 링크 -->
	<a href="list.jsp?column=<%=pagination.getColumn()%>&keyword=<%=pagination.getKeyword()%>&p=<%=i%>"><%=i%></a>
	<%}else{ %>
	<!-- 목록용 링크 -->
	<a href="list.jsp?p=<%=i%>"><%=i%></a>
	<%} %>
<%} %>

<%if(pagination.isNextAvailable()){ %>
	<%if(pagination.isSearch()){ %>
		<!-- 검색용 링크 -->
		<a href="list.jsp?column=<%=pagination.getColumn()%>&keyword=<%=pagination.getKeyword()%>&p=<%=pagination.getNextBlock()%>">&gt;</a>
	<%} else { %>
		<!-- 목록용 링크 -->
		<a href="list.jsp?p=<%=pagination.getNextBlock()%>">&gt;</a>
	<%} %> 
<%} else {%>
	<a>&gt;</a>
<%} %>

<br><br>

<!-- 검색창 -->
<form action="list.jsp" method="get">
	
	<select name="column">
		<%if(pagination.columnIs("event_title")){ %>
		<option value="event_title" selected>제목</option>
		<%}else{ %>
		<option value="event_title">제목</option>
		<%} %>
		
		<%if(pagination.columnIs("event_content")){ %>
		<option value="event_content" selected>내용</option>
		<%}else{ %>
		<option value="event_content">내용</option>
		<%} %>
		
		<%if(pagination.columnIs("event_writer")){ %>
		<option value="event_writer" selected>작성자</option>
		<%}else{ %>
		<option value="event_writer">작성자</option>
		<%} %>
		
	</select>
	
	<input type="search" name="keyword" placeholder="검색어 입력" required value="<%=pagination.getKeywordString()%>">
	
	<input type="submit" value="검색">
	
</form>


<jsp:include page="/template/footer.jsp"></jsp:include>