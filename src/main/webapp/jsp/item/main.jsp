<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp">
	<jsp:param name="pageTitle" value="메인" />
</jsp:include>
    
 <% 
request.getSession().setAttribute("usersIdx", 1);
request.getSession().setAttribute("usersGrade", "관리자");
			//테스트 세션 생성 => 각자의 DB정보에 따라 입력.

 String root = request.getContextPath();
 //관리자 권한으로 게시글 생성.=> 일반회원 X
		 
 %>

 <h2><a href="<%=root%>/jsp/item/list.jsp">게시판</a></h2>
<!--  이 다음에는 list.jsp 생성 후 검색조회(글 생성 링크 포함) 리스트 생성 해서 list.jsp => 글쓰 넘어갈떄 글쓰기 권한 세션 받아서 진행 -->

 
 <jsp:include page="/template/footer.jsp"></jsp:include>