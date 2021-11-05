<%@page import="beans.UsersDto"%>
<%@page import="beans.UsersDao"%>
<%@page import="java.util.HashSet"%>
<%@page import="java.util.Set"%>
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
<style>
	.container-500{width: 500px;}
	.container-center{margin-left: auto; margin-right: auto;}
	.row{margin-top: 10px; margin-bottom: 10px;}
	.center{text-align: center;}
		*{
			box-sizing: border-box;
		}
		
        textarea {
            resize:none;
        }
        
/*      .flex-container{ */
/*      	display: flex; */
/*      	flex-direction: row; */
/*      } */
     
/*      .flex-item-textarea, .flex-item-btn{ */
/*      	font-size: 25px; */
/*      	padding: 0.5rem; */
/*      } */
     
/*      .flex-item-textarea{ */
/*      width: 75%; */
/*      border: 1px solid black; */
/*      } */
     
/*      .flex-item-btn{ */
/*      width: 25%; */
/*      border : none; */
/*      background-color: blue; */
/*      color: white; */
/*      } */
     
     
</style>
 
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
<a href="<%=root%>/item/insert.jsp">새 글작성</a>
<a href="<%=root%>/item/edit.jsp?itemIdx=<%=itemIdx%>">수정</a>
<a href="<%=root%>/item/delete.nogari?itemIdx=<%=itemIdx%>">삭제</a>
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
	
	<form action="<%=root%>/item_reply/insert.nogari" method="post">
		<div class="container-500 container-center">

				<div class="row">
					<textarea name="itemReplyDetail" rows="3" cols="70" placeholder="댓글 입력" class="flex-item-textarea"></textarea>
				</div>
				<div class="row">
					<input type="submit" value="댓글 작성" class="flex-item-btn">
				</div>
					<input type="hidden" name="itemIdx" value="<%=itemIdx%>">

		</div>
	</form>

	<%if(!list.isEmpty()) {%>
		<%for (ItemReplyDto itemReplyDto : list) {%>
			<table align="center" border="1" width="700">
			
				<tbody>
						<%
						//이 글을 쓴사람의 아이디를 알기 위해서 user의 정보를 불러와야 한다.
						UsersDao usersDao = new UsersDao();
						UsersDto usersDto = usersDao.get(itemReplyDto.getUsersIdx());
						%>
						<tr>
							<td>
							<%=usersDto.getUsersId()==null?"아이디 지정 안함":usersDto.getUsersId()%>(<%=itemReplyDto.getItemReplyDate()%>)
							</td>
							<td><%=itemReplyDto.getItemReplyDetail()%></td>
							<td>
								<a>수정</a>
								<a>삭제</a>
							</td>
						</tr>
						
				</tbody>
			</table>
		<%}%>
	<%}else{%>
<h3 align="center">댓글이 없습니다.</h3>
	<%} %>
	
<!-- 댓글 작성란 추가(수정란까지 포함해서) -->
<!-- 댓글작성자 및 수정 삭제 권한 추가 -->
<!-- 댓글 있을때 없을떄 구분해서 추가하기 -->
<!-- 리스트에 댓글 수 표시. -->
<!-- 수정 및 삭제 a태그 추가하기. -->
<!-- 게시글 수정하기 추가 -->


<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>