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
	.row{margin-top: 5px; margin-bottom: 5px;}
	.center{text-align: center;}
		*{
			box-sizing: border-box;
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
		    border: 1px solid rgb(43, 48, 90);
		}
		
		.form-btn {
		    color: white;
		    background-color: rgb(43, 48, 90);
		    font-weight: bold;
		    height: 90%;
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
     	
     	
</style>
 
 <% 
 String root = request.getContextPath();
 int itemIdx = Integer.parseInt(request.getParameter("itemIdx"));
 ItemDao itemDao = new ItemDao();
 ItemDto itemDto = itemDao.get(itemIdx);

 
 int usersIdx = (int)request.getSession().getAttribute("usersIdx");
 //자신이 쓴글인지(현재 접속자 = 게시물 작성자)?
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
<table border="1" align="center" width="950">
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
<table align="center"  border="1" width="950">

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
				<jsp:include page="kakaomap.jsp">
					<jsp:param value="<%=itemDto.getItemIdx()%>" name="itemIdx"/>
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
<%
//이 글의 댓글 목록 불러오기.
ItemReplyDao itemReplyDao = new ItemReplyDao();
List<ItemReplyDto> list = itemReplyDao.list(itemIdx);


//게시물 수정 삭제와 같은 것과 마찬가지로 필터가 필요함(주소에서 침범하는것 방지.)!!!!!!!!!
%>

<!-- 댓글 리스트 -->
<h3 align="center">[댓글 목록]</h3>
	
<!-- 	댓글작성란 -->

		<form action="<%=root%>/item_reply/insert.nogari" method="post">
		<div class="container-500 container-center">
				<div class="flex-container">
					<div class="row center">
					<textarea name="itemReplyDetail" rows="2" cols="30" placeholder="댓글 입력" required class="form-input form-inline"></textarea>
					</div>
					<div class="row center">
					<input type="submit" value="댓글 작성" class="form-btn form-inline">
					</div>
					<input type="hidden" name="itemIdx" value="<%=itemIdx%>">
				</div>
		</div>
	</form>

	<%if(!list.isEmpty()) {%>
		<%for (ItemReplyDto itemReplyDto : list) {%>
			<table align="center" border="1" width="950">
			
				<tbody>
				
						<%
						//이 글을 쓴사람의 아이디를 알기 위해서 user의 정보를 불러와야 한다.
						UsersDao usersDao = new UsersDao();
						UsersDto usersDto = usersDao.get(itemReplyDto.getUsersIdx());
						
						// 게시물의 작성자가 댓글 작성자인가?
						boolean isSameItemReply = itemDto.getUsersIdx() == itemReplyDto.getUsersIdx();
						//현재 접속한 유저가 이 댓글 작성한 사람인가?
						boolean isUsersReplyWriter = usersIdx == itemReplyDto.getUsersIdx();
						%>
						
						<tr>

							<td>
	
							<%if(itemReplyDto.getItemReplyDepth() != 0){ %>
								<%for(int i = 0 ; i < itemReplyDto.getItemReplyDepth() ; i++){ %>
									&nbsp;&nbsp;&nbsp;&nbsp;
								<%} %>
								<img src="<%=root%>/resource/image/reply.png" width="20px">
							<%} %>

							<%=usersDto.getUsersId()==null?"아이디 지정 안함":usersDto.getUsersId()%>
							
<!-- 							게시물의 작성자가 댓글 작성자 -->
							<%if(isSameItemReply) {%>
							(글쓴이)
							<%} %>
							
							(<%=itemReplyDto.getItemReplyTotalDate()%>)
							&nbsp;
							<%=itemReplyDto.getItemReplyDetail()%>
							&nbsp;
							
<!-- 							댓글 작성자이거나 관리자의 경우 수정 삭제가 가능하다. -->
							<%if(isManager || isUsersReplyWriter) {%>
								<a>대댓글</a>
								<a>수정</a>
								<a href="<%=root%>/item_reply/delete.nogari?itemIdx=<%=itemIdx%>&itemReplyIdx=<%=itemReplyDto.getItemReplyIdx()%>">삭제</a>
							<%} %>
	
							</td>
							
						</tr>
						
<!-- 							자바스크립트를 배우고 나서 이부분을 수정한다. -->
<!-- 대댓글 창 -->
						<tr>
							<td>
								<form action="<%=root%>/item_reply/insert.nogari" method="post">
											<textarea name="itemReplyDetail" rows="2" cols="20" placeholder="댓글 입력" required></textarea>
											<input type="submit" value="대댓글">
											<input type="hidden" name="itemIdx" value="<%=itemIdx%>">
											<input type="hidden" name="itemReplyTargetIdx" value="<%=itemReplyDto.getItemReplyIdx()%>">
								</form>
							
							</td>
						</tr>	
						
<!-- 						각 댓글마다 수정 칸을 숨겨준다. -->
<!-- 							자바스크립트를 배우고 나서 이부분을 수정한다. -->

<!-- 							수정 창 -->
<!-- 							댓글 작성자이거나 관리자의 경우 수정 입력이 가능하다. -->
<%if(isManager || isUsersReplyWriter) {%>
							<td>
								<form action="<%=root%>/item_reply/update.nogari" method="post">
											<textarea name="itemReplyDetail" rows="2" cols="20" placeholder="수정" required></textarea>
											<input type="submit" value="수정">
											<input type="hidden" name="itemIdx" value="<%=itemIdx%>">
											<input type="hidden" name="itemReplyIdx" value="<%=itemReplyDto.getItemReplyIdx()%>">
								</form>
							</td>
						<%} %>	
						<tr>
								
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
<!-- 수정 및 삭제 a태그 추가하기. -->
<!-- 디자인 -->
<!-- 이미지 파일 연동 -->
<!-- 대댓글 추가 표시 / 구분이 되도록 div또는 테이블로 구성 -->
<!-- 플로우차트 그리기 -->
<!-- 디자인 구현하기. -->
<!-- 파일 사진 올리기. 구현 -->
<!-- 대딧글 수정 눌렀을떄 구현되게 하는 자바스크립트 구현 -->
<!-- 새글작성 수정 삭제 버튼으로 만들기  / 댓글 레이아웃-->
<!-- 비주얼로 테스트 해보고 시행하기. -->
<!-- 이전글 다음글 -->
<!-- 수정 삭제 새글 리모컨 픽스 추가 -->
<!-- 작성일 작성시간 몇분전 몇일 전 표시하기. -->


<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>