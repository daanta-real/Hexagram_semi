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
<SECTION>

<!-- 페이지 내용 시작 -->
<% String root = request.getContextPath(); %>

<%-- 페이지에 필요한 세션, 파라미터값 저장 및 변수 선언 --%>
<%	
	//usersIdx 세션값 변수에 저장
	int usersIdx = (int)request.getSession().getAttribute("usersIdx");
	//코스번호 받기
	int courseIdx = Integer.parseInt(request.getParameter("courseIdx"));
	
	//코스 내용 및 제목등을 출력하기 위한 단일조회
	CourseDao courseDao = new CourseDao();
	CourseDto courseDto = courseDao.get(courseIdx);
	
	//글 작성자 아이디 및 닉네임 출력을 위한 단일 조회
	UsersDao usersDao = new UsersDao();
	UsersDto usersShow = usersDao.get(courseDto.getUsersIdx());

	//자신의 글인지 확인 (수정, 삭제, 조회수증가)
	boolean isMyboard = request.getSession().getAttribute("usersIdx") != null && courseDto.getUsersIdx() == usersIdx;
	
	//회원 등급 변수 저장(관리자만에게만 보이는 수정 삭제 버튼 표시를 위해)
	String usersGrade = (String)request.getSession().getAttribute("usersGrade");
	//관리자인지?
	boolean isManager = request.getSession().getAttribute("users_grade") != null && usersGrade.equals("관리자");
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


 
<!-- 코스 게시글 제목 -->
<div>
	<h1><%=courseDto.getCourseName() %></h1>
	<h4><%=usersShow.getUsersId() %>(<%=usersShow.getUsersNick() %>)</h4>
</div>

<!-- 수정/삭제는 jsp에서도 막아주는 것 이외로 주소로 입력하는 것을 방지하게 위해서 필터로도 막아줘야 한다. -->
<!-- 댓글 작성자 또는 관리자가 아니라면 버튼이 보여지지 않게 처리 -->
<%if(isMyboard || isManager){ %>
<div>
	<span><a href="delete.nogari?courseIdx=<%=courseIdx%>">삭제</a></span>
	&nbsp;&nbsp;
	
	<span><a href="udpate_sequence.nogari?courseOriginSequnce=<%=courseIdx%>">수정</a></span>
<!-- 	수정을 위해서는 대상 코스 번호를 넘겨줘야한다(courseIdx이지만 다른 시퀀스 번호와 구분하기 위해서 sourseOriginSequnce로 하여 보내기로 정함) -->
<!-- CourseCreateSequnceForUpdateServlet 참조 -->

	&nbsp;&nbsp;
	<span><a href="insert_sequence.nogari">새 코스 작성</a></span>
</div>
<%} %>

<!-- course_item 및 course 목록 출력 -->
<table border="1" width="900px">
	<tr>
		<th>코스 번호</th>
		<th>관광지 번호</th>
		<th>관광지 작성자</th>
		<th>관광지 사진</th>
		<th>관광지 지역</th>
	</tr>
	<!-- courseItem 목록 출력 -->
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
			<!-- 첨부파일이 있다면 -->
				<%if(itemFileDto == null){ %>
					<!-- 첨부파일 출력 -->
					<img src="http://via.placeholder.com/100x100">
				<%}else{ %>
					<!-- 대체 이미지 출력 -->
					<img src="<%=root%>/item/file/download.nogari?itemFileIdx=<%=itemFileDto.getItemFileIdx()%>" width="150px" height="150px">
				<%} %>
			</td>
			<td>
			<%=itemDto.getItemAddress()%>
			</td>
		</tr>
	<%} %>
</table>

<!-- 지도 -->
<div>		
	<jsp:include page="course_kakaomap.jsp">
	<jsp:param value="<%=courseIdx%>" name="courseIdx"/>
	</jsp:include>
</div>
<br>

<!-- 코스 내용 -->
<div>
	<span><%=courseDto.getCourseDetail() %></span>
</div>


<!-- 페이지 내용 끝. -->
<br><br>

<!-- 댓글 -->

<!-- 댓글 작성 공간 -->
<form action="<%=root %>/course_reply/insert.nogari" method="post">
<!-- 댓글 작성시 댓글 번호를 숨겨서 보내준다 -->
<input type="hidden" name="courseIdx" value="<%=courseIdx %>">
<table border="1" width="900px">
	<tbody>
		<tr>
			<td>
			<!-- 댓글 등록 내용 -->
			<textarea name="courseReplyDetail" cols="110" rows="5" required></textarea>
			</td>
			<td>
			<!-- 댓글 등록 버튼 -->
			<input type="submit" value="등록">
			</td>
		</tr>
	</tbody>
</table>
</form>


<!-- 댓글이 있다면 댓글목록을 출력한다-->
<%if(!list.isEmpty()){ %>
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
		<%for(CourseReplyDto courseReplyDto : list){ %>

		<% 
		//게시글 작성자를 알기위해 usersDto 선언
		UsersDto usersDto = usersDao.get(courseReplyDto.getUsersIdx());
		
		//게시물 작성자 = 댓글 작성자?
		boolean ownerReply = courseDto.getUsersIdx() == courseReplyDto.getUsersIdx();
		
		//본인 댓글인지 확인
		boolean myReply = usersIdx == courseReplyDto.getUsersIdx();
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
				<%=usersDto.getUsersId() %>(<%=usersDto.getUsersNick() %>)
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