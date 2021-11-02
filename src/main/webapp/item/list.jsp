<%@page import="beans.UsersDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.ItemDto"%>
<%@page import="java.util.List"%>
<%@page import="beans.ItemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 관광지 목록</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->

<%-- 관리자만 글쓰기위한 세션 받기 --%>
<%
	String usersId = (String)request.getSession().getAttribute("usersId");
	int usersIdx = (int)request.getSession().getAttribute("usersIdx");
	String usersGrade = (String)request.getSession().getAttribute("usersGrade");
		
	//세션 값이 관리자라면
	boolean admin = usersGrade != null && usersGrade.equals("관리자");
%>

<%-- 페이지네이션 --%>
<%
	int psize = 10;
	int p;
	
	try{
		p = Integer.parseInt(request.getParameter("p"));
		
		if(p <= 0){
			throw new Exception();
		}
	}
	catch(Exception e){
		p = 1;
	}
	
	int end = p * psize;
	int begin = end - (psize - 1);
%>
p = <%=p %>, begin = <%=begin %>, end = <%=end %>

<%-- 네이게이터 --%>
<%
	int bsize = 10;

	int startBlock = (p-1) / bsize * bsize + 1;
	int finishBlock = startBlock + (bsize - 1);
%> 
<br>
startBlock = <%=startBlock %>, finishBlock = <%=finishBlock %>
<%-- 검색 및 목록 처리 --%>
<%
	String column = request.getParameter("column");
	String keyword = request.getParameter("keyword");
	String root = request.getContextPath();

	boolean search = column != null && keyword != null && !keyword.equals("") && !column.equals("");

	ItemDao itemDao = new ItemDao();
	List<ItemDto> list;

	if(search){
		list = itemDao.searchList(column, keyword);
	}else{
		list = itemDao.list(begin, end);
	}

	String title = search ? "검색" : "관광지 목록";
%>

<h2><%=title %></h2>
<h5>(usersId = <%=usersId %>, usersIdx = <%=usersIdx %>, grade=<%=usersGrade %>)</h5>

<form action="<%=root%>/item/list.jsp" method="get">
<select name="column">
		<%if(column != null && column.equals("item_type")) {%>
		<option value="item_type" selected>카테고리</option>
		<%}else{ %>
		<option value="item_type">카테고리</option>
		<%} %>
		<%if(column != null && column.equals("item_name")) {%>
		<option value="item_name" selected>관광지명</option>
		<%}else{ %>
		<option value="item_name">관광지명</option>
		<%} %>
		<%if(column!=null && column.equals("item_detail")) {%>
		<option value="item_detail" selected>내용</option>
		<%}else{ %>
		<option value="item_detail">내용</option>
		<%} %>
	</select>
	<%if(keyword == null){ %>
	<input type="search" name="keyword" placeholder="검색어 입력" required>
	<%}else{ %>
	<input type="search" name="keyword" placeholder="검색어 입력" required value="<%=keyword%>">
	<%} %>
	<input type="submit" value="검색">
</form>


<%if(!list.isEmpty()){%>
<%-- 전체 목록 조회 --%>
<table border="1" style="width:700px;">
	<thead>
		<tr>
			<th>카테고리</th>
			<th>관광지명</th>
			<th>관광지 소개</th>

		</tr>
	</thead>
	<tbody>
		<%for(ItemDto itemDto : list){ %>
		<tr>
			<td align ="center"><%=itemDto.getItemType() %></td>
			<td align ="center">
			<a href="<%=root%>/item/count.nogari?itemIdx=<%=itemDto.getItemIdx()%>">
<!-- 			클릭시 단 한번의 조회를 위해서 Count서블릿으로 item_idx을 넘겨줌 -->
			<%=itemDto.getItemName()%>
			</a>
			</td>
			<td><%=itemDto.getItemDetail().substring(0, 1) %>....</td>

		</tr>
		<%} %>
	</tbody>	
</table>
<%}else{ %>
<h2>결과가 없습니다.</h2>
<%} %>
<br><br>

[이전] 

<%for(int i = startBlock; i<=finishBlock; i++) {%>
	<%if(search){ %>
		<a href="#?column=<%=column %>&keyword<%=keyword %>&p=<%=i %>"><%=i %></a>
	<%}else{ %>
		<a href="#?p=<%=i %>"><%=i %></a>
	<%} %>
<%} %>

[다음]

<br><br>
<%-- 관리자만 글쓰기 가능 --%>
<%if(admin){ %>
<form action="insert.jsp">
	<input type="submit" value="글쓰기">
</form>
<%}else{%>
<form action="insert.jsp"> 
	<input type="submit" value="글쓰기"> 
</form> 
<%} %>
 
<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>