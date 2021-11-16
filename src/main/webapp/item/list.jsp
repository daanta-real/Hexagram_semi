<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@page import="beans.UsersDto"%>
<%@page import="beans.ItemDto"%>
<%@page import="beans.ItemDao"%>
<%@page import="beans.Pagination_users"%>

<%@page import="beans.ItemFileDto"%>
<%@page import="beans.ItemFileDao"%>

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

<%
// 1. 변수 준비
ItemDao itemDao = new ItemDao();
Pagination_users<ItemDao, ItemDto> pn = new Pagination_users<>(request, itemDao);
boolean isSearchMode = pn.isSearchMode();
System.out.println(
	  "[관광지 목록] 컬럼(" + request.getParameter("column") + ")"
	+ ", 키워드(" + request.getParameter("keyword") + ")"
	+ ", 검색모드 여부(" + isSearchMode + ")"
);
pn.calculate();
System.out.println("[관광지 목록] 페이지네이션 정보: " + pn);

// 관광지 목록 도출
List<ItemDto> list = pn.getResultList();
System.out.println("[관광지 목록] 출력할 관광지 수: " + list.size());

// 제목 h2 태그에 들어갈 타이틀 결정
String title = isSearchMode
    ? ("["+pn.getKeyword()+"]" + " 검색")
    : ("관광지 목록");

// 썸네일표시를 위한 파일 조회를 위한 ItemFileDao 생성
ItemFileDao itemFileDao = new ItemFileDao();

// HTML 출력 시작
%>
<div class="container-900 container-center">
	<div class="row center">
		<%-- 페이지 제목 --%>
		<h2>
		<%=title%>
		</h2>
	</div>

	<div class="row center">
		<%-- 검색창 --%>
		<form action="<%=root%>/item/list.jsp" method="get">

		<select name="column" class="form-input form-inline">
				<%if(pn.columnValExists("item_type")) {%>
				<option value="item_type" selected>카테고리</option>
				<%}else{ %>
				<option value="item_type">카테고리</option>
				<%} %>
				<%if(pn.columnValExists("item_name")) {%>
				<option value="item_name" selected>관광지명</option>
				<%}else{ %>
				<option value="item_name">관광지명</option>
				<%} %>
				<%if(pn.columnValExists("item_detail")) {%>
				<option value="item_detail" selected>내용</option>
				<%}else{ %>
				<option value="item_detail">내용</option>
				<%} %>
			</select>

			<input type="search" name="keyword" placeholder="검색어 입력"
			required value="<%=pn.getKeywordString()%>"  class="form-input form-inline">

			<input type="submit" value="검색"  class="form-btn form-inline">

		</form>
	</div>

	<div class="row center">
		<%-- 전체 목록 조회 --%>
<%if(!list.isEmpty()) {%>
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
		<%if(pn.hasPreviousBlock()){ %>
			<%if(isSearchMode){%>
				<a href="list.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&page=<%=pn.getPreviousBlock()%>">[이전]</a>
			<%}else{ %>
				<a href="list.jsp?page=<%=pn.getPreviousBlock() %>">[이전]</a>
			<%} %>
		<%}else{%>
			<a>[이전]</a>
		<%} %>

		<%-- 숫자 a 태그 --%>
		<%for(int i = pn.getStartBlock(); i<=pn.getRealLastBlock(); i++) {%>
			<%if(isSearchMode){ %>
				<a href="list.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&page=<%=i %>"><%=i %></a>
			<%}else{ %>
				<a href="list.jsp?page=<%=i %>"><%=i %></a>
			<%} %>
		<%} %>

		<%-- [다음] a 태그 --%>
		<%if(pn.hasNextBlock()){ %>
			<%if(isSearchMode){%>
				<a href="list.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&page=<%=pn.getNextBlock()%>">[다음]</a>
			<%}else{ %>
				<a href="list.jsp?page=<%=pn.getNextBlock() %>">[다음]</a>
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
<%

// 현재 로그인한 사용자 등급이 관리자인지 확인
String usersGrade = (String)request.getSession().getAttribute("usersGrade");
boolean admin = usersGrade != null && usersGrade.equals(util.users.GrantChecker.GRADE_ADMIN);
System.out.println("[관광지 목록] 관리자 여부 → " + admin);

// 관리자일 경우에 한해 글쓰기 버튼 표시
if(admin){ %>
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