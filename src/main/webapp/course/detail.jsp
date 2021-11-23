<%@page import="beans.CourseDao"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
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
<%@page import="util.users.Sessioner"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 메인</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<script src="https://code.jquery.com/jquery-latest.js"></script>
<script src="/resource/css/item/reply.js"></script>
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

        /* 코스 제목*/
        .course-name{
            font-size:40px;
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
        /* float 안에 왼쪽 정렬*/
        .float-container > .float-left{
            font-size: 17px;
            float:left;
        }
        /* float 안에 오른쪽 정렬*/
        .float-container > .float-right{
            font-size:17px;
            font-weight: bold;
            float:right;
        }
        .float-container > .float-btn{
        	font-size:17px;
            border:1px solid black;
            margin: 10px 10px;
            padding:6px 6px;
        }
        /* 코스 내용*/
        .course-detail{
        	padding:10px;
            border-top: 3px solid gray;
        }
		.course-map{
			border-top: 3px solid gray;
		}
        .item-title{
            display:block;
            position:relative;
            top:30px;
            
        }
		
		/* 아이템 썸네일 부분 */
        ul{
        	list-style:none;
        }
        
        .item-link{
            text-decoration:none; 
            color:inherit;
        }
        #slide ul{
            white-space:nowrap; 
            overflow-x: auto; 
            text-align:center;
        }
        
        #slide ul li{
            display:inline-block; 
            padding: 10px 20px; 
            background: #ccc; 
            margin-right:10px;
            margin-bottom: 20px;
        }
        
    </style>

<SECTION>

<!-- 페이지 내용 시작 -->
<%
String root = request.getContextPath();
%>

<%-- 페이지에 필요한 세션, 파라미터값 저장 및 변수 선언 --%>
<%
	//코스번호 받기
	int courseIdx = Integer.parseInt(request.getParameter("courseIdx"));
	
	//코스 내용 및 제목등을 출력하기 위한 단일조회
	CourseDao courseDao = new CourseDao();
	CourseDto courseDto = courseDao.get(courseIdx);

	//글 작성자 아이디 및 닉네임 출력을 위한 단일 조회
	UsersDao usersDao = new UsersDao();
 	UsersDto usersDto = usersDao.get(courseDto.getUsersIdx());

	//로그인 하였는지?  	
	 String usersId = Sessioner.getUsersId(request.getSession());
 	 boolean isLogin = usersId != null;
 	//(본인글인지 확인을 위해)
	 boolean isMyboard = usersId.equals(usersDto.getUsersId());
	
	//회원 등급 변수 저장(관리자만에게만 보이는 수정 삭제 버튼 표시를 위해)
  	//관리자인지?
  	boolean isManager = Sessioner.getUsersGrade(request.getSession()) != null 
  	&& Sessioner.getUsersGrade(request.getSession()).equals(Sessioner.GRADE_ADMIN);
%>

<%-- course_item 및 course의 제목 및 내용 출력을 위한 변수 선언 --%>
<%
//course_item 조회
	CourseItemDao courseItemDao = new CourseItemDao();
	List<CourseItemDto> getItemList = courseItemDao.getByCourse(courseIdx);
	
	//첨부파일을 불러오기위해 변수 선언
	ItemDao itemDao = new ItemDao();
	ItemFileDao itemFileDao = new ItemFileDao();
%>

<%-- 현재 게시글에 대한 댓글 목록 출력 --%>
<%
//댓글 리스트 불러오기
	CourseReplyDao courseReplyDao = new CourseReplyDao();
	List<CourseReplyDto> list = courseReplyDao.listByTreeSort(courseIdx);
%>


<%-- 조회수 증가 기능 (조회수 중복 방지) => 한번이 아니라 다른 회원이 들어올떄마다 조회수를 증가시켜주기 위해 게시물을 클릭시킬떄마다 +1을 해준다.(새로고침 방지)--%>
<%
// 	Set<Integer> boardCountView = (Set<Integer>)request.getSession().getAttribute("boardCountView");
	
// 	if(boardCountView==null){
// 		boardCountView = new HashSet<Integer>();
// 	}
// 	if(boardCountView.add(courseIdx)){
// 		courseDao.readUp(courseIdx,usersIdx);
// 	}
// 	request.getSession().setAttribute("boardCountView", boardCountView);
%>

<!-- 전체 레이아웃 컨테이너 사이즈는 메인에 맞게 조절-->
<div class="container-900 container-center">

    <!-- 작성자 닉네임 및 아이디 왼쪽 정렬 -->
    <div class="row">
        <div class="row float-container">
            <span class="float-left">작성자 : <%=usersDto.getUsersId()%>(<%=usersDto.getUsersNick()%>)</span>
            <%
            if(isMyboard || isManager){
            %>
            <!-- 수정/삭제는 jsp에서도 막아주는 것 이외로 주소로 입력하는 것을 방지하게 위해서 필터로도 막아줘야 한다. -->
			<!-- 댓글 작성자 또는 관리자가 아니라면 버튼이 보여지지 않게 처리 -->
			
            <a href="udpate_sequence.nogari?courseOriginSequnce=<%=courseIdx%>&usersFilterId=<%=usersId%>" class="float-right float-btn">수정</a>
            <a href="delete.nogari?courseSequnce=<%=courseIdx%>&usersFilterId=<%=usersId%>" class="float-right float-btn">삭제</a>
<!--             필터의 파라미터 이름을 동일하게 해주기위해서 파라미터 명을 courseSequnce로 하였다. -->
            <a href="insert_sequence.nogari?usersFilterId=<%=usersId%>" class="float-right float-btn">새글작성</a>
<!--             usersFilterId는 ajax(코스-아이템 등록/수정/삭제) 및 코스 등록, 수정시에 필터처리를 위해서 필요한 인자이다. -->
<!--             최초 시퀀스번호를 생성하고 접속한 사람만이 실질적인 접근 권한이 생긴다. -->

            <%
            }
            %>
        </div>
        
        <div class="top-menu right">
        </div>
        <!-- 코스 제목 가운데 정렬-->
        <div class="row center">
            <span class="course-name"><%=courseDto.getCourseName()%></span><br>
            <!-- 코스 제목 밑에 지역 표시-->
            <%
            int itemIdx = courseItemDao.getItemIdxByCourse(courseIdx);
            ItemDto location = itemDao.get(itemIdx);
            %>
            <span class="course-location"><%=location.getAdressCity()%> &nbsp; <%=location.getAdressCitySub()%></span>
        </div>
        <!-- 조회수 및 좋아요? 왼쪽 정렬 / 작성일자 오른쪽 정렬 -->
        <div class="row float-container">
            <span class="float-left">조회수 : <%=courseDto.getCourseCountView()%> or 좋아요</span>
            <span class="float-right"><%=courseDto.getCourseDate()%></span>
        </div>
    </div>
    <!-- 코스 작성 내용-->
    <div class="row course-detail">
    	<span>[글 작성 내용]</span>
    	<br>
        <span><%=courseDto.getCourseDetail()%></span>
    </div>
    <!-- 지도 표시-->
    <div class="row center course-map">
        <!-- 지도 들어가는곳 이미 임시 추가-->
        <jsp:include page="course_kakaomap.jsp">
		<jsp:param value="<%=courseIdx%>" name="courseIdx"/>
		</jsp:include>
    </div>
    <!-- 코스 목록 썸네일 구역-->
    <div class="row" id="slide">
    <!-- courseItem 목록 출력 -->
        <ul>
		<%for(CourseItemDto courseItemDto : getItemList){ %>
		<%
		ItemDto itemDto = itemDao.get(courseItemDto.getItemIdx());
		ItemFileDto itemFileDto = itemFileDao.find2(itemDto.getItemIdx());
		%>
            <li>
                <span class="item-title"><%=itemDto.getItemName()%></span>
                <a href="<%=root%>/item/detail.jsp?itemIdx=<%=itemDto.getItemIdx()%>" class="item-link">
                    <%if(itemFileDto == null){ %>
					<!-- 첨부파일 출력 -->
					<img src="http://via.placeholder.com/100x100">
					<%
					}else{
					%>
					<!-- 대체 이미지 출력 -->
					<img src="<%=root%>/item/file/download.nogari?itemFileIdx=<%=itemFileDto.getItemFileIdx()%>" width="150px" height="150px">
					<%}	%>
                </a>
            </li>
        <%} %>
        </ul>
    </div>
    <div class="row">
        <div>댓글 구간</div>
    </div>
</div>

<!-- 댓글 -->

<!-- 댓글 작성 공간(댓글부분은 공통CSS가 생기면 그때 작업 -->
<table border="1" width="900px">
	<tbody>
		<tr>
	<%if(isLogin){ %>
		<form action="<%=root%>/course_reply/insert.nogari" method="post">
		<!-- 댓글 작성시 댓글 번호를 숨겨서 보내준다 -->
		<input type="hidden" name="courseIdx" value="<%=courseIdx%>">
			<td>
			<!-- 댓글 등록 내용 -->
			<textarea name="courseReplyDetail" cols="110" rows="5" required></textarea>
			</td>
			<td>
			<!-- 댓글 등록 버튼 -->
			<input type="submit" value="등록">
			</td>
		<%}else{ %>
			<td><h3>로그인 후 댓글 작성이 가능합니다.</h3></td>
		<%} %>
		</tr>
	</tbody>
</table>
</form>

<div class="row center"></div>

<!-- 댓글이 있다면 댓글목록을 출력한다-->
<%
if(!list.isEmpty()){
%>
<table border="1" width="900px">
	<thead>
		<tr>
			<th>아이디 (작성 시간)</th>
			<th>내용</th>
			<th>수정 삭제</th>
		</tr>
	</thead>
	<tbody>
		<!-- 댓글 목록 출력 -->
		<%
		for(CourseReplyDto courseReplyDto : list){
		%>

		<%
		//게시글 작성자를 알기위해 usersDto 선언
				UsersDto usersReplyDto = usersDao.get(courseReplyDto.getUsersIdx());
				
				//게시물 작성자 = 댓글 작성자?
				boolean ownerReply = courseDto.getUsersIdx() == courseReplyDto.getUsersIdx();
				
				//본인 댓글인지 확인
				boolean myReply = usersId.equals(usersReplyDto.getUsersId());
		%>
		
		<tr>
			<td width="35%">
				<!-- 만약 대댓글이라면 -->
				<%if(courseReplyDto.hasDepth()){ //CourseReplyDto에 메소드 추가 %>
					<%for(int i = 0 ; i < courseReplyDto.getCourseReplyDepth() ; i++){ %>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<%} %>
					<!-- 4칸 띄고 대댓글 표시 이미지 출력 -->
					<img src="<%=root%>/resource/image/reply.png" width="20px">
				<%} %>
				<!-- 댓글 작성자 및 닉네임 표시 -->
				<%=usersReplyDto.getUsersId() %>(<%=usersReplyDto.getUsersNick() %>)
				<!-- 게시글 작성자라면 [작성자]라고 표시해준다 -->
				<%if(ownerReply){ %>
					[작성자]
				<%} %>
				<br>
				<!-- 댓글 작성 일자 및 시간 출력 -->
				(<%=courseReplyDto.getCourseReplyTotalDate() %>)
			</td>
			<td>
				<!-- 댓글 내용 출력 -->
				<pre><%=courseReplyDto.getCourseReplyDetail() %></pre>
			</td>
			<td>
				<!-- 댓글 작성자 또는 관리자 에게만 수정, 삭제를 표시 -->
				<%if(myReply || isManager){ %>
				<a href="<%=root %>/course_reply/update.nogari">수정</a>
				<a href="<%=root %>/course_reply/delete.nogari?courseIdx=<%=courseIdx%>&courseReplyIdx=<%=courseReplyDto.getCourseReplyIdx()%>">삭제</a>
			<%} %>
			</td>
		</tr>
		
		<!-- 본인 글일 경우 수정을 위한 공간을 추가적으로 생성(관리자 포함) -->
		<%if(myReply || isManager){ %>
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
		
		<!-- 대댓글 작성 창 -->
		<tr>
			<td colspan="3">
				<form action="<%=root %>/course_reply/insert.nogari" method="post">
					<!-- 대댓글 작성시 courseIdx를 숨겨서 같이 보내준다 -->
					<input type="hidden" name="courseIdx" value="<%=courseIdx %>">
					<!-- 대댓글 확인을 위해 댓글 번호를 같이 보내준다 -->
					<input type="hidden" name="courseReplyIdx" value="<%=courseReplyDto.getCourseReplyIdx() %>">
					<!-- 대댓글 내용 입력 창 -->
					<textarea name="courseReplyDetail" cols="110" rows="5" required></textarea>
					<input type="submit" value="대댓글 등록">
				</form>
			</td>
		</tr>
		<%} %>
	</tbody>
</table>

<!--  댓글이 없다면  -->
<%}else{ %>
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