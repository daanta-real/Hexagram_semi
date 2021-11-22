<%@page import="util.users.Sessioner"%>
<%@page import="servlet.item.ItemCityList"%>
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
<!-- <LINK REL="STYLESHEET" HREF="<%=root%>/resource/css/item/list.css" /> <!-- CSS 첨부 --> -->

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
            width:55%;
            height:130px;
            padding:0.2rem;
        }
        .item-list > .item-content > h5{
            margin:0.5rem;
            padding:0.2rem;
        }
        .item-list > .item-content > h3{
            margin:0.5rem;
            padding:0.2rem;
        }
	

    .float-container > .float-item-left > .right-wrap{
        border: 1px solid gray;
        margin-top: 190px;
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
        
        /* 게시판에서 사용되는 변수들 */
	.pagenation {
		--board-grid-columns: 7rem minmax(15rem, 1fr) 5rem 5rem 5rem;
		
		--board-color-title-bg: var(--color10);
		--board-color-title-font: var(--color8);
		--board-color-body-bg: var(--color1);
		--board-color-body-font: var(--color8);
		--board-border-color: var(--color7);
		--board-topbot-border-width: 1px;
		--board-row-height: 1.5rem;
		--board-el-bgcolor-highlighted: #8882;
		
		--board-page-color: var(--color8);
		--board-page-el-width: 2rem;
		--board-page-lr-width: 3rem;
		--box-sizing:content-box;
	}
	.pagenation > .boardContainer > .boardBox {
		display:flex; justify-content:center; align-items:center;
		width:100%;
	}
	
	/* 게시판 하단 페이징 블럭들 */
	.pagenation > .boardContainer > .boardBox.page {
		display:flex; flex-direction:row; justify-content:center;
		color: var(--board-page-color);
		box-sizing: var(--box-sizing);
	}
	
	.pagenation > .boardContainer > .boardBox.page .el {
		/*width: var(--board-page-el-width);*/
		box-sizing: var(--box-sizing);
	}
	
	.pagenation > .boardContainer > .boardBox.page .el.LR {
		width: var(--board-page-lr-width);
		box-sizing: var(--box-sizing);
	}
    </style>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!-- 페이지 내용 시작 -->

<%
//지역을 누르거나 최신순 댓글순 인기순을 눌렀을때 정렬, 또는 검색에 필요한 파라미터값을 변수에 저장한다
String order = "item_idx";
//정렬(최신순, 댓글순, 인기순)을 눌렀다면 (277번째 줄부터)
if(request.getParameter("order") != null)
order = request.getParameter("order");
String subCity = request.getParameter("subCity");

//아무 파라미터가 없을때 정렬은 기본 아이템 번호 최신순(즉 최신 등록순으로 진행.)

// 1. 변수 준비
ItemDao itemDao = new ItemDao();
Pagination<ItemDao, ItemDto> pn = new Pagination<>(request, itemDao);
boolean isSearchMode = pn.isSearchMode();
pn.calculate();

//관광지 목록 도출(페이지네이션)
List<ItemDto> list = new ArrayList<>();
if(isSearchMode){
	
	//만약 위 파라미터 값에 지역(시,구,군)이 있다면 지역(시,구,군)으로 뽑아낸 메소드로 목록으로 최신순 인기순 댓글순 정렬을 할수 있다
	if(subCity != null){
		list = itemDao.subCityList(subCity,order, pn.getColumn(), pn.getKeyword(), pn.getBegin(), pn.getEnd());
		pn.setCount(itemDao.count(pn.getColumn(), pn.getKeyword(),subCity));
		pn.setLastBlock((pn.getCount()-1)/pn.getPageSize()+1); 
	}
	
	//파라미터값에 지역(시,구,군)이 없고 order만 받았다면 현재 선택된 지역의 최신순, 인기순, 댓글순 조회
	else{
	list=itemDao.orderByKeywordList(order, pn.getColumn(), pn.getKeyword(), pn.getBegin(), pn.getEnd());
	}
}

//아무 파라미터가 없을때 정렬은 기본 아이템 번호 최신순(즉 최신 등록순으로 진행.)
else{
	list=itemDao.orderByList(order, pn.getBegin(), pn.getEnd());
}

// 제목 h2 태그에 들어갈 타이틀 결정
String title = isSearchMode
    ? pn.getKeyword()
    : "전체 목록";

// 썸네일표시를 위한 파일 조회를 위한 ItemFileDao 생성
ItemFileDao itemFileDao = new ItemFileDao();

%>

<!-- 페이지 시작 -->
<div class="container-900 container-center">

	<div class="row float-container">
	   	<!-- 왼쪽 목록 페이지 -->
		<div class="float-item-left">
			<!-- 검색 또는 지역 클릭한 제목 -->
			<div class="row center">
    			<h1><%=title %></h1>
			</div>
			<!-- 검색 내용 총 개수 -->
			<div class="row center">
    			<h3>총 <%=pn.getCount() %>건</h3>
            </div>
  		
  		<!-- 최신순 인기순 댓글순 조회 버튼 -->
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
					<img src="https://placeimg.com/125/125/nature" class="image">
					<%}else{ %>
					<!-- 첨부파일이 있다면 첨부파일을 출력  -->
					<img src="file/download.nogari?itemFileIdx=<%=itemFileDto.getItemFileIdx()%>">
					<%} %>
					</div>
					<div class="float-item-left item-content">
						<h3>
							<a href="readup.nogari?itemIdx=<%=itemDtoList.getItemIdx()%>">
							<!-- 이 항목을 리스트에서 누를시에만 조회수가 올라가게 ItemReadupServlet 서블릿에서 게시물 조회수 증가를 시킨 후 detail페이지로 이동시킨다. -->
							<%=itemDtoList.getItemName()%>
							</a>
							<!-- 댓글이 있다면 관광지명 옆에 댓글 개수를 출력 -->
							<%if(itemDtoList.isCountReply()){ %>
								[<%=itemDtoList.getItemCountReply() %>]
							<%} %>
						</h3>
						<!-- 관광지 주소 -->
						<h5><%=itemDtoList.getItemAddress() %></h5>
						<!-- 타입(관광지, 축제) , 조회수 -->
						<h5>
	                    	<%=itemDtoList.getItemType() %>
							(조회수:<%=itemDtoList.getItemCountView() %>)
						</h5>
					</div>
				</div>
			</div>
			<%} %>
		<%} %>
		
		
		
	
		<div class="row center">
		<%-- 관리자만 글쓰기 버튼 보이기 --%>
			<div>
				<%if(Sessioner.getUsersGrade(request.getSession()) != null && Sessioner.getUsersGrade(request.getSession()).equals(Sessioner.GRADE_ADMIN)) {%>
				<h2><a href="insert.jsp">글쓰기</a></h2>
				<%} %>
			</div>
		</div>
		</div>
          
        <!-- 왼쪽 지역 float 테이블 -->  
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
            List<String> subCityList = ItemCityList.getSubcityList(pn.getKeyword()); 
            %>
			<!-- 리스트가 널이 아니라면(지역클릭시) -->
            <div class="right-wrap2">
                <div class="menu-city">
              		<!-- 시,군,구 목록 보여주기 -->
					<%
					if(!subCityList.isEmpty()){
					for(String s : subCityList){ %>
                    <a href="list_city.jsp?column=item_address&keyword=<%=pn.getKeyword()%>&subCity=<%=s%>" class="city"><%=s %></a>
                    <%}}} %>
                </div>
            </div>
        </div>
    </div>
    
    
<!-- 페이지네이션 -->
		<div class="pagenation">
			<div class="boardContainer">
				<div class='boardBox page'>
					<%-- [이전] a 태그 --%>
					<div class='el'>
						<%if(pn.hasPreviousBlock()){ %>
							<%if(isSearchMode){%>
								<%if(subCity != null) {%>
								<a href="list_city.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&page=<%=pn.getPreviousBlock()%>&order=<%=order%>&subCity=<%=subCity%>">◀</a>
								<%}else{ %>
								<a href="list_city.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&page=<%=pn.getPreviousBlock()%>&order=<%=order%>">◀</a>
								<%} %>
							<%}else{ %>
								<a href="list_city.jsp?page=<%=pn.getPreviousBlock() %>&order=<%=order%>">◀</a>
							<%} %>
						<%}else{%>
							<a>◀</a>
						<%} %>
					</div>
					<%-- 숫자 a 태그 --%>
					<div class='el'>
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
					</div>
					<%-- [다음] a 태그 --%>
					<div class='el'>
						<%if(pn.hasNextBlock()){ %>
							<%if(isSearchMode){%>
								<%if(subCity != null) {%>
								<a href="list_city.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&order=<%=order%>&subCity=<%=subCity%>">▶</a>
								<%}else{ %>
								<a href="list_city.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&order=<%=order%>">▶</a>
								<%} %>
							<%}else{ %>
								<a href="list_city.jsp?page=<%=pn.getNextBlock() %>&order=<%=order%>">▶</a>
							<%} %>
						<%}else{ %>
							<a>▶</a>
						<%} %>
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