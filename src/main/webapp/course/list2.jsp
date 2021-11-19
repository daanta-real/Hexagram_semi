<%@page import="beans.Pagination"%>
<%@page import="beans.ItemDto"%>
<%@page import="beans.ItemDao"%>
<%@page import="beans.CourseItemDao"%>
<%@page import="beans.CourseDto"%>
<%@page import="java.util.List"%>
<%@page import="beans.CourseDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    //절대 경로를 위해 index.jsp 페이지 변수 저장
        String root = request.getContextPath();
    	
    	//페이지 네이션
        CourseDao courseDao = new CourseDao();
        Pagination<CourseDao, CourseDto> pn = new Pagination<>(request, courseDao);

        //검색용 페이지 네이션
        boolean isSearchMode = pn.isSearchMode();
        pn.calculate();
        
        //course 데이터 목록 불러오기
        List<CourseDto> list = pn.getResultList();
        
     	// 제목 h2 태그에 들어갈 타이틀 결정
        String title = isSearchMode ? ("["+pn.getKeyword()+"]" + " 검색") : ("코스 목록");
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

<!-- 페이지 제목 -->
<h2><%=title%></h2>

<!-- 검색 form -->
<form action="list.jsp" method="get">
	<select name="column" required>
		<option disabled>선택</option>
		
		<%if(pn.columnValExists("item_address")){ %>
		<option value="item_address" selected>지역명</option>
		<%}else{ %>
		<option value="item_address">지역명</option>
		<%} %>
		
		<%if(pn.columnValExists("course_name")){ %>
		<option value="course_name" selected>코스명</option>
		<%}else{ %>
		<option value="course_name">코스명</option>
		<%} %>
		
		<%if(pn.columnValExists("course_detail")){ %>
		<option value="course_detail" selected>내용</option>
		<%}else{ %>
		<option value="course_detail">내용</option>
		<%} %>
	</select>
	
	<input type="search" name="keyword" placeholder="검색어 입력"
	required value="<%=pn.getKeywordString()%>"  class="form-input form-inline">
	
	<input type="submit" value="검색">
</form>


<!-- 컨셉 :  -->
<!-- 1) 코스 번호는 코스_아이템 DB에 저장되어야 하므로, 미리 생성해서 작성란으로 가야한다. -->
<!-- 2) 비회원은 작성할 수 없도록 설정해 두었다. -->
<%if(request.getSession().getAttribute("usersIdx") != null){ %>
<!-- 글쓰기 버튼을 누르면CourseCreateSequnceForInsertServlet 으로 이동해서 시퀀스 번호를 생성해준다. -->
<h2><a href="insert_sequence.nogari">글 쓰기</a></h2>
<%} %>

<!-- 만약 데이터가 있다면 목록 불러오기 -->
<%if(!list.isEmpty()) {%>

<table border="1" width="800px">
	<tbody>
		<tr>
			<th>지역명</th>
			<th>코스명</th>
			<th>내용</th>
			<th>조회수</th>
		</tr>
		
		<!-- 목록 출력 -->			
		<%for(CourseDto courseDto : list) {%>
			<%
		    //지역 알아내기 -> 코스아이템에서 첫번쨰 아이템 내용 전달.
		    CourseItemDao courseItemDao = new CourseItemDao();
		    int itemIdx = courseItemDao.getItemIdxByCourse(courseDto.getCourseIdx());
		    ItemDao itemDao = new ItemDao();
		   	ItemDto itemDto = itemDao.get(itemIdx);	
			%>
		<tr>
			<!-- 지역 -->
			<td><%=itemDto.getAdressCity()%></td>
			<td>
				<!-- 코스제목을 누르면 조회수 증가 서블릿으로 이동, 코스 제목옆에 댓글의 개수를 보여준다 -->
				<a href="readup.nogari?courseIdx=<%=courseDto.getCourseIdx()%>">
<!-- 				이 항목을 리스트에서 누를시에만 조회수가 올라가게 CourseReadupServlet 서블릿에서 게시물 조회수 증가를 시킨 후 detail페이지로 이동시킨다. -->
				<%=courseDto.getCourseName()%>
				</a>
			<%-- 댓글수 --%>
			<!-- 댓글이 있다면 개수를 출력 -->
					<%if(courseDto.isCountReply()){ %>
						[<%=courseDto.getCourseCountReply() %>]
					<%} %>
			</td>
			<!-- 코스 내용 -->
			<td><%=courseDto.getCourseDetail()%></td>
			<!-- 조회수 -->
			<td><%=courseDto.getCourseCountView() %></td>
		</tr>
		<%} %>
	</tbody>
</table>
			
<br><br>

<!-- 페이지네이션 시작 -->
<div>		
	<%if(pn.hasPreviousBlock()){ %>
		<%if(isSearchMode){ %>
			<!-- 검색용 링크 -->
			<a href="list.jsp?column=<%=pn.getColumn()%>&keyword=<%=pn.getKeyword()%>&page=<%=pn.getPreviousBlock()%>">&lt;</a>
		<%} else { %>
			<!-- 목록용 링크 -->
			<a href="list.jsp?page=<%=pn.getPreviousBlock()%>">&lt;</a>
		<%} %>
	<%} else { %>
		 <a>&lt;</a>
	<%} %> 
			
			
	<%for(int i = pn.getStartBlock(); i <= pn.getRealLastBlock(); i++){ %>
		<%if(isSearchMode){ %>
			<!-- 검색용 링크 -->
			<a href="list.jsp?column=<%=pn.getColumn()%>&keyword=<%=pn.getKeyword()%>&page=<%=i%>"><%=i%></a>
		<%}else{ %>
			<!-- 목록용 링크 -->
			<a href="list.jsp?page=<%=i%>"><%=i%></a>
		<%} %>
	<%} %>
	
	
	<%if(pn.hasNextBlock()){ %>
		<%if(isSearchMode){ %>
			<!-- 검색용 링크 -->
			<a href="list.jsp?column=<%=pn.getColumn()%>&keyword=<%=pn.getKeyword()%>&page=<%=pn.getNextBlock()%>">&gt;</a>
		<%} else { %>
			<!-- 목록용 링크 -->
			<a href="list.jsp?page=<%=pn.getNextBlock()%>">&gt;</a>
		<%} %> 
	<%} else {%>
		<a>&gt;</a>
	<%} %>
</div>

<br><br>

<!-- 데이터가 없다면 -->
<%}else{ %>
	<h3>글이 없습니다.</h3>
<%} %>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>