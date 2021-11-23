<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="util.HexaLibrary" %>

<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="util.users.Sessioner" %>

<%@ page import="beans.EventDto"%>
<%@ page import="beans.EventDao"%>

<%

// 1. 변수준비
String root = request.getContextPath();
Sessioner sessioner = new Sessioner(session);

// 2. 상세 조회할 글의 idx 검사
String eventIdxStr = request.getParameter("eventIdx");
if(eventIdxStr == null) throw new Exception(); // idx 미입력 시 날려버리기

// 3. 해당 idx의 이벤트 DTO 조회
Integer eventIdx = Integer.parseInt(eventIdxStr);
System.out.println("[이벤트 - 상세보기] idx: " + eventIdx);
EventDao eventDao = new EventDao();
EventDto eventDto = eventDao.get(eventIdx);
System.out.println("[이벤트 - 상세보기] DTO 내용: " + eventDto);

%>

<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 이벤트 상세보기</TITLE>
<%/*템플릿*/%>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
<%/*CSS들*/%>
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/detail.css">
<style type='text/css'>
.boardContainer { --board-grid-columns: 3rem 15rem; font-size:1rem; }
.boardContainer .title { font-size:1.5rem; }
.boardContainer .id { font-size:0.7rem; }
.boardContainer .content { font-size:0.8rem; font-weight:initial; }
</style>
</HEAD>

<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->

<table class='boardContainer'><tbody class='boardBox'>

	<tr class='row'>
		<th>제목</th>
		<td class='flexCenter'>
			<div>No. <%=eventDto.getEventIdx() %></div>
			<span>&nbsp;</span>
			<div class='title'>"<%=eventDto.getEventName() %>"</div>
			<span>&nbsp;</span>
			<div>(<%=eventDto.getEventDate() %>)</div>
		</td>
	</tr>
	
	<tr class='row'>
		<th>작성자</th>
		<td>
			<span class='nick'><%=eventDto.getUsersNick() %></span>
			<span>&nbsp;</span>
			<span class='id'>(<%=eventDto.getUsersId()%>)</span>
		</td>
	</tr>
	
	<tr class='row'>
		<th>조회</th>
		<td>
			<span>조회 <%=eventDto.getEventCountView() %></span>
			<span>&nbsp;/&nbsp;</span>
			<span>댓글 <%=eventDto.getEventCountReply()%></span>
		</td>
	</tr>
	
	<tr class='row'>
		<th>내용</th>
		<th class='content'><%=eventDto.getEventDetail() %></th>
	</tr>
	
	<tr class='row'></tr>
	
</tbody>

<tfoot class='boardBox'>

	<tr class='boardBox'>
		<td colspan=2>
		<td>
			<a href="<%=root%>/event/modify.jsp?eventidx=<%=eventDto.getEventIdx()%>">수정</a>
			<a href="<%=root%>/event/delete.jsp?eventidx=<%=eventDto.getEventIdx()%>">삭제</a>
		</td>
	</tr>

</tfoot>

</table>			
	
<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>