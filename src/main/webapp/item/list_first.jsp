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
<LINK REL="STYLESHEET" HREF="<%=root%>/resource/css/item/list.css" /> <!-- CSS 첨부 -->
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
    .item-img{
        height:258px;
        width:258px;
    }
    .item-pop{
        padding: 55px;
        margin: 0 auto;
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
  
    </style>

<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
  <!-- 관광지 목록 페이지 시작 -->
    <div class="container-900 container-center">
    <form action="list.jsp">
        <div class="back">
            <div class="search">
                <select name="column" class="search-select">
                    <option value="item_type">카테고리</option>
                    <option value="item_name">제목</option>
                    <option value="item_detail">내용</option>
                </select>
                <input type="text" name="keyword" required class="search-keyword">
                <input type="submit" value="검색" class="search-btn">
            </div>
        </div>
      </form>
      
      
      
         <div class="row center">
            <span class="item-title">국내 여행지</span>
        </div>
        <div class="course-box">
            <div class="menu-bar">
                <span class="course-location">카테고리</span>
                <a href="#" class="course-city">축제</a>        
                <a href="#" class="course-city">관광지</a>
            </div>
        </div>
         <div class="course-box">
            <div class="menu-bar">
                <span class="course-location">지역</span>
                <a href="list_city.jsp?column=item_address&keyword=서울" class="course-city">서울</a>        
                <a href="list_city.jsp?column=item_address&keyword=부산" class="course-city">부산</a>
                <a href="list_city.jsp?column=item_address&keyword=인천" class="course-city">인천</a>
                <a href="list_city.jsp?column=item_address&keyword=대구" class="course-city">대구</a>
                <a href="list_city.jsp?column=item_address&keyword=대전" class="course-city">대전</a>
                <a href="list_city.jsp?column=item_address&keyword=광주" class="course-city">광주</a>
                <a href="list_city.jsp?column=item_address&keyword=울산" class="course-city">울산</a>
            </div>
        </div>
        <div class="course-box">
            <div class="menu-bar">
                <a href="list_city.jsp?column=item_address&keyword=경기" class="course-city">경기도</a>
                <a href="list_city.jsp?column=item_address&keyword=세종" class="course-city">세종</a>
                <a href="list_city.jsp?column=item_address&keyword=강원" class="course-city">강원도</a>
                <a href="list_city.jsp?column=item_address&keyword=제주" class="course-city">제주도</a>
                <a href="list_city.jsp?column=item_address&keyword=경상북도" class="course-city">경상북도</a>
                <a href="list_city.jsp?column=item_address&keyword=경상남도" class="course-city">경상남도</a>
                <a href="list_city.jsp?column=item_address&keyword=전라남도" class="course-city">전라남도</a>
                <a href="list_city.jsp?column=item_address&keyword=전라북도" class="course-city">전라북도</a>
            </div>
        </div>
        <div class="course-box">
            <div class="menu-bar">
                <a href="list_city.jsp?column=item_address&keyword=충청남도" class="course-city">충청남도</a>
                <a href="list_city.jsp?column=item_address&keyword=충청북도" class="course-city">충청북도</a>
            </div>
        </div>

<%
		ItemDao itemDao = new ItemDao();
		ItemFileDao itemFileDao = new ItemFileDao();
		
		List<ItemDto> list= itemDao.list(1, 12);// 12개 가져오기
		
		
		%>

        <!-- 인기순 보여주기(조회수 기준)-->
        <div class="row center">
            <span class="item-title">인기 여행지</span>
        </div>
        <div class="row left">
            <div class="row item-pop">
            	<%for(ItemDto itemDto : list){ %>
            <div style="display: inline-block;">
            	<!-- 목록을 보여주면서 itemDto의 itemIdx정보를 받는다. -->
				<%ItemFileDto itemFileDto = itemFileDao.find2(itemDto.getItemIdx());%>
				<a href="detail.jsp?itemIdx=<%=itemDto.getItemIdx()%>">
				<%if(itemFileDto == null){ %>
								<!-- 첨부파일이 없다면 대체이미지 보여주기 -->
								<img src="http://via.placeholder.com/300x300" class="item-img">
						<%}else{ %>
								<!-- 첨부파일이 있다면 첨부파일을 출력  -->
								<img src="file/download.nogari?itemFileIdx=<%=itemFileDto.getItemFileIdx()%>" class="item-img">
						<%} %>
					</a>
						<label style="display: block; text-align: center"><%=itemDto.getItemName() %></label>
				</div>	
                <%} %>
            </div>
        </div>
    </div>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>