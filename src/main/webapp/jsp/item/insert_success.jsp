<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp">
	<jsp:param name="pageTitle" value="메인" />
</jsp:include>
    
 <% 
 int users_idx = (int)request.getSession().getAttribute("users_key");
 String root = request.getContextPath();
 //관리자 권한으로 게시글 생성.=> 일반회원 X
 %>

<h2>관광지 등록 완료!</h2>
<h5><a href="<%=root%>/jsp/item/list.jsp?<%=users_idx%>">게시판</a></h5>

<!--  이 다음에는 list.jsp 생성 후 검색조회(글 생성 링크 포함) 리스트 생성 해서 list.jsp => 글쓰 넘어갈떄 글쓰기 권한 세션 받아서 진행 -->

 
 <jsp:include page="/template/footer.jsp"></jsp:include>