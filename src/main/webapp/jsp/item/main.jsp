<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp">
	<jsp:param name="pageTitle" value="메인" />
</jsp:include>
    
 <% 
 String users_idx = (String)request.getSession().getAttribute("users_idx");
 String root = request.getContextPath();
 %>
 <h2><a href="<%=root%>/jsp/item/list.jsp?<%=users_idx%>">게시판</a></h2>
<!--  이 다음에는 list.jsp 생성 후 검색조회(글 생성 링크 포함) -->
 
 <jsp:include page="/template/footer.jsp"></jsp:include>