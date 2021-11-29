<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="util.users.Sessioner"%>
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
<%String root = request.getContextPath();%>



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
    
    /* 검색 (입력, 셀렉, 버튼) */
    .form-input,
	.form-btn {
	    font-size: 0.8rem;
	    padding: 0.3rem;
	}
	/* 검색 (입력, 셀렉, 버튼) */
	.form-input {
	    border: 1px solid rgb(43, 48, 90);
	    width:60%;
	}
	/* 검색 (입력, 셀렉, 버튼) */
	.form-btn {
		width:10%;
	    color: rgb(77, 25, 25);
	    background-color: rgb(232, 193, 125);
	    font-weight: bold;
	}
	/* 검색 (입력, 셀렉, 버튼) */
	.form-block {
	    display: block;
	}
	/* 검색 (입력, 셀렉, 버튼) */
	.form-inline {
	    width: auto;
	}
    .item-title{
    	font-size:2rem;
    }
    /* 관광지 지역 부분 */
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
	  width: 900px;
      height:300px;
      
	}
	/* 검색창*/
	.searchBox {
	  width: 600px;
      height: 130px;
      background-color: rgba(0, 0, 0, 0.3);
	}
 
 	/* 관광지 목록 출력 썸네일 부분*/
 	/* 그리드 컨테이너 내부에서 사용되는 변수들의 선언 */ 
	.second {
		--grid-box-margin:2rem;
		--grid-el-width: 10rem;
		--grid-el-height: 11rem;
		--grid-el-margin: 1rem;
		   text-align: center;
	}
	
	/* 그리드 앨범들을 가지고 있는 최상위 컨테이너. 앨범 박스를 통째로 중앙 정렬하기 위해서 반드시 필요하다. */
	.second > .gridContainer {
		width: 100%;
		/*border:1px solid blue;*/
	}
	
	/* 그리드 앨범 박스*/
	.second > .gridContainer > .gridBox {
		display: grid;
   		justify-content:center;
   		grid-template-columns: repeat(auto-fit, minmax(var(--grid-el-width), max-content));
		margin: var(--grid-box-margin);
   		border:1px solid #0002;
 	}
 	
 	/* 앨범 한 개 한 개 */
 	.second > .gridContainer > .gridBox > .gridEl {
 		display:flex; flex-direction:column; align-items:center;
 		/* 세로 가운데 정렬 필요하면 오른쪽 것 주석 해제할 것: justify-content:center; */
 		width: var(--grid-el-width);
 		height: var(--grid-el-height);
 		margin: var(--grid-el-margin);
 		border: 1px solid #dfdfdf;
 		
 	}
 	.second > .gridContainer > .gridBox > .gridEl:hover {
 		display:flex; flex-direction:column; align-items:center;
 		/* 세로 가운데 정렬 필요하면 오른쪽 것 주석 해제할 것: justify-content:center; */
 		width: var(--grid-el-width);
 		height: var(--grid-el-height);
 		margin: var(--grid-el-margin);
 		border: 1px solid #dfdfdf;
 		background-color:hsl(40, 58%, 77%);
 	}
 	
 	
 	.gridElTitle {
 		display: block; 
 		text-align: center;
 		white-space : nowrap; 
 	}
 	
 	
	 	/* 아이템 썸네일 부분 */
	ul{
		list-style:none;
	}
	
	#slide ul{
	    white-space:nowrap; 
	    overflow-x: auto; 
	    text-align:center;
	}
	
	#slide ul li{
	    display:inline-block; 
	    padding: 10px 20px; 
		border: 1px solid #dfdfdf;
	    margin-right:10px;
	    margin-bottom: 20px;
	}
	#slide ul li:hover{
	    display:inline-block; 
	    padding: 10px 20px; 
		border: 1px solid #dfdfdf;
	    margin-right:10px;
	    margin-bottom: 20px;
	    background-color:hsl(40, 58%, 77%);
	}
	
    </style>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script>
	$(function(){
		
		<%
		Calendar c = Calendar.getInstance();
		int month = c.get(Calendar.MONTH)+1;
		int p;
		if(month>=3 && month<=5) p = 0;
		else if(month>=6 && month<=8) p = 1;
		else if(month>=9 && month<=11) p = 2;
		else p = 3;
		%>
        //[1] 현재 시스템 월을 받아서 초기 값 설정(ex>현재 달이 11월이면 p는2)
        var p = <%=p%>;
		
        //[2] p페이지 빼고 다 숨김
        //= 다 숨기고 p페이지만 표시
        $(".season-page").hide();
        $(".season-page").eq(p).show();


        //[3] 다음 단계로 버튼에 대한 이벤트 처리
        //= p를 1 증가시키고 해당하는 페이지를 표시
        //= form 안의 버튼은 submit 효과가 자동 부여되므로 이를 방지해야 한다.
        $(".btn-next").click(function(e){
            e.preventDefault();

            p++;
            $(".season-page").hide();
            $(".season-page").eq(p).show();
        });

        //[4] 이전 단계로 버튼에 대한 이벤트 처리
        $(".btn-prev").click(function(e){
            e.preventDefault();

            p--;
            $(".season-page").hide();
            $(".season-page").eq(p).show();
        });
		
	});
	
	
	</script>


<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>

<!-- 관광지 목록 페이지 시작 -->
<div class="container-900 container-center">
	<!-- 검색 창 -->
	<form action="list.jsp">
	    <div class="back">
	        <div class="searchBox container-center">
	        	<div class="row center">
	             <select name="column" class="form-input form-inline">
	                 <option value="item_name">제목</option>
	                 <option value="item_detail">내용</option>
	             </select>
	           	 	<input type="text" name="keyword" required class="form-input from-inline">
	           	 	<input type="submit" value="검색" class="form-btn from-inline">
	         	</div>
	        </div>
		</div>
	</form>

	<div class="row center">
		<span class="item-title">국내 여행지</span>
	</div>
	
	<div class="gridFirst">
		<div class='gridContainer'>
			<div class='gridBox'>
				<div class='gridTitle'>카테고리</div>
				<div class='gridContents'>
					<a href="<%=root%>/item/list.jsp?column=item_type&keyword=축제" class='gridEl'>축제</a>        
					<a href="<%=root%>/item/list.jsp?column=item_type&keyword=관광지" class='gridEl'>관광지</a>
				</div>
				<div class='gridTitle'>지역</div>
				<div class='gridContents'>
					<a href="list_city.jsp" class='gridEl'>전체</a>  
					<a href="list_city.jsp?column=item_address&keyword=서울" class='gridEl'>서울</a>        
	                <a href="list_city.jsp?column=item_address&keyword=부산" class='gridEl'>부산</a>
	                <a href="list_city.jsp?column=item_address&keyword=인천" class='gridEl'>인천</a>
	                <a href="list_city.jsp?column=item_address&keyword=대구" class='gridEl'>대구</a>
	                <a href="list_city.jsp?column=item_address&keyword=대전" class='gridEl'>대전</a>
	                <a href="list_city.jsp?column=item_address&keyword=광주" class='gridEl'>광주</a>
	                <a href="list_city.jsp?column=item_address&keyword=울산" class='gridEl'>울산</a>
	                <a href="list_city.jsp?column=item_address&keyword=경기" class='gridEl'>경기도</a>
	                <a href="list_city.jsp?column=item_address&keyword=세종" class='gridEl'>세종</a>
	                <a href="list_city.jsp?column=item_address&keyword=강원" class='gridEl'>강원도</a>
	                <a href="list_city.jsp?column=item_address&keyword=제주" class='gridEl'>제주도</a>
	                <a href="list_city.jsp?column=item_address&keyword=경상북도" class='gridEl'>경상북도</a>
	                <a href="list_city.jsp?column=item_address&keyword=경상남도" class='gridEl'>경상남도</a>
	                <a href="list_city.jsp?column=item_address&keyword=전라남도" class='gridEl'>전라남도</a>
	                <a href="list_city.jsp?column=item_address&keyword=전라북도" class='gridEl'>전라북도</a>
	                <a href="list_city.jsp?column=item_address&keyword=충청남도" class='gridEl'>충청남도</a>
	                <a href="list_city.jsp?column=item_address&keyword=충청북도" class='gridEl'>충청북도</a>               
				</div>
			</div>
		</div>
	</div>
	  
	<!-- 관광지 첫페이지는 인기여행지로 목록에서 12개만 뽑아낸다(조회수 기준)-->
	<br>
	<div class="row center">
	    <span class="item-title">인기 관광지</span>
	</div>

	<!-- 목록 출력 을 위한 변수선언 -->
	<%
		ItemDao itemDao = new ItemDao();
		ItemFileDao itemFileDao = new ItemFileDao();
		
		List<ItemDto> list= itemDao.searchByOrder("item_count_view","item_type","관광지",1, 9);// 인기 관광지 9개 가져오기		
	%>
	 
	 <div class="second">
	 	<div class='gridContainer'>
			<div class='gridBox'>
				<!-- 목록 출력 시작 -->
				<%for(ItemDto itemDto : list){ 
					String tourName = itemDto.getItemName();
					if(tourName.length()>15) tourName=tourName.substring(0,15)+"...";
					//제목이 길면 틀에서 깨지므로,, 15글자로 제한해서 보여준다.
				%>
				<div class='gridEl'>
					<a href="readup.nogari?itemIdx=<%=itemDto.getItemIdx()%>">
	            	<!-- 목록을 보여주면서 itemDto의 itemIdx정보를 받는다. -->
					<%ItemFileDto itemFileDto = itemFileDao.find2(itemDto.getItemIdx());%>
					<%if(itemFileDto == null){ %>
						<!-- 첨부파일이 없다면 대체이미지 보여주기 -->
						<img src="http://placeimg.com/170/170/nature">
					<%}else{ %>
						<!-- 첨부파일이 있다면 첨부파일을 출력  -->
						<img src="file/download.nogari?itemFileIdx=<%=itemFileDto.getItemFileIdx()%>" width="170" height="170">
					<%} %>
						<span class="gridElTitle"><%=tourName %></span>
						<span class="gridElTitle"><%=itemDto.getAdressCity()%>&nbsp;<%=itemDto.getAdressCitySub()%></span>
					</a>
				</div>	
	            <%} %>
			</div>
		</div>
	</div>
	
	<br>
	<div class="row center">
	    <span class="item-title">인기 축제</span>
	</div>

	<!-- 목록 출력 을 위한 변수선언 -->
	<%
		List<ItemDto> list1= itemDao.searchByOrder("item_count_view","item_type","축제",1, 9);// 인기 축제 9개 가져오기		
	%>
	 
	 <div class="second">
	 	<div class='gridContainer'>
			<div class='gridBox'>
				<!-- 목록 출력 시작 -->
				<%for(ItemDto itemDto : list1){
					String festivalName = itemDto.getItemName();
					if(festivalName.length()>15) festivalName=festivalName.substring(0,15)+"...";
					//제목이 길면 틀에서 깨지므로,, 15글자로 제한해서 보여준다.
					%>
				<div class='gridEl'>
					<a href="readup.nogari?itemIdx=<%=itemDto.getItemIdx()%>">
	            	<!-- 목록을 보여주면서 itemDto의 itemIdx정보를 받는다. -->
					<%ItemFileDto itemFileDto = itemFileDao.find2(itemDto.getItemIdx());%>
					<%if(itemFileDto == null){ %>
						<!-- 첨부파일이 없다면 대체이미지 보여주기 -->
						<img src="http://placeimg.com/170/170/nature">
					<%}else{ %>
						<!-- 첨부파일이 있다면 첨부파일을 출력  -->
						<img src="file/download.nogari?itemFileIdx=<%=itemFileDto.getItemFileIdx()%>" width="170" height="170">
					<%} %>
						<span class="gridElTitle"><%=festivalName%></span>
						<span class="gridElTitle"><%=itemDto.getAdressCity()%>&nbsp;<%=itemDto.getAdressCitySub()%></span>
						<span class="gridElTitle"><%=itemDto.getItemPeriod() %></span>
					</a>
				</div>	
	            <%} %>
			</div>
		</div>
	</div>
	
		<br>
	<div class="row center">
	    <span class="item-title">계절별 축제</span>
	</div>
	
	<%
	//계절별 축제를 위해 데이터를 1~5개까지 들고온다.
	List<ItemDto> springList = itemDao.getSeasonItem("03", "04", "05");
	List<ItemDto> summerList = itemDao.getSeasonItem("06", "07", "08");
	List<ItemDto> fallList = itemDao.getSeasonItem("09", "10", "11");
	List<ItemDto> winterList = itemDao.getSeasonItem("12", "01", "02");
	%>
	
	    <!-- 축제 계절별 썸네일 구역-->
	
	<div class="second season-page">
		<div class='gridContainer'>
			<div class="row center">
		<button class="btn">◁</button>
		&nbsp;&nbsp; <span>봄(3월~5월)</span> &nbsp;&nbsp;
		<button class="btn btn-next">▶</button>
		</div>
			<div class='gridBox'>
				<div class="row" id="slide">
					<ul>
				<!-- 목록 출력 시작 -->
				<%if(!springList.isEmpty()){ %>
				<%for(ItemDto itemDto : springList){
					String festivalName = itemDto.getItemName();
					if(festivalName.length()>15) festivalName=festivalName.substring(0,15)+"...";
					//제목이 길면 틀에서 깨지므로,, 15글자로 제한해서 보여준다.
					%>
					<li>
				<div class='gridEl'>
					<a href="readup.nogari?itemIdx=<%=itemDto.getItemIdx()%>">
	            	<!-- 목록을 보여주면서 itemDto의 itemIdx정보를 받는다. -->
					<%ItemFileDto itemFileDto = itemFileDao.find2(itemDto.getItemIdx());%>
					<%if(itemFileDto == null){ %>
						<!-- 첨부파일이 없다면 대체이미지 보여주기 -->
						<img src="http://placeimg.com/170/170/nature">
					<%}else{ %>
						<!-- 첨부파일이 있다면 첨부파일을 출력  -->
						<img src="file/download.nogari?itemFileIdx=<%=itemFileDto.getItemFileIdx()%>" width="170" height="170">
					<%} %>
						<span class="gridElTitle"><%=festivalName%></span>
						<span class="gridElTitle"><%=itemDto.getAdressCity()%>&nbsp;<%=itemDto.getAdressCitySub()%></span>
						<span class="gridElTitle"><%=itemDto.getItemPeriod() %></span>
					</a>
				</div>	
					</li>
	            <%} %>
	              <%}else{ %>
	              <li><h2>해당 계절의 축제가 없습니다.</h2></li>
	              <%} %>
	            	 </ul>
	            </div>
			</div>
		</div>
	</div>
	
	<div class="second season-page">
		<div class='gridContainer'>
			<div class="row center">
			<button class="btn btn-prev">◀</button>
			&nbsp;&nbsp; <span>여름(6월~8월)</span> &nbsp;&nbsp;
			<button class="btn btn-next">▶</button>
			</div>
			<div class='gridBox'>
				<div class="row" id="slide">
					<ul>
				<!-- 목록 출력 시작 -->
				<%if(!summerList.isEmpty()){ %>
				<%for(ItemDto itemDto : summerList){
					String festivalName = itemDto.getItemName();
					if(festivalName.length()>15) festivalName=festivalName.substring(0,15)+"...";
					//제목이 길면 틀에서 깨지므로,, 15글자로 제한해서 보여준다.
					%>
					<li>
				<div class='gridEl'>
					<a href="readup.nogari?itemIdx=<%=itemDto.getItemIdx()%>">
	            	<!-- 목록을 보여주면서 itemDto의 itemIdx정보를 받는다. -->
					<%ItemFileDto itemFileDto = itemFileDao.find2(itemDto.getItemIdx());%>
					<%if(itemFileDto == null){ %>
						<!-- 첨부파일이 없다면 대체이미지 보여주기 -->
						<img src="http://placeimg.com/170/170/nature">
					<%}else{ %>
						<!-- 첨부파일이 있다면 첨부파일을 출력  -->
						<img src="file/download.nogari?itemFileIdx=<%=itemFileDto.getItemFileIdx()%>" width="170" height="170">
					<%} %>
						<span class="gridElTitle"><%=festivalName%></span>
						<span class="gridElTitle"><%=itemDto.getAdressCity()%>&nbsp;<%=itemDto.getAdressCitySub()%></span>
						<span class="gridElTitle"><%=itemDto.getItemPeriod() %></span>
					</a>
				</div>
					</li>
	            <%} %>
	              <%}else{ %>
	              <li><h2>해당 계절의 축제가 없습니다.</h2></li>
	              <%} %>
	            	</ul>
	            </div>
			</div>
		</div>
	</div>
	
	
	<div class="second season-page">
		<div class='gridContainer'>
			<div class="row center">
			<button class="btn btn-prev">◀</button>
			&nbsp;&nbsp; <span>가을(9월~11월)</span> &nbsp;&nbsp;
			<button class="btn btn-next">▶</button>
			</div>
			<div class='gridBox'>
				<div class="row" id="slide">
					<ul>
				<!-- 목록 출력 시작 -->
				<%if(!fallList.isEmpty()){ %>
				<%for(ItemDto itemDto : fallList){
					String festivalName = itemDto.getItemName();
					if(festivalName.length()>15) festivalName=festivalName.substring(0,15)+"...";
					//제목이 길면 틀에서 깨지므로,, 15글자로 제한해서 보여준다.
					%>
					<li>
				<div class='gridEl'>
					<a href="readup.nogari?itemIdx=<%=itemDto.getItemIdx()%>">
	            	<!-- 목록을 보여주면서 itemDto의 itemIdx정보를 받는다. -->
					<%ItemFileDto itemFileDto = itemFileDao.find2(itemDto.getItemIdx());%>
					<%if(itemFileDto == null){ %>
						<!-- 첨부파일이 없다면 대체이미지 보여주기 -->
						<img src="http://placeimg.com/170/170/nature">
					<%}else{ %>
						<!-- 첨부파일이 있다면 첨부파일을 출력  -->
						<img src="file/download.nogari?itemFileIdx=<%=itemFileDto.getItemFileIdx()%>" width="170" height="170">
					<%} %>
						<span class="gridElTitle"><%=festivalName%></span>
						<span class="gridElTitle"><%=itemDto.getAdressCity()%>&nbsp;<%=itemDto.getAdressCitySub()%></span>
						<span class="gridElTitle"><%=itemDto.getItemPeriod() %></span>
					</a>
				</div>
				 </li>	
	            <%} %>
	              <%}else{ %>
	              <li><h2>해당 계절의 축제가 없습니다.</h2></li>
	              <%} %>
	            	</ul>
	            </div>
			</div>
		</div>
	</div>
	
	
	<div class="second season-page">
		<div class='gridContainer'>
			<div class="row center">
			<button class="btn btn-prev">◀</button>
			&nbsp;&nbsp; <span>겨울(12월~2월)</span> &nbsp;&nbsp;
			<button class="btn">▷</button>
			</div>
			<div class='gridBox'>
				<div class="row" id="slide">
					<ul>
				<!-- 목록 출력 시작 -->
				<%if(!winterList.isEmpty()){ %>
				<%for(ItemDto itemDto : winterList){
					String festivalName = itemDto.getItemName();
					if(festivalName.length()>15) festivalName=festivalName.substring(0,15)+"...";
					//제목이 길면 틀에서 깨지므로,, 15글자로 제한해서 보여준다.
					%>
					<li>
				<div class='gridEl'>
					<a href="readup.nogari?itemIdx=<%=itemDto.getItemIdx()%>">
	            	<!-- 목록을 보여주면서 itemDto의 itemIdx정보를 받는다. -->
					<%ItemFileDto itemFileDto = itemFileDao.find2(itemDto.getItemIdx());%>
					<%if(itemFileDto == null){ %>
						<!-- 첨부파일이 없다면 대체이미지 보여주기 -->
						<img src="http://placeimg.com/170/170/nature">
					<%}else{ %>
						<!-- 첨부파일이 있다면 첨부파일을 출력  -->
						<img src="file/download.nogari?itemFileIdx=<%=itemFileDto.getItemFileIdx()%>" width="170" height="170">
					<%} %>
						<span class="gridElTitle"><%=festivalName%></span>
						<span class="gridElTitle"><%=itemDto.getAdressCity()%>&nbsp;<%=itemDto.getAdressCitySub()%></span>
						<span class="gridElTitle"><%=itemDto.getItemPeriod() %></span>
					</a>
				</div>
					</li>
	            <%} %>
	              <%}else{ %>
	              <li><h2>해당 계절의 축제가 없습니다.</h2></li>
	              <%} %>
	            	</ul>
	            </div>
			</div>
		</div>
	</div>
	
	
</div>      


<!-- 관리자에게만 글쓰기 버튼 보여주기 -->
<div>
	<%if(Sessioner.getUsersGrade(request.getSession()) != null && Sessioner.getUsersGrade(request.getSession()).equals(Sessioner.GRADE_ADMIN)) {%>
	<h2><a href="insert.jsp">글쓰기</a></h2>
	<%} %>
</div>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>