<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 그리드 필터 양식</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
<STYLE TYPE='TEXT/CSS'>

	/* 그리드 컨테이너 내부에서 사용되는 변수들의 선언 */ 
	:root {
		--grid-box-margin: 3rem;
		--grid-title-width: 6rem;
		--grid-el-width: 4rem;
		--grid-el-height: 2rem;
		--grid-el-margin: 0.3rem;
	}
	
	/* 그리드 앨범들을 가지고 있는 최상위 컨테이너. 앨범 박스를 통째로 중앙 정렬하기 위해서 반드시 필요하다. */
	.gridContainer {
		width: 100%;
		border:1px solid blue;
	}
	
	/* 그리드 앨범 박스*/
	.gridContainer > .gridBox {
		display: grid;
   		justify-content:center;
   		grid-template-columns: var(--grid-box-margin) 1fr;
		margin: var(--grid-box-margin);
   		border:1px solid green;
 	}
 	
 	/* 좌측 타이틀부 */
 	.gridContainer > .gridBox > .gridTitle {
 		display:flex; flex-direction:column; justify-content:center; align-items:center;
 		width: var(--grid-title-width);
 		border:1px solid gold;
 	}
 	
 	/* 우측 콘텐츠부 */
 	.gridContainer > .gridBox > .gridContents {
 		display:flex; flex-direction:row; justify-content:flex-start; align-items:center; flex-wrap:wrap;
 		border:1px solid lime;
	}
 	
 	/* 우측 콘텐츠부 내부 개별 객체 */
 	.gridContainer > .gridBox > .gridContents > .gridEl {
 		width: var(--grid-el-width);
 		height: var(--grid-el-height);
 		margin: var(--grid-el-margin);
 		border: 1px solid red;
 	}
	
	
</STYLE>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<% String root = request.getContextPath(); %>
<!-- 페이지 내용 시작 -->
<div class='gridContainer'>
	<div class='gridBox'>
	
		<div class='gridTitle'>카테고리</div>
		<div class='gridContents'>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
		</div>
		
		<div class='gridTitle'>지역</div>
		<div class='gridContents'>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
			<div class='gridEl'>g</div>
		</div>
		
	</div>
</div>


<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>