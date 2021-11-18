/**
 * 
 */

// 입력한 비밀번호와 재확인 비밀번호 일치 여부 검사 결과 메세지 보여주기
function checkPwInputsEquals() {

	// 0. 변수준비
	// 비밀번호 입력값 일치여부 검사시 템플릿안의 로그인에도 name=usersPw가 있어서 값을 못받아 오기때문에
	// form에 id=joinForm 을 부여하여 선택자 지정시킴  
	console.log("비번 재입력값 검사 시작");
	var form      = document.querySelector('#joinForm');
	var usersPw   = form.querySelector("input[name=usersPw]").value; // 비밀번호 입력값
	var reInputPw = form.querySelector("#reInputPw").value;          // 비밀번호 재확인 입력값
	var noticePw  = form.querySelector(".noticePw");                 // 비번 두개 일치확인결과 출력하는 레이어.noticePw 클래스
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


// 회원가입 정규표현식 검사 
//- 검사결과에 따른 메세지를 보여줄 div에 class="message" 부여
//- 입력값이 있을 경우에만 검사하도록 설정. 필수입력값(아이디, 비번, 비번확인,닉네임, 이메일) 미입력시 'OOO을 입력해 주세요' 메세지 출력
//     - 아이디 정규표현식 검사 통과 후 아이디 중복검사 진행

//아이디 정규표현식 검사
function regexCheckId(){
	
	var form  = document.querySelector("#joinForm");
	var regex = /^(?=[a-z].*)[a-z_0-9]{4,20}$/;
	var inputId = form.querySelector("input[name=usersId]").value;	
	var message = form.querySelector("input[name=usersId] + .message");

	if(inputId != ""){
		if(regex.test(inputId)){
			console.log("아이디 정규표현식 검사 통과");
			message.textContent = "";
			
			//아이디 중복검사(Ajax)  
			console.log("중복검사 시작");
			var url = "http://localhost:8080/Hexagram_semi/users/join_id_check.nogari";
			console.log("[Ajax 검사]");
			console.log("inputId: " + inputId);
			console.log("url: " + url);
			
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
					$(message).text("아이디 사용 가능");
					$("input").prop("disabled", false);
				} else if(resp =="USED") { //아이디가 중복이라면 다른 입력창에 대한 입력을 방지
					$(message).text("아이디가 이미 사용중입니다");
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
			
		}else{
			console.log("아이디 정규표현식 검사 실패");
			message.textContent = "영문 소문자, 숫자, 특수문자_ 4~20자 이내로 입력해주세요";
			return;
		}
	}else{
		console.log("아이디 미입력");
		message.textContent = "아이디를 입력해 주세요";
	}
}

//비밀번호 정규표현식 검사
function regexCheckPw(){

	var form  = document.querySelector('#joinForm');
	var regex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[-_~!@#$%^&*=+/,.;’”?])[a-zA-Z0-9-_~!@#$%^&*=+/,.;’”?]{4,20}$/
	var inputPw = form.querySelector("input[name=usersPw]").value;
	var message = form.querySelector("input[name=usersPw] + .message");
	if(inputPw != ""){
		if(!regex.test(inputPw)){
			console.log("비밀번호 정규표현식 검사 실패");
			message.textContent = "비밀번호는 영문, 숫자, 특수문자 _-~!@#$%^&*=+/,.;’”? 하나씩 포함되야 합니다";
		}else{
			console.log("비밀번호 정규표현식 검사 통과");
			message.textContent = "";
		}		
	}else{
		console.log("비밀번호 미입력");
		message.textContent = "비밀번호를 입력해 주세요";
	}
}

 //닉네임 정규표현식 검사
 function regexCheckNick(){

	var form  = document.querySelector('#joinForm');
	var regex = /^[a-zA-Zㄱ-ㅎ가-힣0-9]{2,10}$/
	var inputNick = form.querySelector("input[name=usersNick]").value;
	var message = form.querySelector("input[name=usersNick] + .message");
	if(inputNick != ""){
		if(regex.test(inputNick)){
			console.log("닉네임 정규표현식 검사 통과");
			message.textContent = "";
		}else{
			console.log("닉네임 정규표현식 검사 실패");
			message.textContent = "영문, 한글, 숫자 2~10글자로 작성해주세요";
		}
	}else{
		console.log("닉네임 미입력");
		message.textContent = "닉네임을 입력해 주세요";
	}
 }
 
 //이메일 정규표현식 검사
 function regexCheckEmail(){

	var form  = document.querySelector('#joinForm');
	var regex = /^[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*@[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*\.([a-zA-Z])+$/
	var inputEmail = form.querySelector("input[name=usersEmail]").value;
	var message = form.querySelector("input[name=usersEmail] + .message");
	if(inputEmail != ""){ 
		if(regex.test(inputEmail)){
			console.log("이메일 정규표현식 검사 통과");
			message.textContent = "";
		} else{
			console.log("이메일 정규표현식 검사 실패");
			message.textContent = "이메일 형식에 맞지 않습니다";
		}			
	}else{
		console.log("이메일 미입력");
		message.textContent = "이메일을 입력해 주세요";
	}	
 }
 
 //폰번호 정규표현식 검사
 function regexCheckPhone(){

	var form  = document.querySelector('#joinForm');
	var regex = /^(01[016-9])[0-9]{4}[0-9]{4}$/
	var inputPhone = form.querySelector("input[name=usersPhone]").value;
	var message = form.querySelector("input[name=usersPhone] + .message");
	if(inputPhone != ""){
		if(regex.test(inputPhone)){ 
			console.log("폰번호 정규표현식 검사 통과");
			message.textContent = "";
		}else{
			console.log("폰번호 정규표현식 검사 실패");
			message.textContent = "특수문자를 제외하고 01000000000 총 11자리로 입력해 주세요";
		}	 
	}
 }
 
 //초기화 버튼 클릭시 입력값, 모든 메세지 초기화하기
 // = 모든 이벤트도 제거
 // = 새로고침으로 해결
 function resetAll(){
	 console.log("회원가입 form 초기화 시작");
	 location.reload();
 }


//비밀번호 보기/숨김 토글
function togglePw() {
    //type이 password면 text로 바꾸고 text면 password로 바꾼다
	var form = document.querySelector("#joinForm");
    var input = form.querySelector("input[name=usersPw]");
    if (input.type == "password") {
        input.type = "text";
    } else {
        input.type = "password"
    }
}

// 로드 이후 리스너 추가
window.addEventListener("load", () => {
	
	// 1. PW 주 입력부 & 재확인 입력부 간 일치 검사
	document.querySelector("#joinForm #reInputPw").addEventListener("blur", checkPwInputsEquals);
	
	// 2. ID 정규표현식 검사 & 중복검사
	document.querySelector("#joinForm input[name=usersId]").addEventListener("blur", regexCheckId);
	
 	// 3. PW 정규표현식 검사
 	document.querySelector("#joinForm input[name=usersPw]").addEventListener("blur", regexCheckPw);
	
 	// 4. NICK 정규표현식 검사
 	document.querySelector("#joinForm input[name=usersNick]").addEventListener("blur", regexCheckNick);
	
 	// 5. EMAIL 정규표현식 검사
 	document.querySelector("#joinForm input[name=usersEmail]").addEventListener("blur", regexCheckEmail);
	
 	// 7. PHONE 정규표현식 검사
 	document.querySelector("#joinForm input[name=usersPhone]").addEventListener("blur", regexCheckPhone);
 	
 	// 8. 초기화 버튼 클릭시 검사관련 메세지도 초기화 하기
 	document.querySelector("#joinForm #reset").addEventListener("click",  resetAll);
	
	// 9. 비밀번호 숨김/보기 토글
	document.querySelector("#joinForm input[type=checkbox]").addEventListener("input", togglePw);	
	
});

