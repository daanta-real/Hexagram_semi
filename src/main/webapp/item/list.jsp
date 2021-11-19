<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>

<%@page import="beans.UsersDto"%>
<%@page import="beans.ItemDto"%>
<%@page import="beans.ItemDao"%>
<%@page import="beans.Pagination"%>

<%@page import="beans.ItemFileDto"%>
<%@page import="beans.ItemFileDao"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 관광지 목록</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
<%
String root = request.getContextPath();
%>
<LINK REL="STYLESHEET" HREF="<%=root%>/resource/css/item/list.css" /> <!-- CSS 첨부 -->
</HEAD>
<style>
        .row {
            margin-top: 10px;
            margin-bottom: 10px;
        }
        
               .float-container::after {
            content:"";
            display: block;
            clear: both;
        }

        .float-container > .float-item-left {
            float:left;
        }
        
        
</style>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!-- 페이지 내용 시작 -->

<%
String order = "item_idx";
if(request.getParameter("order") != null)
order = request.getParameter("order");

//아무 파라미터가 없을때 정렬은 기본 아이템 번호 최신순(즉 최신 등록순으로 진행.)

// 1. 변수 준비
ItemDao itemDao = new ItemDao();
Pagination<ItemDao, ItemDto> pn = new Pagination<>(request, itemDao);
boolean isSearchMode = pn.isSearchMode();
System.out.println(
	  "[관광지 목록] 컬럼(" + request.getParameter("column") + ")"
	+ ", 키워드(" + request.getParameter("keyword") + ")"
	+ ", 검색모드 여부(" + isSearchMode + ")"
);
pn.calculate();
System.out.println("[관광지 목록] 페이지네이션 정보: " + pn);

//관광지 목록 도출
List<ItemDto> list = new ArrayList<>();
if(isSearchMode){
	list=itemDao.orderByKeywordList(order, pn.getColumn(), pn.getKeyword(), pn.getBegin(), pn.getEnd());
}else{
	list=itemDao.orderByList(order, pn.getBegin(), pn.getEnd());
}


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
		<!-- 검색후 검색한 내용을 고정하기 위해 if문과 selected를 사용 -->
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
			<!-- 검색어 입력 창 -->
			<input type="search" name="keyword" placeholder="검색어 입력"
			required value="<%=pn.getKeywordString()%>"  class="form-input form-inline">
			<input type="hidden" name="order" value="<%=order%>">
			<input type="submit" value="검색"  class="form-btn form-inline">
		</form>
	</div>
	
<div class="row float-container">
	<div class="float-item-left">
		<form action="<%=root%>/item/list.jsp" method="get">
			<input type="hidden" name="order" value="item_idx">
			<input type="hidden" name="keyword" value="<%=pn.getKeywordString()%>">
			<input type="hidden" name="column" value="<%=pn.getColumn()%>">
			<input type="submit" value="최신순 조회">
		</form>
	</div>
	<div class="float-item-left">
		<form action="<%=root%>/item/list.jsp" method="get">
			<input type="hidden" name="order" value="item_count_view">
			<input type="hidden" name="keyword" value="<%=pn.getKeywordString()%>">
			<input type="hidden" name="column" value="<%=pn.getColumn()%>">
			<input type="submit" value="인기순 조회">
		</form>
	</div>
	<div class="float-item-left">		
		<form action="<%=root%>/item/list.jsp" method="get">
			<input type="hidden" name="order" value="item_count_reply">
			<input type="hidden" name="keyword" value="<%=pn.getKeywordString()%>">
			<input type="hidden" name="column" value="<%=pn.getColumn()%>">
			<input type="submit" value="댓글순 조회">
		</form>
	</div>
</div>
	<div class="row center">

<%-- 전체 목록 조회 --%>

<!-- 목록 내용이 있다면-->
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
		<!-- 목록 불러오기 -->
		<%for(ItemDto itemDtoList : list){ %>

		<!-- 목록을 보여주면서 itemDto의 itemIdx정보를 받는다. -->
		<%ItemFileDto itemFileDto = itemFileDao.find2(itemDtoList.getItemIdx());%>
		<tr>
			<!-- 카테고리 출력 -->
			<td width="10%"><%=itemDtoList.getItemType() %></td>
			<td class="left" width="30%">
			<!-- 관광지 제목을 출력 (제목을 누르면 조회수 증가 서블릿으로 이동)  -->
			<a href="readup.nogari?itemIdx=<%=itemDtoList.getItemIdx()%>">
			<!-- 				이 항목을 리스트에서 누를시에만 조회수가 올라가게 ItemReadupServlet 서블릿에서 게시물 조회수 증가를 시킨 후 detail페이지로 이동시킨다. -->
			<%=itemDtoList.getItemName()%>
			</a>
			<%-- 댓글수 --%>
			<!-- 댓글이 있다면 개수를 출력 -->
			<%if(itemDtoList.isCountReply()){ %>
				[<%=itemDtoList.getItemCountReply() %>]
			<%} %>
			</td>

			<td width="50%">
				<div	class="flex-container">
					<div class="image-wrapper">
						<!-- 만약 첨부파일이 있다면 첨부파일을 썸네일로 보여준다 -->
						<%if(itemFileDto == null){ %>
								<!-- 첨부파일이 없다면 대체이미지 보여주기 -->
								<img src="http://via.placeholder.com/100x100" class="image">
						<%}else{ %>
								<!-- 첨부파일이 있다면 첨부파일을 출력  -->
								<img src="file/download.nogari?itemFileIdx=<%=itemFileDto.getItemFileIdx()%>">
						<%} %>
					</div>

					<div class="detail-wrapper">
						<!-- 관광지 소개 및 지역 출력 -->
						<%
						//관광지 소개를 변수에 저장
						String showItemDetail;
						//만약 소개글이 20글자 이상이라면
						if(itemDtoList.getItemDetail().length() >= 20){
							//20글자 까지만 화면에 출력
							showItemDetail = itemDtoList.getItemDetail().substring(0, 20) + "...";
						}else{
							//20글자 이하라면 화면에 전부 출력
							showItemDetail = itemDtoList.getItemDetail();
						}
						//관광지 지역 변수 저장
						String area = itemDtoList.getAdressCity()+" "+itemDtoList.getAdressCitySub();
						%>
						<!-- 관광지 소개글 출력 -->
						<h4 class="center"><%=showItemDetail%></h4>
						<!-- 관광지 지역 출력 -->
						<p><%=area%></p>
					</div>
				</div>
			</td>
			<!-- 조회수 출력 -->
			<td><%=itemDtoList.getItemCountView() %></td>
		</tr>
		<%} %>
	</tbody>
</table>
</div>
<%} %>


	<!-- 페이지네이션 -->
	<div class="row pagination">
		<%-- [이전] a 태그 --%>
		<%if(pn.hasPreviousBlock()){ %>
			<%if(isSearchMode){%>
				<a href="list.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&page=<%=pn.getPreviousBlock()%>&order=<%=order%>">[이전]</a>
			<%}else{ %>
				<a href="list.jsp?page=<%=pn.getPreviousBlock() %>&order=<%=order%>">[이전]</a>
			<%} %>
		<%}else{%>
			<a>[이전]</a>
		<%} %>

		<%-- 숫자 a 태그 --%>
		<%for(int i = pn.getStartBlock(); i<=pn.getRealLastBlock(); i++) {%>
			<%if(isSearchMode){ %>
				<a href="list.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&page=<%=i %>&order=<%=order%>"><%=i %></a>
			<%}else{ %>
				<a href="list.jsp?page=<%=i %>&order=<%=order%>"><%=i %></a>
			<%} %>
		<%} %>

		<%-- [다음] a 태그 --%>
		<%if(pn.hasNextBlock()){ %>
			<%if(isSearchMode){%>
				<a href="list.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&order=<%=order%>">[다음]</a>
			<%}else{ %>
				<a href="list.jsp?page=<%=pn.getNextBlock() %>&order=<%=order%>">[다음]</a>
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
// String usersGrade = (String)request.getSession().getAttribute("usersGrade");
// //usersGrade가 null이 아니고 usersGrade가 관리자라면
// boolean admin = usersGrade != null && usersGrade.equals(util.users.GrantChecker.GRADE_ADMIN);
// System.out.println("[관광지 목록] 관리자 여부 → " + admin);
%>
<!-- 관리자일 경우에 한해 글쓰기 버튼 표시 -->
<%-- <%if(admin){%> --%>
<!-- <form action="insert.jsp"> -->
<!-- 	<input type="submit" value="글쓰기"> -->
<!-- </form> -->
<%-- <%} %> --%>


<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>