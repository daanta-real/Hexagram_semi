<%@page import="beans.UsersDao"%>
<%@page import="beans.UsersDto"%>
<%@page import="beans.EventReplyDto"%>
<%@page import="java.util.List"%>
<%@page import="beans.EventReplyDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="util.HexaLibrary" %>

<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page import="util.users.Sessioner" %>
<%@ page import="system.Settings"%>

<%@ page import="beans.EventDto"%>
<%@ page import="beans.EventDao"%>
<%@ page import="beans.EventFileDto"%>
<%@ page import="beans.EventFileDao"%>

<%

// 1. 변수준비
String root = request.getContextPath();
Sessioner sessioner = new Sessioner(session);

// 2. 상세 조회할 글의 idx 검사
String eventIdxStr = request.getParameter("eventIdx");
if(eventIdxStr == null) throw new Exception(); // idx 미입력 시 날려버리기

// 3. 해당 idx의 이벤트 DTO 조회
Integer eventIdx = Integer.parseInt(eventIdxStr);
System.out.println("[이벤트 - 상세보기] idx: " + eventIdx);
EventDao eventDao = new EventDao();
EventDto eventDto = eventDao.get(eventIdx);
System.out.println("[이벤트 - 상세보기] DTO 내용: " + eventDto);

	//글 작성자 아이디 및 닉네임 출력을 위한 단일 조회
	UsersDao usersDao = new UsersDao();
	UsersDto usersDto = usersDao.get(eventDto.getUsersIdx());

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

<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 이벤트 상세보기</TITLE>
<%/*템플릿*/%>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
<%/*CSS들*/%>
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/detail.css">
<style type='text/css'>
.boardContainer { --board-grid-columns: 3rem minmax(20rem, 1fr); font-size:1rem; }
.boardContainer .title { font-size:1.5rem; }
.boardContainer .id { font-size:0.7rem; }
.boardContainer .content { font-weight:initial; justify-content: flex-start; min-height: 10rem; }

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
	margin-left: 0.3rem;
		    border-radius: 0.5rem;
		    padding: 0.05rem 0.6rem;
		    box-shadow: 0 0 1rem #8882;
		    color: hsl(0, 50%, 20%);
		    background: hsl(34, 60%, 70%);
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
    border: 1px solid #0002;
}

.form-btn {
    margin-left: 0.3rem;
    border-radius: 0.5rem;
    padding: 0.05rem 0.6rem;
    box-shadow: 0 0 1rem #8882;
    color: hsl(0, 50%, 20%);
    background: hsl(34, 60%, 70%);
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
    border:1px solid #0002;

}

.table.table-border {
    border:1px solid black;
    border-collapse: collapse;

}


.form-link-btn{
    margin-left: 0.2rem;
    border-radius: 0.5rem;
    padding: 0.05rem 0.6rem;
    box-shadow: 0 0 1rem #8882;
    color: hsl(0, 50%, 20%);
    background: hsl(34, 60%, 70%);
    width:25%;
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
	border:1px solid #0002;
	margin-left: 0.3rem;
}

.gapy{
	margin-top: 2rem;
	margin-bottom: 2rem;
}

.like-clicked{
	color: red;
}

.mainImage {
    max-width: 35rem;
}

</style>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="<%=root%>/resource/js/reply.js"></script>
<script type='text/javascript'>
function confirmDelete(eventIdx) {
	if(confirm("삭제하시겠어요?")) location.href = "<%=root%>/event/delete.nogari?eventIdx=" + eventIdx;
}
</script>
</HEAD>

<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->

<table class='boardContainer'><tbody class='boardBox'>

	<tr class='row'>
		<th>제목</th>
		<td class='flexCenter'>
			<div>No. <%=eventDto.getEventIdx() %></div>
			<span>&nbsp;</span>
			<div class='title'>"<%=eventDto.getEventName() %>"</div>
			<span>&nbsp;</span>
			<div>(<%=eventDto.getEventDate() %>)</div>
		</td>
	</tr>
	
	<tr class='row'>
		<th>작성자</th>
		<td>
			<span class='nick'><%=eventDto.getUsersNick() %></span>
			<span>&nbsp;</span>
			<span class='id'>(<%=eventDto.getUsersId()%>)</span>
		</td>
	</tr>
	
	<tr class='row'>
		<th>조회</th>
		<td>
			<span>조회 <%=eventDto.getEventCountView() %></span>
			<span>&nbsp;/&nbsp;</span>
			<span>댓글 <%=eventDto.getEventCountReply()%></span>
		</td>
	</tr>
	
	<tr class='row'>
		<th>내용</th>
		<th class='content flexCol' style="display:flex;">
			<%
			// 이미지가 있을 경우 이미지를 글 상단에 출력
			EventFileDto file = new EventFileDao().get(eventIdx);
			if(file != null) {
				%><div><img class='mainImage' src="<%=root %>/img.nogari?img_type=<%=file.getEventFileType() %>&img_src=<%=file.getEventFileSaveName() %>" /></div><%
			}
			%>
			<div><%=eventDto.getEventDetail() %></div>
		</th>
	</tr>
	
</tbody>

<tfoot class='boardBox'>

	<tr class='boardBox'>
		<td colspan=2>
		<td class="flexCenter flexCol">
			<a class="bottomLongBtn" href="<%=root%>/event/list.jsp">목록</a>
			<%if(Sessioner.getUsersGrade(request.getSession()) != null && Sessioner.getUsersGrade(request.getSession()).equals(Sessioner.GRADE_ADMIN)) {%>
				<a class="bottomLongBtn" href="<%=root%>/event/modify.jsp?eventIdx=<%=eventDto.getEventIdx()%>">수정</a>
				<button class="bottomLongBtn" onclick='confirmDelete(<%=eventDto.getEventIdx()%>)'>삭제</button>
			<%} %>
		</td>
	</tr>

</tfoot>

</table>			
	
<div class="container-900 container-center"><!-- 댓글 리스트 -->
	<div class="row center">
	<h3>[댓글 목록]</h3>
	</div>
	
<%
//댓글 리스트 불러오기
	EventReplyDao eventReplyDao = new EventReplyDao();
	List<EventReplyDto> list = eventReplyDao.listByTreeSort(eventIdx);
%>


	<div class="row center gapy">
		<table class="table table-border">
			<!-- 만약 댓글이 있다면 -->
			<%if(!list.isEmpty()){%>
				<!-- 댓글 목록 출력 -->
				<%for(EventReplyDto eventReplyDto : list){%>
					<tbody>
						<%
						//게시글 작성자를 알기위해 usersDto 선언
						UsersDto usersReplyDto = usersDao.get(eventReplyDto.getUsersIdx());
						
						//게시물 작성자 = 댓글 작성자라면 댓글 아이디 옆에(글쓴이라고 표시를 위해)
						boolean ownerReply = eventDto.getUsersIdx() == eventReplyDto.getUsersIdx();
						
						//본인 댓글인지 확인
						boolean myReply;
						if(isLogin){
							myReply = usersId.equals(usersReplyDto.getUsersId());
						}else{
							myReply = false;
						}
						%>
						
						<tr class="view-row">
							<td width="25%" class="left">
								<!-- 대댓글이라면 표시해주어라 -->
								<%if(eventReplyDto.hasDepth()){ //CourseReplyDto에 메소드 추가 %>
									<%for(int i = 0 ; i < eventReplyDto.getEventReplyDepth() ; i++){ %>
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
							<br>(<%=eventReplyDto.getItemReplyTotalDate() %>)
							</td>
							
							
							<td class="left">
							<!-- 댓글 내용 -->
							<%=eventReplyDto.getEventReplyDetail() %>
							</td>
							
							<!-- 댓글 작성자이거나 관리자의 경우 수정 삭제가 가능하다. -->
							<td width="25%">
							<%if(isLogin){ %>
								<a class="reply-btn form-link-btn form-line">대댓글</a>
							<%} %>
							<%if(myReply || isManager){ %>
								<a class="edit-btn form-link-btn form-line">수정</a>
								<a href="<%=root %>/event_reply/delete.nogari?eventIdx=<%=eventIdx%>&eventReplyIdx=<%=eventReplyDto.getEventReplyIdx()%>" class="form-link-btn form-line">삭제</a>
								
							<%} %>
							</td>
						</tr>
						
						<!-- 수정 창(각 댓글마다 수정 칸을 숨겨준다. ) -->
						<!-- 댓글 작성자이거나 관리자의 경우 수정 입력이 가능하다. -->
						<tr class="edit-row">
						<%if(myReply || isManager){ %>
							<td colspan="3">
								<!-- 댓글 수정시 댓글 수정에 필요한 itemIdx와 itemReplyIdx를 숨겨서 보내준다 -->
								<form action="<%=root %>/event_reply/update.nogari" method="post">
									<input type="hidden" name="eventReplyIdx" value="<%=eventReplyDto.getEventReplyIdx()%>">
									<input type="hidden" name="eventIdx" value="<%=eventIdx %>">
									
									<!-- 댓글 수정 내용 -->
									<div class="flex-container">
										<div class="reply-write-wrapper">
											<textarea name="eventReplyDetail" cols="110" rows="5" required class="form-input"><%=eventReplyDto.getEventReplyDetail() %></textarea>
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
								<form action="<%=root %>/event_reply/insert.nogari" method="post">
									<!-- 대댓글 작성시 courseIdx를 숨겨서 같이 보내준다 -->
									<input type="hidden" name="eventIdx" value="<%=eventIdx %>">
									<!-- 대댓글 확인을 위해 댓글 번호를 같이 보내준다 -->
									<input type="hidden" name="eventReplyIdx" value="<%=eventReplyDto.getEventReplyIdx()%>">
										<div class="flex-container">
											<!-- 대댓글 내용 -->
											<div class="reply-write-wrapper">
												<textarea name="eventReplyDetail" cols="110" rows="5" required class="form-input"></textarea>
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
		<form action="<%=root%>/event_reply/insert.nogari" method="post">
			<!-- 댓글 작성시 댓글 번호를 숨겨서 보내준다 -->
			<input type="hidden" name="eventIdx" value="<%=eventIdx%>">
				<div class="row center">
					<div class="flex-container">
						<div class="reply-write-wrapper">
							<textarea name="eventReplyDetail" cols="110" rows="3" required class="form-input"></textarea>
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

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>