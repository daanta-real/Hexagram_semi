<%@page import="beans.ItemDto"%>
<%@page import="beans.ItemDao"%>
<%@ page import="system.Settings"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="/resource/template/header.jsp">
	<jsp:param name="pageTitle" value="주소로 장소 표시하기" />
</jsp:include>
<SECTION CLASS="flexCenter flexCol">
<!-- 페이지 내용 시작 -->

<%
int itemIdx = Integer.parseInt(request.getParameter("itemIdx"));

ItemDao itemDao = new ItemDao();
ItemDto itemDto = itemDao.get(itemIdx);
%>

	<div id="map" style="width: 100%; height: 300px;"></div>

	<script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<%=system.Settings.API_KEY_KAKAOMAP %>"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level : 3 // 지도의 확대 레벨
		};

		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption);

		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();

		// 주소로 좌표를 검색합니다
		geocoder
				.addressSearch(
						'<%=itemDto.getItemAddress()%>',
						function(result, status) {

							// 정상적으로 검색이 완료됐으면 
							if (status === kakao.maps.services.Status.OK) {

								var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

								// 결과값으로 받은 위치를 마커로 표시합니다
								var marker = new kakao.maps.Marker({
									map : map,
									position : coords
								});

								// 인포윈도우로 장소에 대한 설명을 표시합니다
								var infowindow = new kakao.maps.InfoWindow({
									content : '<div style="width:150px;text-align:center;padding:6px 0;"><%=itemDto.getItemName()%></div>'
								});
								infowindow.open(map, marker);

								// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
								map.setCenter(coords);
							}
						});
	</script>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>