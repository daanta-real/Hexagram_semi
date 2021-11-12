<%@page import="beans.CourseItemDto"%>
<%@page import="java.util.List"%>
<%@page import="beans.CourseItemDao"%>
<%@page import="beans.ItemDto"%>
<%@page import="beans.ItemDao"%>
<%@ page import="system.Settings"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%

String root = request.getContextPath();

int courseIdx = Integer.parseInt(request.getParameter("courseIdx"));

CourseItemDao courseItemDao = new CourseItemDao();
List<CourseItemDto> courseItemList = courseItemDao.getByCourse(courseIdx);

ItemDao itemDao = new ItemDao();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>주소로 장소 표시하기</title>
    
</head>
<body>

<div id="map" style="width:800px;height:350px;"></div>

<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<%=system.Settings.API_KEY_KAKAOMAP%>&libraries=services"></script>
	<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.55321, 126.972613), // 지도의 중심좌표 지금은 서울역으로 해놓았으나, 정확한 주소를 입력할 시에 이동이 가능함.
        level: 3 // 지도의 확대 레벨
    };  
    
//선배열 초기화
var linePath = [];

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

//주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();


//주소로 좌표를 검색합니다
<%for(int i = 0 ; i < courseItemList.size() ; i++){%>
<%
ItemDto itemDto = itemDao.get(courseItemList.get(i).getItemIdx());
%>
geocoder.addressSearch('<%=itemDto.getItemAddress()%>', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
        //선 배열 값입력
        
        
        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;"><%=itemDto.getItemName()%></div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        <%if(i==0){%>
        map.setCenter(coords);
        <%}%>
    } 
     
});  
<%}%>

var linePath = [];
linePath.push(new kakao.maps.LatLng(result[0].y, result[0].x);
//선을 구성하는 좌표 배열입니다. 이 좌표들을 이어서 선을 표시합니다
var linePath = [
    new kakao.maps.LatLng(33.452344169439975, 126.56878163224233),
    new kakao.maps.LatLng(33.452739313807456, 126.5709308145358),
    new kakao.maps.LatLng(33.45178067090639, 126.5726886938753) 
];

// 지도에 표시할 선을 생성합니다
var polyline = new kakao.maps.Polyline({
    path: linePath, // 선을 구성하는 좌표배열 입니다
    strokeWeight: 5, // 선의 두께 입니다
    strokeColor: '#FFAE00', // 선의 색깔입니다
    strokeOpacity: 0.7, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
    strokeStyle: 'solid' // 선의 스타일입니다
});

// 지도에 선을 표시합니다 
polyline.setMap(map);  

</script>
</body>
</html>