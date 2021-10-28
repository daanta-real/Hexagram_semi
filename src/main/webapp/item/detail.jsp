<%@page import="beans.ItemDto"%>
<%@page import="beans.ItemDao"%>
<%@page import="beans.ItemReplyDao"%>
<%@page import="java.util.List"%>
<%@page import="beans.ItemReplyDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 관광지 상세</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->

 <% 
 
 String root = request.getContextPath();
 int itemIdx = Integer.parseInt(request.getParameter("itemIdx"));
 
 String usersGrade = (String)request.getSession().getAttribute("usersGrade");
 
 ItemDao itemDao = new ItemDao();
 ItemDto itemDto = itemDao.get(itemIdx);

 %>
 <!-- **기본정보 표시  -->
 
<!-- 지명 표시 -->
<h1 align="center"><%=itemDto.getItemName()%></h1>

<!-- 지역 표시 -->
<h3 align="center"><%=itemDto.getItemAddress().substring(0,2)%></h3>

<!-- 기간 표시(축제 경우에 한해서임) -->
<%if(itemDto.getItemType().equals("축제")) {%>
<h3 align="center"><%=itemDto.getItemPeriods()%></h3>
<%}%>

<h3 align="center">
<br>
좋아요 표시(예정)
<!-- 조회수 표시 -->
/ 조회수 : [ <%=itemDto.getItemCount()%> ]

</h3>

<!-- 관리자가 보는 경우 수정 / 삭제가 가능하도록 설정 -->
<%-- <%if(request.getSession().getAttribute("users_grade") != null && usersGrade.equals("관리자")){%> --%>
<a href="<%=root%>/item/edit.jsp?itemIdx=<%=itemIdx%>">수정</a>
<a href="<%=root%>/item/delete.nogari?itemIdx=<%=itemIdx%>">삭제</a>
<%-- <%}%> --%>

<!-- **사진 표시(DB테이블 만들어서 resource 파일정보를 불러올 예정(idea) -->
<table border="1" style="text-align:center; width:1500px;">
	<thead>
		<tr>
			<th>사진</th>
		</tr>
	</thead>
	
	<tbody align="center" >
		<tr>
			<td><img src="http://via.placeholder.com/200"></td>
		</tr>
	</tbody>
</table>




<!-- **상세정보 표시 -->
<table style="text-align:center; border-width:1px; width:1500px">

	<tbody>
		<tr height="100">
			<th>상세정보</th>
			<td><%=itemDto.getItemDetail()%></td>
		</tr>
<!-- 	카카오 지도 API활용한 jsp를 끌고옴 -->
		<tr>
			<th>지도표시</th>
			<td>
			<jsp:include page="/item/kakaomap.jsp">
				<jsp:param value="<%=itemIdx%>" name="item_idx"/>
			</jsp:include>
			</td>
		</tr>
		<tr>
			<th height="50">상세주소</th>
			<td><%=itemDto.getItemAddress()%></td>
		</tr>
		<tr>
			<th height="50">홈페이지</th>
			<td><%=itemDto.getItemHomepage()%></td>
		</tr>
		<tr>
			<th height="50">운영시간</th>
			<td><%=itemDto.getItemTime()%></td>
		</tr>
		<tr>
			<th height="50">주차</th>
			<td><%=itemDto.getItemParking()%></td>
		</tr>
	</tbody>
</table>

<!-- 구분선표시 -->
<hr>

<!-- **댓글 표시(끌고옴) -->
<!-- 댓글 리스트 -->
<jsp:include page="/item_reply/list.jsp">
	<jsp:param value="<%=itemIdx%>" name="itemIdx"/>
</jsp:include>
<!-- 쓰기 -->
<jsp:include page="/item_reply/insert.jsp">
	<jsp:param value="<%=itemIdx%>" name="itemIdx"/>
</jsp:include>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>