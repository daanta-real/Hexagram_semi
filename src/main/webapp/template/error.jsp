<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp">
	<jsp:param name="pageTitle" value="에러" />
</jsp:include>
<!-- 페이지 내용 시작 -->

<%String root = request.getContextPath();%>

<style type='text/css'>
BODY { min-width:max-content; }
CONTENT, fieldset { min-width:55rem; }
div.container {
	display:flex; flex-direction:column; justify-content:center; align-items:center;
}
:root { --errBoxScale:5; }
div.errBox {
    width: calc(8.6rem * var(--errBoxScale));
    height: calc(5rem * var(--errBoxScale));
    /*width: 860px; height: 500px;*/
	background-image:url("<%=request.getContextPath()%>/resource/image/error.jpg");
    background-size: cover;
    padding: 50px;
}
div.errBox > p {
	font-size:1.5rem;
	color:mistyrose;
	line-height:170%;
}
div.errBox > p.error {
	font-size:6rem;
	color:darksalmon;
}
</style>

<div class=container>

	<div class=errBox>
		<p class=error>ERROR</p>
		<p>여행을 가면 <font color="">일류</font></p>
		<p>여행을 못 가면 <font color="">이류</font></p>
		<p>여행을 즐기는 것을 <font color="">풍류</font></p>
		<p>페이지 오류가 나는 것을 <font color="">오류</font>라고 합니다.</p>
	</div>
	
	<div class=to>
		<span><a href="#" onclick='history.go(-1);'>뒤로 가기</a></span>
		<span>&nbsp;|&nbsp;</span>
		<span><a href="<%=root%>">메인으로</a></span>
	</div>
	
</div>

<!-- 페이지 내용 끝. -->
<jsp:include page="/template/footer.jsp"></jsp:include>