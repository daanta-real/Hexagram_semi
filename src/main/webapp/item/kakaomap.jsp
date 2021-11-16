<%@page import="beans.ItemDto"%>
<%@page import="beans.ItemDao"%>
<%@ page import="system.Settings"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%

String root = request.getContextPath();

int itemIdx = Integer.parseInt(request.getParameter("itemIdx"));

ItemDao itemDao = new ItemDao();
ItemDto itemDto = itemDao.get(itemIdx);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>주소로 장소 표시하기</title>
    	<style>
		#map {
			width: 800px;
			height: 350px;
		}
	</style>

<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<%=system.Settings.API_KEY_KAKAOMAP%>&libraries=services"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
	<script>
	var address = '<%=itemDto.getItemAddress()%>';

	$(function(){
		//지도 생성 준비 코드
		var container = document.querySelector("#map");
		var options = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 3
		};

		//지도 생성 코드
		var map = new kakao.maps.Map(container, options);
		
// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();

// 주소로 좌표를 검색합니다
geocoder.addressSearch(address, function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });
        
        marker.setMap(map);
        
		var infoWindowText = $("#marker-info-window-template").html();
		infoWindowText = infoWindowText.replace("{mapY}", result[0].y);
		infoWindowText = infoWindowText.replace("{mapX}", result[0].x);
		infoWindowText = infoWindowText.replace("{mapY}", result[0].y);
		infoWindowText = infoWindowText.replace("{mapX}", result[0].x);
		var iwPosition = new kakao.maps.LatLng(result[0].y, result[0].x);
		
        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            position : iwPosition,
        	content: infoWindowText
        	
        		});
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});    


	});

</script>
</head>
<body>
	<template id="marker-info-window-template">
		<div style="padding:5px;">
			<%=itemDto.getItemName()%> <br>
			<a href="https://map.kakao.com/link/map/<%=itemDto.getItemName()%>,{mapY},{mapX}" style="color:blue" target="_blank">큰지도보기</a> 
			<a href="https://map.kakao.com/link/to/<%=itemDto.getItemName()%>,{mapY},{mapX}" style="color:blue" target="_blank">길찾기</a>
		</div>
	</template>
	
	<div id="map"></div>
</body>
</html>
