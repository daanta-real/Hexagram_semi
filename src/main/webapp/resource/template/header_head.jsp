<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%String root = request.getContextPath();%>

<!-- ↓ HEADER_HEAD -->

<!-- 인코딩 설정 -->
<META CHARSET="UTF-8">

<!-- 뷰포트 설정 -->
<META NAME="viewport" CONTENT="width=device-width, initial-scale=1.0">

<!-- 라이브러리 로드 -->
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/main.js"></SCRIPT>

<!-- CSS 로드 -->
<LINK REL="STYLESHEET" HREF="<%=root%>/resource/css/main.css" />
<LINK REL="STYLESHEET" MEDIA="(min-width:769px)" HREF="<%=root%>/resource/css/main_pc.css" />
<LINK REL="STYLESHEET" MEDIA="(max-width:768px)" HREF="<%=root%>/resource/css/main_mobile.css" />

<!-- 파비콘 로드 -->
<link rel="apple-touch-icon" sizes="180x180" href="<%=root%>/resource/image/fabicon/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32" href="<%=root%>/resource/image/fabicon/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="<%=root%>/resource/image/fabicon/favicon-16x16.png">
<link rel="manifest" href="<%=root%>/resource/image/fabicon/site.webmanifest">
<link rel="mask-icon" href="<%=root%>/resource/image/fabicon/safari-pinned-tab.svg" color="#5bbad5">
<meta name="msapplication-TileColor" content="#da532c">
<meta name="theme-color" content="#ffffff">

<!-- ↑ HEADER_HEAD -->