<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="util.HexaLibrary" %>
<%@ page import="beans.UsersDao" %>
<%@ page import="beans.UsersDto" %>
<%
// 환경설정
String title = "노가리투어ㅡ" + request.getParameter("pageTitle");
System.out.println("<헤더 출력> from " + request.getRequestURL().toString() + "(" + title + ")");
String root  = request.getContextPath();

//세션id를 확인하여 로그인 여부를 검사
String sessionId = (String) request.getSession().getAttribute("usersId");
boolean isLogin = HexaLibrary.isExists(sessionId);
%>
<!DOCTYPE html>
<HTML>
<HEAD>
<META CHARSET="UTF-8">
<TITLE><%=title%></TITLE>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/js/main.js"></SCRIPT> <!-- 라이브러리 로드 -->
<LINK REL="STYLESHEET" HREF="<%=root%>/css/main.css" />             <!-- CSS 로드 -->
<!-- 파비콘 로드 -->
<link rel="apple-touch-icon" sizes="180x180" href="<%=root%>/resource/image/fabicon/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32" href="<%=root%>/resource/image/fabicon/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="<%=root%>/resource/image/fabicon/favicon-16x16.png">
<link rel="manifest" href="<%=root%>/resource/image/fabicon/site.webmanifest">
<link rel="mask-icon" href="<%=root%>/resource/image/fabicon/safari-pinned-tab.svg" color="#5bbad5">
<meta name="msapplication-TileColor" content="#da532c">
<meta name="theme-color" content="#ffffff">
</HEAD>

<BODY>

<HEADER>
<DIV ID="userContainer">
<%

// 로그인이 되었을 경우
if(isLogin) {
	UsersDao dao = new UsersDao();
	UsersDto dto = dao.get(sessionId);
	String usersId = dto.getUsersId();
	String usersNick = dto.getUsersNick();
	String usersGrade = dto.getUsersGrade();%>
	<h5><%=usersNick%>(<%=usersId%>)님 (등급: <%=usersGrade%>)</h5>
	<a href='<%=root%>/users/logout.nogari'><button>로그아웃</button></a>
<%}
// 로그인이 되지 않았을 경우
else {%>
	<a href='<%=root%>/jsp/users/login.jsp'><button>로그인</button></a>
<%}%>
</DIV>
<DIV ID="logoContainer"><A HREF="<%=root%>">
	<SPAN>노가리</SPAN>
	<IMG ID="logo" SRC="<%=root%>/resource/image/logo.png" ALT="로고"/>
	<SPAN>투어</SPAN>
</A></DIV>
<DIV ID="searchContainer">검색박스</DIV>
</HEADER>

<fieldset><legend>페이지 내용</legend>
<!-- <CONTENT> -->