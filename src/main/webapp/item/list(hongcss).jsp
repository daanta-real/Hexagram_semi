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
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->

<%-- 관리자만 글쓰기위한 세션 받기 --%>
<%
String usersId = (String)request.getSession().getAttribute("usersId");
	

// 	list.jsp에서 확인 후 필요없으면 삭제(회원 번호)
	int usersIdx;
	try{
		
		usersIdx = (int)request.getSession().getAttribute("usersIdx");
		
	}catch(Exception e){
		e.printStackTrace();
		usersIdx = 0;
	}
	
	
	String usersGrade = (String)request.getSession().getAttribute("usersGrade");
	//세션 Grade값이 관리자라면
	boolean admin = usersGrade != null && usersGrade.equals("관리자");
	//root path
	String root = request.getContextPath();
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
        .float-container > .float-item-right {
            float:right;
        }
        .search-select{
            font-size:3.5mm;
            padding: 6px;
            margin:0.5rem;
        }
        .search-input{
            font-size:3.5mm;
            padding: 6px;
            margin:0.5rem;
        }
        .search-btn{
            font-size:3.5mm;
            padding: 6px;
            margin:0.5rem;
            background-color:hsl(34, 93%, 67%);
            border:none;
        }
        .content{
            color:black;
        }
        .item-list{
            border-top:2px solid gray;
        }
        .item-list > .item-image {
            padding:1rem;
            width:150px;
        }
        .item-list > .item-content {
            width:740px;
            height:154px;
            padding:5px;
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
  
    </style>
</head>
<body>
    
    <div class="container-900 container-center">
    	<div class="row center">
    		<h2><%=title %></h2>
    	</div>
    	<%-- 검색창 --%>
        <div class="row center">
           <form action="<%=root%>/item/list.jsp" method="get">
				<select name="column" class="search-select">
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
				required value="<%=itemPagination.getKeywordString()%>"  class="search-input">
				<input type="submit" value="검색"  class="search-btn">
			</form>
        </div>
        
        <%-- 리스트목록 --%>
        <%if(!list.isEmpty()){%>
        <div class="row">
        	<%for(ItemDto itemDtoList : list){ %>
			<!-- 목록을 보여주면서 itemDto의 itemIdx정보를 받는다. -->
			<%ItemFileDto itemFileDto = itemFileDao.find2(itemDtoList.getItemIdx());%>
            <div class="float-container item-list">
                <div class="float-item-left item-image">
					<%if(itemFileDto == null){ %>
                		<a href="detail.jsp?itemIdx=<%=itemDtoList.getItemIdx()%>">
                    	<img src="http://via.placeholder.com/100x100" class="image">
					<%}else{ %>
                 	 	<img src="file/download.nogari?itemFileIdx=<%=itemFileDto.getItemFileIdx()%>">
					<%} %>
                    </a>      
                </div>
                <div class="float-item-left item-content">
                    <h3><%=itemDtoList.getItemName()%></h3>
                    <h5>주소 : <%=itemDtoList.getItemAddress() %></h5>
                    <h5>분류 : <%=itemDtoList.getItemType() %></h5>
                </div>
            </div>
        </div>
        <%} %>
	<%}else{ %>
	<h2>결과가 없습니다.</h2>
	<%} %>   
      <%-- 페이지네이션 --%>
        <div class="pagination">
           <%if(itemPagination.isBackPage()){ %>
			<%if(itemPagination.isSearch()){%>
				<a href="list.jsp?column=<%=itemPagination.getColumn() %>&keyword<%=itemPagination.getKeyword() %>&p=<%=itemPagination.getBackPage()%>">[이전]</a>
			<%}else{ %>
				<a href="list.jsp?p=<%=itemPagination.getBackPage() %>">[이전]</a>
			<%} %>	
			<%}else{%>
				<a>[이전]</a>
			<%} %>
			
			<%-- 숫자 a 태그 --%>
			<%for(int i = itemPagination.getStartBlock(); i<=itemPagination.getEndBlock(); i++) {%>
				<%if(itemPagination.isSearch()){ %>
					<a href="list.jsp?column=<%=itemPagination.getColumn() %>&keyword<%=itemPagination.getKeyword() %>&p=<%=i %>"><%=i %></a>
				<%}else{ %>
					<a href="list.jsp?p=<%=i %>"><%=i %></a>
				<%} %>
			<%} %>
			
			<%-- [다음] a 태그 --%>
			<%if(itemPagination.isNextPage()){ %>
				<%if(itemPagination.isSearch()){%>
					<a href="list.jsp?column=<%=itemPagination.getColumn() %>&keyword<%=itemPagination.getKeyword() %>&p=<%=itemPagination.getEndBlock()%>">[다음]</a>
				<%}else{ %>
					<a href="list.jsp?p=<%=itemPagination.getEndBlock() %>">[다음]</a>
				<%} %>	
			<%}else{ %>
				<a>[다음]</a>
			<%} %>
        </div>
        <div class="row center">
            <%if(admin){ %>
			<form action="insert.jsp">
				<input type="submit" value="글쓰기" class="search-btn">
			</form>
			<%} %>
        </div>
	</div>


</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>