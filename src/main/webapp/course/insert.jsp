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
    <%
   
    String root = request.getContextPath();
    
//     최초 코스 번호는서블릿에서 생성한 번호를 받아준다. 이후에는 코스_아이템 항목 추가,삭제 서블릿에서 전달한 해당 시퀀스 값을 다시 받는다.
	int courseSequnce = Integer.parseInt(request.getParameter("courseSequnce"));
// 	최초로 지역을 먼저 설정하게 한다. 이것을 선택한 후에는 대부분 courseSequnce / city는 함께 파라미터로 움직여야 한다.
    String city = request.getParameter("city");
	
    ItemDao itemDao = new ItemDao();
    CourseItemDao courseItemDao = new CourseItemDao();
    
    List<CourseItemDto> courseItemList = courseItemDao.getByCourse(courseSequnce);
//     3개이상만 가능하게 하는 기능 / 목록을 보여주고 삭제 옵션을 주는 기능

	boolean isLogin = request.getSession().getAttribute("usersIdx") != null;
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


<form action="insert_course.nogari" method="post">	
	<table border="1" width="800px">
		<tbody>
			<tr>
				<th>제목</th>
				<td><input type="text" name="courseName" required></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><input type="text" name="courseDetail" required></td>
			<input type="hidden" name="courseSequnce" value="<%=courseSequnce%>">
			</tr>
			
			<tr>
			<%if(courseItemList != null && courseItemList.size() >=3 && isLogin) {%>
			<td><input type="submit" value="최종 선택 완료"></td>
			<%}else{%>
			<td><input type="button" value="관광지 3개이상 선택필수(로그인 필수)"></td>
			<%}%>
			</tr>
		</tbody>
	</table>
</form>	

<%if(request.getParameter("error") != null) {%>
<h2 style="color: red">동일한 지역군을 선택하지 군았거나, 동일한 관광지를 선택하였습니다.</h2>
<%} %>
<!-- 에러메세지로 알려준다. -->


현재 지역 선택 상황 : <%=city!=null?city:"지역 선택 없음"%>
<!-- 지역 선택(그 지역에 한해서 한정 선택할 수 있다.) -->
<form action="insert.jsp" method="get">
	<select name="city" required>
		<%if(city == null) {%>
		<option value="" selected>선택</option>
		<%}else{ %>
		<option value="">선택</option>
		<%} %>
	
		<%if(city != null && city.equals("서울")) {%>
		<option selected>서울</option>
		<%}else{ %>
		<option>서울</option>
		<%} %>
		
		<%if(city != null && city.equals("전라북도")) {%>
		<option selected>전라북도</option>
		<%}else{ %>
		<option>전라북도</option>
		<%} %>
		
		<%if(city != null && city.equals("대구")) {%>
		<option selected>대구</option>
		<%}else{ %>
		<option>대구</option>
		<%} %>
		
		<%if(city != null && city.equals("경상남도")) {%>
		<option selected>경상남도</option>
		<%}else{ %>
		<option>경상남도</option>
		<%} %>
	</select>
	
	<input type="hidden" name="courseSequnce" value="<%=courseSequnce%>">
<!-- 	핵심이다.. courseSequnce는 무슨일이 있어서 최초 생성하고 잃어서는 안될 고유 번호이다. -->
	<input type="submit" value="지역 선택 완료">
</form>


<br><br>
<%
List<ItemDto> listchek = itemDao.getCityList(city);
// 갯수 체크용임 후에 질울 것!!
%>
목록 갯수  : <%=listchek.size() %>
<br><br>


<h3>선택 지역 목록</h3>
<%if(city == null) {%>
	<h3>지역을 먼저 선택하세요.</h3>
<%}else{ %>
	<h3>지역 : <%=city%></h3>
		<%
		List<ItemDto> list = itemDao.getCityList(city);
		// 위의 도시 선택 이후에 보여지는 것이며, 선택한 도시에 대한 item DB에 저장된 해당 도시 관광지 목록을 불러 오는 것임
		%>
		
<!-- 		추후에 이 목록 리스트 선택란을 페이지네이션으로 구현할것임. -->
		<%if(!list.isEmpty()){ %>
			<table border="1" width="800px">
				<tbody>
						<tr>
							<th>선택</th>
							<th>지역</th>
							<th>관광지명</th>
						</tr>
						
						<form action="insert_course_item.nogari" method="post">
						<%for(ItemDto itemDto : list) {%>
							<tr>
								<td>
									<input type="radio" name="itemIdx" value="<%=itemDto.getItemIdx()%>" required>
	<!-- 								파라미터 1: 추가를 눌렀을때 courseitem DB에 저장할 번호임. -->
								</td>
								<td><%=itemDto.getAdressCity()%></td>
								<td><%=itemDto.getItemName()%></td>
							</tr>
						<%} %>

							<tr colspan="3">
								<input type="hidden" name="courseSequnce" value="<%=courseSequnce%>">
	<!-- 							코스번호는 항상 보내기. -->
								<input type="submit" value="관광지 추가하기">
							</tr>
						</form>
				</tbody>
			</table>
						<%} %>
<%} %>


<%if(courseItemList != null){ %>
<h2>현재 선택된 관광지(취소를 원하시면 클릭하세요.)</h2>
<%for(CourseItemDto courseItemDto : courseItemList) {
ItemDto showItemDto = itemDao.get(courseItemDto.getItemIdx());
%>
<a href="delete_course_item.nogari?courseSequnce=<%=courseSequnce%>&itemIdx=<%=courseItemDto.getItemIdx()%>">
<!-- 도시명은 아마,, 다시 돌아와서 최신화? 아니면 그대로 보여주기.. -->
<%=showItemDto.getItemName()%></a>
<br>
<%} %>
<%} %>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>