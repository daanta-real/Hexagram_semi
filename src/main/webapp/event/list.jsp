<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="util.HexaLibrary" %>

<%@ page import="beans.EventDao" %>
<%@ page import="beans.EventDto" %>

<%@page import="beans.Pagination"%>

<%

// 1. 기본 값 준비
String root = request.getContextPath(); // 서버 루트폴더
String column=request.getParameter("column"); // 검색 시 컬럼명 
String keyword=request.getParameter("keyword"); // 검색 시 키워드

// 2. 페이지네이션 준비
EventDao eventDao = new EventDao();
Pagination<EventDao, EventDto> pn = new Pagination<>(request, eventDao);
boolean isSearchMode = pn.isSearchMode();;
System.out.println(
	  "[이벤트 목록] 컬럼(" + request.getParameter("column") + ")"
	+ ", 키워드(" + request.getParameter("keyword") + ")"
	+ " → 검색모드 여부(" + isSearchMode + ")"
);
//pn.setPageSize(5);
pn.calculate();
System.out.println("[이벤트 목록] 페이지네이션 정보: " + pn);
%>

<!DOCTYPE HTML>
<HTML>

<HEAD>
<TITLE>노가리투어 - 이벤트 게시판</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
<!-- 페이지 제목 css -->
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/sub_title.css">
<!-- 게시판 공통 css -->
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/board.css">
<style type='text/css'>
:root { --board-grid-columns: 3rem 10rem 14rem 7rem 4rem; }
.sub_title { margin:1rem auto; }
.boardContainer > .boardBox.body .row {
	background-color:var(--color7);
    color:#000b;
    margin:0.1rem;
}
td {
    line-height: 1.4rem;
}
td.articleSubject {
	justify-content:flex-start;
}
td small {
	color:var(--color6);
}
tfoot td {
	padding:0.5rem;
}
.bottomForm { display:flex; align-items:center; justify-content:center; }
.bottomForm > *, .bottomForm option {
	min-height:1.3rem; max-height:1.3rem; line-height:1.3rem; font-size:1.3rem;
	padding:0.1rem 0.3rem; margin:0 0.2rem;
	border-style:solid;
	border-width:0.1rem;
	border-color:var(--color11);
	font-family:mainFont !important;
}
.bottomLongBtn {
    min-width: 2rem;
    margin: 0.1rem;
    padding: 0rem 0.3rem;
    border: 0;
    border-radius: 0.4rem;
    color: #000a;
    background: var(--color5);
    text-align: center;
    font-size: inherit;
    cursor: pointer;
}
</style>
</HEAD>

<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->



<div class="sub_title">이벤트 게시판</div>



<table class="boardContainer">
	<thead class="boardBox title"><tr class='row'>
		<th class="flex flexCenter">번호</th>
		<th class="flex flexCenter">작성자</th>
		<th class="flex flexCenter">제목</th>
		<th class="flex flexCenter">작성일</th>
		<th class="flex flexCenter">조회수</th>
	</tr></thead>
	<tbody class='boardBox body'>
		<% List<EventDto> list = pn.getResultList();
		for(EventDto eventDto:list) { %>
		<tr class='row' onclick="location.href='detail.jsp?eventIdx=<%=eventDto.getEventIdx()%>'">
			<td class="flex flexCenter"><%=eventDto.getEventIdx()%></td>
			<td class="flex flexCenter"><%=eventDto.getUsersNick()%>&nbsp;<small>(<%=eventDto.getUsersId()%>)</small></td>
			<td class="flex flexCenter articleSubject"><%=eventDto.getEventName()%>&nbsp;<small>[<%=eventDto.getEventCountReply()%>]</small></td>
			<td class="flex flexCenter"><%=eventDto.getEventDate()%></td>
			<td class="flex flexCenter"><%=eventDto.getEventCountView()%></td>
		</tr>
		<%}%>
	</tbody>
	
	<!-- 페이지 네비게이터 검색 / 목록 -->
	<tfoot class='boardBox page' style='justify-content:space-between; height:100%; margin: 0.5rem auto;'>
		
		<tr><td colspan=5 class="flexCenter bottomLongBtn" onclick="location.href='list.jsp'">
			<a class='bottomLongBtn' href="list.jsp">전체목록</a>
		</td></tr>
	
		<tr><td colspan=5 class="flexCenter">
		
			<% // 기본 옵션스트링 문구 결정 %>
			<% String optionStr = isSearchMode ? ("&column=" + pn.getColumn() + "&keyword=" + pn.getKeyword()) : ""; %>
		
			<% // 왼쪽 ◀ %>
			<% String prevHrefOptionStr = pn.hasPreviousBlock() ? (" href=\"list.jsp?page=" + pn.getPreviousBlock() + optionStr + "") : ""; %>
			<div class='el flexCenter'><a<%=prevHrefOptionStr%>>◀</a></div>
			
			<% // 중간 숫자들
			for(int i = pn.getStartBlock() ; i <= pn.getRealLastBlock() ; i++) { %>
				<div class='el flexCenter'><a href="list.jsp?page=<%=i %><%=optionStr%>"><%=i %></a></div>
			<% } %>

			<% // 오른쪽 ▶ %>
			<% String nextHrefOptionStr = pn.hasNextBlock() ? (" href=\"list.jsp?page=" + pn.getNextBlock() + optionStr + "") : ""; %>	
			<div class='el flexCenter'><a<%=nextHrefOptionStr%>>▶</a></div>
			
		</td></tr>
		
		<tr><td colspan=5 class="flexCenter bottomLongBtn">
			<a class='bottomLongBtn' href="write.jsp">글쓰기</a>
		</td></tr>
	
	</tfoot>
	
</table>



<!-- 글쓰기 버튼 -->






<!-- 검색창 -->
<form action="list.jsp" method="get" class='bottomForm'>
	<select name="column">
		<option value="event_name"  <%= column !=null&&column.equals("event_name"  ) ? " selected" : "" %>>제목</option>
		<option value="event_detail"<%= column !=null&&column.equals("event_detail") ? " selected" : "" %>>내용</option>
		<option value="users_nick"  <%= column !=null&&column.equals("users_nick"  ) ? " selected" : "" %>>작성자</option>
	</select>
	<input type="search" name="keyword" placeholder="검색어 입력" required<%= keyword != null ? (" value=\"" + keyword + "\"") : "" %>>
	<input type="submit" value="검색">
</form>



<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>