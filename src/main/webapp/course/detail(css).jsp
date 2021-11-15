<%@page import="beans.UsersDto"%>
<%@page import="beans.UsersDao"%>
<%@page import="beans.CourseDto"%>
<%@page import="beans.CourseReplyDto"%>
<%@page import="beans.CourseReplyDao"%>
<%@page import="beans.ItemFileDto"%>
<%@page import="beans.ItemFileDao"%>
<%@page import="beans.ItemDto"%>
<%@page import="beans.ItemDao"%>
<%@page import="beans.CourseItemDto"%>
<%@page import="java.util.List"%>
<%@page import="beans.CourseItemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 메인</TITLE>
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

        /* 작성자*/
        .course-users {
            font-size:13px;
            font-weight:bold;
        }
        /* 코스 제목*/
        .course-name{
            font-size:30px;
            border-bottom:3px solid black;
        }
        /* 코스 제목 밑에 지역 및 코스 총 거리 (총거리는 계산할수 있으면 추가)*/
        .course-location{
            color:gray;
            font-size: 12px;
            text-align: center;
        }
        /* float 만들기 */
        .float-container::after {
            content:"";
            display: block;
            clear: both;
        }
        /* float 안에 조회수 왼쪽 정렬*/
        .float-container > .course-count{
            font-size: 12px;
            float:left;

        }
        /* float 안에 작성일자 오른쪽 정렬*/
        .float-container > .course-date{
            font-size:12px;
            font-weight: bold;
            float:right;
        }
        /* 코스 내용*/
        .course-detail{
            
        }
        /* 리스트 스타일 none 부여하여 항목 앞에 점을 없앤다*/
       .slide-menu, .slide-menu ul{
           list-style: none;
        }

        .slide-menu, .slide-menu ul, .slide-menu li{ /* 2 */
            padding:auto;
            margin:auto;
        }
        /* flex 속성을 부여하여 가로 정렬 */
        .slide-menu{ /* 3 */
            display:flex;
        }
        .slide-menu > li{ /* 4 */
            width: 100px;
        }
        .slide-menu li{ /* 5 */
            position:relative
        }
        .slide-menu ul{ /* 5 */
            position: absolute;
            top:45px;
            left:0;
        }
        /* 사진 안에 관광지 제목 */
        .slide-menu li > .item-name{ /* 6 */
            color:black;
            position:absolute;
            z-index: 1;
            top: 66px;
            right:-16px;
        
        }
        /* 모든 서브메뉴를 숨겼다가 마우스 올라가면 표시되도록 설정 */
        .slide-menu ul {
            display:none;
        }
        /* 마우스가 올라가면 관광지 내용을 보여주기 위한 표 생성*/
        .slide-menu > li:hover > ul{
            display:block;
            border:1px solid black;
        }

    </style>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
 
<SECTION>

<!-- 페이지 내용 시작 -->
<% String root = request.getContextPath(); %>
<!-- 세션 받기 -->
<%
int courseIdx = Integer.parseInt(request.getParameter("courseIdx"));
int usersIdx = (int)request.getSession().getAttribute("usersIdx");
%>

<%
CourseItemDao courseItemDao = new CourseItemDao();
List<CourseItemDto> getItemList = courseItemDao.getByCourse(courseIdx);

ItemDao itemDao = new ItemDao();
ItemFileDao itemFileDao = new ItemFileDao();
%>

<%-- 현재 게시글에 대한 댓글 목록 출력 --%>
<%
	//댓글 게시물 작성자 확인을 위한 courseDto 선언
	CourseDto courseDto = new CourseDto();
	//댓글 리스트 불러오기
	CourseReplyDao courseReplyDao = new CourseReplyDao();
	List<CourseReplyDto> list = courseReplyDao.listByTreeSort();
%>

  <!-- 전체 레이아웃 컨테이너 사이즈는 메인에 맞게 조절-->
    <div class="container-900 container-center">

        <!-- 상단 레이아웃 시작-->
        <!-- 작성자 닉네임 및 아이디 왼쪽 정렬 -->
        <div class="row">
            <div class="row left">
                <span class="course-users"><%=courseDto.getUsersIdx() %></span>
            </div>
            <!-- 코스 제목 가운데 정렬-->
            <div class="row center">
                <span class="course-name">코스 제목</span><br>
                <!-- 코스 제목 밑에 지역 표시-->
                <span class="course-location">지역 | 코스 총거리?</span>
            </div>
            <!-- 조회수 및 좋아요? 왼쪽 정렬 / 작성일자 오른쪽 정렬 -->
            <div class="row float-container">
                <span class="course-count">조회수 or 좋아요</span>
                <span class="course-date right">작성 일자</span>
            </div>
        </div>
        <!-- 코스 작성 내용-->
        <div class="row">
            <span class="course-detail">Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.</span>
        </div>
        <!-- 지도 표시-->
        <div class="row center">
            <!-- 지도 들어가는곳 이미 임시 추가-->
            <img src="http://via.placeholder.com/850x300">
        </div>
        <!-- 코스 목록 썸네일 구역-->
        <div class="row">
            <ul class="slide-menu">
                <li>
                    <span class="item-name">관광지 제목</span>
                    <a href="#" class="item-img-link">
                        <img src="http://via.placeholder.com/150x150">
                    </a>
                    <ul>
                        <li>
                            <img src="http://via.placeholder.com/150x150">
                            <span>like Aldus PageMaker including versions of Lorem Ipsum.</span>
                        </li>
                    </ul>
                </li>
                <li>
                    <span class="item-name">관광지 제목</span>
                    <a href="#" class="item-img-link">
                        <img src="http://via.placeholder.com/150x150">
                    </a>
                    <ul>
                        <li><a href="#">항목1</a></li>
                    </ul>
                </li>
                <li>
                    <span class="item-name">관광지 제목</span>
                    <a href="#" class="item-img-link">
                        <img src="http://via.placeholder.com/150x150">
                    </a>
                    <ul>
                        <li><a href="#">항목1</a></li>
                    </ul>
                </li>
                <li>
                    <span class="item-name">관광지 제목</span>
                    <a href="#" class="item-img-link">
                        <img src="http://via.placeholder.com/150x150">
                    </a>
                    <ul>
                        <li><a href="#">항목1</a></li>
                    </ul>
                </li>
            </ul>
        </div>
        <div class="row">
            <div>댓글 구간</div>
        </div>
    </div>
    
<h3><a href="delete.nogari?courseIdx=<%=courseIdx%>">삭제</a></h3>
<h1>현재 코스의 아이템 목록 보여주기</h1>
		<table border="1" width="900px">
			<tr>
				<th>코스 번호</th>
				<th>관광지 번호</th>
				<th>관광지 작성자</th>
				<th>관광지 사진</th>
				<th>관광지 지역</th>
			</tr>
<%for(CourseItemDto courseItemDto : getItemList){ %>
		<%
		ItemDto itemDto = itemDao.get(courseItemDto.getItemIdx());
		ItemFileDto itemFileDto = itemFileDao.find2(itemDto.getItemIdx());
		%>
			<tr>
				<td><%=courseItemDto.getCourseIdx()%></td>
				<td><%=itemDto.getItemIdx()%></td>
				<td><%=itemDto.getUsersIdx()%></td>
				<td width="30%">
				<%-- 첨부파일이 있다면 --%>
						<%if(itemFileDto == null){ %>
								 <img src="http://via.placeholder.com/100x100">
						<%}else{ %>
								<img src="<%=root%>/item/file/download.nogari?itemFileIdx=<%=itemFileDto.getItemFileIdx()%>" width="150px" height="150px">
						<%} %>
				</td>
				<td><%=itemDto.getItemAddress()%></td>
			</tr>
<%} %>
		</table>
		<div>		
		<jsp:include page="course_kakaomap.jsp">
			<jsp:param value="<%=courseIdx%>" name="courseIdx"/>
		</jsp:include>
		</div>

<!-- 페이지 내용 끝. -->
<br><br>

<!-- 댓글 -->

<!-- 댓글 작성 공간 -->
<form action="<%=root %>/course_reply/insert.nogari" method="post">
<input type="hidden" name="courseIdx" value="<%=courseIdx %>">
<table border="1" width="900px">
	<tbody>
		<tr>
			<td>
			<textarea name="courseReplyDetail" cols="110" rows="5" required></textarea>
			</td>
			<td>
			<input type="submit" value="등록">
			</td>
		</tr>
	</tbody>
</table>
</form>


<%if(!list.isEmpty()){ %>
<!-- 댓글이 있다면 -->
<table border="1" width="900px">
	<thead>
		<tr>
			<th>아이디 (작성 시간)</th>
			<th>내용</th>
			<th>수정 삭제</th>
		</tr>
	</thead>
	<tbody>
		<%for(CourseReplyDto courseReplyDto : list){ %>

		<% 
		//게시글 작성자를 알기위해 usersDto 선언
		UsersDao usersDao = new UsersDao();
		UsersDto usersDto = usersDao.get(courseReplyDto.getUsersIdx());
		
		//게시물 작성자 = 댓글 작성자?
		boolean ownerReply = courseDto.getUsersIdx() == courseReplyDto.getUsersIdx();
		
		//본인 댓글인지 확인
		boolean myReply = usersIdx == courseReplyDto.getUsersIdx();
		%>
		
		<tr>
			<td width="35%">
				<%if(courseReplyDto.hasDepth()){ //CourseReplyDto에 메소드 추가 %>
					<%for(int i = 0 ; i < courseReplyDto.getCourseReplyDepth() ; i++){ %>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<%} %>
				<img src="<%=root%>/resource/image/reply.png" width="20px">
			<%} %>
			
			<%=usersDto.getUsersId() %>(<%=usersDto.getUsersNick() %>)
			<%-- 게시글 작성자라면 [작성자]라고 표시해준다 --%>
			<%if(ownerReply){ %>
				[작성자]
			<%} %>
			<br>
			(<%=courseReplyDto.getCourseReplyTotalDate() %>)
			</td>
			<td>
			<pre><%=courseReplyDto.getCourseReplyDetail() %></pre>
			</td>
			<td>
			<%-- 댓글 작성자 에게만 수정, 삭제를 표시 --%>
			<%if(myReply){ %>
			<a href="<%=root %>/course_reply/update.nogari">수정</a>
			<a href="<%=root %>/course_reply/delete.nogari?courseIdx=<%=courseIdx%>&courseReplyIdx=<%=courseReplyDto.getCourseReplyIdx()%>">삭제</a>
			<%} %>
			</td>
		</tr>
		
		<%-- 본인 글일 경우 수정을 위한 공간을 추가적으로 생성 --%>
		<%if(myReply){ %>
		<tr>
			<td colspan="3">
				<form action="<%=root %>/course_reply/edit.nogari" method="post">
					<input type="hidden" name="courseReplyIdx" value="<%=courseReplyDto.getCourseReplyIdx() %>">
					<input type="hidden" name="courseIdx" value="<%=courseIdx %>">
					<textarea name="courseReplyDetail" cols="110" rows="5" required><%=courseReplyDto.getCourseReplyDetail() %></textarea>
					<input type="submit" value="수정">
				</form>
			</td>
		</tr>
		<%} %>
		
		<%-- 대댓글 작성 창 --%>
		<tr>
			<td colspan="3">
				<form action="<%=root %>/course_reply/insert.nogari" method="post">
				<input type="hidden" name="courseIdx" value="<%=courseIdx %>">
				
				<%-- 대댓글 확인을 위해 댓글 번호를 같이 보내준다 --%>
				<input type="hidden" name="courseReplyIdx" value="<%=courseReplyDto.getCourseReplyIdx() %>">
				
				<textarea name="courseReplyDetail" cols="110" rows="5" required></textarea>
				<input type="submit" value="대댓글 등록">
				</form>
			</td>
		</tr>
	<%} %>
	</tbody>
</table>
<%}else{ %>

<!--  댓글이 없을 경우  -->
<table border="1" width="900px">
	<tbody>
		<tr>
			<td>작성된 댓글이 없습니다.</td>
		</tr>
	</tbody>
</table>
<%} %>

</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>