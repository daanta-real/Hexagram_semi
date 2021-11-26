<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String root = request.getContextPath(); %>

<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 관리자페이지</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
<%/*CSS들*/%>
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/sub_title.css">
<style type='text/css'>
	/* 그리드 컨테이너 내부에서 사용되는 변수들의 선언 */ 
	:root {
		--grid-box-margin:3rem;
		--grid-el-width: 6rem;
		--grid-el-height: 6rem;
		--grid-el-margin: 0.5rem;
		--board-color-body-font: var(--color8);
		--board-border-color: var(--color7);
	}
	
	/* 그리드 앨범들을 가지고 있는 최상위 컨테이너. 앨범 박스를 통째로 중앙 정렬하기 위해서 반드시 필요하다. */
	.gridContainer {
		width: 100%;
		border:0;
	}
	
	/* 그리드 앨범 박스*/
	.gridContainer > .gridBox {
		display: grid;
   		justify-content:center;
   		grid-template-columns: repeat(auto-fit, minmax(var(--grid-el-width), max-content));
		margin: var(--grid-box-margin);
   		border:0;
 	}
 	
 	/* 앨범 한 개 한 개 */
 	.gridContainer > .gridBox > .gridEl {
 		display:flex; flex-direction:column; align-items:center;
 		/* 세로 가운데 정렬 필요하면 오른쪽 것 주석 해제할 것: justify-content:center; */
 		width: var(--grid-el-width);
 		height: var(--grid-el-height);
 		margin: var(--grid-el-margin);
 		border: 0;
		background-color:#8882;
		text-align:center;
		cursor:pointer;
		font-size:1.5rem;
		padding: 1rem 1rem;
 	}
 	
 	.gridContainer > .gridBox > .gridEl:hover{
 		background-color: var(--color4);
 	}

	img{ margin: 0.5rem 0; }
</style>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->
<h1>관리자 페이지</h1>
<div class='gridContainer'>
	<div class='gridBox'>
		<div class='gridEl'>
			<a href="users/list.jsp">
				회원 관리<img src='<%=root %>/resource/image/admin/users.png' width='80%'>
			</a>
		</div>
		<div class='gridEl'>
			<a href="<%=root %>/item/list_first.jsp">
			   관광지 관리<img src='<%=root %>/resource/image/admin/item.png' width='60%'>
			</a>
		</div>
		<div class='gridEl'>
			<a href="<%=root %>/course/list.jsp">
			   코스 관리<img src='<%=root %>/resource/image/admin/course.png' width='50%'>
			</a>
		</div>
		<div class='gridEl'>
			<a href="<%=root %>/event/list.jsp">
			   이벤트 관리<img src='<%=root %>/resource/image/admin/event.png' width='50%'>
			</a>
		</div>
	</div>
</div>
<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>