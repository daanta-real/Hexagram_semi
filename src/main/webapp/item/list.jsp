<%@page import="beans.ItemFileDto"%>
<%@page import="beans.ItemFileDao"%>
<%@page import="beans.Pagination_item"%>
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
<%String root = request.getContextPath();%>
<LINK REL="STYLESHEET" HREF="<%=root%>/resource/css/item/list.css" /> <!-- CSS 첨부 -->
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->

<%-- 관리자만 글쓰기위한 세션 받기 --%>
<%
String usersId = (String)request.getSession().getAttribute("usersId");

//	list.jsp에서 확인 후 필요없으면 삭제(회원 번호)?????
int usersIdx;
try{
	usersIdx = (int)request.getSession().getAttribute("usersIdx");
}catch(Exception e){
	e.printStackTrace();
	usersIdx = 0;
}

//세션 Grade값 획득 및 이에 따른 관리자 여부 결정
String usersGrade = (String)request.getSession().getAttribute("usersGrade");
boolean admin = usersGrade != null && usersGrade.equals("관리자");

%>

<%-- 페이지네이션(모듈화) --%>
<%
Pagination_item itemPagination = new Pagination_item(request);
	itemPagination.calculateList();
%>

<%-- 페이지네이션 확인을 위한 toString --%>
<%-- <%=itemPagination.toString() %> --%>

<%-- 관리자 확인을 위한 세션 찍기 --%>
<%-- <h5>(usersId = <%=usersId %>, usersIdx = <%=usersIdx %>, grade=<%=usersGrade %>)</h5> --%>

<%-- 검색 및 목록 처리 --%>
<%
	ItemDto itemDto = new ItemDto();
	List<ItemDto> list;
	ItemDao itemDao = new ItemDao();
	if(itemPagination.isSearch()){
		list = itemDao.searchList
		(itemPagination.getColumn(), itemPagination.getKeyword(), itemPagination.getBegin(), itemPagination.getEnd());
	}
	else{
		list = itemDao.list
		(itemPagination.getBegin(), itemPagination.getEnd());
	}
	String title = itemPagination.isSearch() ? "["+itemPagination.getKeyword()+"]" + " 검색" : "관광지 목록";
%>

<%-- 썸네일표시를 위한 파일 조회를 위한 ItemFileDao 생성 --%>
<%
 	ItemFileDao itemFileDao = new ItemFileDao();
%>
<div class="container-900 container-center">
	<div class="row center">
		<%-- 페이지 제목 --%>
		<h2><%=title %></h2>
	</div>
	
	<div class="row center">
		<%-- 검색창 --%>
		<form action="<%=root%>/item/list.jsp" method="get">
		
		<select name="column" class="form-input form-inline">
				<%if(itemPagination.columnIs("item_type")) {%>
				<option value="item_type" selected>카테고리</option>
				<%}else{ %>
				<option value="item_type">카테고리</option>
				<%} %>
				<%if(itemPagination.columnIs("item_name")) {%>
				<option value="item_name" selected>관광지명</option>
				<%}else{ %>
				<option value="item_name">관광지명</option>
				<%} %>
				<%if(itemPagination.columnIs("item_detail")) {%>
				<option value="item_detail" selected>내용</option>
				<%}else{ %>
				<option value="item_detail">내용</option>
				<%} %>
			</select>
			
			<input type="search" name="keyword" placeholder="검색어 입력" 
			required value="<%=itemPagination.getKeywordString()%>"  class="form-input form-inline">

			<input type="submit" value="검색"  class="form-btn form-inline">

		</form>
	</div>
	
	<div class="row center">
		<%-- 전체 목록 조회 --%>
<%if(!list.isEmpty()){%>
<table class="table table-border table-hover table-stripe">
	<thead>
		<tr>
			<th>카테고리</th>
			<th>관광지명</th>
			<th>관광지 소개</th>
			<th>조회수</th>
		</tr>
	</thead>
	<tbody>
		<%for(ItemDto itemDtoList : list){ %>
		
<!-- 		목록을 보여주면서 itemDto의 itemIdx정보를 받는다. -->
		<%
		ItemFileDto itemFileDto = itemFileDao.find2(itemDtoList.getItemIdx());
		%>
		<tr>
			<td width="10%"><%=itemDtoList.getItemType() %></td>
			
			<td class="left" width="30%">
			<a href="detail.jsp?itemIdx=<%=itemDtoList.getItemIdx()%>">
			<%=itemDtoList.getItemName()%>
			</a>
			<%-- 댓글수 --%>
			<%if(itemDtoList.isCountReply()){ %>
				[<%=itemDtoList.getItemCountReply() %>]
			<%} %>
			</td>
			
			<td width="50%">
				<div	class="flex-container">
					<div class="image-wrapper">
						<%-- 첨부파일이 있다면 --%>
						<%if(itemFileDto == null){ %>
								 <img src="http://via.placeholder.com/100x100" class="image">
						<%}else{ %>
								<img src="file/download.nogari?itemFileIdx=<%=itemFileDto.getItemFileIdx()%>">
						<%} %>
					</div>
					
					<div class="detail-wrapper">
						<%
						String showItemDetail;
						if(itemDtoList.getItemDetail().length() >= 20){
							showItemDetail = itemDtoList.getItemDetail().substring(0, 20) + "...";
						}else{
							showItemDetail = itemDtoList.getItemDetail();
						}
						
						String area = itemDtoList.getAdressCity()+" "+itemDtoList.getAdressCitySub();
						%>
						<h4 class="center"><%=showItemDetail%></h4>
						<p><%=area%></p>	
					</div>
				</div>
			</td>
				
			<td><%=itemDtoList.getItemCountView() %></td>
		</tr>
		<%} %>
	</tbody>	
</table>
<%}else{ %>
<h2>결과가 없습니다.</h2>
<%} %>
	</div>

<!-- 	페이지네이션 -->
	<div class="row pagination">
		<%-- [이전] a 태그 --%>
		<%if(itemPagination.isBackPage()){ %>
			<%if(itemPagination.isSearch()){%>
				<a href="list.jsp?column=<%=itemPagination.getColumn() %>&keyword<%=itemPagination.getKeyword() %>&p=<%=itemPagination.getBackPage()%>">[이전]</a>
			<%}else{ %>
				<a href="list.jsp?page=<%=itemPagination.getBackPage() %>">[이전]</a>
			<%} %>	
		<%}else{%>
			<a>[이전]</a>
		<%} %>
		
		<%-- 숫자 a 태그 --%>
		<%for(int i = itemPagination.getStartBlock(); i<=itemPagination.getEndBlock(); i++) {%>
			<%if(itemPagination.isSearch()){ %>
				<a href="list.jsp?column=<%=itemPagination.getColumn() %>&keyword<%=itemPagination.getKeyword() %>&p=<%=i %>"><%=i %></a>
			<%}else{ %>
				<a href="list.jsp?page=<%=i %>"><%=i %></a>
			<%} %>
		<%} %>
		
		<%-- [다음] a 태그 --%>
		<%if(itemPagination.isNextPage()){ %>
			<%if(itemPagination.isSearch()){%>
				<a href="list.jsp?column=<%=itemPagination.getColumn() %>&keyword<%=itemPagination.getKeyword() %>&p=<%=itemPagination.getEndBlock()%>">[다음]</a>
			<%}else{ %>
				<a href="list.jsp?page=<%=itemPagination.getEndBlock() %>">[다음]</a>
			<%} %>	
		<%}else{ %>
			<a>[다음]</a>
		<%} %>
	</div>


<!-- 콘테이너 마지막 div -->
</div>






<br><br>

<br><br>

<%-- 관리자만 글쓰기 버튼 보이기 --%>
<%if(admin){ %>
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