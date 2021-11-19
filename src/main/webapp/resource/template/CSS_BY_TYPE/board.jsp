<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 게시판 양식</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
<STYLE TYPE='TEXT/CSS'>

	/* 게시판에서 사용되는 변수들 */
	:root {
		--board-grid-columns: 7rem minmax(15rem, 1fr) 5rem 5rem 5rem;
		
		--board-color-title-bg: var(--color10);
		--board-color-title-font: var(--color8);
		--board-color-body-bg: var(--color1);
		--board-color-body-font: var(--color8);
		--board-border-color: var(--color7);
		--board-topbot-border-width: 1px;
		--board-row-height: 1.5rem;
		--board-el-bgcolor-highlighted: #8882;
		
		--board-page-color: var(--color8);
		--board-page-el-width: 2rem;
		--board-page-lr-width: 3rem;
	}
	 
	/* 공통 속성들 */
	* { box-sizing:content-box; }
	.boardContainer > .boardBox {
		display:flex; justify-content:center; align-items:center;
		width:100%;
	}
	.boardContainer > .boardBox .row {
		display:grid; grid-template-columns:var(--board-grid-columns);
	}
	.boardContainer > .boardBox .row, .boardContainer > .boardBox.page {
		height:var(--board-row-height);
	}
	.boardContainer > .boardBox.title .row {
		color: var(--board-color-title-font);
		background-color: var(--board-color-title-bg);
	}
	.boardContainer > .boardBox.body .row {
		color: var(--board-color-body-font);
		background-color: var(--board-color-body-bg);
	}
	.boardContainer > .boardBox .row > div {
		display:flex; justify-content:center; align-items:center;
	} 
	.boardContainer > .boardBox .row > div.subject {
		justify-content:flex-start;
	} 
	.boardContainer > .boardBox.body .row,       .boardContainer > .boardBox.page .el { cursor:pointer; }
	.boardContainer > .boardBox.body .row:hover, .boardContainer > .boardBox.page .el:hover {
		background-color:var(--board-el-bgcolor-highlighted);
	}
	
	/* 상/하단 테두리 두께 설정 */
	.boardContainer > .boardBox.body .row:not(:last-child) {
		border-bottom-style:solid;
		border-bottom-color:var(--board-border-color);
		border-bottom-width:var(--board-topbot-border-width);
	}
	.boardContainer > .boardBox.title { /* 타이틀줄 상하단 외곽선 */
		border-top-style:solid;
		border-bottom-style:solid;
		border-top-color:var(--board-border-color);
		border-bottom-color:var(--board-border-color);
		border-top-width:calc(var(--board-topbot-border-width) * 2);
		border-bottom-width:calc(var(--board-topbot-border-width) * 2);
	}
	.boardContainer > .boardBox.body .row:last-child { /* 타이틀줄 상하단 외곽선 */
		border-bottom-style:solid;
		border-bottom-color:var(--board-border-color);
		border-bottom-width:calc(var(--board-topbot-border-width) * 2);
	}
	
	/* 레이아웃 */
	.boardContainer, .boardContainer > .boardBox.body {
		display:flex; flex-direction:column;
	}
		
	/* 게시판 하단 페이징 블럭들 */
	.boardContainer > .boardBox.page {
		display:flex; flex-direction:row; justify-content:center;
		color: var(--board-page-color);
	}
	
	.boardContainer > .boardBox.page .el {
		width: var(--board-page-el-width);
	}
	
	.boardContainer > .boardBox.page .el.LR {
		width: var(--board-page-lr-width);
	}
	
</STYLE>
<SCRIPT TYPE='text/javascript'>
window.addEventListener("load", () => {
	document.getElementById("debug_query").value = "section *"; 
	//debug_rainbowQueryRun();
});
</SCRIPT>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<% String root = request.getContextPath(); %>
<!-- 페이지 내용 시작 -->

<h1>게시판이다</h1>

<div class='boardContainer'>

	<div class='boardBox title'>
		<div class='row'>
			<div>으제목</div>
			<div>오제목</div>
			<div>어제목</div>
			<div>이제목</div>
			<div>아제목</div>
		</div>
	</div>
	
	<div class='boardBox body'>
		<div class='row'>
			<div>으</div>
			<div class='subject'>글제목제목글제목제목글제목제목</div>
			<div>어</div>
			<div>이</div>
			<div>아</div>
		</div>
		<div class='row'>
			<div>으</div>
			<div class='subject'>글제목제목글제목제목글제목제목</div>
			<div>어</div>
			<div>이</div>
			<div>아</div>
		</div>
		<div class='row'>
			<div>으</div>
			<div class='subject'>글제목제목글제목제목글제목제목</div>
			<div>어</div>
			<div>이</div>
			<div>아</div>
		</div>
		<div class='row'>
			<div>으</div>
			<div class='subject'>글제목제목글제목제목글제목제목</div>
			<div>어</div>
			<div>이</div>
			<div>아</div>
		</div>
		<div class='row'>
			<div>으</div>
			<div class='subject'>글제목제목글제목제목글제목제목</div>
			<div>어</div>
			<div>이</div>
			<div>아</div>
		</div>
		<div class='row'>
			<div>으</div>
			<div class='subject'>글제목제목글제목제목글제목제목</div>
			<div>어</div>
			<div>이</div>
			<div>아</div>
		</div>
		<div class='row'>
			<div>으</div>
			<div class='subject'>글제목제목글제목제목글제목제목</div>
			<div>어</div>
			<div>이</div>
			<div>아</div>
		</div>
		<div class='row'>
			<div>으</div>
			<div class='subject'>글제목제목글제목제목글제목제목</div>
			<div>어</div>
			<div>이</div>
			<div>아</div>
		</div>
		<div class='row'>
			<div>으</div>
			<div class='subject'>글제목제목글제목제목글제목제목</div>
			<div>어</div>
			<div>이</div>
			<div>아</div>
		</div>
		<div class='row'>
			<div>으</div>
			<div class='subject'>글제목제목글제목제목글제목제목</div>
			<div>어</div>
			<div>이</div>
			<div>아</div>
		</div>
	</div>
	
	<div class='boardBox page'>
		<div class='el'>◀</div>
		<div class='el'>1</div>
		<div class='el'>2</div>
		<div class='el'>3</div>
		<div class='el'>4</div>
		<div class='el'>5</div>
		<div class='el'>6</div>
		<div class='el'>7</div>
		<div class='el'>8</div>
		<div class='el'>9</div>
		<div class='el'>▶</div>
	</div>
	
</div>


<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>