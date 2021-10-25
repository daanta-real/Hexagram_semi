<%@page import="java.util.ArrayList"%>
<%@page import="beans.ItemDto"%>
<%@page import="java.util.List"%>
<%@page import="beans.ItemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp">
	<jsp:param name="pageTitle" value="메인" />
</jsp:include>


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

<form action="<%=root%>/jsp/item/list.jsp" method="get">
<select name="column">
		<%if(column != null && column.equals("itemType")) {%>
		<option value="itemType" selected>카테고리</option>
		<%}else{ %>
		<option value="itemType">카테고리</option>
		<%} %>
		<%if(column != null && column.equals("itemName")) {%>
		<option value="itemName" selected>관광지명</option>
		<%}else{ %>
		<option value="itemName">관광지명</option>
		<%} %>
		<%if(column!=null && column.equals("itemDetail")) {%>
		<option value="itemDetail" selected>내용</option>
		<%}else{ %>
		<option value="itemDetail">내용</option>
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
			<th>조회수</th>
		</tr>
	</thead>
	<tbody>
		<%for(ItemDto itemDto : list){ %>
		<tr>
			<td align ="center"><%=itemDto.getItemType() %></td>
			<td align ="center">
			<a href="<%=root%>/jsp/item/count.nogari?item_idx=<%=itemDto.getItemIdx()%>">
<!-- 			클릭시 단 한번의 조회를 위해서 Count서블릿으로 item_idx을 넘겨줌 -->
			<%=itemDto.getItemName()%>
			</a>
			</td>
			<td><%=itemDto.getItemDetail().substring(0, 1) %>....</td>
			<td align ="center"><%=itemDto.getItemCount()%></td>
		</tr>
		<%} %>
	</tbody>	
</table>
<%}else{ %>
<h2>결과가 없습니다.</h2>
<%} %>


<%-- 관리자만 글쓰기 가능 --%>
<form action="insert.jsp">
	<input type="submit" value="글쓰기">
</form>
 
 <jsp:include page="/template/footer.jsp"></jsp:include>
