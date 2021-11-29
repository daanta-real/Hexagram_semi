// 로드 이후 리스너 추가
window.addEventListener("load", () => {
	// 입력한 비밀번호와 재확인 비밀번호 일치 여부 검사 결과 메세지 보여주기
	document.querySelector(".form-regexCheck #reInputPw").addEventListener("blur", function(){
		
		// 0. 변수준비    
		// 비밀번호 입력값 일치여부 검사시 템플릿안의 로그인에도 name=usersPw가 있어서 값을 못받아 오기때문에
		// form에 id=joinForm 을 부여하여 선택자 지정시킴  
		console.log("비번 재입력값 검사 시작");
		var form      = document.querySelector('.form-regexCheck');
		var usersPw   = form.querySelector("input[name=usersPw]").value; // 비밀번호 입력값
		var reInputPw = form.querySelector("#reInputPw").value;          // 비밀번호 재확인 입력값
		var noticePw  = form.querySelector(".noticePw");                 // 비번 두개 일치확인결과 출력하는 레이어.noticePw 클래스
		console.log("[입력값]usersPw:" + usersPw + ", reInputPw:" + reInputPw);
	    // 둘 다 빈칸이 아닐때
		if(usersPw != "" && reInputPw != ""){
			//  일치하지 않으면
			if(usersPw != reInputPw){
		        noticePw.textContent = "비밀번호가 일치하지 않습니다";
		        console.log("비번 & 재확인비번 불일치");
				form.querySelector("#reInputPw").focus();
				$(form).attr('onsubmit', 'event.preventDefault();');
			}
			// 일치하면
		    else if(usersPw == reInputPw){
		        noticePw.textContent = "비밀번호 일치";
		        console.log("비번 & 재확인비번 일치");	
				$(form).attr('onsubmit', 'event.addEventListener();');
			}
		}
	});
});