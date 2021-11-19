<%@page import="servlet.item.ItemCityList"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.UsersDto"%>
<%@page import="beans.UsersDao"%>
<%@page import="beans.Pagination_users"%>
<%@page import="beans.ItemDto"%>
<%@page import="beans.ItemDao"%>
<%@page import="beans.CourseItemDao"%>
<%@page import="beans.CourseDto"%>
<%@page import="java.util.List"%>
<%@page import="beans.CourseDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String order = "course_idx";
	if(request.getParameter("order") != null)
	order = request.getParameter("order");
	
	String subCity = request.getParameter("subCity");

	//절대 경로를 위해 index.jsp 페이지 변수 저장
    String root = request.getContextPath();
	
	//페이지 네이션
    CourseDao courseDao = new CourseDao();
    Pagination_users<CourseDao, CourseDto> pn = new Pagination_users<>(request, courseDao);

    //검색용 페이지 네이션
    boolean isSearchMode = pn.isSearchMode();
   
    pn.setPageSize(12);
    pn.setStartBlock(pn.getPage()/pn.getBlockSize()*pn.getBlockSize()+1);
    pn.setFinishBlock(pn.getStartBlock()+(pn.getBlockSize()-1));
    pn.setEnd(pn.getPage()*pn.getPageSize());
    pn.setBegin(pn.getEnd()-(pn.getPageSize()-1));
    
    //course 데이터 목록 불러오기
   //관광지 목록 도출
	List<CourseDto> list = new ArrayList<>();
	if(isSearchMode){
		if(pn.getColumn().equals("item_address")){
			if(subCity != null){
				List<Integer> countIdxList = courseDao.subCityList(subCity,order, pn.getColumn(), pn.getKeyword(), pn.getBegin(), pn.getEnd());
				for(int courseNumber : countIdxList){
					list.add(courseDao.get(courseNumber));
				}
				pn.setCount(courseDao.countSubCity(pn.getColumn(), pn.getKeyword(),subCity));
				pn.setLastBlock((pn.getCount()-1)/pn.getPageSize()+1); 
		}else
		{
			List<Integer> countIdxList = courseDao.cityList(order, pn.getColumn(), pn.getKeyword(), pn.getBegin(), pn.getEnd());
			for(int courseNumber : countIdxList){
				list.add(courseDao.get(courseNumber));
			}
			pn.setCount(courseDao.countCity(pn.getColumn(), pn.getKeyword()));
			pn.setLastBlock((pn.getCount()-1)/pn.getPageSize()+1);
		}
		}
		
		else{
		list=courseDao.orderByKeywordList(order, pn.getColumn(), pn.getKeyword(), pn.getBegin(), pn.getEnd());
		pn.setCount(courseDao.count(pn.getColumn(), pn.getKeyword()));
		pn.setLastBlock((pn.getCount()-1)/pn.getPageSize()+1);
		}
	}else{
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
    
    /* 검색창 배경 블러 처리 */
    .search-img {
        opacity: 0.5;
        position: relative;
    }
   
    .course-box{
        background: white;
        border-left: 1px solid black;;
        border-right: 1px solid black;;
        border-bottom: 1px solid black;;
    }
    .menu-bar{
        border-top: 1px solid black;;
        height: 55px;
        line-height: 55px;
        width: 100%;
    }
    .course-location{
        float: left;
        border-right: 1px solid black;
        height: 55px;
        text-align: black;
        width: 12%;
        font-weight: bold;
        text-align: center;
    }
    .course-city{
        float: left;
        height: 55px;
        width: 12%;
        font-weight: bold;
        text-align: center;
        text-decoration: none;
        color:gray;
    }
    .course-city:hover{
        float: left;
        height: 55px;
        width: 12%;
        font-weight: bold;
        text-align: center;
        text-decoration: none;
        color:black;
    }
    .item-title{
        font-size:20px;
        font-weight: bold;
    }
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
        border: 1px solid black;
        margin-left: 13px;
        margin-top: 10;
        margin-bottom: 10px;

    }
    .box-detail{
        margin:3px;
    }
    .search{
        width: 640px;
        height: 138px;
        border-radius: 3px;
        background: url(http://via.placeholder.com/640x138) repeat;
        margin: 0 auto;
        padding: 50px;
        position: relative;
    }
    .back{
        background: url(http://via.placeholder.com/900x300) repeat;
        width: 900px;
        height:300px;
    }
    .right-wrap{
        border: 1px solid gray;
        margin-top: 150px;
    }
    
    .flex-container {
            display: flex;
            flex-wrap: wrap;
        }
   .flex-btn {
            flex-grow: 25%;
        }
        
     .right-wrap2{
        border: 1px solid gray;
        margin-top: 8px;
    }
    .city{
        float: left;
        height: 40px;
        width: 10%;
        font-weight: bold;
        text-align: center;
        text-decoration: none;
        color:gray;
         line-height: 40px;
    }
     .menu-city{
     	border:1px solid blue;
        height: 165px;
        width: 100%;
        margin: 0 auto;
        padding: 0;
    }
</style>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->


<!-- 기본적인 글쓰기 및 -->
<!-- 확인용 리스트 구현 -->


<!-- 페이지 검색 : 지역 , 코스명 , 내용 -->
<!-- 두가지 방법이 있는데, (둘다 시도 중)-->
<!-- 첫번째는 세션을 이용하여 세션안에서 아이템들을 모아서 처리하였다가 마지막에 그 세션을 파기 시키는 방법 (course_try 내부에 저장해 두었다)-->

<!-- 두번째는 글쓰기를 누를떄 시퀀스 번호를 생성하는 서블릿으로 이동한 후, 그 시퀀스 번호를 이용해서 코스아이템 DB에 추가 저장하는 방식. -->

<!-- 페이지 제목 -->
<h2><%=title%></h2>
<h2><%=order%></h2>
<h2><%=list.size()%></h2>
<h2><%=pn.getCount()%></h2>

<!-- 검색 form -->
    <div class="container-900 container-center">
        <div class="back">
            <div class="search center">
            <form action="<%=root%>/course/list.jsp" method="get">
                <select name="column" class="search-select">
                   <%if(pn.columnValExists("item_address")){ %>
							<option value="item_address" selected>지역명</option>
							<%}else{ %>
							<option value="item_address">지역명</option>
							<%} %>
							
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
                <input type="search" name="keyword" placeholder="검색어 입력"
						required value="<%=pn.getKeywordString()%>" class="search-keyword">
				<input type="hidden" name="order" value="<%=order%>">
                <input type="submit" value="검색" class="search-btn">
                
            </div>
        </div>

	<div class="row center">
            <span class="item-title">국내 여행지</span>
        </div>
        <div class="course-box">
            <div class="menu-bar">
                <span class="course-location">카테고리</span>
                <a href="/item/list.jsp?column=item_type&keyword=" class="course-city">축제</a>        
                <a href="/item/list.jsp?column=item_type&keyword=" class="course-city">관광지</a>
            </div>
        </div>
             <div class="course-box">
            <div class="menu-bar">
                <span class="course-location">지역</span>
                <a href="list.jsp?column=item_address&keyword=서울&order=<%=order%>" class="course-city">서울</a>        
                <a href="list.jsp?column=item_address&keyword=부산&order=<%=order%>" class="course-city">부산</a>
                <a href="list.jsp?column=item_address&keyword=인천&order=<%=order%>" class="course-city">인천</a>
                <a href="list.jsp?column=item_address&keyword=대구&order=<%=order%>" class="course-city">대구</a>
                <a href="list.jsp?column=item_address&keyword=대전&order=<%=order%>" class="course-city">대전</a>
                <a href="list.jsp?column=item_address&keyword=광주&order=<%=order%>" class="course-city">광주</a>
                <a href="list.jsp?column=item_address&keyword=울산&order=<%=order%>" class="course-city">울산</a>
            </div>
        </div>
        <div class="course-box">
            <div class="menu-bar">
                <a href="list.jsp?column=item_address&keyword=경기&order=<%=order%>" class="course-city">경기도</a>
                <a href="list.jsp?column=item_address&keyword=세종&order=<%=order%>" class="course-city">세종</a>
                <a href="list.jsp?column=item_address&keyword=강원&order=<%=order%>" class="course-city">강원도</a>
                <a href="list.jsp?column=item_address&keyword=제주&order=<%=order%>" class="course-city">제주도</a>
                <a href="list.jsp?column=item_address&keyword=경상북도&order=<%=order%>" class="course-city">경상북도</a>
                <a href="list.jsp?column=item_address&keyword=경상남도&order=<%=order%>" class="course-city">경상남도</a>
                <a href="list.jsp?column=item_address&keyword=전라남도&order=<%=order%>" class="course-city">전라남도</a>
                <a href="list.jsp?column=item_address&keyword=전라북도&order=<%=order%>" class="course-city">전라북도</a>
            </div>
        </div>
        <div class="course-box">
            <div class="menu-bar">
                <a href="list.jsp?column=item_address&keyword=충청남도&order=<%=order%>" class="course-city">충청남도</a>
                <a href="list.jsp?column=item_address&keyword=충청북도&order=<%=order%>" class="course-city">충청북도</a>
            </div>
        </div>
        
        
        
<!--             리스트가 널이 아니라면 -->
            <div class="flex-container">
                <div class="menu-city">
                
           <%
            if(isSearchMode && pn.getColumn().equals("item_address")){
            List<String> subCityList = ItemCityList.getSubcityList(pn.getKeyword()); %>
					<%
					if(!subCityList.isEmpty()){
					for(String s : subCityList){ %>
                    <a href="list.jsp?column=item_address&keyword=<%=pn.getKeyword()%>&subCity=<%=s%>" class="city"><%=s %></a>
                    <%}}}else{ %>
                    <h1 class="center">광고</h1>
                    <%} %>
                </div>
            </div>



       <!-- 인기순 보여주기(조회수 기준)-->
        <div class="row flex-container">
				<div class="flex-btn">
				<form action="<%=root%>/course/list.jsp" method="get">
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
				<form action="<%=root%>/course/list.jsp" method="get">
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
				<form action="<%=root%>/course/list.jsp" method="get">
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
        
        
        
<%if(!list.isEmpty()) {%>
 <div class="flex-loop">
 		<%for(CourseDto courseDto : list) {%>
			<%
		    //지역 알아내기 -> 코스아이템에서 첫번쨰 아이템 내용 전달.
		    CourseItemDao courseItemDao = new CourseItemDao();
		    int itemIdx = courseItemDao.getItemIdxByCourse(courseDto.getCourseIdx());
		    ItemDao itemDao = new ItemDao();
		   	ItemDto itemDto = itemDao.get(itemIdx);
		   	UsersDao usersDao = new UsersDao();
		   	UsersDto usersDto = usersDao.get(courseDto.getUsersIdx());
			%>
            <div class="box">
                <img src="http://via.placeholder.com/280x150" class="box-img">      
                <div class="box-detail"><%="TE"%></div> <!--지역 -->
                
                
                <div class="box-detail">
                <a href="readup.nogari?courseIdx=<%=courseDto.getCourseIdx()%>">
                <%=courseDto.getCourseName()%>
                </a>
                <%-- 댓글수 --%>
					<!-- 댓글이 있다면 개수를 출력 -->
				<%if(courseDto.isCountReply()){ %>
						[<%=courseDto.getCourseCountReply() %>]
				<%} %>
                </div>
                
                
                <div class="box-detail"><%=usersDto.getUsersId()%></div>
                <div class="box-detail"><%=courseDto.getCourseDate()%></div>
            </div>
            <%} %>
        </div>


    </div>

<!-- 페이지네이션 -->
	<div class="row pagination">
		<%-- [이전] a 태그 --%>
		<%if(pn.hasPreviousBlock()){ %>
			<%if(isSearchMode){%>
				<%if(subCity != null) {%>
				<a href="list.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&page=<%=pn.getPreviousBlock()%>&order=<%=order%>&subCity=<%=subCity%>">[이전]</a>
				<%}else{ %>
				<a href="list.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&page=<%=pn.getPreviousBlock()%>&order=<%=order%>">[이전]</a>
				<%} %>
			<%}else{ %>
				<a href="list.jsp?page=<%=pn.getPreviousBlock() %>&order=<%=order%>">[이전]</a>
			<%} %>
		<%}else{%>
			<a>[이전]</a>
		<%} %>

		<%-- 숫자 a 태그 --%>
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

		<%-- [다음] a 태그 --%>
		<%if(pn.hasNextBlock()){ %>
			<%if(isSearchMode){%>
				<%if(subCity != null) {%>
				<a href="list.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&order=<%=order%>&subCity=<%=subCity%>">[다음]</a>
				<%}else{ %>
				<a href="list.jsp?column=<%=pn.getColumn() %>&keyword=<%=pn.getKeyword() %>&order=<%=order%>">[다음]</a>
				<%} %>
			<%}else{ %>
				<a href="list.jsp?page=<%=pn.getNextBlock() %>&order=<%=order%>">[다음]</a>
			<%} %>
		<%}else{ %>
			<a>[다음]</a>
		<%} %>
	</div>

<br><br>

<!-- 데이터가 없다면 -->
<%}else{ %>
	<h3 class="center">글이 없습니다.</h3>
<%} %>

<!-- 컨셉 :  -->
<!-- 1) 코스 번호는 코스_아이템 DB에 저장되어야 하므로, 미리 생성해서 작성란으로 가야한다. -->
<!-- 2) 비회원은 작성할 수 없도록 설정해 두었다. -->
<%if(request.getSession().getAttribute("usersIdx") != null){ %>
<!-- 글쓰기 버튼을 누르면CourseCreateSequnceForInsertServlet 으로 이동해서 시퀀스 번호를 생성해준다. -->
<h2><a href="insert_sequence.nogari">글 쓰기</a></h2>
<%} %>


<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>