<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="system.TableInitializer" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - DB 재생성</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<% String root = request.getContextPath(); %>
<!-- 페이지 내용 시작 -->

<!-- 1. 시작 -->
<p>[DB 초기화] DB 초기화 실행. 태초의 상태로 돌아갑니다..</p>
<!-- 2. DB 전체 삭제 (테이블/시퀀스/제약조건/더미) -->
<p>[DB 초기화] 테이블 전체 지우기 작업 중...
<%
try { TableInitializer.run("DELETE"); }
catch(Exception e) { e.printStackTrace(); return; }
%>
완료!</p>

<!-- 3. DB 전체 생성 (테이블/시퀀스/제약조건/더미) -->
<p>[DB 초기화] 테이블 전체 만들기 작업 중...
<%
try { TableInitializer.run("CREATE"); }
catch(Exception e) { e.printStackTrace(); return; }
%>
완료!</p>

<!-- 4. 메인으로 리다이렉트 -->
<p>[DB 초기화] DB 초기화 성공. admin(닉네임: 관리자1, 등급: 관리자)님으로 세션을 새로 부여해 드립니다..</p>
<%
session.setAttribute("usersIdx"  , "1");
session.setAttribute("usersId"   , "admin");
session.setAttribute("usersGrade", "관리자");
%>
<p>메인 페이지로 돌아갑니다..</p>
<a href="<%=root%>"><button>메인으로</button></a>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML> 