<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
System.out.println("[풋터 출력] from " + request.getRequestURL().toString());
%>
<!-- </SECTION> -->

<FOOTER><UL CLASS='footerContainer'>
	<LI>
		<span>이용약관</span>
		<span>&nbsp;|&nbsp;</span>
		<span>개인정보취급방침</span>
	</LI>
	<LI>ⓒ 2021 ㈜Hexagram CO., Ltd. All rights reserved.</LI>
	<LI>사이트명: 노가리투어 / 대표자명: Hexagram</LI>
	<LI>사업자등록번호: 123-45-6789</LI>
	<LI>고객지원문의전화: 010-6744-3229 (평일 오전 9시 30분 ~ 오후 6시 30분; ※ 토/일/공휴일/회사 정기휴일 및 특별휴일 제외)</LI>
	<LI>Github: <A HREF='https://github.com/daanta-real/Hexagram_semi'>https://github.com/daanta-real/Hexagram_semi</A></LI>
	<LI>세션 IDX (usersIdx) = '<%=session.getAttribute("usersIdx") %>', <%= session.getAttribute("usersIdx").getClass().getName() %></LI>
	<LI>세션 ID (usersId) = '<%=session.getAttribute("usersId") %>', <%= session.getAttribute("usersId").getClass().getName() %></LI>
	<LI>세션 GRADE (usersGrade) = '<%=session.getAttribute("usersGrade") %>', <%= session.getAttribute("usersGrade").getClass().getName() %></LI>
	<LI>#mobileMenuLayer *</LI>
</UL></FOOTER>