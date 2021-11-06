<%@page import="beans.ItemFileDto"%>
<%@page import="beans.ItemFileDao"%>
<%@page import="beans.ItemPagination"%>
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
	ItemPagination itemPagination = new ItemPagination(request);
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
	.container-900{width: 900px;}
	.container-left {
	    margin-left: 0;
	    margin-right: auto;
	}
	.container-center {
	    margin-left: auto;
	    margin-right:auto;
	}
	.container-right {
	    margin-left: auto;
	    margin-right:0;
	}

	.row{
	margin-top: 5px; margin-bottom: 5px;
	}
	
	.left {
	    text-align: left !important;
	}
	.center {
	    text-align: center !important;
	}
	.right {
	    text-align: right !important;
	}
	
	
		*{
			box-sizing: border-box;
		}
		
		.form-input,
		.form-btn {
		    width: 100%;
		    font-size: 20px;
		    padding: 10px;
		}
		        
		.form-input {
		    border: 1px solid rgb(43, 48, 90);
		    width: 200px;
		}
		
		.form-btn {
		    color: white;
		    background-color: rgb(43, 48, 90);
		    font-weight: bold;
		    height: 90%;
		}
		
		.form-block {
		    display: block;
		}
		
		.form-inline {
		    width: auto;
		}
		
		.form-inline-block {
		   display: inline-block;
		}
     
     	.flex-container{
     		display: flex;
             flex-direction: row;
     	}

         .table{
            width: 100%;
        }

        .table>thead>tr>th,
        .table>thead>tr>td,
        .table>tbody>tr>th,
        .table>tbody>tr>td,
        .table>tfoot>tr>th,
        .table>tfoot>tr>td{
            padding: 0.5rem;
            text-align: center;
        }
		.table.table-border {
		    border:1px solid black;
		    border-collapse: collapse;
		
		}
		.table.table-border > thead > tr > th, 
		.table.table-border > thead > tr > td,
		.table.table-border > tbody > tr > th,
		.table.table-border > tbody > tr > td,
		.table.table-border > tfoot > tr > th,
		.table.table-border > tfoot > tr > td {
		    border:1px solid black;
		
		}
		.table.table-stripe>thead>tr{
		    background-color: darksalmon;
		}
		.table.table-hover>tbody>tr:hover{
		    background-color: bisque;
		}
		.table.table-hover>tbody>tr>td>a:hover{
		   	color: darksalmon;
		}

        .flex-container > .flex-reply-write-wrapper{
            flex-grow: 2;
        }
        .flex-container > .flex-reply-btn-wrapper{
            flex-grow: 1;
            margin-top: auto;
            margin-bottom: auto;
        }
        .link-btn, 
        .link-btn-block,
        .form-link-btn
        {
            padding:0.5rem;
            border:1px solid gray;
            text-decoration: none;
            color:gray;
        }
        .link-btn:hover,
        .link-btn-block:hover,
        .form-link-btn:hover {
            border-color:black;
            color:black;
        }
        .link-btn-block{
            display:block;
            width:100%;
        }
        .form-link-btn {
            padding:0.85rem 0.75rem;
            font-size:20px;
        }

        .flex-container > .reply-write-wrapper {
			width:80%;
		}
		.flex-container > .reply-send-wrapper {
			flex-grow:1;
		}
		.flex-container > .image-wrapper {
			width:25%;
		}
		.flex-container > .image-wrapper > img {
			width:130px;
			height: 130px;
		}
		.flex-container > .detail-wrapper {
			flex-grow:1;
		}
		
		.flex-container > .reply-send-wrapper > .form-btn,
		.flex-container > .reply-send-wrapper > .form-link-btn {
			width:100%;
			height:100%;
			display: flex;
			align-items:center;
			justify-content:center;
		}	
			
		.pagination {
		    text-align: center;
		}
		
		.pagination > a{
		    color:black;
		    text-decoration: none;
		    border:1px solid gray;
		    min-width:2.5rem;
		    display: inline-block;
		    text-align: center;
		    padding:0.5rem;
		}
		
		.pagination > a:hover,
		.pagination > a.active{
		    color:red;
		    border:1px solid red;
		}	
		
		

</style>
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
						<h3><%=itemDtoList.getItemDetail().substring(0, 1) %>...</h3>
						<p><%=itemDtoList.getItemAddress()%></p>					
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