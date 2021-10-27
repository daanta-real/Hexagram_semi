<%@page import="beans.APIDto"%>
<%@page import="beans.APIDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
        int region = 0; String strRegion = request.getParameter("region");
                int section = 0; String strSection = request.getParameter("section");
                int pages = 0;	String strPages = request.getParameter("pages");
                int number = 1;	String strNumber = request.getParameter("number");

                if(request.getParameter("region") != null && !request.getParameter("region").equals("0")){
                	region=Integer.parseInt(request.getParameter("region"));
                }
                if(request.getParameter("section") != null && !request.getParameter("section").equals("0")){
                	section=Integer.parseInt(request.getParameter("section"));
                }
                if(request.getParameter("pages") != null && !request.getParameter("pages").equals("0")){
                	pages=Integer.parseInt(request.getParameter("pages"));
                }
                if(request.getParameter("number") != null && Integer.parseInt(request.getParameter("number")) > 1){
                	number=Integer.parseInt(request.getParameter("number"));
                }else{
                	number = 1;
                }
        %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1>관광지 Google</h1>

<form action="./KakaoDB.jsp">
	<select name="region" required="required">

		<option value="">지역 선택</option>
		<%
		if(1 == region){
		%>
		<option value="1" selected>서울</option>
		<option value="4">대구</option>
		<%
		} else if(region == 4) {
		%>
		<option value="1" >서울</option>
		<option value="4" selected>대구</option>
		<%
		} else if(region == 0){
		%>
		<option value="1" >서울</option>
		<option value="4">대구</option>
			<%
			}
			%>

	</select>

&nbsp;
<%
if(region == 0){
%>

	<select name="section">
		<option value="0">구 선택</option>
	</select>

<%
} else if(region==1){
%>

	<select name="section" required="required">
		<option value="0">구 선택</option>
		<option value="1">강남구</option>
		<option value="2">강동구</option>
		<option value="3">강북구</option>
		<option value="4">강서구</option>
		<option value="5">관악구</option>
		<option value="6">광진구</option>
		<option value="7">구로구</option>
		<option value="8">금천구</option>
		<option value="9">금천구</option>
		<option value="10">동대문구</option>
		<option value="11">도봉구</option>
		<option value="12">동작구</option>
		<option value="13">마포구</option>
		<option value="14">서대문구</option>
		<option value="15">서초구</option>
		<option value="16">성동구</option>
		<option value="17">성북구</option>
		<option value="18">송파구</option>
		<option value="19)">양천구</option>
		<option value="20">영등포구</option>
		<option value="21">용산구</option>
		<option value="22">은평구</option>
		<option value="23">종로구</option>
		<option value="24">중구</option>
		<option value="25">중랑구</option>
	</select>
		

<%
		} else if(region==4){
		%>

	<select name="section" required="required">
		<option value="0">구 선택</option>
		<option value="1">남구</option>
		<option value="2">달서구</option>
		<option value="3">달성군</option>
		<option value="4">동구</option>
		<option value="5">북구</option>
		<option value="6">서구</option>
		<option value="7">수성구</option>
		<option value="8">중구</option>
	</select>

<%
}
%>
&nbsp;
	<%
	if(region == 0 && section ==0) {
	%>
		<select name="pages">
		<option value="0">검색 개수 선택</option>
		</select>
		<%
		} else{
		%>
		<select name="pages" required="required">
		<option value="0" selected disabled>검색 개수 선택</option>
		<option value="1">1</option>
		<option value="2">2</option>
		<option value="3">3</option>
		<option value="4">4</option>
		<option value="5">5</option>
		</select>
		<%
		}
		%>
&nbsp;

	<input type="submit" value="검 색">
</form>

<%
APIDao apiDao = new APIDao();
List<APIDto> list = new ArrayList<>();
boolean search = region != 0 && section != 0 && pages !=0;
if(search){
list = apiDao.getTourList(region, section, pages, number);
}

%>

<br><br><br>


<%if(search) {%>
	<%if(list.size() !=0) {%>
<table border="1" style="width:800px;">
	<thead>
		<tr>
		<th>순 서</th>
		<th>TITLE</th>
		<th>ADDRESS</th>
		<th>DB단일조회</th>
		<th>CUSTOM단일조회</th>
		<th>DB주변목록</th>
		</tr>
	</thead>
	
	<tbody align="center">
		<%for(int i=0 ; i<list.size() ; i++){ %>
	<tr>
		<td><%=i%>번</td>
		<td><%=list.get(i).getTitle()%></td>
		<td><%=list.get(i).getAddress()%></td>
		
		<%
		String detail = apiDao.getTourDetailExaminationString(list.get(i).getContentid());
		%>
		<td><a href="<%=detail%>">상세 보기(DB)</a></td>
		

		<%
		String around = apiDao.getTourAroundString(list.get(i).getMapx(), list.get(i).getMapy());
		%>
		<td><a href="<%=around%>">주변 상세 보기</a></td>
		
	</tr>
		<%}%>
	</tbody>
	<tfoot>
	</tfoot>
</table>


<a href="./KakaoDB.jsp?region=<%=region%>&section=<%=section%>&pages=<%=pages%>&number=<%=number-1%>">이전 페이지</a> / 
<a href="./KakaoDB.jsp?region=<%=region%>&section=<%=section%>&pages=<%=pages%>&number=<%=number+1%>">다음 페이지</a>
<%} else{%>
<h2>더이상 항목이 없네요.</h2>
<%} %>
<%} else{%>
<h2>검색하세요.</h2>
<%} %>

</body>
</html>