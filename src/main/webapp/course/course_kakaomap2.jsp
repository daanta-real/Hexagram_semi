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
<p style="margin-top:-12px">
    <em class="link">
        <a href="javascript:void(0);" onclick="window.open('http://fiy.daum.net/fiy/map/CsGeneral.daum', '_blank', 'width=981, height=650')">
            혹시 주소 결과가 잘못 나오는 경우에는 여기에 제보해주세요.
        </a>
    </em>
</p>
<div id="map" style="width:100%;height:350px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<%=system.Settings.API_KEY_KAKAOMAP%>&libraries=services"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 



// 주소로 좌표를 검색합니다
<%for(int i = 0 ; i < courseItemList.size() ; i++){%>

	<%ItemDto itemDto = itemDao.get(courseItemList.get(i).getItemIdx());%>


// 주소-좌표 변환 객체를 생성합니다
var geocoder = new kakao.maps.services.Geocoder();
geocoder.addressSearch('<%=itemDto.getItemAddress()%>', function(result, status) {

	<%if(i>0){%>
		var lestCoords = [
        <%if(i ==courseItemList.size()-1){%>
        [result[0].y, result[0].x,'<div style="padding: 5px"><%=itemDto.getItemName()%></div>']
        <%}else{%>
        [result[0].y, result[0].x,'<div style="padding: 5px"><%=itemDto.getItemName()%></div>'],
        <%}%>
        ];
		
		<%}else if(i==0){%>
    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;">우리회사</div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
});

<%}%>
<%}%>

for (var i = 0; i < lestCoords.length; i ++) {
    
    // 마커를 생성합니다
    var marker = new lestCoordsMarker({
        position: new kakao.maps.Lating(lestCoords[i][0],lestCoords[i][1]),
        map: map // 마커를 표시할 지도

    });
    
    var infowindow = new kakao.maps.InfoWindow({
    	content: lestCoords[i][2]
    });
}

</script>
</body>
</html>