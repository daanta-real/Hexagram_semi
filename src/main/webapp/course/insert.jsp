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
	ItemDao itemDao = new ItemDao();
    
    String city = request.getParameter("city");
    String items = request.getParameter("items");
    
    List<Integer> itemIdxList = (List<Integer>)request.getSession().getAttribute("itemIdxList");
    
    if(itemIdxList != null && request.getParameter("deleteItemIdx") != null){
    	itemIdxList.remove(Integer.parseInt(request.getParameter("deleteItemIdx")));
    	request.getSession().setAttribute("itemIdxList", itemIdxList);
    }

    if(city != null && items != null){
    	if(itemIdxList == null){
    		itemIdxList = new ArrayList<>();
    		itemIdxList.add(Integer.parseInt(items));
    		request.getSession().setAttribute("itemIdxList", itemIdxList);
    	}else{
    		ItemDto itemDto = itemDao.get(itemIdxList.get(0)); //첫번째 인덱스의 값 즉 첫번째로 들어간 값
    		boolean isSameCity = itemDto.getAdressCity().substring(0, 2) == city.substring(0, 2);
    		boolean isNotSameItem = itemDto.getItemIdx() != Integer.parseInt(items);
			//         		또한 전체 번호중에 중복 번호가 있는지 체크해야한다.
    				
			if(!isSameCity){
				response.sendRedirect("insert.jsp?error");
			}else if(!isNotSameItem){
				response.sendRedirect("insert.jsp?error&city="+city);
			}else{
				itemIdxList.add(Integer.parseInt(items));
				request.getSession().setAttribute("itemIdxList", itemIdxList);
			}
			
    	}
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


<form action="insert.nogari">	
	<table border="1" width="800px">
		<tbody>
			<tr>
				<th>제목</th>
				<td><input type="text" name="courseName" required></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><input type="text" name="courseDetail" required></td>
			</tr>
			<%if(itemIdxList != null && itemIdxList.size() >=2) {%>
			<tr>
			<td><input type="submit" value="최종 선택 완료"></td>
			</tr>
			<%} %>
		</tbody>
	</table>
</form>	

<%if(request.getParameter("error") != null) {%>
<h2 style="color: red">동일한 지역을 선택하지 않았거나, 동일한 관광지를 선택하였습니다.</h2>
<%} %>
<!-- 에러메세지로 알려준다. -->
현재 지역 선택 상황 : <%=city!=null?city:"지역 선택 없음"%>
<!-- 지역 선택(그 지역에 한해서 한정 선택할 수 있다.) -->
<form action="insert.jsp" method="get">
	<select name="city" required>
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
	<input type="submit" value="지역 선택 완료">
</form>
<%
List<ItemDto> listchek = itemDao.getCityList(city);
%>
목록 갯수  : <%=listchek.size() %>
<h3>선택 지역 목록</h3>
<%if(city == null) {%>
	<h3>지역을 먼저 선택하세요.</h3>
<%}else{ %>
	<h3>지역 : <%=city%></h3>
		<%
		List<ItemDto> list = itemDao.getCityList(city);
		%>
		

			<table border="1" width="800px">
				<tbody>
						<tr>
							<th>선택</th>
							<th>지역</th>
							<th>관광지명</th>
						</tr>
						<form action="insert.jsp" method="get">
						<%for(ItemDto itemDto : list) {%>
						<tr>
							<td>
								<input type="radio" name="items" value="<%=itemDto.getItemIdx()%>" required>
							</td>
							<td><%=itemDto.getAdressCity()%></td>
							<td><%=itemDto.getItemName()%></td>
						</tr>
						<%} %>
						<%if(list != null) {%>
						<tr>
							<input type="hidden" name="city" value="<%=city%>">
<!-- 							값을 담은 리스트도 함꼐 보내기 -->
							<input type="submit" value="선택 완료">
						</tr>
						<%} %>
						</form>
				</tbody>
			</table>
		</form>
	
<%} %>

<%if(itemIdxList != null){ %>
<h2>현재 선택된 관광지(취소를 원하시면 클릭하세요.)</h2>
<%for(int itemIdx : itemIdxList) {
ItemDto showItemDto = itemDao.get(itemIdx);
%>
<a href="insert.jsp?deleteItemIdx=<%=showItemDto.getItemIdx()%>&city=<%=city%>">
<%=showItemDto.getItemName() %></a>
<br>
<%} %>
<%} %>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>