<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="util.HexaLibrary" %>
<%@ page import="beans.UsersDao" %>
<%@ page import="beans.UsersDto" %>
<%
// 환경설정
String title = "노가리투어ㅡ" + request.getParameter("pageTitle");
System.out.println("<헤더 출력> from " + request.getRequestURL().toString() + "(" + title + ")");
String root = request.getContextPath();
String searcher = request.getParameter("searchKeyword");
if(searcher == null) searcher = "";

//세션id를 확인하여 로그인 여부를 검사
String sessionId = (String) request.getSession().getAttribute("usersId");
boolean isLogin = HexaLibrary.isExists(sessionId);
%>
<!DOCTYPE html>
<HTML>
<HEAD>
<META CHARSET="UTF-8">
<TITLE><%=title%></TITLE>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/main.js"></SCRIPT> <!-- 라이브러리 로드 -->
<LINK REL="STYLESHEET" HREF="<%=root%>/resource/css/main.css" />             <!-- CSS 로드 -->
<!-- 파비콘 로드 -->
<link rel="apple-touch-icon" sizes="180x180" href="<%=root%>/resource/image/fabicon/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32" href="<%=root%>/resource/image/fabicon/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="<%=root%>/resource/image/fabicon/favicon-16x16.png">
<link rel="manifest" href="<%=root%>/resource/image/fabicon/site.webmanifest">
<link rel="mask-icon" href="<%=root%>/resource/image/fabicon/safari-pinned-tab.svg" color="#5bbad5">
<meta name="msapplication-TileColor" content="#da532c">
<meta name="theme-color" content="#ffffff">
</HEAD>

<BODY CLASS="flexCenter flexCol">

<HEADER CLASS="flexCenter flexCol">
<DIV ID="userContainer" CLASS="flexCenter flexRow">
<%

// 로그인이 되었을 경우
if(isLogin) {
	UsersDao dao = new UsersDao();
	UsersDto dto = dao.get(sessionId);
	String usersId = dto.getUsersId();
	String usersNick = dto.getUsersNick();
	String usersGrade = dto.getUsersGrade();%>
	<H4 CLASS="userInfoTxt"><%=usersNick%>(<%=usersId%>)님 <SPAN>등급: <%=usersGrade%></SPAN></H4>
	<A CLASS='userButton' HREF='<%=root%>/users/logout.nogari'>로그아웃</A>
<%}
// 로그인이 되지 않았을 경우
else {%>
	<A CLASS='userButton' HREF='<%=root%>/users/login.jsp'>로그인</A>
<%}%>
</DIV>
<DIV ID="logoContainer" CLASS="flexCenter flexRow"><A CLASS="flexCenter flexRow" HREF="<%=root%>">
	<SPAN>노가리</SPAN>
	<IMG ID="logo" SRC="<%=root%>/resource/image/logo.png" ALT="로고"/>
	<SPAN>&nbsp;투어</SPAN>
</A></DIV>
<FORM ID='searcherContainer' METHOD='GET' ACTION=searchAll.jsp>
	<INPUT CLASS="searcher textCenter" value="<%=searcher%>" placeholder="검색" ALT="검색창" />
	<SPAN CLASS="magnifier">🔍</SPAN>
</FORM>
<DIV ID='menuContainer' CLASS="flexCenter flexRow">
	<A HREF="/item/list.jsp">관광지 정보</A>
	<span>|</span>
	<A HREF="/course/list.jsp">코스 정보</A>
	<span>|</span>
	<A HREF="/event/list.jsp">이벤트 정보</A>
</DIV>
</HEADER>

<CONTENT CLASS="flexCenter flexCol">
<!-- <CONTENT> -->