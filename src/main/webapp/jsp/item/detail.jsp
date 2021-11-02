<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
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
 ItemDao itemDao = new ItemDao();
 ItemDto itemDto = itemDao.get(itemIdx);

 
 int usersIdx = (int)request.getSession().getAttribute("usersIdx");
 //자신이 쓴글인지?
boolean isMyboard = request.getSession().getAttribute("usersIdx") != null && itemDto.getUsersIdx() == usersIdx;
 
 
 String usersGrade = (String)request.getSession().getAttribute("usersGrade");
//  관리자인지?
 boolean isManager = request.getSession().getAttribute("users_grade") != null && usersGrade.equals("관리자");
 


//조회수 산정하기.
Set<Integer> boardCountView = (Set<Integer>)request.getSession().getAttribute("boardCountView");

if(boardCountView==null){
	boardCountView = new HashSet<Integer>();
}
if(boardCountView.add(itemIdx)){
	itemDao.readUp(itemIdx,usersIdx); //조회수를 늘려준다.
}
request.getSession().setAttribute("boardCountView", boardCountView);
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
</h3>


<!-- 관리자 또는 글 작성자가 보는 경우 글작성 / 수정 / 삭제가 가능하도록 설정 : 수정 삭제의 경우 필터에서도 처리가능하도록 해야함.-->
<%if(isManager || isMyboard){%>
<h4 align="center">
<a href="<%=root%>/jsp/item/insert.jsp">새 글작성</a>
<a href="<%=root%>/jsp/item/edit.jsp?itemIdx=<%=itemIdx%>">수정</a>
<a href="<%=root%>/jsp/item/delete.nogari?itemIdx=<%=itemIdx%>">삭제</a>
</h4>
<%}%>


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
		<tr>
			<th>조회수</th>
			<td><%=itemDto.getItemCountView()%></td>
		</tr>
		<tr height="200">
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
<%
//이 글의 댓글 목록 불러오기.
ItemReplyDao itemReplyDao = new ItemReplyDao();
List<ItemReplyDto> list = itemReplyDao.list(itemIdx);

//이 글을 쓴사람 불러오기.

//댓글을 쓴사람(게시물과 같은 사람 표시)
//댓글을 쓴사람만이 게시글 수정과 삭제가 가능하게 하기
//게시물 수정 삭제와 같은 것과 마찬가지로 필터가 필요함(주소에서 침범하는것 방지.)
%>

<!-- 댓글 리스트 -->
<h3 align="center">[댓글 목록]</h3>
<table align="center" border="1" width="700">
	<thead>
		<tr>
			<th>작성자 아이디</th>
			<th>작성 시간</th>
			<th>내 용</th>
			<th>관리</th>
		</tr>
	</thead>

	<tbody>
		<%for (ItemReplyDto itemReplyDto : list) {%>
		
			
			
		<%}%>
	</tbody>
</table>

