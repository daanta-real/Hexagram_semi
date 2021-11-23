<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% String root = request.getContextPath(); %>
<!DOCTYPE HTML>
<HTML>

<HEAD>
<TITLE>노가리투어 - 이벤트 작성</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/sub_title.css">
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/detail.css">
<style type='text/css'>
textarea { outline:none; resize:vertical; }
.inputs {
	margin:0 !important;
	border-style: solid !important;
    border-width: 0.2rem !important;
    border-color: var(--color11) !important;
}
.fileSelector {
	font-family:'mainFont' !important; cursor:pointer; background:var(--color4);
	width:100%; height:100%; line-height:1rem;
}
</style>
<script type='text/javascript'>

// 변수 선언
let fileEl = null; 

// 리스너 관리
window.addEventListener("load", () => {
	
	// 변수 선언
	fileEl = document.getElementById("fileInput");
	
	// 파일 업로드 시 파일 이름을 span에 반영 
	fileEl.addEventListener("change", () => {
		const fileName = fileEl.files[0].name;
		document.getElementById("selectedFileIcon").textContent = "✔️";
		document.getElementById("selectedFileName").textContent = fileName;
	});
	
});

</script>
</HEAD>

<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->



<div class="sub_title">이벤트 작성</div>

<form action="insert.nogari" method="post" enctype="multipart/form-data">
<table class='boardContainer'>

	<tbody class='boardBox'>
		<tr class='row'>
			<th>제목</th>
			<td><input class='inputs' type="text" name="eventName" required></td>
		</tr>
		<tr class='row'>
			<th>내용</th>
			<td><textarea class='inputs' name="eventDetail" required rows="10" cols="60"></textarea></td>
		</tr>
		<tr class='row'>
			<th>첨부파일</th>
			<td><label class='fileSelector flexCenter'>
				<input id="fileInput" class='inputs' type="file" name="attach" accept="image/png, image/jpeg" style="display:none;">
				<small id="selectedFileIcon">📤</small>&nbsp;<span id="selectedFileName">파일 올리기</span>
			</label></td>
		</tr>
	</tbody>
	
	<tfoot class='boardBox'>
		<tr><td colspan="2" align="right">
			<button type=submit>등록</button>
			<button type=reset>취소</button>
		</td></tr>
	</tfoot>
	
</table>
</form>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>