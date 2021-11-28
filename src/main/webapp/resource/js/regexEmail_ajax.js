
 
 // 로드 이후 리스너 추가
window.addEventListener("load", () => {
	
    // EMAIL 정규표현식 검사
    document.querySelector(".form-regexCheck input[name=usersEmail]").addEventListener("blur", function(){
	
       var form  = document.querySelector('.form-regexCheck');
        var regex = /^[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*@[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*\.([a-zA-Z])+$/;
        var inputEmail = form.querySelector("input[name=usersEmail]").value;
        var message = form.querySelector("input[name=usersEmail] + .message");
        if(inputEmail != ""){ 
            if(regex.test(inputEmail)){
                console.log("이메일 정규표현식 검사 통과");
                message.textContent = "";

				// 이메일 중복검사
				console.log("중복검사 시작");
				var url = sysurl + "/users/email_check.nogari";
				console.log("[Ajax 검사]");
				console.log("inputEmail: " + inputEmail);
				console.log("url: " + url);
				
				// Ajax 설정 (1) 패러미터 설정
				var params = {
					type: "get", //전송방식 post로도 가능
					url: url,
					data: { //전송시 첨부할 파라미터 정보
						usersEmail:inputEmail	//이름:값
					}
				};
	
				// Ajax 설정 (2) 통신 완료 시 동작 설정
				params.success = (resp) => {
					console.log("Email 중복검사 요청 성공. Email : "+resp);
					if(resp == "CAN_USE") { //사용가능한 이메일이라면 다른 입력창에 대한 입력이 가능
						$(message).text("이메일 사용 가능");
						$(form).attr('onsubmit', 'event.addEventListener();');
					} else if(resp =="USED") { //이메일이 중복이라면 focus를 해당 입력창으로. 다른 입력창에 대한 입력을 방지
						$(message).text("이메일이 이미 사용중입니다");
						form.querySelector("input[name=usersEmail]").focus();
						$(form).attr('onsubmit', 'event.preventDefault();');
					}
				}
				
				// Ajax 설정 (3) 통신 실패 시 동작 설정
				params.error = (err) => { //통신 실패
					console.log("NickName 중복검사 요청 실패");
					console.log(err);
				}
				
				// Ajax 처리
				$.ajax(params);
            } else{
                console.log("이메일 정규표현식 검사 실패");
                message.textContent = "이메일 형식에 맞지 않습니다";
				form.querySelector("input[name=usersEmail]").focus();
				$(form).attr('onsubmit', 'event.preventDefault();');
            }			
        }
    });
 
});