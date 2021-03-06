<%@page import="util.users.Sessioner"%>
<%@page import="beans.ItemFileDto"%>
<%@page import="beans.ItemFileDao"%>
<%@page import="servlet.item.ItemCityList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.UsersDto"%>
<%@page import="beans.UsersDao"%>
<%@page import="beans.Pagination"%>
<%@page import="beans.ItemDto"%>
<%@page import="beans.ItemDao"%>
<%@page import="beans.CourseItemDao"%>
<%@page import="beans.CourseDto"%>
<%@page import="java.util.List"%>
<%@page import="beans.CourseDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	//페이지 내에서 조회에 필요한 파라미터값을 변수에 저장한다
   	String order = "course_idx";
   	if(request.getParameter("order") != null)
   	order = request.getParameter("order");
   	//지역의 시,군,구 파라미터 값
   	String subCity = request.getParameter("subCity");
   	//절대 경로를 위해 index.jsp 페이지 변수 저장
    String root = request.getContextPath();
   	
   	boolean isLogin = request.getSession().getAttribute("usersIdx") != null;
   	
   	//페이지 네이션
    CourseDao courseDao = new CourseDao();
    Pagination<CourseDao, CourseDto> pn = new Pagination<>(request, courseDao);
    //검색용 페이지 네이션
    boolean isSearchMode = pn.isSearchMode();
   
    //모듈에서 calculate()메소드를 사용하여 아래의 것들을 한번에 처리할 수 있지만, 정렬 및 기타 파라미터들이 늘어나면서
    //해당 화면에서 페이지 사이즈 및 필요 요소들을 설정해두었다.
    pn.setPageSize(9);
    pn.setStartBlock(pn.getPage()/pn.getBlockSize()*pn.getBlockSize()+1);
    pn.setFinishBlock(pn.getStartBlock()+(pn.getBlockSize()-1));
    pn.setEnd(pn.getPage()*pn.getPageSize());
    pn.setBegin(pn.getEnd()-(pn.getPageSize()-1));
    
   //아무 파라미터가 없을때 정렬은 기본 아이템 번호 최신순(즉 최신 등록순으로 진행.)
   
   //course 데이터 목록 불러오기
   //관광지 목록 도출
	List<CourseDto> list = new ArrayList<>();
	if(isSearchMode){
		//파라미터값에 컬럼이 item_address라면 (지역을 클릭시)
		if(pn.getColumn().equals("item_address")){
			//파라미터값에 컬럼이 item_address이고 시,군,구가 있다면
			if(subCity != null){
				//시,군,구로 목록을 보여주고 최신순으로 보여준다 (아무 파라미터가 없을때 정렬은 기본 아이템 번호 최신순(즉 최신 등록순으로 진행.))
				list = courseDao.subCityList(subCity,order, pn.getColumn(), pn.getKeyword(), pn.getBegin(), pn.getEnd());
				pn.setCount(courseDao.countSubCity(pn.getColumn(), pn.getKeyword(),subCity));
				pn.setLastBlock((pn.getCount()-1)/pn.getPageSize()+1); 
			}
			
			else{
				//시,군,구를 선택하고 인기순,최신순,댓글순으로 정렬할수 있는 메소드
				list = courseDao.cityList(order, pn.getColumn(), pn.getKeyword(), pn.getBegin(), pn.getEnd());
				pn.setCount(courseDao.countCity(pn.getColumn(), pn.getKeyword()));
				pn.setLastBlock((pn.getCount()-1)/pn.getPageSize()+1);
			}
		}
		
		//검색어 입력창에 검색어를 입력했다면
		else{
			//검색어로 입력한 값으로 목록을 보여주고 최신순으로 보여준다(아무 파라미터가 없을때 정렬은 기본 아이템 번호 최신순(즉 최신 등록순으로 진행.))
			list=courseDao.orderByKeywordList(order, pn.getColumn(), pn.getKeyword(), pn.getBegin(), pn.getEnd());
			pn.setCount(courseDao.count(pn.getColumn(), pn.getKeyword()));
			pn.setLastBlock((pn.getCount()-1)/pn.getPageSize()+1);
		}
	}
	//검색을 하지 않았고 지역선택을 하지 않았다면
	//아무 파라미터가 없을때 정렬은 기본 아이템 번호 최신순(즉 최신 등록순으로 진행.)
	else{
		list=courseDao.orderByList(order, pn.getBegin(), pn.getEnd());
		pn.setCount(courseDao.count());
		pn.setLastBlock((pn.getCount()-1)/pn.getPageSize()+1);
	}
        
     	// 제목 h2 태그에 들어갈 타이틀 결정
        String title = isSearchMode ? ("["+pn.getKeyword()+"]" + " 검색") : ("코스 목록");
%>
    
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 관광지 목록</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
 <style>
    * {
        box-sizing: border-box;
    }
    /* 전체 레이아웃 사이즈 (메인으로 옮겨 메인에 맞게 조정)*/
    .container-900 {width: 900px;}
    /* 각 div 마다 부여할 margin 값 */
    .row {margin-top: 10px; margin-bottom: 10px;}
    /* 컨테이너 왼쪽 정렬 */
    .container-left {margin-left: 0; margin-right: auto;}
    /* 컨테이너 가운데 정렬 */
    .container-center {margin-left: auto; margin-right: auto;}
    /* 컨테이너 오른쪽 정렬*/
    .container-right {margin-left: auto; margin-right: 0;}
    /* div 내에 태그 왼쪽 정렬*/
    .left {text-align: left;}
    /* div 내에 태그 가운데 정렬*/
    .center {text-align: center;}
    /* div 내에 태그 오른쪽 정렬*/
    .right {text-align: right;}
  
   
    
    .box-img{
        height:150px;
        width:280px;
    }
    .flex-loop{
        display: flex;
        flex-wrap: wrap;
    }
    .box{
        display: flex;
        flex-direction: column;
        width: 282px;
        height: 262px;
        border: 1px solid #0002;
        margin-left: 13px;
        margin-top: 10;
        margin-bottom: 10px;
    }
    .box:hover{
        display: flex;
        flex-direction: column;
        width: 282px;
        height: 262px;
        border: 1px solid #0002;
        margin-left: 13px;
        margin-top: 10;
        margin-bottom: 10px;
        background-color: hsl(34, 60%, 70%);
    }
    .box-detail{
        margin:3px;
    }
    .back{
        background: url(http://via.placeholder.com/900x300) repeat;
        width: 900px;
        height:300px;
    }
    
    .flex-container {
            display: flex;
            flex-wrap: wrap;
        }
   .flex-btn {
            flex-grow: 25%;
            
        }    
    
      
    .form-input,
	.form-btn {
	    font-size: 0.8rem;
	    padding: 0.3rem;
	}
	
	.form-input {
	    border: 1px solid rgb(43, 48, 90);
	    width:60%;
	}
	
	.form-btn {
		width:10%;
	    color: rgb(77, 25, 25);
	    background-color: rgb(232, 193, 125);
	    font-weight: bold;
	}
	
	.form-block {
	    display: block;
	}
	
	.form-inline {
	    width: auto;
	}
    
	.top-btn{
   		margin-left: 0.3rem;
	    border-radius: 0.5rem;
	    padding: 0.05rem 0.6rem;
	    box-shadow: 0 0 1rem #8882;
	    color: hsl(0, 50%, 20%);
	    background: hsl(34, 60%, 70%);
     }
     .top-btn:hover{
   		border:1px solid inherit;
   		background-color:hsl(38, 70%, 70%);
     }
     
	.item-title {
    	font-size: 3rem;
    	line-height: 6rem;
    }
    
    /* 그리드 컨테이너 내부에서 사용되는 변수들의 선언 */ 
	.gridFirst {
		--grid-box-margin: 3rem;
		--grid-title-width: 3rem;
		--grid-el-width: 4rem;
		--grid-el-height: 2rem;
		--grid-el-margin: 0.3rem;
	}
	
	/* 그리드 앨범들을 가지고 있는 최상위 컨테이너. 앨범 박스를 통째로 중앙 정렬하기 위해서 반드시 필요하다. */
	.gridFirst > .gridContainer {
		width: 100%;
		/*border:1px solid blue;*/
	}
	/* 그리드 앨범 박스*/
	.gridFirst > .gridContainer > .gridBox {
		display: grid;
   		justify-content:center;
   		grid-template-columns: var(--grid-box-margin) 1fr;
		margin: var(--grid-box-margin);
   		/*border:1px solid black;*/
   		margin-top: 2rem;
 	}
 	
 	/* 좌측 타이틀부 */
 	.gridFirst > .gridContainer > .gridBox > .gridTitle {
 		display:flex; flex-direction:column; justify-content:center; align-items:center;
 		width: var(--grid-title-width);
 		border:1px solid #0002;
 		/*border:1px solid gold;*/
 		background-color:hsl(38, 70%, 70%);
 	}
 	
 	/* 우측 콘텐츠부 */
 	.gridFirst > .gridContainer > .gridBox > .gridContents {
 		display:flex; flex-direction:row; justify-content:flex-start; align-items:center; flex-wrap:wrap;
 		border:1px solid #0002;
	}
 	
 	/* 우측 콘텐츠부 내부 개별 객체 */
 	.gridFirst > .gridContainer > .gridBox > .gridContents > h3 { width:100%; }
 	.gridFirst > .gridContainer > .gridBox > .gridContents > .gridEl {
 		width: var(--grid-el-width);
 		height: var(--grid-el-height);
 		margin: var(--grid-el-margin);
 		/*border: 1px solid red;*/
 		text-align: center;
 		padding-top: 0.4rem;
 	}
 	.gridFirst > .gridContainer > .gridBox > .gridContents > .gridEl:hover {
 		width: var(--grid-el-width);
 		height: var(--grid-el-height);
 		margin: var(--grid-el-margin);
 		/*border: 1px solid red;*/
 		text-align: center;
 		padding-top: 0.4rem;
 		background-color:hsl(40, 58%, 77%);

 	}
 	/*검색창 백그라운드 이미지*/
 	.back {
	  background-image:url(https://cdn.pixabay.com/photo/2017/10/10/22/27/creux-du-van-2839124_960_720.jpg);
	  background-position:0 0;
	  background-repeat: no-repeat;
	  width: 38rem;
      height:100%;
      margin:auto;
	}
	/* 검색어 입력 폼 */
	.searchBox {
	  width: 100%;
      height: 4rem;
      background-color: rgba(0, 0, 0, 0.3);
      margin: 3rem;
	}
	.searchColumns {
		display: flex;
	}
	.searchColumns > input[name=keyword] {
	    width: 20rem;
	}
	
	.searchColumns > input[type=submit] {
	    width: 4rem;
	}
	
	.searchColumns > select {
	    width: 6rem;
	}
	/* 검색어 입력 폼박스 안의 각종 form 엘레멘트들 (분류선택, 검색어 입력창, 검색 버튼) */ 
	.searchColumns > *, .searchColumns option {
	    min-height: 2rem;
	    max-height: 2rem;
	    line-height: 2rem;
	    font-size: 1.5rem;
	    margin: 0 0.3rem;
	    padding: 0 1rem;
	    border: 1px solid black;
    	font-family: 'mainFont';
    	border-radius:0.2rem;
	}
	
	/* 게시판에서 사용되는 변수들 */
	.board {
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
		--board-page-el-width: 4rem;
		--board-page-lr-width: 3rem;
		box-sizing:content-box;
	}
	 

	.boardContainer > .boardBox.body .row {
		color: var(--board-color-body-font);
		background-color: var(--board-color-body-bg);
	}
	.boardContainer > .boardBox .row > div {
		display:flex; justify-content:center; align-items:center;
	} 

	.boardContainer > .boardBox.body .row,       .boardContainer > .boardBox.page .el { cursor:pointer; }
	.boardContainer > .boardBox.body .row:hover, .boardContainer > .boardBox.page .el:hover {
		background-color:var(--board-el-bgcolor-highlighted);
	}
	

		
	/* 게시판 하단 페이징 블럭들 */
	.boardContainer > .boardBox.page {
		display:flex; flex-direction:row; justify-content:center;
		color: var(--board-page-color);
	}
	
	.boardContainer > .boardBox.page .el {
		text-align:center;
		width: 18%;
	}
	
	.boardContainer > .boardBox.page .el.LR {
		width: var(--board-page-lr-width);
	}
	
</style>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->


<div class="container-900 container-center">

<!-- 검색 form -->
<!-- 페이지 검색 : 지역 , 코스명 , 내용 -->
    <form action="<%=root%>/course/list.jsp" method="get">
        <div class="back flexCenter">
            <div class="searchBox container-center flexCenter">
            	<div class="row center searchColumns">
	                 <select name="column" class="form-input form-inline">
						<%if(pn.columnValExists("course_name")){ %>
							<option value="course_name" selected>코스명</option>
						<%}else{ %>
							<option value="course_name">코스명</option>
						<%} %>
							
						<%if(pn.columnValExists("course_detail")){ %>
							<option value="course_detail" selected>내용</option>
						<%}else{ %>
							<option value="course_detail">내용</option>
						<%} %>
					</select>
						<%if(pn.getColumn() != null && pn.getColumn().equals("item_address")){ %>
						    <input type="search" name="keyword" placeholder="검색어 입력"
						required class="search-keyword" class="form-input form-inline">
						<%}else{ %>
						    <input type="search" name="keyword" placeholder="검색어 입력"
						required value="<%=pn.getKeywordString()%>" class="form-input form-inline">
						<%} %>

				<input type="hidden" name="order" value="<%=order%>">
                <input type="submit" value="검색" class="form-btn form-inline">
             	</div>
            </div>
        </div>
	</form>
    
    <!-- 제목 테이블 -->
    <div class="row center">
		<span class="item-title">국내 여행지</span>
    </div>
    
    <!-- 지역 선택 테이블 -->
    <div class="gridFirst">
		<div class='gridContainer'>
			<div class='gridBox'>
				
				<div class='gridTitle'>지역</div>
				<div class='gridContents'>
					<a href="list.jsp" class='gridEl'>전체</a> 
					<a href="list.jsp?column=item_address&keyword=서울&order=<%=order%>" class='gridEl'>서울</a>        
	                <a href="list.jsp?column=item_address&keyword=부산&order=<%=order%>" class='gridEl'>부산</a>
	                <a href="list.jsp?column=item_address&keyword=인천&order=<%=order%>" class='gridEl'>인천</a>
	                <a href="list.jsp?column=item_address&keyword=대구&order=<%=order%>" class='gridEl'>대구</a>
	                <a href="list.jsp?column=item_address&keyword=대전&order=<%=order%>" class='gridEl'>대전</a>
	                <a href="list.jsp?column=item_address&keyword=광주&order=<%=order%>" class='gridEl'>광주</a>
	                <a href="list.jsp?column=item_address&keyword=울산&order=<%=order%>" class='gridEl'>울산</a>
	                <a href="list.jsp?column=item_address&keyword=경기&order=<%=order%>" class='gridEl'>경기도</a>
	                <a href="list.jsp?column=item_address&keyword=세종&order=<%=order%>" class='gridEl'>세종</a>
	                <a href="list.jsp?column=item_address&keyword=강원&order=<%=order%>" class='gridEl'>강원도</a>
	                <a href="list.jsp?column=item_address&keyword=제주&order=<%=order%>" class='gridEl'>제주도</a>
	                <a href="list.jsp?column=item_address&keyword=경상북도&order=<%=order%>" class='gridEl'>경상북도</a>
	                <a href="list.jsp?column=item_address&keyword=경상남도&order=<%=order%>" class='gridEl'>경상남도</a>
	                <a href="list.jsp?column=item_address&keyword=전라남도&order=<%=order%>" class='gridEl'>전라남도</a>
	                <a href="list.jsp?column=item_address&keyword=전라북도&order=<%=order%>" class='gridEl'>전라북도</a>
	                <a href="list.jsp?column=item_address&keyword=충청남도&order=<%=order%>" class='gridEl'>충청남도</a>
                	<a href="list.jsp?column=item_address&keyword=충청북도&order=<%=order%>" class='gridEl'>충청북도</a>
				</div>
				
				<!-- 리스트가 널이 아니라면(지역을 클릭하면 밑에 시,군,구를 출력한다)-->
				<div class='gridTitle'>시군구</div>
				<div class='gridContents'>
		           <%
		            if(isSearchMode && pn.getColumn().equals("item_address")){
		            List<String> subCityList = ItemCityList.getSubcityList(pn.getKeyword()); 
		            %>
		            
					<%
					if(!subCityList.isEmpty()){
					for(String s : subCityList){ %>
                    <a href="list.jsp?column=item_address&keyword=<%=pn.getKeyword()%>&subCity=<%=s%>" class='gridEl'><%=s %></a>
                    <%}}}else{ %>
                    <h3 class="center">지역을 먼저 선택하세요.</h3>
                    <%} %>
				</div>
			</div>
		</div>
	</div>


        <!-- 최신순 조회-->
        <div class="row flex-container">
				<div class="flex-btn">
				<form action="<%=root%>/course/list.jsp" method="get">
					<input type="hidden" name="order" value="course_idx">
					<%if(subCity != null) {%>
					<input type="hidden" name="subCity" value="<%=subCity%>">
					<%} %>
					<input type="hidden" name="keyword" value="<%=pn.getKeywordString()%>">
					<input type="hidden" name="column" value="<%=pn.getColumn()%>">
					<input type="submit" value="최신순 조회" class="top-btn">
				</form>
			</div>
			<!-- 인기순 조회(조회수 기준)-->
			<div class="flex-btn">
				<form action="<%=root%>/course/list.jsp" method="get">
					<input type="hidden" name="order" value="course_count_view">
					<%if(subCity != null) {%>
					<input type="hidden" name="subCity" value="<%=subCity%>">
					<%} %>
					<input type="hidden" name="keyword" value="<%=pn.getKeywordString()%>">
					<input type="hidden" name="column" value="<%=pn.getColumn()%>">
					<input type="submit" value="인기순 조회" class="top-btn">
				</form>	
			</div >
			<!-- 댓글순 조회(댓글개수 기준)-->
			<div class="flex-btn">			
				<form action="<%=root%>/course/list.jsp" method="get">
					<input type="hidden" name="order" value="course_count_reply">
					<%if(subCity != null) {%>
					<input type="hidden" name="subCity" value="<%=subCity%>">
					<%} %>
					<input type="hidden" name="keyword" value="<%=pn.getKeywordString()%>">
					<input type="hidden" name="column" value="<%=pn.getColumn()%>">
					<input type="submit" value="댓글순 조회" class="top-btn">
				</form>
			</div>	
		</div>
        
        
	<!-- 목록 출력 부분 -->
	<%if(!list.isEmpty()) {%>
	 <div class="flex-loop">
		<%for(CourseDto courseDto : list) {%>
			<%
		    //지역 알아내기 -> 코스아이템에서 첫번쨰 아이템 내용 전달.
		    CourseItemDao courseItemDao = new CourseItemDao();
		    int itemIdx = courseItemDao.getItemIdxByCourse(courseDto.getCourseIdx());
		    
		    //위에는 받아올때 idx가 빈값으로 받아오니까?
		    CourseDto courseCheckDto = courseDao.get(courseDto.getCourseIdx());
		    
		    //전달 받은 내용으로 코스에서 지역과 작성자 사진을 출력한다
			//목록을 보여주면서 itemDto의 itemIdx의 첫번째 정보를 받는다
		    ItemDao itemDao = new ItemDao();
		   	ItemDto itemDto = itemDao.get(itemIdx);
		   	UsersDao usersDao = new UsersDao();
		   	UsersDto usersDto = usersDao.get(courseCheckDto.getUsersIdx());

			ItemFileDao itemFileDao = new ItemFileDao();
			ItemFileDto itemFileDto = itemFileDao.find2(itemIdx);
			%>
			<a href="readup.nogari?courseIdx=<%=courseDto.getCourseIdx()%>">
	        <div class="box">      
				<%if(itemFileDto == null){ %>
					<!-- 첨부파일이 없다면 대체이미지 보여주기 -->
					<img src="https://placeimg.com/280/150/nature" class="box-img">
				<%}else{ %>
					<!-- 첨부파일이 있다면 첨부파일을 출력  -->
					<img src="../item/file/download.nogari?itemFileIdx=<%=itemFileDto.getItemFileIdx()%>" class="box-img">
				<%} %>
				<!--지역 -->
				<div class="box-detail"><%=itemDto.getAdressCity()%></div> 
		
				<div class="box-detail">
					<!-- 관광지 제목 -->
					<%
					String name = courseDto.getCourseName();
					if(name.length() > 30){
						name = name.substring(0,30)+"...";
					}
					%>
					<%=name%>
					<!-- 댓글이 있다면 관광지 제목 옆에 댓글 개수를 출력 -->
					<%if(courseDto.isCountReply()){ %>
						[<%=courseDto.getCourseCountReply() %>]
					<%} %>
				</div>
		        <div class="box-detail"><%=usersDto.getUsersId()%></div>
		        <div class="box-detail">
		        	<%=courseDto.getCourseDate()%> (조회수 :<%=courseDto.getCourseCountView()%>) 
		        </div>
	        </div>
			</a>
		<%} %>
	</div>

	<br>
	<!-- 페이지네이션 -->
	<div class="board">
		<div class="boardContainer">
			<div class='boardBox page'>
			<%-- [이전] a 태그 --%>
					<div class='el'>
					<%if(pn.hasPreviousBlock()){ %>
						<%if(isSearchMode){%>
							<%if(subCity != null) {%>
							<a href="list.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&page=<%=pn.getPreviousBlock()%>&order=<%=order%>&subCity=<%=subCity%>">◀</a>
							<%}else{ %>
							<a href="list.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&page=<%=pn.getPreviousBlock()%>&order=<%=order%>">◀</a>
							<%} %>
						<%}else{ %>
							<a href="list.jsp?page=<%=pn.getPreviousBlock() %>&order=<%=order%>">◀</a>
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
							<a href="list.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&page=<%=i %>&order=<%=order%>&subCity=<%=subCity%>"><%=i %></a>
							<%}else{ %>
							<a href="list.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&page=<%=i %>&order=<%=order%>"><%=i %></a>
							<%} %>
						<%}else{ %>
							<a href="list.jsp?page=<%=i %>&order=<%=order%>"><%=i %></a>
						<%} %>
					<%} %>
					</div>
					<%-- [다음] a 태그 --%>
					<div class='el'>
					<%if(pn.hasNextBlock()){ %>
						<%if(isSearchMode){%>
							<%if(subCity != null) {%>
							<a href="list.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&order=<%=order%>&subCity=<%=subCity%>">▶</a>
							<%}else{ %>
							<a href="list.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&order=<%=order%>">▶</a>
							<%} %>
						<%}else{ %>
							<a href="list.jsp?page=<%=pn.getNextBlock() %>&order=<%=order%>">▶</a>
						<%} %>
					<%}else{ %>
						<a>▶</a>
					<%} %>
				</div>
			</div>
		</div>
	</div>
</div>
<br>

<!-- 데이터가 없다면 -->
<%}else{ %>
	<h3 class="center">글이 없습니다.</h3>
<%} %>


<%if(isLogin){ %>
<!-- 글쓰기 버튼을 누르면CourseCreateSequnceForInsertServlet 으로 이동해서 시퀀스 번호를 생성해준다. -->
<h2><a href="insert_sequence.nogari" class="top-btn">글 쓰기</a></h2>
<%} %>


<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>