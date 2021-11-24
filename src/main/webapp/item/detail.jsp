<%@page import="util.users.Sessioner"%>
<%@page import="beans.ItemFileDto"%>
<%@page import="beans.ItemFileDao"%>
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
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="/resource/js/reply.js"></script>
<script>
$(function(){
    $(".view-row").find(".edit-btn").click(function(){
        $(this).parents("tr.view-row").hide();
        $(this).parents("tr.view-row").next("tr.edit-row").show();
    });
    
    $(".edit-row").find(".edit-cancel-btn").click(function(){
        $(this).parents("tr.edit-row").hide();
        $(this).parents("tr.edit-row").prev("tr.view-row").show();
    });
    

    $(".view-row").find(".reply-btn").click(function(){
        $(this).parents("tr.view-row").next("tr.edit-row").next("tr.reply-row").show();
    });			
        
    
    $(".reply-row").find(".reply-cancel-btn").click(function(){
        $(this).parents("tr.reply-row").hide();
    });
    
    $(".edit-row").hide();
    $(".reply-row").hide();
});
</script>
<style>
	.container-900{width: 900px;}
	.container-left {
	    margin-left: 0;
	    margin-right: auto;
	}
	.container-center {
	    margin-left: auto;
	    margin-right:auto;
	}
	.container-right {
	    margin-left: auto;
	    margin-right:0;
	}

	.row{
	margin-top: 5px; margin-bottom: 5px;
	}
	
	.left {
	    text-align: left !important;
	}
	.center {
	    text-align: center !important;
	}
	.right {
	    text-align: right !important;
	}
	
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
		    border: 1px solid rebeccapurple;
		}
		
		.form-btn {
		    color: white;
		    background-color: rebeccapurple;
		    font-weight: bold;
		    height: 90%;
		}
		.form-btn:hover{
		 color: red;
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
        .flex-container > .flex-reply-write-wrapper{
            flex-grow: 3;
        }
        .flex-container > .flex-reply-btn-wrapper{
            flex-grow: 1;
            margin-top: auto;
            margin-bottom: auto;
        }
     	
     	.image {
		    border: 2px solid transparent;
		    padding: 2rem;
		}
     	
     	.table{
			    width: 100%;
			}
			
			.table>thead>tr>th,
			.table>thead>tr>td,
			.table>tbody>tr>th,
			.table>tbody>tr>td,
			.table>tfoot>tr>th,
			.table>tfoot>tr>td{
			    padding: 0.5rem;
			    text-align: center;
			}
			
			.table>.tabheight{
				min-height: 300px;
			}
			
			.table.table-border {
			    border:1px solid black;
			    border-collapse: collapse;
			
			}
			.table.table-border > thead > tr > th, 
			.table.table-border > thead > tr > td,
			.table.table-border > tbody > tr > th,
			.table.table-border > tbody > tr > td,
			.table.table-border > tfoot > tr > th,
			.table.table-border > tfoot > tr > td {
			    border:1px solid black;
			
			}
			
			.form-link-btn
	        {
	            border:1px solid rebeccapurple;
	            text-decoration: none;
	            color:rebeccapurple;
	            padding:0.1rem 0.1rem;
         	    font-size:20px;
         	    margin: 0 0;
	        }
	      .form-link-btn:hover {
            border-color:red;
            color:red;
       		 }
	        	.flex-container > .reply-write-wrapper {
					width:80%;
				}
				.flex-container > .reply-send-wrapper {
					flex-grow:1;
				}
				.flex-container > .reply-send-wrapper > .form-btn,
				.flex-container > .reply-send-wrapper > .form-link-btn {
					width:100%;
					height:93%;
					display: flex;
					align-items:center;
					justify-content:center;
				}
				
				.gapy{
					margin-top: 2rem;
					margin-bottom: 2rem;
				}
</style> 
 
<%-- 페이지에 필요한 세션, 파라미터값 저장 및 변수 선언 --%>
 <%
 //경로 설정을 위해 index.jsp를 변수 저장
  	 String root = request.getContextPath();
  	 //list.jsp에서 받은 itemIdx 파라미터값 변수 저장
  	 int itemIdx = Integer.parseInt(request.getParameter("itemIdx"));
  	 //출력을위해 Dao Dto 변수 선언
  	 ItemDao itemDao = new ItemDao();
  	 ItemDto itemDto = itemDao.get(itemIdx);
  	 UsersDao usersDao = new UsersDao();
  	 UsersDto usersDto = usersDao.get(itemDto.getUsersIdx());
  	 
	//로그인 하였는지?  	
	 String usersId = (String)Sessioner.getUsersId(request.getSession());
  	 boolean isLogin = usersId != null;
  	//(본인글인지 확인을 위해)
	 boolean isMyboard; 
 	if(isLogin)
 	isMyboard = usersId.equals(usersDto.getUsersId());
 	else//로그인이 되어있지 않다면,
 	isMyboard = false;
	 
  	//관리자인지?
  	boolean isManager = Sessioner.getUsersGrade(request.getSession()) != null 
  	&& Sessioner.getUsersGrade(request.getSession()).equals(Sessioner.GRADE_ADMIN);
 %>
 
<%-- 조회수 중복방지 기능 (추 후 필요할시 주석 제거하고 위에 조회수 기능 삭제) --%>
<%-- 조회수 증가 기능 (조회수 중복 방지) => 한번이 아니라 다른 회원이 들어올떄마다 조회수를 증가시켜주기 위해 게시물을 클릭시킬떄마다 +1을 해준다.(새로고침 방지)--%>
<%
//Set<Integer> boardCountView = (Set<Integer>)request.getSession().getAttribute("boardCountView");

	//if(boardCountView==null){
	//	boardCountView = new HashSet<Integer>();
	//}
	//if(boardCountView.add(itemIdx)){
	//	itemDao.readUp(itemIdx,usersIdx);
	//}
	//request.getSession().setAttribute("boardCountView", boardCountView);
%>
 
<%-- 게시글 사진파일 정보 조회  --%>
<%
ItemFileDao itemFileDao = new ItemFileDao();
	List<ItemFileDto> itemFileList = itemFileDao.find1(itemIdx);
%>
 
 <!-- 기본정보 표시  -->
 <div class="container-900 container-center">
 
	<!-- 지명 표시 -->
    <div class="row center">
		<h1><%=itemDto.getItemName()%></h1>
    </div>
    
	<!-- 지역 표시 -->
 	<div class="row center">
        <%
        String area = itemDto.getAdressCity()+" "+itemDto.getAdressCitySub();
        %>
		<h3><%=area%></h3>
    </div>
    
    <!-- 만약 축제라면 축제 기간을 표시 -->
    <div class="row center">
    	<%
    	if(itemDto.getItemType().equals("축제")) {
    	%>
			<h3><%=itemDto.getItemPeriod()%></h3>
		<%
		}
		%>
    </div>
    
    <!-- 좋아요 및 조회수 출력 -->
	<div class="row right">
		좋아요 표시(예정)
		|
		조회수 : <%=itemDto.getItemCountView()%>
    </div>
	
	<!-- a태그 링크 -->    
	<div class="row right">
		<!-- 관리자 또는 글 작성자가 보는 경우 글작성 / 수정 / 삭제가 가능하도록 설정 : 수정 삭제의 경우 필터에서도 처리가능하도록 해야함.-->
		<!-- 리모컨으로 구현하기 -->
		<a href="<%=root%>/item/list_first.jsp">목록으로</a>
			<%
			if(isManager || (isLogin && isMyboard)){
			%>
			<!-- 글 작성 페이지로 이동 -->
			<a href="<%=root%>/item/insert.jsp">새 글작성</a>
			<!-- itemIdx번호와 함께 수정페이지로 이동 -->
			<a href="<%=root%>/item/edit.jsp?itemIdx=<%=itemIdx%>">수정</a>
			<!-- itemIdx번호를 delete Servlet으로 보내주고 삭제 -->
			<a href="<%=root%>/item/delete.nogari?itemIdx=<%=itemIdx%>">삭제</a>
		<%
		}
		%>
    </div>

    <!-- **사진 표시(DB테이블 만들어서 resource 파일정보를 불러올 예정(idea) -->
    <div class="row center gapy">
     	<!-- 만약 첨부파일이 있다면 -->
		<%
		if(!itemFileList.isEmpty()){
		%>
			<!-- 점부파일 목록 조회 -->
			<%
			for(ItemFileDto itemFileDto : itemFileList){
			%>
				<!-- 첨부파일 출력 -->
				<img src="file/download.nogari?itemFileIdx=<%=itemFileDto.getItemFileIdx()%>" width="500" height="500" class="image">
			<%
			}
			%>
		<!-- 첨부파일이 없다면 (대체 이미지를 보여줄지 없앨지 회의 후 결정) -->
		<%
		}else{
		%>
				<!-- 첨부 파일이 없다면 대체 이미지를 설정 -->
				<img src="http://placeimg.com/500/500/nature" class="image">
		<%
		}
		%>
    </div>
    
    <!-- 상세정보 표시 -->
     <div class="row">
	      <table class="table table-border">
	      	<tbody>
			     <tr>
					<th>지도표시</th>
					<td>
						<jsp:include page="kakaomap.jsp">
							<jsp:param value="<%=itemDto.getItemIdx()%>" name="itemIdx"/>
						</jsp:include>
					</td>
				</tr>
				
				<tr height="400px">
					<th>상세정보</th>
					<td><%=itemDto.getItemDetail()%></td>
				</tr>
				
				<tr>
					<th>상세주소</th>
					<td><%=itemDto.getItemAddress()%></td>
				</tr>

				<tr>
					<th>홈페이지</th>
					<td><a href="<%=itemDto.getItemHomepage()%>" target="_blank"><%=itemDto.getItemHomepage()%></a></td>
				</tr>
				
				<tr>
					<th>운영시간</th>
					<td><%=itemDto.getItemTime()%></td>
				</tr>
				
				<tr>
					<th>주차</th>
					<td><%=itemDto.getItemParking()%></td>
				</tr>
				
	      	</tbody>
	      </table>
	      
    </div>
 	


<!-- 댓글 표시 -->
<%
//이 글의 댓글 목록 불러오기.
	//게시물 수정 삭제와 같은 것과 마찬가지로 필터가 필요함(주소에서 침범하는것 방지.)!!!!!!!!!
	ItemReplyDao itemReplyDao = new ItemReplyDao();
	List<ItemReplyDto> list = itemReplyDao.list(itemIdx);
%>


<div class="row center">
	<h3>[댓글 목록]</h3>
</div>

<!-- 댓글 리스트 -->
	<div class="row center gapy">
		<table class="table table-border">
			<!-- 만약 댓글이 있다면 -->
			<%
			if(!list.isEmpty()) {
			%>
				<!-- 댓글 조회 -->
				<%
				for (ItemReplyDto itemReplyDto : list) {
				%>
					<tbody>
						<%
						//이 글을 쓴사람의 아이디를 알기 위해서 user의 정보를 불러와야 한다.
														UsersDto usersItemReplyDto = usersDao.get(itemReplyDto.getUsersIdx());
														// 게시물의 작성자가 댓글 작성자인가?
														boolean isSameItemReply = itemDto.getUsersIdx() == itemReplyDto.getUsersIdx();
														//현재 접속한 유저가 이 댓글 작성한 사람인가?
														boolean isUsersReplyWriter;
														if(isLogin)
														isUsersReplyWriter =	 usersId.equals(usersItemReplyDto.getUsersId());
														else
														isUsersReplyWriter = false; 
						%>
						
						<tr class="view-row">
							<td width="35%" class="left">
								<!-- 대댓글이라면 표시해주어라 -->
								<%if(itemReplyDto.hasDepth()){ %>
									<%for(int i = 0 ; i < itemReplyDto.getItemReplyDepth() ; i++){ %>
									<!-- 대댓글이라면 4칸 띄어서 보여준다 -->
									&nbsp;&nbsp;&nbsp;&nbsp;
									<%} %>
									<!-- 대댓글을 표시해줄 이미지 -->
									<img src="<%=root%>/resource/image/reply.png" width="20px">
								<%} %>
								<!-- 댓글 작성자의 아이디 출력 -->
								<%=usersDto.getUsersId()%>
								<!-- 게시물의 작성자가 댓글 작성자 -->
								<%if(isSameItemReply) {%>
									<!-- 게시물의 작성자라면 아이디 옆에 (글쓴이를 표시해준다) -->
									<span>(글쓴이)</span>
								<%} %>
							<!-- 날짜 표시 -->
							<br>(<%=itemReplyDto.getItemReplyTotalDate()%>)
							</td>
							
							
							<td class="left">
							<!-- 댓글 내용 -->
							<%=itemReplyDto.getItemReplyDetail()%>
							</td>
							
							<!-- 댓글 작성자이거나 관리자의 경우 수정 삭제가 가능하다. -->
							<%if(isManager || isUsersReplyWriter) {%>
								<td width="17%">
									<a class="reply-btn form-link-btn form-line">대댓글</a>
									<a class="edit-btn form-link-btn form-line">수정</a>
									<a href="<%=root%>/item_reply/delete.nogari?itemIdx=<%=itemIdx%>&itemReplyIdx=<%=itemReplyDto.getItemReplyIdx()%>" class="form-link-btn form-line">삭제</a>
								</td>
							<%} %>
						</tr>
						
						<!-- 수정 창(각 댓글마다 수정 칸을 숨겨준다. ) -->
						<!-- 댓글 작성자이거나 관리자의 경우 수정 입력이 가능하다. -->
						<%if(isManager || isUsersReplyWriter) {%>
						<tr class="edit-row">
							<td colspan="3">
								<!-- 댓글 수정시 댓글 수정에 필요한 itemIdx와 itemReplyIdx를 숨겨서 보내준다 -->
								<form action="<%=root%>/item_reply/update.nogari" method="post">
									<input type="hidden" name="itemIdx" value="<%=itemIdx%>">
									<input type="hidden" name="itemReplyIdx" value="<%=itemReplyDto.getItemReplyIdx()%>">
									<!-- 댓글 수정 내용 -->
									<div class="flex-container">
										<div class="reply-write-wrapper">
											<textarea name="itemReplyDetail" rows="3" cols="30" placeholder="수정" required class="form-input"><%=itemReplyDto.getItemReplyDetail()%></textarea>
										</div>
										<!-- 댓글 수정 버튼 -->
										<div class="reply-send-wrapper" height="100%">
											<input type="submit" value="수정" class="form-btn">
										</div>
										<!-- 취소 버튼 -->
										<div class="reply-send-wrapper">
											<a class="edit-cancel-btn form-link-btn">취소</a>
										</div>
									</div>
								</form>
							</td>
						</tr>
						<%} %>	
						
						<!-- 자바스크립트를 배우고 나서 이부분을 수정한다. -->
						
						<!-- 대댓글 창 -->
						<tr class="reply-row">
							<td colspan="3">
								<!-- 대댓글 입력시 필요한 itemIdx와 itemReplyTargetIdx(대댓글시 상위 댓글번호가 필요)를 숨겨서 보낸다 -->
								<form action="<%=root%>/item_reply/insert.nogari" method="post">
									<input type="hidden" name="itemIdx" value="<%=itemIdx%>">
									<input type="hidden" name="itemReplyTargetIdx" value="<%=itemReplyDto.getItemReplyIdx()%>">
										<div class="flex-container">
											<!-- 대댓글 내용 -->
											<div class="reply-write-wrapper">
												<textarea name="itemReplyDetail" rows="2" cols="20" placeholder="댓글 입력" required class="form-input"></textarea>
											</div >
											<!-- 대댓글 등록 버튼 -->
											<div class="reply-send-wrapper">
												<input type="submit" value="대댓글" class="form-btn">
											</div>
											<!-- 대댓글 취소 버튼 -->
											<div class="reply-send-wrapper">
												<a class="reply-cancel-btn form-link-btn">취소</a>
											</div>
										</div>	
								</form>
							</td>
						</tr>	
				</tbody>
			<%}%>
		</table>
	</div>
	
<!--테이블 정보 종료지점 -->	
			<%}else{%>
				<h3 align="center gapy">댓글이 없습니다.</h3>
			<%} %>

<!-- 댓글 등록 -->
<div class="row center gapy">
	<h3>[댓글 작성]</h3>
</div>
	
	<!-- 댓글작성란 -->
	<%if(isLogin){ %>
		<form action="<%=root%>/item_reply/insert.nogari" method="post">
			<input type="hidden" name="itemIdx" value="<%=itemIdx%>">
				<div class="row center">
					<div class="flex-container">
						<div class="reply-write-wrapper">
							<textarea name="itemReplyDetail" rows="2" cols="30" placeholder="댓글 입력" required class="form-input"></textarea>
						</div>
						<div class="reply-send-wrapper">
							<input type="submit" value="댓글 작성" class="form-btn">
						</div>
					</div>
				</div>
		</form>
	<%}else{ %>
		<div class="row center">
			<h3 align="center gapy">로그인 후 댓글 작성이 가능합니다.</h3>
		</div>
	<%} %>	
	</div>
<!-- 필터를 통해서 댓글 수정 및 삭제 금지하는 필터 설정을 해야한다!!!!!!!!!!!!!!!! -->
<!-- 작성일 작성시간 몇분전 몇일 전 표시하기. -->

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>