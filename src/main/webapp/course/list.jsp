<%@page import="beans.ItemDto"%>
<%@page import="beans.ItemDao"%>
<%@page import="beans.CourseItemDao"%>
<%@page import="beans.CourseDto"%>
<%@page import="java.util.List"%>
<%@page import="beans.CourseDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
    String root = request.getContextPath();
   
    
    String column = request.getParameter("column");
    String keyword = request.getParameter("keyword");
    
    boolean search = column != null && keyword != null && !column.equals("") && !keyword.equals("");
    CourseDao courseDao = new CourseDao();
    
    int psize = 5;
    int p;
    try{
    	p=Integer.parseInt(request.getParameter("p"));
    	if(p<=0) throw new Exception();
    }catch(Exception e){
    	p = 1;
    }
    
    int end = p * psize;
    int begin = end - (psize-1);
    
    int bsize = 5;
    int count;
    if(search){
    	count = courseDao.count(column,keyword);
    }else{
    	count =courseDao.count();
    }
    
    int lastBlock = (count-1)/psize+1;
    
	int startBlock = (p - 1) / bsize * bsize + 1;
	int finishBlock = startBlock + (bsize - 1);
    
    List<CourseDto> list = courseDao.list();
    if(search){
    	list = courseDao.searchByRownum(column,keyword,begin,end);
    }else{
    	list = courseDao.listByRownum(begin,end);
    }
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


<!-- 페이지 검색 : 지역 , 코스명 , 내용 -->
<!-- 두가지 방법이 있는데, (둘다 시도 중)-->
<!-- 첫번째는 세션을 이용하여 세션안에서 아이템들을 모아서 처리하였다가 마지막에 그 세션을 파기 시키는 방법 (course_try 내부에 저장해 두었다)-->

<!-- 두번째는 글쓰기를 누를떄 시퀀스 번호를 생성하는 서블릿으로 이동한 후, 그 시퀀스 번호를 이용해서 코스아이템 DB에 추가 저장하는 방식. -->

<form action="list.jsp" method="get">
	<select name="column" required>
		<option disabled>선택</option>
		
		<%if(column != null && column.equals("item_address")){ %>
		<option value="item_address" selected>지역명</option>
		<%}else{ %>
		<option value="item_address">지역명</option>
		<%} %>
		
		<%if(column != null && column.equals("course_name")){ %>
		<option value="course_name" selected>코스명</option>
		<%}else{ %>
		<option value="course_name">코스명</option>
		<%} %>
		
		<%if(column != null && column.equals("course_detail")){ %>
		<option value="course_detail" selected>내용</option>
		<%}else{ %>
		<option value="course_detail">내용</option>
		<%} %>
	</select>
	
	<%if(keyword != null){ %>
	<input type="text" value="<%=keyword%>" name="keyword" required autocomplete="off" placeholder="검색어 입력">
	<%}else{ %>
	<input type="text" name="keyword" required autocomplete="off" placeholder="검색어 입력">
	<%} %>
	
	<input type="submit" value="검색">
</form>

<%if(request.getSession().getAttribute("usersIdx") != null){ %>
<h2><a href="insert_sequence.nogari">글 쓰기</a></h2>
<%} %>


<%if(!list.isEmpty()) {%>
			<table border="1" width="800px">
				<tbody>
					<tr>
						<th>지역명</th>
						<th>코스명</th>
						<th>내용</th>
					</tr>
		<%for(CourseDto courseDto : list) {%>
			<%
		    //지역 알아내기 -> 코스아이템에서 첫번쨰 아이템 내용 전달.
		     CourseItemDao courseItemDao = new CourseItemDao();
		     int itemIdx = courseItemDao.getItemIdxByCourse(courseDto.getCourseIdx());
		     ItemDao itemDao = new ItemDao();
		   	ItemDto itemDto = itemDao.get(itemIdx);	
			%>
					<tr>
						<td><%=itemDto.getAdressCity()%></td>
						<td>
						<a href="detail.jsp?courseIdx=<%=courseDto.getCourseIdx()%>">
						<%=courseDto.getCourseName()%>
						</a>
						</td>
						<td><%=courseDto.getCourseDetail()%></td>
					</tr>
		<%} %>
				</tbody>
			</table>
			
			<br><br>
	<div>		
	<%if(startBlock > 1){ %>
		<%if(search){ %>
			<!-- 검색용 링크 -->
			<a href="list.jsp?column=<%=column%>&keyword=<%=keyword%>&p=<%=startBlock-1%>">&lt;</a>
		<%} else { %>
			<!-- 목록용 링크 -->
			<a href="list.jsp?p=<%=startBlock-1%>">&lt;</a>
		<%} %>
	<%} else { %>
		 <a>&lt;</a>
	<%} %> 
			
			
	<%for(int i = startBlock; i <= Math.min(finishBlock, lastBlock); i++){ %>
		<%if(search){ %>
		<!-- 검색용 링크 -->
		<a href="list.jsp?column=<%=column%>&keyword=<%=keyword%>&p=<%=i%>"><%=i%></a>
		<%}else{ %>
		<!-- 목록용 링크 -->
		<a href="list.jsp?p=<%=i%>"><%=i%></a>
		<%} %>
	<%} %>
	
	
	<%if(finishBlock < lastBlock){ %>
		<%if(search){ %>
			<!-- 검색용 링크 -->
			<a href="list.jsp?column=<%=column%>&keyword=<%=keyword%>&p=<%=finishBlock+1%>">&gt;</a>
		<%} else { %>
			<!-- 목록용 링크 -->
			<a href="list.jsp?p=<%=finishBlock+1%>">&gt;</a>
		<%} %> 
	<%} else {%>
		<a>&gt;</a>
	<%} %>
	</div>
			<br><br>
<%}else{ %>
	<h3>글이 없습니다.</h3>
<%} %>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>