<%@page import="beans.ItemDto"%>
<%@page import="beans.ItemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp">
	<jsp:param name="pageTitle" value="메인" />
</jsp:include>
    
 <% 
 
 String root = request.getContextPath();
 int item_idx = Integer.parseInt(request.getParameter("item_idx"));
 String users_grade = (String)request.getSession().getAttribute("users_grade");
 
 ItemDao itemDao = new ItemDao();
 ItemDto itemDto = itemDao.get(item_idx);
 
 if(request.getParameter("count") == null){
 itemDto.setItem_count(itemDto.getItem_count()+1);
 itemDao.updateCount(itemDto);
 }	//조회수를 늘리는데, count 파라미터를 통해서댓글을 추가하거나 새로고침 해서는 조회수가 늘리지 않게 하기 위함.
 
 %>
 <!-- **기본정보 표시 -->
 
<!-- 지명 표시 -->
<h3><%=itemDto.getItem_name()%></h3>

<!-- 지역 표시 -->
<h5><%=itemDto.getItem_address().substring(0,2)%></h5>

<!-- 기간 표시(축제 경우에 한해서임) -->
<%if(itemDto.getItem_type().equals("축제")) {%>
<h5><%=itemDto.getItem_periods()%></h5>
<%}%>

<br>

좋아요 표시(예정)
<!-- 조회수 표시 -->
<%=itemDto.getItem_count()%>



<!-- 관리자가 보는 경우 수정 / 삭제가 가능하도록 설정 -->
<%if(users_grade != null && users_grade.equals("관리자")){%>
<a href="<%=root%>/jsp/item/edit.jsp?item_idx=<%=item_idx%>">수정</a>
<a href="<%=root%>/jsp/item/delete.jsp?item_idx=<%=item_idx%>">삭제</a>
<%}%>

<!-- **사진 표시(DB테이블 만들어서 resource 파일정보를 불러올 예정(idea) -->
<table border="1" width="1000">
	<thead>
		<tr>
			<th>사진</th>
		</tr>
	</thead>
	
	<tbody>
		<tr>
			<td><img src="http://via.placeholder.com/200"></td>
		</tr>
	</tbody>
</table>




<!-- **상세정보 표시 -->
<table border="1" width="1000">

	<tbody>
		<tr height="200">
			<th>상세정보</th>
			<td><%=itemDto.getItem_detail()%></td>
		</tr>
<!-- 	카카오 지도 API활용한 jsp를 끌고옴 -->
		<tr>
			<th>지도표시</th>
			<td>
			<jsp:include page="/jsp/item/kakaomap.jsp">
				<jsp:param value="<%=item_idx%>" name="item_idx"/>
			</jsp:include>
			</td>
		</tr>
		<tr>
			<th>상세주소</th>
			<td><%=itemDto.getItem_address()%></td>
		</tr>
		<tr>
			<th>홈페이지</th>
			<td><%=itemDto.getItem_homepage()%></td>
		</tr>
		<tr>
			<th>운영시간</th>
			<td><%=itemDto.getItem_time()%></td>
		</tr>
		<tr>
			<th>주차</th>
			<td><%=itemDto.getItem_parking()%></td>
		</tr>
	</tbody>
</table>


<!-- **댓글 표시(끌고옴) -->
<!-- 댓글 리스트 -->
<jsp:include page="/jsp/item_reply/list.jsp">
	<jsp:param value="<%=item_idx%>" name="item_idx"/>
</jsp:include>
<!-- 쓰기 -->
<jsp:include page="/jsp/item_reply/insert.jsp">
	<jsp:param value="<%=item_idx%>" name="item_idx"/>
</jsp:include>

 
 <jsp:include page="/template/footer.jsp"></jsp:include>