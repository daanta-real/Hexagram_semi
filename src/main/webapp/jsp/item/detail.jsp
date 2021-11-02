<%@page import="beans.UsersDao"%>
<%@page import="beans.UsersDto"%>
<%@page import="beans.ItemDto"%>
<%@page import="beans.ItemDao"%>
<%@page import="beans.ItemReplyDao"%>
<%@page import="java.util.List"%>
<%@page import="beans.ItemReplyDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

 <% 
 
 String root = request.getContextPath();
 int itemIdx = Integer.parseInt(request.getParameter("itemIdx"));

 
 String usersGrade = (String)request.getSession().getAttribute("usersGrade");
 
 ItemDao itemDao = new ItemDao();
 ItemDto itemDto = itemDao.get(itemIdx);

//해당 인덱스 글 번호의 ,, 댓글 목록을 불러온다
ItemReplyDao itemReplyDao = new ItemReplyDao();
List<ItemReplyDto> list = itemReplyDao.list(itemIdx);

//이 댓글을 단 회원의 아이디를 가져오기 위해 단일조회를 한다.
UsersDao usersDao = new UsersDao();
 
 %>
 <!-- **기본정보 표시  -->
 
<!-- 지명 표시 -->
<h1 align="center"><%=itemDto.getItemName()%></h1>

<!-- 지역 표시 -->
<h3 align="center"><%=itemDto.getItemAddress().substring(0,2)%></h3>

<!-- 기간 표시(축제 경우에 한해서임) -->
<%if(itemDto.getItemType().equals("축제")) {%>
<h3 align="center"><%=itemDto.getItemPeriod()%></h3>
<%}%>

<h3 align="center">
<br>
좋아요 표시(예정)
<!-- 조회수 표시 -->


</h3>

<!-- 관리자가 보는 경우 수정 / 삭제가 가능하도록 설정 -->
<%-- <%if(request.getSession().getAttribute("users_grade") != null && usersGrade.equals("관리자")){%> --%>
<a href="<%=root%>/jsp/item/edit.jsp?itemIdx=<%=itemIdx%>">수정</a>
<a href="<%=root%>/jsp/item/delete.nogari?itemIdx=<%=itemIdx%>">삭제</a>
<%-- <%}%> --%>

<!-- **사진 표시(DB테이블 만들어서 resource 파일정보를 불러올 예정(idea) -->
<table border="1" align="center" width="700">
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
<table align="center"  border="1" width="700">

	<tbody>
		<tr height="100">
			<th>상세정보</th>
			<td><%=itemDto.getItemDetail()%></td>
		</tr>
<!-- 	카카오 지도 API활용한 jsp를 끌고옴 -->
		<tr>
			<th>지도표시</th>
			<td>
				카카오 활용 예정.
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
<h3 align="center">[댓글 목록]</h3>
<table align="center" border="1" width="700">
	<thead>
		<tr>
			<th>댓글 번호</th>
			<th>작성자 아이디</th>
			<th>작성 시간</th>
			<th>내 용</th>
			<th>관리</th>
		</tr>
	</thead>

	<tbody>
		<%for (ItemReplyDto itemReplyDto : list) {%>
		
			<%
			int itemReplyIdx = itemReplyDto.getItemReplyIdx();
			UsersDto usersDto = usersDao.get(itemReplyDto.getUsersIdx());
			%>
			
			<%if(itemReplyDto.getItemReplyTargetIdx()==0){ %>
					<tr>
						<td>
						<a href="detail.jsp?checkReplyIdx=<%=itemReplyDto.getItemReplyIdx()%>&itemIdx=<%=itemIdx%>">
						<%=itemReplyDto.getItemReplyIdx()%>
						</a>
						</td>
						<td>
							<a href="detail.jsp?checkReplyIdx=<%=itemReplyDto.getItemReplyIdx()%>&itemIdx=<%=itemIdx%>">
								<%=itemReplyDto.getUsersIdx() == 0 ? "탈퇴한 회원" : usersDto.getUsersId()%>
							</a>
						</td>
						<td><%=itemReplyDto.getItemReplyTime()%></td>
						<td><%=itemReplyDto.getItemReplyDetail()%></td>
						<td>
							<a href="#">수정</a>
							<a href="<%=request.getContextPath()%>/jsp/item/deleteReply.kh?itemReplyIdx=<%=itemReplyDto.getItemReplyIdx()%>?itemIdx=<%=itemIdx%>">삭제</a>
						</td>
					</tr>	
			
			<%if(request.getParameter("checkReplyIdx") != null && Integer.parseInt(request.getParameter("checkReplyIdx"))==itemReplyDto.getItemReplyIdx()){ %>
			<jsp:include page="/jsp/item_reply/target_insert.jsp">
				<jsp:param name="itemReplyTargetIdx" value="<%=itemReplyDto.getItemReplyIdx()%>"/>
				<jsp:param name="itemIdx" value="<%=itemIdx%>"/>
			</jsp:include>		
			<%} %>
			
			<jsp:include page="/jsp/item_reply/target_list.jsp">
				<jsp:param name="itemReplyIdx" value="<%=itemReplyDto.getItemReplyIdx()%>"/>
				<jsp:param name="itemIdx" value="<%=itemIdx%>"/>
			</jsp:include>
			

			<%}%>
		<%}%>
	</tbody>
</table>
<!-- 쓰기 -->
<jsp:include page="/jsp/item_reply/insert.jsp">
	<jsp:param value="<%=itemIdx%>" name="itemIdx"/>
</jsp:include>
