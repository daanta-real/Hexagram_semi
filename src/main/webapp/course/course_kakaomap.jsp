<%@page import="beans.CourseItemDto"%>
<%@page import="java.util.List"%>
<%@page import="beans.CourseItemDao"%>
<%@page import="beans.ItemDto"%>
<%@page import="beans.ItemDao"%>
<%@ page import="system.Settings"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<%
//마커까지 완성형임.
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
    <style>
.label {margin-bottom: 100px;}
.label:hover{
	color : blue;
	border : 1px solid blue;
}
.label * {display: inline-block;vertical-align: top;}
.label .left {background: url("https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_l.png") no-repeat;display: inline-block;height: 24px;overflow: hidden;vertical-align: top;width: 7px;}
.label .center {background: url(https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_bg.png) repeat-x;display: inline-block;height: 24px;font-size: 22px;line-height: 24px;}
.label .right {background: url("https://t1.daumcdn.net/localimg/localimages/07/2011/map/storeview/tip_r.png") -1px 0  no-repeat;display: inline-block;height: 24px;overflow: hidden;width: 6px;}
</style>
</head>
<body>

<div id="map" style="width:900px;height:450px;"></div>

<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<%=system.Settings.API_KEY_KAKAOMAP%>&libraries=services"></script>
	<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.55321, 126.972613), // 지도의 중심좌표 지금은 서울역으로 해놓았으나, 정확한 주소를 입력할 시에 이동이 가능함.
        level: 10 // 지도의 확대 레벨
    };  
// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

var geocoder = new kakao.maps.services.Geocoder();
//주소로 좌표를 검색합니다
   var  mapX=0;
    
<%for(int i = 0 ; i < courseItemList.size() ; i++){%>
<%
ItemDto itemDto = itemDao.get(courseItemList.get(i).getItemIdx());
%>
geocoder.addressSearch('<%=itemDto.getItemAddress()%>', function(result, status) {
    // 정상적으로 검색이 완료됐으면 
    
     if (status === kakao.maps.services.Status.OK) {
        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });
        marker.setMap(map);
        
        var content = '<div class ="label">'+
        '<span class="left"></span><span class="center">'+
        '  <a href="<%=root%>/item/detail.jsp?itemIdx=<%=itemDto.getItemIdx()%>"><%=(i+1)+"."+itemDto.getItemName()%></a>' +
        '</span><span class="right"></span></div>';


  // 커스텀 오버레이가 표시될 위치입니다 
     var position = new kakao.maps.LatLng(result[0].y, result[0].x);  
     // 커스텀 오버레이를 생성합니다
     var customOverlay = new kakao.maps.CustomOverlay({
         position: position,
         content: content   
     });

     // 커스텀 오버레이를 지도에 표시합니다
     customOverlay.setMap(map);
     

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        if(mapX<result[0].x){
        	mapX = result[0].x;
       		 map.setCenter(coords);
        }
    } 
     
});  
<%}%>

</script>
</body>
</html>