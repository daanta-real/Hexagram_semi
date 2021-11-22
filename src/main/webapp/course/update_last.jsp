<%@page import="beans.CourseDto"%>
<%@page import="beans.CourseItemDto"%>
<%@page import="beans.CourseDao"%>
<%@page import="beans.CourseItemDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="beans.ItemDto"%>
<%@page import="java.util.List"%>
<%@page import="beans.ItemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 관광지 목록</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<style>
.container-800{width: 800px;}
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
			
.form-link-btn{
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
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
        
	$(function(){
		//최종제출 등록버튼을 누르면 생기는 이벤트
	    $(".next-submit").on("submit",function(e){
	    	//로그인 확인
	    	<%boolean isLogin = request.getSession().getAttribute("usersIdx") != null;%> 
	    	var login = <%=isLogin%>;
	    	//만약 로그인이 안되었다면 이벤트를 발생시킨다
	    	if(!login){
	    		e.preventDefault();
	    		$(".show-login").text("로그인하세요..!").css("color","red");
	    	}
	    });   
	});	
	
</script>

<SECTION>
<!-- 페이지 내용 시작 -->
    <%
  	//절대 경로를 위해 index.jsp 페이지 변수 저장
    String root = request.getContextPath();

    //파라미터로 받은 값 변수에 저장 (기존 번호와 새로 생성한 번호) 
    // - 수정 완료하지 않고 나가버리면 코스db가 바뀌어버리기때문에 시퀀스번호를 임의로 생성한 값도 같이 받는다
    // - 그 후 form을 courseUpdateServlet 으로 보내면 시퀀스 번호를 정리한다
    int courseOriginSequnce = Integer.parseInt(request.getParameter("courseOriginSequnce"));
	int courseSequnce = Integer.parseInt(request.getParameter("courseSequnce"));
	String usersFilterId = request.getParameter("usersFilterId");	
	// 	최초로 지역을 먼저 설정하게 한다. 이것을 선택한 후에는 대부분 courseSequnce / city는 함께 파라미터로 움직여야 한다.
	CourseDao courseDao = new CourseDao();
	CourseDto courseDto = courseDao.get(courseOriginSequnce); //기존 내용을 넘기기 위함.

	//아이템 목록을 보기위해 변수 저장
    ItemDao itemDao = new ItemDao();
    CourseItemDao courseItemDao = new CourseItemDao();
    
    //course_item 목록 출력을 위해 변수저장
    List<CourseItemDto> courseItemList = courseItemDao.getByCourse(courseSequnce);
   	ItemDto getCityDto = itemDao.get( courseItemList.get(0).getItemIdx());

   	//도시 이름을 꺼낸다
    String city;
   	if(getCityDto.getAdressCity().length() != 4) city=getCityDto.getAdressCity().substring(0,2);
   	else city = getCityDto.getAdressCity();
    %>
    

<div class="container-800 container-center">
	<div class="row center">
		<h1>최종 코스 작성란</h1>
	</div>
    
    
	<!-- 수정 입력 from -->    
	<form action="update_course.nogari" class="next-submit" method="post">
		<div class="row">
			<table class="table table-border">
				<tbody>
					<tr>
						<th>대상 지역	</th>
						<td>
						<%=city%>
						</td>
						</tr>
					<tr>
						<th>제목</th>
						<td><input type="text" name="courseName" value = "<%=courseDto.getCourseName()%>" required placeholder="제목 입력" class="form-input"></td>
					</tr>
					<tr>
						<th>내용</th>
						<td>
						<textarea name="courseDetail" rows="5" required placeholder="내용 입력" class="form-input"><%=courseDto.getCourseDetail()%></textarea>
						</td>
					</tr>
				</tbody>
			</table>	
		</div>
		<div class="row right">
			<button class="btn form-btn">최종 제출</button>
			<span class="show-login"></span>
			<input type="hidden" name="courseSequnce" value="<%=courseSequnce%>">
			<input type="hidden" name="courseOriginSequnce" value="<%=courseOriginSequnce%>">
			<input type="hidden" name="usersFilterId" value="<%=usersFilterId%>">
		</div>
	</form>
	
	<!-- 선택한 관광지명 출력 -->
	<div class = "row center">
		<h2> - 선택한 관광지명 확인 - </h2>
	</div>

	<%int index = 1;%>
	<%for(CourseItemDto courseItemDto : courseItemList){ %>
		<%ItemDto itemDto = itemDao.get(courseItemDto.getItemIdx());%>
	<div class = "row center">
		<%=index++%>번 관광지 : <span><%=itemDto.getItemName()%></span>
	</div>
	<%} %>


	<div class = "row">
		<form action="update.jsp" method="get">
			<button class="form-btn">이전으로</button>
			<input type="hidden" name="courseSequnce" value="<%=courseSequnce%>">
			<input type="hidden" name="courseOriginSequnce" value="<%=courseOriginSequnce%>">
			<input type="hidden" name="keyword" value="<%=city%>">
			<input type="hidden" name="column" value="item_address">
			<input type="hidden" name="usersFilterId" value="<%=usersFilterId%>">
		</form>
	</div>
</div>
<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>