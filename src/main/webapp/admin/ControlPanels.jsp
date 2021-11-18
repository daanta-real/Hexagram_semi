<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="system.Settings" %>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 운영자 패널</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<% String root = request.getContextPath(); %>
<!-- 페이지 내용 시작 -->

<% // Settings.java에서 디버그 모드로 설정했을 때에만 실행되는 페이지임
if(!Settings.IS_DEBUG) {%> 

<p>디버그 모드가 켜져 있을 때에만 실행될 수 있는 페이지입니다.</p>
<p>디버그 모드를 켜시려면 아래 문구를 system/Settings.java 안에 추가해 주세요.</p>
<div sytle='color:gray; background:#333; border-radius:0.5rem; padding:0.5rem;'>
	<p>// 디버그모드 설정</p>
	<p>public static final boolean IS_DEBUG = true;</p>
</div>
	
<%} else {%>

<h2>제어판에 오신 것을 환영합니다. 아래 목록에서 원하시는 기능을 실행해 주세요.</h2>
<BUTTON ONCLICK='location.href="<%=root%>/admin/tableInitializer.jsp";'>DB 전체 초기화</BUTTON>

<%}%>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>