<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 그리드 앨범 스타일 양식</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
<STYLE TYPE='TEXT/CSS'>

	/* 그리드 컨테이너 내부에서 사용되는 변수들의 선언 */ 
	:root {
		--grid-box-margin:3rem;
		--grid-el-width: 8rem;
		--grid-el-height: 8rem;
		--grid-el-margin: 0.5rem;
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
   		grid-template-columns: repeat(auto-fit, minmax(var(--grid-el-width), max-content));
		margin: var(--grid-box-margin);
   		border:1px solid green;
 	}
 	
 	/* 앨범 한 개 한 개 */
 	.gridContainer > .gridBox > .gridEl {
 		display:flex; flex-direction:column; align-items:center;
 		/* 세로 가운데 정렬 필요하면 오른쪽 것 주석 해제할 것: justify-content:center; */
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
		<div class='gridEl'>1</div>
		<div class='gridEl'>2</div>
		<div class='gridEl'>3</div>
		<div class='gridEl'>45</div>
		<div class='gridEl'>g</div>
		<div class='gridEl'>g</div>
		<div class='gridEl'>f</div>
		<div class='gridEl'>d</div>
		<div class='gridEl'>s</div>
		<div class='gridEl'>a</div>
		<div class='gridEl'>s</div>
		<div class='gridEl'>d</div>
		<div class='gridEl'>f</div>
		<div class='gridEl'>g</div>
		<div class='gridEl'>3</div>
		<div class='gridEl'>45</div>
		<div class='gridEl'>g</div>
		<div class='gridEl'>g</div>
		<div class='gridEl'>f</div>
		<div class='gridEl'>d</div>
		<div class='gridEl'>s</div>
		<div class='gridEl'>a</div>
		<div class='gridEl'>s</div>
		<div class='gridEl'>d</div>
		<div class='gridEl'>f</div>
		<div class='gridEl'>g</div>
		<div class='gridEl'>3</div>
		<div class='gridEl'>45</div>
		<div class='gridEl'>g</div>
		<div class='gridEl'>g</div>
		<div class='gridEl'>f</div>
		<div class='gridEl'>d</div>
		<div class='gridEl'>s</div>
		<div class='gridEl'>a</div>
		<div class='gridEl'>s</div>
		<div class='gridEl'>d</div>
		<div class='gridEl'>f</div>
		<div class='gridEl'>g</div>
	</div>
</div>


<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>