<%@page import="beans.UsersDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.ItemDto"%>
<%@page import="java.util.List"%>
<%@page import="beans.ItemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<%-- 관리자만 글쓰기위한 세션 받기 --%>
<%
	String usersId = (String)request.getSession().getAttribute("usersId");
	int usersIdx = (int)request.getSession().getAttribute("usersIdx");
	String usersGrade = (String)request.getSession().getAttribute("usersGrade");
		
	//세션 값이 관리자라면
	boolean admin = usersGrade != null && usersGrade.equals("관리자");
%>

<%
String column = request.getParameter("column");
String keyword = request.getParameter("keyword");
String root = request.getContextPath();

boolean search = column != null && keyword != null && !keyword.equals("") && !column.equals("");

ItemDao itemDao = new ItemDao();
List<ItemDto> list = new ArrayList<>();

if(search){
	list = itemDao.searchList(column, keyword);
}else{
	list = itemDao.list();
}

String title = search ? "검색" : "관광지 목록";
%>

<h2><%=title %></h2>
<h5>(usersId = <%=usersId %>, usersIdx = <%=usersIdx %>, grade=<%=usersGrade %>)</h5>

<form action="<%=root%>/jsp/item/list.jsp" method="get">


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


<%if(list.size() != 0){%>
<%-- 전체 목록 조회 --%>
<table border="1" width="700">
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
			<a href="<%=root%>/jsp/item/detail.jsp?itemIdx=<%=itemDto.getItemIdx()%>">

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


<form action="insert.jsp"> 
	<input type="submit" value="글쓰기"> 
</form> 

<%-- 관리자만 글쓰기 가능 --%>
<%-- <%if(admin){ %> --%>
<!-- <form action="insert.jsp"> -->
<!-- 	<input type="submit" value="글쓰기"> -->
<!-- </form> -->
<%-- <%} %> --%>
 
