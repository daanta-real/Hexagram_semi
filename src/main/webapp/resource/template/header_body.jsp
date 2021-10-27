<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="util.HexaLibrary" %>
<%@ page import="beans.UsersDao" %>
<%@ page import="beans.UsersDto" %>

<!-- ↓ HEADER_BODY -->
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
<!-- 상단메뉴 -->
<HEADER CLASS="flexCenter flexCol">

	<!-- 상단메뉴 - 로그인 정보 박스 -->
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
	
	<!-- 상단메뉴 - 노가리 로고그림 영역 -->
	<DIV ID="logoContainer" CLASS="flexCenter flexCol">
		<DIV ID="logoBox">
			<A CLASS="flexCenter flexRow" HREF="<%=root%>">
				<SPAN>노가리</SPAN>
				<IMG ID="logo" SRC="<%=root%>/resource/image/logo.png" ALT="로고"/>
				<SPAN>&nbsp;투어</SPAN>
			</A>
		</DIV>
	</DIV>
	
	<!-- 상단메뉴 - 검색창 영역 -->
	<FORM ID='searcherContainer' CLASS="flexCenter flexCol" METHOD='GET' ACTION=searchAll.jsp>
		<DIV ID='searcherBox'>
			<INPUT CLASS="searcher textCenter" value="<%=searcher%>" placeholder="검색" ALT="검색창" />
			<SPAN CLASS="magnifier">🔍</SPAN>
		</DIV>
		<SPAN ONCLICK='document.getElementById("mainDetailSearcher").style.visibility = "visible;"'>상세검색 ▼</SPAN>
		<DIV ID="mainDetailSearcher">상세검색이다 우와아아앙</DIV>
	</FORM>
	
	<!-- 상단메뉴 - 주 메뉴 영역 -->
	<DIV ID='menuContainer' CLASS="flexCenter flexRow">
		<A HREF="<%=root%>/item/list.jsp">관광지 정보</A>
		<span>|</span>
		<A HREF="<%=root%>/course/list.jsp">코스 정보</A>
		<span>|</span>
		<A HREF="<%=root%>/event/list.jsp">이벤트 정보</A>
	</DIV>
	
</HEADER>

<!-- ↑ HEADER_BODY -->