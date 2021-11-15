<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 회원 가입</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
<%String root = request.getContextPath();%>

<!-- 테이블 css -->
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/table.css">
<!-- 페이지 제목 css -->
<link rel="stylesheet" type="text/css" href="<%=root%>/resource/css/users/sub_title.css">
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.6.0.js"></script>
<!-- 인라인 스크립트 -->
<script type='text/javascript'>

// 입력한 비밀번호와 재확인 비밀번호 일치 여부 검사 결과 메세지 보여주기
function checkPwInputsEquals() {

	// 0. 변수준비
	// 비밀번호 입력값 일치여부 검사시 템플릿안의 로그인에도 name=usersPw가 있어서 값을 못받아 오기때문에
	// form에 id=joinForm 을 부여하여 선택자 지정시킴  
	console.log("비번 재입력값 검사 시작");
	var form      = document.querySelector('#joinForm');
	var usersPw   = form.querySelector("#joinForm input[name=usersPw]").value; // 비밀번호 입력값
	var reInputPw = form.querySelector("#joinForm #reInputPw").value;          // 비밀번호 재확인 입력값
	var noticePw  = form.querySelector("#joinForm .noticePw");                 // 비번 두개 일치확인결과 출력하는 레이어.noticePw 클래스
	console.log("[입력값]usersPw:" + usersPw + ", reInputPw:" + reInputPw);
    
	// 검사 1 - 둘다 빈 칸이면 안 됨 
	if(usersPw == "" || reInputPw == ""){
		noticePw.textContent = "비밀번호를 입력해 주세요";
        console.log("비번 미입력");
		return;
	}
	
	// 검사 2 - 둘다 같은 값이어야 됨
	if(usersPw != reInputPw){
        noticePw.textContent = "비밀번호가 일치하지 않습니다";
        console.log("비번 & 재확인비번 불일치");
		return;
	}
	
	// 검사 1 + 2 모두 통과 시
    else{
        noticePw.textContent = "비밀번호 일치";
        console.log("비번 & 재확인비번 일치");	
	}
    
}





//Ajax를 이용한 회원가입 아이디 중복검사 스크립트
function checkIdIsUnique() {
	
	var inputId = $(this).val();
	var url = "<%=root%>/users/join_id_check.nogari";
	console.log("[Ajax 검사]");
	console.log("inputId: " + inputId);
	console.log("url: " + url);
	
	// 아이디 입력값이 빈값이면 진행 막고 쳐냄
	if(inputId == "") {
		$("input[name=usersId]").next().text("아이디를 입력해 주세요");
		return;
	}
	
	// Ajax 설정 (1) 패러미터 설정
	var params = {
		type: "get", //전송방식 post로도 가능
		url: url,
		data: { //전송시 첨부할 파라미터 정보
			usersId:inputId	//이름:값
		}
	};

	// Ajax 설정 (2) 통신 완료 시 동작 설정
	params.success = (resp) => {
		console.log("ID 중복검사 요청 성공. ID : "+resp);
		if(resp == "CAN_USE") { //사용가능한 아이디라면 다른 입력창에 대한 입력이 가능
			$("input[name=usersId]").next().text("아이디 사용 가능");
			$("input").prop("disabled", false);
		} else if(resp =="USED") { //아이디가 중복이라면 다른 입력창에 대한 입력을 방지
			$("input[name=usersId]").next().text("아이디가 이미 사용중입니다");
			$("input").not($("input[name=usersId]")).prop("disabled",true);
		}
	}
	
	// Ajax 설정 (3) 통신 실패 시 동작 설정
	params.error = (err) => { //통신 실패
		console.log("ID 중복검사 요청 실패");
		console.log(err);
	}
	
	// Ajax 처리
	$.ajax(params);
	
}


// 로드 이후 리스너 추가
window.addEventListener("load", () => {
	
	// 1. ID 중복 검사
    document.querySelector("#joinForm input[name=usersId]").addEventListener("blur", checkIdIsUnique);
	
	// 2. PW 주 입력부 & 재확인 입력부 간 일치 검사
	document.querySelector("#joinForm #reInputPw").addEventListener("blur", checkPwInputsEquals);
	
});

</script>

</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>

<SECTION>
<!-- 페이지 내용 시작 -->
<div class="sub_title">회원 가입</div>
<!-- 
		비밀번호 입력값 일치여부 검사시 템플릿안에 로그인에도 name=usersPw가 있어서 값을 못받아 오기때문에
		form에 id=joinForm 을 부여하여 선택자 지정시킴  
 -->
<form id="joinForm" method='post' action='<%=root%>/users/join.nogari'>
<table class="table">
<tbody>       
	<tr><th>아이디</th><td><input type='text' name='usersId' placeholder='입력하세요'><div></div></td></tr>
	<tr><th>비번</th><td><input type='password' name='usersPw' placeholder='입력하세요'></td></tr>
	<tr>
		<th>비번확인</th>
		<td>
			<input type='password' id='reInputPw' placeholder='비밀번호 재확인'>
			<div class="noticePw"></div>
		</td>
	</tr>
	<tr><th>닉네임</th><td><input type='text' name='usersNick' placeholder='입력하세요'></td></tr>
	<tr><th>이메일</th><td><input type='email' name='usersEmail' placeholder='입력하세요'></td></tr>
	<tr><th>폰번호</th><td><input type='tel' name='usersPhone' placeholder='입력하세요'></td></tr>
</tbody>
<tfoot><tr><td colspan=2 align=center>
	<button type=submit>가입하기</button>
	&nbsp;&nbsp;
	<input type='reset' value='초기화' />
</td></tr></tfoot>
</table>
</form>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>