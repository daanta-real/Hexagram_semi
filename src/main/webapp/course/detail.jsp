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
<h3><a href="delete.nogari?courseIdx=<%=courseIdx%>">삭제</a></h3>
<h3><a href="update.jsp?courseSequnce=<%=courseIdx%>">수정</a></h3>

<!-- 수정/삭제는 jsp에서도 막아주는 것 이외로 주소로 입력하는 것을 방지하게 위해서 필터로도 막아줘야 한다. -->

<h1>코스 목록</h1>
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