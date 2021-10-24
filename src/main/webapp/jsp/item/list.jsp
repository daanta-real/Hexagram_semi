<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp">
	<jsp:param name="pageTitle" value="메인" />
</jsp:include>
    
 <% 
 Integer users_idx = (Integer)request.getSession().getAttribute("users_key");
 String root = request.getContextPath();
 //관리자 권한으로 게시글 생성.=> 일반회원 X
 %>

 <h2>검색 및 목록</h2>


 
 <jsp:include page="/template/footer.jsp"></jsp:include>