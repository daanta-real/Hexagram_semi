<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="util.HexaLibrary" %>
<%@ page import="beans.UsersDao" %>
<%@ page import="beans.UsersDto" %>

<!-- ↓ HEADER_BODY -->
<%
// 환경설정
System.out.println("[헤더 출력] from " + request.getRequestURL().toString());
String root = request.getContextPath();
String searcher = request.getParameter("searchKeyword");
if(searcher == null) searcher = "";

// 세션id를 확인하여 로그인 여부를 검사
String sessionId = (String) request.getSession().getAttribute("usersId");
boolean isLogin = sessionId != null && !sessionId.equals("");

// 로그인 검사결과에 따른 변수준비
String usersId = "", usersNick = "", usersGrade = "", gradeStr = "";

// 로그인 시에만 변수대입
if(isLogin) {
	UsersDao dao = new UsersDao();
	UsersDto dto = dao.get(sessionId);
	usersId = dto.getUsersId();
	usersNick = dto.getUsersNick();
	usersGrade = dto.getUsersGrade();
	gradeStr
		= usersGrade.equals("준회원") ? "newbie"
		: usersGrade.equals("정회원") ? "normal"
		: usersGrade.equals("관리자") ? "admin"
		:                             "error";
}
%>

<!-- 디버그용 -->
<DIV ID="debugContainer">
	<BUTTON ONCLICK='location.href="<%=root%>/users/tableInitializer.jsp";'>DB 초기화</BUTTON>
	<form onsubmit="return false;"><INPUT ID='debug_query' TYPE=text /><BUTTON ONCLICK='debug_rainbowQueryRun();'>레이어 해체보기</BUTTON></form>
</DIV>

<!-- 모바일 메뉴 콘테이너 -->
<DIV ID='mobileMenuLayer'>
	
	<!-- 모바일 메뉴 - 햄버거 버튼 -->
	<!-- <INPUT ID='mobileMenuHamburgerInput' TYPE='hidden'> -->
	<DIV ID="hamburgerBox">
		<LABEL FOR='mobileMenuHamburgerInput'>
			<SPAN></SPAN>
			<SPAN></SPAN>
			<SPAN></SPAN>
		</LABEL>
	</DIV>
	
	<!-- 모바일 메뉴 박스 -->
	<DIV ID='mobileMenuContainer'>
	
		<DIV ID='mobileMenuLoginContainer' CLASS="flexCenter flexCol">
			<!-- 모바일 박스 메뉴 - 로그인 없을 시 -->
			<%if(isLogin) { /* 로그인이 되었을 경우 */ %>
			<H3 CLASS="userInfoTxt"><%=usersNick%>(<%=usersId%>)님 <SPAN class="<%=gradeStr%>"><%=usersGrade%></SPAN></H3>
			<A CLASS='actionButtons loginoutButton flexCenter' HREF='<%=root%>/users/logout.nogari'>로그아웃</A>
			<%} else { /* 로그인이 되지 않았을 경우 */ %>
			<FORM ID='loginInput' CLASS='flexCenter flexCol' NAME='login' METHOD='POST' ACTION='<%=root%>/users/login.nogari'>
				<INPUT TYPE='text' NAME='usersId' VALUE="<% %>" PLACEHOLDER="입력하세요"/>
				<INPUT TYPE='password' NAME='usersPw' VALUE="<% %>" PLACEHOLDER="입력하세요"/>
				<DIV CLASS="loginButtonBox flexCenter flexRow">
					<BUTTON CLASS='actionButtons loginoutButton' TYPE='submit'>로그인</BUTTON>
					<INPUT CLASS='actionButtons joinButton' TYPE='button' VALUE="회원가입" />
				</DIV>
			</FORM>
			<%}%>
		</DIV>
		
	</DIV>
	
</DIV>

<!-- 상단메뉴 -->
<HEADER CLASS="flexCenter flexCol">
	
	<!-- 상단메뉴 - 로그인 정보 박스 -->
	<DIV ID="userContainer" CLASS="flexCenter flexRow">
	<%if(isLogin) { /* 로그인이 되었을 경우 */ %>
		<H4 CLASS="userInfoTxt"><%=usersNick%>(<%=usersId%>)님 <SPAN class="<%=gradeStr%>"><%=usersGrade%></SPAN></H4>
		<A CLASS='userButton' HREF='<%=root%>/users/detail.jsp'>내 정보</A>
		<A CLASS='userButton' HREF='<%=root%>/users/logout.nogari'>로그아웃</A>
		<%if( usersGrade.equals("관리자")) {%>
			<A CLASS='userButton' HREF='<%=root%>/admin/main.jsp'>관리</A>
		<%} %>
	<%} else { /* 로그인이 되지 않았을 경우 */ %>
		<H4 CLASS="userInfoTxt">로그인하세요.</H4><A CLASS='userButton' HREF='<%=root%>/users/login.jsp'>로그인</A>
		<H4 CLASS="userInfoTxt">회원가입 페이지</H4><A CLASS='userButton' HREF='<%=root%>/users/join.jsp'>회원가입</A>
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
			<DIV CLASS="magnifier">🔍</DIV>
		</DIV>
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