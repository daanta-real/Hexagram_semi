<%@page import="util.users.Sessioner" %>
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
	<LI>프로젝트 Github 주소: <A HREF='https://github.com/daanta-real/Hexagram_semi'>https://github.com/daanta-real/Hexagram_semi</A></LI>
	<LI>참여 인원(가나다순)</LI>
	<LI>김의동: <A HREF='https://github.com/EUIDONGKIM'>https://github.com/EUIDONGKIM</A></LI>
	<LI>김소은: <A HREF='https://github.com/soeun407'>https://github.com/soeun407</A></LI>
	<LI>민선아: <A HREF='https://github.com/seonami'>https://github.com/seonamin</A></LI>
	<LI>박준성: <A HREF='https://github.com/daanta-real'>https://github.com/daanta-real</A></LI>
	<LI>조수현: <A HREF='https://github.com/qww2141'>https://github.com/qww2141</A></LI>
	<LI>홍성진: <A HREF='https://github.com/hongbba'>https://github.com/hongbba</A></LI>
	<%
	//<LI>세션 정보 출력:</LI>
	//<LI><PRE><%=Sessioner.getInfo(session)%/></PRE></LI>
	%>
</UL></FOOTER>