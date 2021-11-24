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
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<%String root = request.getContextPath();%>
<script src="<%=root%>/resource/js/reply.js"></script>

<style>
*{
	box-sizing: border-box;
}        
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
/* 코스 제목*/
.course-name{
    font-size:40px;
    border-bottom:3px solid black;
}
/* 코스 제목 밑에 지역 및 코스 총 거리 (총거리는 계산할수 있으면 추가)*/
.course-location{
    color:gray;
    font-size: 25px;
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

    margin-right:10px;
    margin-bottom: 20px;
}

	


textarea {
    resize:none;
}
.form-input,
.form-btn {
    width: 100%;
    font-size: 20px;
    padding: 10px;
}
        
.form-input {
    border: 1px solid rebeccapurple;
}

.form-btn {
    color: rgb(77, 25, 25);
    background-color: rgb(232, 193, 125);
    font-weight: bold;
    height: 90%;
}
.form-btn:hover{
 color: red;
}

.form-block {
    display: block;
}

.form-inline {
    width: auto;
}

.form-in {
   display: inline;
}
   
.flex-container{
	display: flex;
}
.flex-container > .flex-reply-write-wrapper{
    flex-grow: 3;
}
.flex-container > .flex-reply-btn-wrapper{
    flex-grow: 1;
    margin-top: auto;
    margin-bottom: auto;
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


.table.table-border > thead > tr > th, 
.table.table-border > thead > tr > td,
.table.table-border > tbody > tr > th,
.table.table-border > tbody > tr > td,
.table.table-border > tfoot > tr > th,
.table.table-border > tfoot > tr > td {
    border:1px solid black;

}

.table.table-border {
    border:1px solid black;
    border-collapse: collapse;

}


.form-link-btn
{
    border:1px solid;
    background-color:rgb(232, 193, 125);
    text-decoration: none;
    color:rgb(77, 25, 25);
    padding:0.1rem 0.1rem;
    font-size:20px;
    margin: 0 0;
}
.form-link-btn:hover {
	border-color:red;
	color:red;
}
.flex-container > .reply-write-wrapper {
	width:80%;
}
.flex-container > .reply-send-wrapper {
	flex-grow:1;
}
.flex-container > .reply-send-wrapper > .form-btn,
.flex-container > .reply-send-wrapper > .form-link-btn {
	width:100%;
	height:93%;
	display: flex;
	align-items:center;
	justify-content:center;
}

.gapy{
	margin-top: 2rem;
	margin-bottom: 2rem;
}
    </style>

<SECTION>

<!-- 페이지 내용 시작 -->


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
	 boolean isMyboard; 
 	if(isLogin)
 	isMyboard = usersId.equals(usersDto.getUsersId());
 	else//로그인이 되어있지 않다면,
 	isMyboard = false;
 	
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


<!-- 전체 레이아웃 컨테이너 사이즈는 메인에 맞게 조절-->
<div class="container-900 container-center">

    <!-- 작성자 닉네임 및 아이디 왼쪽 정렬 -->
    <div class="row">
        <div class="row float-container">
            <span class="float-left">작성자 : <%=usersDto.getUsersId()%>(<%=usersDto.getUsersNick()%>)</span>
            <%
            int itemIdx = courseItemDao.getItemIdxByCourse(courseIdx);
            ItemDto location = itemDao.get(itemIdx);
            //코스의 지역표시 및 수정시에 사용자가 편하게 동일 지역을 수정할 수 있게 지역 파라미터 정보를 넘겨준다.
            String paramCity = location.getAdressCity();
            if(paramCity.length() != 4) paramCity=paramCity.substring(0,2);
            //전라북도 등 북도 남도만 그대로 보내고 나머지는 2글자만 보내겠다.
            %>
            
            <%
            if(isMyboard || isManager){
            %>
			<!-- 댓글 작성자 또는 관리자가 아니라면 버튼이 보여지지 않게 처리 -->
			
<!-- 			수정시에는 수정용 시퀀스가 생성되는데 기존 이 코스에 대한 코스 정보도 가지고 있어야하므로 현재 해당 코스번호를 courseOriginSequnce로 표시하여 넘긴다. -->
<!--            수정을 편하게 하기위해서 컬럼과 키워드를 보내서 같은 지역에서 수정이 가능하게 보여준다.(수정시에는 다른 지역으로 변경 불가) -->
            <a href="udpate_sequence.nogari?courseOriginSequnce=<%=courseIdx%>&column=item_address&keyword=<%=paramCity%>" class="float-right float-btn">수정</a>
<!--             필터의 파라미터 이름을 동일하게 해주기위해서 파라미터 명을 courseSequnce로 하였다. -->
            <a href="delete.nogari?courseSequnce=<%=courseIdx%>" class="float-right float-btn">삭제</a>
<!--             글작성을 하면, 시퀀스를 생성하여 가기때문에 서블릿으로 먼저 이동한다. -->
            <a href="insert_sequence.nogari" class="float-right float-btn">새글작성</a>

            <%}else{ %>
            <a href="<%=root %>/course/list.jsp" class="float-right float-btn">목록으로</a>
            <%} %>
        </div>
        
        <div class="top-menu right">
        </div>
        <!-- 코스 제목 가운데 정렬-->
        <div class="row center">
            <span class="course-name"><%=courseDto.getCourseName()%></span><br>
            <!-- 코스 제목 밑에 지역 표시-->
            <span class="course-location"><%=location.getAdressCity()%></span>
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
		String courseItemName = itemDto.getItemName();
		if(courseItemName.length()>13) courseItemName=courseItemName.substring(0,13)+"..";
		//제목이 길면 틀에서 깨지므로,, 15글자로 제한해서 보여준다.
		%>
            <li>
                <span class="item-title"><%=courseItemName%></span>
                <a href="<%=root%>/item/detail.jsp?itemIdx=<%=itemDto.getItemIdx()%>" class="item-link">
                    <%if(itemFileDto == null){ %>
					<!-- 첨부파일 출력 -->
					<img src="http://placeimg.com/150/150/nature">
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
 

<!-- 댓글 표시 -->


<div class="row center">
	<h3>[댓글 목록]</h3>
</div>

<!-- 댓글 리스트 -->
	<div class="row center gapy">
		<table class="table table-border">
			<!-- 만약 댓글이 있다면 -->
			<%if(!list.isEmpty()){%>
				<!-- 댓글 목록 출력 -->
				<%for(CourseReplyDto courseReplyDto : list){%>
					<tbody>
						<%
						//게시글 작성자를 알기위해 usersDto 선언
						UsersDto usersReplyDto = usersDao.get(courseReplyDto.getUsersIdx());
						
						//게시물 작성자 = 댓글 작성자라면 댓글 아이디 옆에(글쓴이라고 표시를 위해)
						boolean ownerReply = courseDto.getUsersIdx() == courseReplyDto.getUsersIdx();
						
						//본인 댓글인지 확인
						boolean myReply = usersId.equals(usersReplyDto.getUsersId());
						%>
						
						<tr class="view-row">
							<td width="35%" class="left">
								<!-- 대댓글이라면 표시해주어라 -->
								<%if(courseReplyDto.hasDepth()){ //CourseReplyDto에 메소드 추가 %>
									<%for(int i = 0 ; i < courseReplyDto.getCourseReplyDepth() ; i++){ %>
									&nbsp;&nbsp;&nbsp;&nbsp;
									<%} %>
									<!-- 4칸 띄고 대댓글 표시 이미지 출력 -->
									<img src="<%=root%>/resource/image/reply.png" width="20px">
								<%} %>
								<!-- 댓글 작성자 및 닉네임 표시 -->
								<%=usersReplyDto.getUsersId() %>(<%=usersReplyDto.getUsersNick() %>)
								<!-- 게시물의 작성자가 댓글 작성자 -->
								<%if(ownerReply){ %>
									<!-- 게시물의 작성자라면 아이디 옆에 (글쓴이를 표시해준다) -->
									<span>(글쓴이)</span>
								<%} %>
							<!-- 날짜 표시 -->
							<br>(<%=courseReplyDto.getCourseReplyTotalDate() %>)
							</td>
							
							
							<td class="left">
							<!-- 댓글 내용 -->
							<%=courseReplyDto.getCourseReplyDetail() %>
							</td>
							
							<!-- 댓글 작성자이거나 관리자의 경우 수정 삭제가 가능하다. -->
							<td width="17%">
							<%if(isLogin){ %>
								<a class="reply-btn form-link-btn form-line">대댓글</a>
							<%} %>
							<%if(myReply || isManager){ %>
								<a class="edit-btn form-link-btn form-line">수정</a>
								<a href="<%=root %>/course_reply/delete.nogari?courseIdx=<%=courseIdx%>&courseReplyIdx=<%=courseReplyDto.getCourseReplyIdx()%>" class="form-link-btn form-line">삭제</a>
								
							<%} %>
							</td>
						</tr>
						
						<!-- 수정 창(각 댓글마다 수정 칸을 숨겨준다. ) -->
						<!-- 댓글 작성자이거나 관리자의 경우 수정 입력이 가능하다. -->
						<tr class="edit-row">
						<%if(myReply || isManager){ %>
							<td colspan="3">
								<!-- 댓글 수정시 댓글 수정에 필요한 itemIdx와 itemReplyIdx를 숨겨서 보내준다 -->
								<form action="<%=root %>/course_reply/edit.nogari" method="post">
									<input type="hidden" name="courseReplyIdx" value="<%=courseReplyDto.getCourseReplyIdx() %>">
									<input type="hidden" name="courseIdx" value="<%=courseIdx %>">
									
									<!-- 댓글 수정 내용 -->
									<div class="flex-container">
										<div class="reply-write-wrapper">
											<textarea name="courseReplyDetail" cols="110" rows="5" required class="form-input"><%=courseReplyDto.getCourseReplyDetail() %></textarea>
										</div>
										<!-- 댓글 수정 버튼 -->
										<div class="reply-send-wrapper" height="100%">
											<input type="submit" value="수정" class="form-btn">
										</div>
										<!-- 취소 버튼 -->
										<div class="reply-send-wrapper">
											<a class="edit-cancel-btn form-link-btn">취소</a>
										</div>
									</div>
								</form>
							</td>
						</tr>
						<%} %>	
						
						<!-- 자바스크립트를 배우고 나서 이부분을 수정한다. -->
						
						<!-- 대댓글 창 -->
						<tr class="reply-row">
							<td colspan="3">
								<!-- 대댓글 입력시 필요한 itemIdx와 itemReplyTargetIdx(대댓글시 상위 댓글번호가 필요)를 숨겨서 보낸다 -->
								<form action="<%=root %>/course_reply/insert.nogari" method="post">
									<!-- 대댓글 작성시 courseIdx를 숨겨서 같이 보내준다 -->
									<input type="hidden" name="courseIdx" value="<%=courseIdx %>">
									<!-- 대댓글 확인을 위해 댓글 번호를 같이 보내준다 -->
									<input type="hidden" name="courseReplyIdx" value="<%=courseReplyDto.getCourseReplyIdx() %>">
										<div class="flex-container">
											<!-- 대댓글 내용 -->
											<div class="reply-write-wrapper">
												<textarea name="courseReplyDetail" cols="110" rows="5" required class="form-input"></textarea>
											</div >
											<!-- 대댓글 등록 버튼 -->
											<div class="reply-send-wrapper">
												<input type="submit" value="대댓글" class="form-btn">
											</div>
											<!-- 대댓글 취소 버튼 -->
											<div class="reply-send-wrapper">
												<a class="reply-cancel-btn form-link-btn">취소</a>
											</div>
										</div>	
								</form>
							</td>
						</tr>
						
				</tbody>
			<%}%>
		</table>
	</div>
	
<!--테이블 정보 종료지점 -->	
			<%}else{%>
				<h3 align="center gapy">댓글이 없습니다.</h3>
			<%} %>

<!-- 댓글 등록 -->
<div class="row center gapy">
	<h3>[댓글 작성]</h3>
</div>
	
	<!-- 댓글작성란 -->
	<%if(isLogin){ %>
		<form action="<%=root%>/course_reply/insert.nogari" method="post">
			<!-- 댓글 작성시 댓글 번호를 숨겨서 보내준다 -->
			<input type="hidden" name="courseIdx" value="<%=courseIdx%>">
				<div class="row center">
					<div class="flex-container">
						<div class="reply-write-wrapper">
							<textarea name="courseReplyDetail" cols="110" rows="3" required class="form-input"></textarea>
						</div>
						<div class="reply-send-wrapper">
							<input type="submit" value="댓글 작성" class="form-btn">
						</div>
					</div>
				</div>
		</form>
	<%}else{ %>
		<div class="row center">
			<h3 align="center gapy">로그인 후 댓글 작성이 가능합니다.</h3>
		</div>
	<%} %>	
	</div>
   
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>