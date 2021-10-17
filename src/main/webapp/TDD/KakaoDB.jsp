<%@page import="beans.APIDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.TestDto"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%		
       			int region = 0; String strRegion = request.getParameter("region");
                int section = 0; String strSection = request.getParameter("section");
                int pages = 0;	String strPages = request.getParameter("pages");
                int number = 1;	String strNumber = request.getParameter("number");

                if(request.getParameter("region") != null && !request.getParameter("region").equals("0")&& !request.getParameter("region").equals("")){
                	region=Integer.parseInt(request.getParameter("region"));
                }
                if(request.getParameter("section") != null && !request.getParameter("section").equals("0") && !request.getParameter("section").equals("")){
                	section=Integer.parseInt(request.getParameter("section"));
                }
                if(request.getParameter("pages") != null && !request.getParameter("pages").equals("0")&& !request.getParameter("pages").equals("")){
                	pages=Integer.parseInt(request.getParameter("pages"));
                }
                if(request.getParameter("number") != null && Integer.parseInt(request.getParameter("number")) > 1&& !request.getParameter("number").equals("")){
                	number=Integer.parseInt(request.getParameter("number"));
                }else{
                	number = 1;
                }
                
                APIDao apiDao = new APIDao();      
         		List<String> regionList = apiDao.getReionName();
                int regionCount = 1;
        %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h1><a href="./KakaoDB.jsp">관광지 Google</a></h1>

<form action="./KakaoDB.jsp">
	<select name="region" required="required">
		<option value="0">지역 선택</option>
		<%for(String str : regionList){ %>
		<%if(region==regionCount) {%>
		<option value="<%=regionCount++%>" selected><%=str%></option>
		<%}else{%>
		<option value="<%=regionCount++%>"><%=str%></option>
			<%}%>
		<%}%>
	</select>
&nbsp;

<%if(region == 0){%>
	<select name="section">
		<option value="0">구 선택</option>
	</select>
<%} else{%>

<%
List<String> sectionList = apiDao.getSigunguName(region);
int sectionCount = 1;
%>

	<select name="section">
		<option value="">구 선택</option>
		<%for(String str : sectionList) {%>
		<option value="<%=sectionCount++%>"><%=str%></option>
			<%}%>
		<%}%>
	</select>		
&nbsp;
	<%if(region == 0 && section ==0) {%>
		<select name="pages">
		<option value="0">검색 개수 선택</option>
	<%} else{%>
		<select name="pages" required="required">
		<option value="0" selected disabled>검색 개수 선택</option>
		<option value="1">1</option>
		<option value="2">2</option>
		<option value="3">3</option>
		<option value="4">4</option>
		<option value="5">5</option>
		<%}%>
	</select>
&nbsp;
	<input type="submit" value="검 색">
</form>

<%
List<TestDto> list = new ArrayList<>();
boolean search = region != 0 && section != 0 && pages !=0;
if(search){
list = apiDao.getTourList(region, section, pages, number);
}
%>

<br><br><br>


<%if(search) {%>
	<%if(list.size() !=0) {%>
<table border="1" width="1050">
	<thead>
		<tr>
		<th>순 서</th>
		<th>TITLE</th>
		<th>ADDRESS</th>
		<th>DB단일조회</th>
		<th>CUSTOM단일조회</th>
		<th>DB주변목록</th>
		<th>비 고</th>
		</tr>
	</thead>
	
	<tbody align="center">
		<%for(int i=0 ; i<list.size() ; i++){ %>
	<tr>
		<td><%=i+1%>번</td>
		<td><%=list.get(i).getTitle()%></td>
		<td><%=list.get(i).getAddress()%></td>
		
		<%
		String detail = apiDao.getTourDetailExaminationString(list.get(i).getContentid());
		%>
		<td><a href="<%=detail%>"><img src="<%=list.get(i).getImg()%>" width="80" height="80"><br/>클릭</a></td>
		<%
		String address = list.get(i).getAddress();
		String title = list.get(i).getTitle();
		String mapy = list.get(i).getMapy();
		String mapx = list.get(i).getMapx();
		String img = list.get(i).getImg();
		String contentid = list.get(i).getContentid();
		%>
		<td>
		<a href="./KakaoDetail.jsp?address=<%=address%>&title=<%=title%>&mapy=<%=mapy%>&mapx=<%=mapx%>&img=<%=img%>&contentid=<%=contentid%>">상세 보기(custom)</a>
		</td>
		
		<%
		String around = apiDao.getTourAroundString(list.get(i).getMapx(), list.get(i).getMapy());
		%>
		<td><a href="<%=around%>">주변 상세 보기(전방 1km내)</a></td>
			
			
			<td>반경 조절 가능</td>
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
<h4>지역(도시) 검색 후 추가 항목을 설정하세요.</h4>
<%} %>

</body>
</html>