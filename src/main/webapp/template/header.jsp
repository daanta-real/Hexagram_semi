<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 환경설정
//request.setCharacterEncoding("UTF-8");
String title = request.getParameter("pageTitle");
System.out.println(title);
String root  = request.getContextPath();
%>
<!DOCTYPE html>
<HTML>
<HEAD>
<META CHARSET="UTF-8">
<TITLE><%=title%></TITLE>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/lib/main.js"></SCRIPT> <!-- 라이브러리 로드 -->
<LINK REL="STYLESHEET" HREF="<%=root%>/css/main.css" />
</HEAD>

<BODY>

<HEADER>
<DIV ID="userContainer">횐갑</DIV>
<DIV ID="logoContainer">
	<SPAN>노가리</SPAN>
	<IMG ID="logo" SRC="<%=root%>/resource/image/logo.png" ALT="로고"/>
	<SPAN>투어</SPAN>
</DIV>
<DIV ID="searchContainer">검색박스</DIV>
</HEADER>

<fieldset><legend>페이지 내용</legend>
<!-- <CONTENT> -->