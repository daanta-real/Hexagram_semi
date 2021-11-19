<%@page import="servlet.item.ItemCityList"%>
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
<style>
        * {
            box-sizing: border-box;
        }
        .container-900 {
            width: 900px;
        }
        .row {
            margin-top: 10px;
            margin-bottom: 10px;
        }

        .container-left {
            margin-left: 0;
            margin-right: auto;
        }

        .container-center {
            margin-left: auto;
            margin-right: auto;
        }

        .container-right {
            margin-left: auto;
            margin-right: 0;
        }
        .left {
            text-align: left;
        }

        .center {
            text-align: center;
        }

        .right {
            text-align: right;
        }

        .float-container::after {
            content:"";
            display: block;
            clear: both;
        }

        .float-container > .float-item-left {
            float:left;
        }

        .float-container > .float-item-left:nth-child(1) {
		width:70%;	
		padding:0.5rem;
        }
        .float-container > .float-item-left:nth-child(2) {
            width:30%;
            padding:0.5rem;
        }
        .float-container > .float-item-left.item-image {
		width:25%;	
		padding:0.5rem;
        }
        .float-container > .float-item-left.item-content {
            width:75%;
            padding:0.5rem;
        }
        
        .float-container > .float-item-left.btn {
            width:15%;
        }

        .float-container > .float-item-right {
            float:right;
        }
        .list-item{
            width: 50%;
            float: left; 
        }
        .content{
            color:black;
        }
        .item-list{
            border-top:2px solid gray;
        }
        .item-list > .item-image {
            padding:1rem;
            width:30%;
        }
        .item-list > .item-image > img{
            width:100%;
        }
        .item-list > .item-content {
            width:65%;
            height:154px;
            padding:1rem;
        }
        .item-list > .item-content > h5{
            margin:0.5rem;
            padding:0.5rem;
        }
        .item-list > .item-content > h3{
            margin:0.5rem;
            padding:0.5rem;
        }
        .pagination {
            border-top:2px solid gray;
            text-align: center;
        }

        .pagination>a,
        .pagination>a:link,
        .pagination>a:visited {
            color: black;
            text-decoration: none;
            border: 1px solid gray;
            min-width: 2.5rem;
            display: inline-block;
            text-align: center;
            padding: 0.5rem;
            margin:20px 0px;
        }

        .pagination>a:hover,
        .pagination>a.active {
            color: red;
            border: 1px solid red;
        }

    .float-container > .float-item-left > .right-wrap{
        border: 1px solid gray;
        margin-top: 150px;
    }
    .float-container > .float-item-left > .right-wrap2{
        border: 1px solid gray;
        margin-top: 8px;
    }

        .city{
        float: left;
        height: 40px;
        width: 33%;
        font-weight: bold;
        text-align: center;
        text-decoration: none;
        color:gray;
         line-height: 40px;
    }
    .menu-bar{
        height: 40px;
        line-height: 40px;
        width: 100%;
        margin: 0 auto;
    }

    .menu-city{
        height: 440px;
        width: 100%;
        margin: 0 auto;
        padding: 0;
    }

    .city:hover{
        float: left;
        height: 40px;
        line-height: 40px;
        width: 33%;
        font-weight: bold;
        text-align: center;
        text-decoration: none;
        color:blue
    }
    
          .flex-container {
            display: flex;
            flex-direction: row;
        }
          .flex-btn {
            flex-grow: 25%;
        }
    </style>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!-- 페이지 내용 시작 -->

<%
String order = "item_idx";
if(request.getParameter("order") != null)
order = request.getParameter("order");

String subCity = request.getParameter("subCity");

//아무 파라미터가 없을때 정렬은 기본 아이템 번호 최신순(즉 최신 등록순으로 진행.)

// 1. 변수 준비
ItemDao itemDao = new ItemDao();
Pagination_users<ItemDao, ItemDto> pn = new Pagination_users<>(request, itemDao);
boolean isSearchMode = pn.isSearchMode();
pn.calculate();

//관광지 목록 도출
List<ItemDto> list = new ArrayList<>();
if(isSearchMode){
	if(subCity != null){
		list = itemDao.subCityList(subCity,order, pn.getColumn(), pn.getKeyword(), pn.getBegin(), pn.getEnd());
		pn.setCount(itemDao.count(pn.getColumn(), pn.getKeyword(),subCity));
		pn.setLastBlock((pn.getCount()-1)/pn.getPageSize()+1); 
	}else{
	list=itemDao.orderByKeywordList(order, pn.getColumn(), pn.getKeyword(), pn.getBegin(), pn.getEnd());
	}
}else{
	list=itemDao.orderByList(order, pn.getBegin(), pn.getEnd());
}

// 제목 h2 태그에 들어갈 타이틀 결정
String title = isSearchMode
    ? pn.getKeyword()
    : "전체 목록";

// 썸네일표시를 위한 파일 조회를 위한 ItemFileDao 생성
ItemFileDao itemFileDao = new ItemFileDao();

// HTML 출력 시작
%>

<div class="container-900 container-center">

	        <div class="row float-container">
	        
            <div class="float-item-left">
                <div class="row center">
                    <h1><%=title %></h1>
                </div>
                <div class="row center">
                    <h3>총 <%=pn.getCount() %>건</h3>
                </div>
                
			<div class="row flex-container">
				<div class="flex-btn">
				<form action="<%=root%>/item/list_city.jsp" method="get">
					<input type="hidden" name="order" value="item_idx">
					<%if(subCity != null) {%>
					<input type="hidden" name="subCity" value="<%=subCity%>">
					<%} %>
					<input type="hidden" name="keyword" value="<%=pn.getKeywordString()%>">
					<input type="hidden" name="column" value="<%=pn.getColumn()%>">
					<input type="submit" value="최신순 조회">
				</form>
			</div>
			<div class="flex-btn">
				<form action="<%=root%>/item/list_city.jsp" method="get">
					<input type="hidden" name="order" value="item_count_view">
			<%if(subCity != null) {%>
					<input type="hidden" name="subCity" value="<%=subCity%>">
					<%} %>
					<input type="hidden" name="keyword" value="<%=pn.getKeywordString()%>">
					<input type="hidden" name="column" value="<%=pn.getColumn()%>">
					<input type="submit" value="인기순 조회">
				</form>	
			</div >
				<div class="flex-btn">			
				<form action="<%=root%>/item/list_city.jsp" method="get">
					<input type="hidden" name="order" value="item_count_reply">
			<%if(subCity != null) {%>
					<input type="hidden" name="subCity" value="<%=subCity%>">
					<%} %>
					<input type="hidden" name="keyword" value="<%=pn.getKeywordString()%>">
					<input type="hidden" name="column" value="<%=pn.getColumn()%>">
					<input type="submit" value="댓글순 조회">
				</form>
				</div>
				
			</div>

<%-- 전체 목록 조회 --%>

<!-- 목록 내용이 있다면-->
<%if(!list.isEmpty()) {%>

                    
		<!-- 목록 불러오기 -->
		<%for(ItemDto itemDtoList : list){ %>

		<!-- 목록을 보여주면서 itemDto의 itemIdx정보를 받는다. -->
		<%ItemFileDto itemFileDto = itemFileDao.find2(itemDtoList.getItemIdx());%>
		                <div class="row">
                    <div class="float-container item-list">
                        <div class="float-item-left item-image">
                        						<%if(itemFileDto == null){ %>
								<!-- 첨부파일이 없다면 대체이미지 보여주기 -->
								<img src="http://via.placeholder.com/40x40" class="image">
						<%}else{ %>
								<!-- 첨부파일이 있다면 첨부파일을 출력  -->
								<img src="file/download.nogari?itemFileIdx=<%=itemFileDto.getItemFileIdx()%>">
						<%} %>
                        </div>
                        <div class="float-item-left item-content">
                            <h3>
                            <a href="readup.nogari?itemIdx=<%=itemDtoList.getItemIdx()%>">
			<!-- 				이 항목을 리스트에서 누를시에만 조회수가 올라가게 ItemReadupServlet 서블릿에서 게시물 조회수 증가를 시킨 후 detail페이지로 이동시킨다. -->
			<%=itemDtoList.getItemName()%>
			</a>
			<%-- 댓글수 --%>
			<!-- 댓글이 있다면 개수를 출력 -->
			<%if(itemDtoList.isCountReply()){ %>
				[<%=itemDtoList.getItemCountReply() %>]
			<%} %>
                            </h3>
                            <h5><%=itemDtoList.getItemAddress() %></h5>
                            <h5><%=itemDtoList.getItemType() %></h5>
                        </div>
                    </div>
                </div>


		<%} %>
<%} %>


<!-- 페이지네이션 -->
	<div class="row pagination">
		<%-- [이전] a 태그 --%>
		<%if(pn.hasPreviousBlock()){ %>
			<%if(isSearchMode){%>
				<%if(subCity != null) {%>
				<a href="list_city.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&page=<%=pn.getPreviousBlock()%>&order=<%=order%>&subCity=<%=subCity%>">[이전]</a>
				<%}else{ %>
				<a href="list_city.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&page=<%=pn.getPreviousBlock()%>&order=<%=order%>">[이전]</a>
				<%} %>
			<%}else{ %>
				<a href="list_city.jsp?page=<%=pn.getPreviousBlock() %>&order=<%=order%>">[이전]</a>
			<%} %>
		<%}else{%>
			<a>[이전]</a>
		<%} %>

		<%-- 숫자 a 태그 --%>
		<%for(int i = pn.getStartBlock(); i<=pn.getRealLastBlock(); i++) {%>
			<%if(isSearchMode){ %>
				<%if(subCity != null) {%>
				<a href="list_city.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&page=<%=i %>&order=<%=order%>&subCity=<%=subCity%>"><%=i %></a>
				<%}else{ %>
				<a href="list_city.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&page=<%=i %>&order=<%=order%>"><%=i %></a>
				<%} %>
			<%}else{ %>
				<a href="list_city.jsp?page=<%=i %>&order=<%=order%>"><%=i %></a>
			<%} %>
		<%} %>

		<%-- [다음] a 태그 --%>
		<%if(pn.hasNextBlock()){ %>
			<%if(isSearchMode){%>
				<%if(subCity != null) {%>
				<a href="list_city.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&order=<%=order%>&subCity=<%=subCity%>">[다음]</a>
				<%}else{ %>
				<a href="list_city.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&order=<%=order%>">[다음]</a>
				<%} %>
			<%}else{ %>
				<a href="list_city.jsp?page=<%=pn.getNextBlock() %>&order=<%=order%>">[다음]</a>
			<%} %>
		<%}else{ %>
			<a>[다음]</a>
		<%} %>
	</div>

<div class="row center">
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
 </div>
            </div>
            
<div class="float-item-left">
<div class="right-wrap">
                <div class="menu-bar">
                    <a href="list_city.jsp" class="city">전체</a>
                    <a href="list_city.jsp?column=item_address&keyword=서울" class="city">서울</a>
                    <a href="list_city.jsp?column=item_address&keyword=부산" class="city">부산</a>
                </div>
                <div class="menu-bar">
                    <a href="list_city.jsp?column=item_address&keyword=인천" class="city">인천</a>
                    <a href="list_city.jsp?column=item_address&keyword=대구" class="city">대구</a>
                    <a href="list_city.jsp?column=item_address&keyword=대전" class="city">대전</a>
                </div>
                  <div class="menu-bar">
                    <a href="list_city.jsp?column=item_address&keyword=광주" class="city">광주</a>
                    <a href="list_city.jsp?column=item_address&keyword=울산" class="city">울산</a>
                    <a href="list_city.jsp?column=item_address&keyword=경기" class="city">경기</a>
                </div>
                <div class="menu-bar">
                    <a href="list_city.jsp?column=item_address&keyword=세종" class="city">세종</a>
                    <a href="list_city.jsp?column=item_address&keyword=강원" class="city">강원</a>
                    <a href="list_city.jsp?column=item_address&keyword=제주" class="city">제주</a>
                </div>
                <div class="menu-bar">
                    <a href="list_city.jsp?column=item_address&keyword=경상북도" class="city">경북</a>
                    <a href="list_city.jsp?column=item_address&keyword=경상남도" class="city">경남</a>
                    <a href="list_city.jsp?column=item_address&keyword=전라남도" class="city">전남</a>
                </div>
                <div class="menu-bar">
                    <a href="list_city.jsp?column=item_address&keyword=전라북도" class="city">전북</a>
                    <a href="list_city.jsp?column=item_address&keyword=충청남도" class="city">충남</a>
                    <a href="list_city.jsp?column=item_address&keyword=충청북도" class="city">충북</a>
                </div>
            </div>
   <%
            if(isSearchMode){
            List<String> subCityList = ItemCityList.getSubcityList(pn.getKeyword()); %>
<!--             리스트가 널이 아니라면 -->
            <div class="right-wrap2">
                <div class="menu-city">
                
					<%
					if(!subCityList.isEmpty()){
					for(String s : subCityList){ %>
                    <a href="list_city.jsp?column=item_address&keyword=<%=pn.getKeyword()%>&subCity=<%=s%>" class="city"><%=s %></a>
                    <%}}} %>
                </div>
            </div>
             
             
            </div>
        </div>
    


  </div>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>