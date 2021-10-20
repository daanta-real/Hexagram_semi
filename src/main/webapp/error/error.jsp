<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러</title>
<style type='text/css'>
div.err {
    width: 860px;
    height: 500px;
	background-image:url("<%=request.getContextPath()%>/resource/image/error.jpg");
    padding: 50px;
}
p {
	font-size:25px;
	color:burlywood;
}
p.error {
	font-size:80px;
	color:darksalmon;
}
a:link, a:visited, a:active, a:hover { text-decoration:none; }
</style>
</head>
<body>
<div class=err>
	<p class=error>ERROR</p>
	<p>여행을 좋아하면 <font color="">일류</font></p>
	<p>여행을 못 가면 <font color="">이류</font></p>
	<p>여행을 즐기는 것을 <font color="">풍류</font></p>
	<p>페이지 오류가 나는 것을 <font color="">오류</font>라고 합니다.</p>
</div>
<br/>
<a href="#" onclick='history.go(-1);'>뒤로 가기</a>
</body>
</html>