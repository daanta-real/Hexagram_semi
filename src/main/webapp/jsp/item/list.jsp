<%@page import="beans.ItemDto"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.ItemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
  int users_idx = (int)request.getSession().getAttribute("users_key");
  String root = request.getContextPath();
  //관리자 권한으로 게시글 생성.=> 일반회원 X
%>
 
 <%-- 입력 --%>
<%
	//검색 및 전체 조회
	String column = request.getParameter("column");
	String keyword = request.getParameter("keyword");
%>
<%-- 처리 --%>
<%
	//처리 (컬럼 키워드가 null 아니고 빈칸이 아니라면 true)
	boolean search = column != null && column.equals("") && keyword != null && keyword.equals("");
	
	ItemDao itemDao = new ItemDao();
	List<ItemDto>list;
	
	if(search){
		list = itemDao.searchList(column, keyword);
	}
	else{
		list = itemDao.list();
	}
	
	//삼항 연산을 이용하여 제목 변경
	String title = search ? "검색" : "관광지 목록";
%>

<jsp:include page="/template/header.jsp">
	<jsp:param name="pageTitle" value="메인" />
</jsp:include>
    


 <h2><%=title %></h2>

<%-- 카테고리 관광지명 내용으로 키워드 검색 --%>
<form action="list.jsp" method="get">
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

<%if(list.isEmpty()){ %>
	<h3>검색 내용이 존재 하지 않습니다.</h3>
<%}else{ %>

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
			<td align ="center"><%=itemDto.getItem_type() %></td>
			<td align ="center"><%=itemDto.getItem_name() %></td>
			<td><%=itemDto.getItem_detail().substring(0, 30) %>....</td>
			<td align ="center"><%=itemDto.getItem_count()%></td>
		</tr>
		<%} %>
	</tbody>	
</table>

<%} %>

<%-- 관리자만 글쓰기 가능 --%>
<form action="insert.jsp">
	<input type="submit" value="글쓰기">
</form>
 
 <jsp:include page="/template/footer.jsp"></jsp:include>