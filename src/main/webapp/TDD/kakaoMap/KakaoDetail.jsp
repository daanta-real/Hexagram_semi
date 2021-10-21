<%@page import="beans.APIDto"%>
<%@page import="beans.APIDao"%>
<%@page import="system.Settings"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
	String address = request.getParameter("address");
	String title = request.getParameter("title");
	String mapy = request.getParameter("mapy");
	String mapx =	request.getParameter("mapx");
	String img = request.getParameter("img");
	String contentid = request.getParameter("contentid");
    
	APIDao apiDao = new APIDao();
	
	APIDto aPIDtoExplain = apiDao.getTourSegmentObject(contentid);
	APIDto aPIDtoEtc = apiDao.getEtcInfo(contentid);        

  %>
    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 만든 상세조회</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<%=system.Settings.API_KEY_KAKAOMAP %>"></script>
</head>
<body>
<h1>관광지 상세 설명</h1>
<ul>
	<li>주소 : <%=address%></li>
	<li>지명 : <%=title%></li>
	<li>설명 : <%=aPIDtoExplain.getOverview()%></li>
	<li>참조 홈페이지 : <%=aPIDtoExplain.getHomepage()%></li>
	<li>담당 부서 : <%=aPIDtoEtc.getInfocenter()%></li>
	<li>주차 여부 : <%=aPIDtoEtc.getParking()%></li>
	<li>운영 시간 : <%=aPIDtoEtc.getUsetime()%></li>
	<li>관광지 사진</li>
</ul>
<img src="<%=img%>">


<div id="map" style="width:600px;height:600px;"></div>
카카오 지도 표시!

</body>

<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=b7b59922097d6f4a6c38970ebbf190aa"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng('<%=mapy%>', '<%=mapx%>'),
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption);

//마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng('<%=mapy%>', '<%=mapx%>');

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

const str = ''.concat('<div style="padding:5px;">Hello World! <br><a href="https://map.kakao.com/link/map/Hello World!,');
const str1 = str.concat('<%=mapy%>,<%=mapx%>" ');
const str2 = str1.concat('style="color:blue" target="_blank">큰지도보기</a> <a href="https://map.kakao.com/link/to/Hello World!,');
const str3 = str2.concat('<%=mapy%>,<%=mapx%>" ');
const str4 = str3.concat('style="color:blue" target="_blank">길찾기</a></div>');
var iwContent = str4;
iwPosition = new kakao.maps.LatLng('<%=mapy%>', '<%=mapx%>'); //인포윈도우 표시 위치입니다

//인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({
position : iwPosition, 
content : iwContent 
});
</script>
</html>