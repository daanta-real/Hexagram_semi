<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="beans.EventDao" %>
<%@ page import="beans.EventDto" %>

<%@ page import="beans.EventFileDao" %>
<%@ page import="beans.EventFileDto" %>

<%


// 0. 기본 변수 설정
String root = request.getContextPath();

// 1. 파라미터 접수
String eventIdxStr = request.getParameter("eventIdx");
System.out.println("[이벤트 - 수정] 1. 접수된 패러미터 확인. 수정할 eventIdx = " + eventIdxStr);
Integer eventIdx = null;
if(eventIdxStr == null || eventIdxStr.equals("")) {
	System.out.println("[이벤트 - 수정] 1. eventIdx가 입력되지 않았습니다.");
	throw new Exception();
} else {
	eventIdx = Integer.valueOf(eventIdxStr);
}

// 2. 해당 이벤트 정보를 받아옴
System.out.println("[이벤트 - 수정] 2. 이벤트 정보 확인");
EventDao eventDao = new EventDao();
EventDto eventDto = eventDao.get(eventIdx);
if(eventDto == null) {
	System.out.println("[이벤트 - 수정] 오류. 번호에 해당하는 eventDto가 없습니다.");
	return;
}
System.out.println("[이벤트 - 수정] 2. 수정 요청된 이벤트 정보: " + eventDto);

%>
<!DOCTYPE HTML>
<HTML>

<HEAD>
<TITLE>노가리투어 - 이벤트 수정</TITLE>
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
	
	// 기존에 업로드되었던 파일이 있는지 체크하여, 있을 때에는 파일 이름을 보여주는 함수
	fileInputElementReady()
	
	// 파일 업로드 시 파일 이름을 span에 반영 
	fileEl.addEventListener("change", () => {
		const fileName = fileEl.files[0].name;
		document.getElementById("selectedFileIcon").textContent = "✔️";
		document.getElementById("selectedFileName").textContent = fileName;
	});
	
});

// 기존에 업로드되었던 파일이 있는지 체크하여, 있을 때에만 내용을 갱신해주는 함수
function fileInputElementReady() {
	let icon = null;
	let fileName = "<%=eventDto.getFileUploadName()%>";
	if(fileName != "null") {
		console.log("기존에 첨부한 파일이 있습니다.");
		document.getElementById("selectedFileIcon").textContent = "✔️";
		document.getElementById("selectedFileName").textContent = fileName;
	} else {
		console.log("기존에 첨부한 파일이 없습니다.");
	}
}

</script>
</HEAD>

<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->



<div class="sub_title">이벤트 수정</div>

<form action="update.nogari" method="post" enctype="multipart/form-data">
<input type='hidden' name='eventIdx' value='<%=eventDto.getEventIdx() %>' />
<input type='hidden' name='usersIdx' value='<%=eventDto.getUsersIdx() %>' />
<table class='boardContainer'>

	<tbody class='boardBox'>
		<tr class='row'>
			<th>제목</th>
			<td><input class='inputs' type="text" name="eventName" required value=<%=eventDto.getEventName() %>></td>
		</tr>
		<tr class='row'>
			<th>내용</th>
			<td><textarea class='inputs' name="eventDetail" required rows="10" cols="60"><%=eventDto.getEventDetail() %></textarea></td>
		</tr>
		<tr class='row'>
			<th>첨부파일</th>
			<td><label class='fileSelector flexCenter'>
				<input id="fileInput" class='inputs' type="file" name="attach" accept="image/png, image/jpeg" style="display:none;">
				<small id="selectedFileIcon">📤</small>
				&nbsp;
				<span id="selectedFileName">파일 올리기</span>
			</label></td>
		</tr>
	</tbody>
	
	<tfoot class='boardBox'>
		<tr><td colspan="2" align="right">
			<button type=submit>등록</button>
			<button onclick="history.go(-1);">취소</button>
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