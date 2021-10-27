<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp">
	<jsp:param name="pageTitle" value="메인" />
</jsp:include>
<%String root = request.getContextPath();%>
<!-- 페이지 내용 시작 -->

<h1>회원 가입</h1>

<h4>회원 가입에 성공하셨습니다.</h4>

<h6><a href="<%=root%>/">메인 페이지로</a></h6>

<!-- 페이지 내용 끝. -->
<jsp:include page="/template/footer.jsp"></jsp:include>