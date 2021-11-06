<%@page import="beans.CourseDto"%>
<%@page import="java.util.List"%>
<%@page import="beans.CourseDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    String root = request.getContextPath();
    %>
    
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 관광지 목록</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->


<!-- 기본적인 글쓰기 및 -->
<!-- 확인용 리스트 구현 -->

<%
CourseDao courseDao = new CourseDao();
List<CourseDto> list = courseDao.list();
%>


<h2><a href="insert.jsp">확인용 글 쓰기</a></h2>

<%if(!list.isEmpty()) {%>
		<%for(CourseDto courseDto : list) {%>
			<table border="1" width="800px">
				<tbody>
					<tr>
						<th>코스 확인용 번호</th>
						<th>제목</th>
						<th>내용</th>
					</tr>
					<tr>
						<td><%=courseDto.getCourseIdx() %></td>
						<td>
						<a href="detail.jsp?courseIdx=<%=courseDto.getCourseName() %>">
						<%=courseDto.getCourseName() %>
						</a>
						</td>
						<td><%=courseDto.getCourseDetail() %></td>
					</tr>
				</tbody>
			</table>
		<%} %>
<%}else{ %>
	<h3>글이 없습니다.</h3>
<%} %>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>