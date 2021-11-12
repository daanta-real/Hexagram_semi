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
<% String root = request.getContextPath(); %>
<!-- 페이지 내용 시작 -->

<%
int courseIdx = Integer.parseInt(request.getParameter("courseIdx"));

CourseItemDao courseItemDao = new CourseItemDao();
List<CourseItemDto> getItemList = courseItemDao.getByCourse(courseIdx);

ItemDao itemDao = new ItemDao();
ItemFileDao itemFileDao = new ItemFileDao();
%>
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
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>