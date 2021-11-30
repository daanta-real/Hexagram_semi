<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 메인</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
<style type='text/css'>
section > img { object-fit:cover; width: 38rem; margin:2rem; }
</style>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<% String root = request.getContextPath(); %>
<!-- 페이지 내용 시작 -->

<img src="<%=root %>/resource/image/main/1.jpg" ALT="이미지"/>
<img src="<%=root %>/resource/image/main/2.jpg" ALT="이미지"/>
<img src="<%=root %>/resource/image/main/3.jpg" ALT="이미지"/>
<img src="<%=root %>/resource/image/main/4.jpg" ALT="이미지"/>
<img src="<%=root %>/resource/image/main/5.jpg" ALT="이미지"/>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>