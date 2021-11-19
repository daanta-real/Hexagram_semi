<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="system.TableInitializer" %>
<%@ page import="util.users.Sessioner" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%

// 로그아웃 + DB 초기화 실행까지 다 해주는 웹사이트 초기화 JSP 파일이다.

// 1. 시작
System.out.println("로그아웃 처리..");
Sessioner.logout(session);
System.out.println("완료.");

%>
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

<!-- 1. 로그아웃 처리 -->
<p>[로그아웃] 페이지를 로그아웃하면서 세션 비우기를 완료했습니다.</p>

<!-- 2. 시작 -->
<p>[DB 초기화] DB 초기화 실행. 태초의 상태로 돌아갑니다..</p>
<!-- 3. DB 전체 삭제 (테이블/시퀀스/제약조건/더미) -->
<p>[DB 초기화] 테이블 전체 지우기 작업 중...
<%
try { TableInitializer.run("DELETE"); }
catch(Exception e) { e.printStackTrace(); return; }
%>
완료!</p>

<!-- 4. DB 전체 생성 (테이블/시퀀스/제약조건/더미) -->
<p>[DB 초기화] 테이블 전체 만들기 작업 중...
<%
try { TableInitializer.run("CREATE"); }
catch(Exception e) { e.printStackTrace(); return; }
%>
완료!</p>

<!-- 5. 메인으로 리다이렉트 -->
<p>[DB 초기화] DB 초기화 성공.<br/>id: admin1, idx: 1, 닉네임: 관리자1, 등급: 관리자<br/>이렇게 세션을 새로 부여해 드립니다..</p>
<%
session.setAttribute("usersIdx"  , "1");
session.setAttribute("usersId"   , "admin1");
session.setAttribute("usersGrade", "관리자1");
%>
<p>메인 페이지로 돌아갑니다..</p>
<a href="<%=root%>"><button>메인으로</button></a>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML> 