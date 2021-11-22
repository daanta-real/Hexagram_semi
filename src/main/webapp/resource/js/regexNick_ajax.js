//- 검사결과에 따른 메세지를 보여줄 div에 class="message" 부여
//- 입력값이 있을 경우에만 검사하도록 설정. 미입력시 'OOO을 입력해 주세요' 메세지 출력
//     - 닉네임 정규표현식 검사 통과 후 닉네임 중복검사 진행


 // 로드 이후 리스너 추가
window.addEventListener("load", () => {
 
    // NICK 정규표현식 검사 
    document.querySelector(".form-regexCheck input[name=usersNick]").addEventListener("blur", function(){
    	// 정규식 검사 실패, 중복, 미입력시 submit 버튼 비활성화
		// submit.disabled = true; 이면 비활성화
		// submit.disabled = false; 이면 활성화
		var submit = document.querySelector("[type=submit]");    
		
        var form  = document.querySelector('.form-regexCheck');
        var regex = /^[a-zA-Zㄱ-ㅎ가-힣0-9]{2,10}$/;
        var inputNick = form.querySelector("input[name=usersNick]").value;
        var message = form.querySelector("input[name=usersNick] + .message");
        if(inputNick != ""){
            if(regex.test(inputNick)){
                console.log("닉네임 정규표현식 검사 통과");
                message.textContent = "";

				// 닉네임 중복검사
				console.log("중복검사 시작");
				var url = sysurl + "/users/nickName_check.nogari";
				console.log("[Ajax 검사]");
				console.log("inputNick: " + inputNick);
				console.log("url: " + url);
				
				// Ajax 설정 (1) 패러미터 설정
				var params = {
					type: "get", //전송방식 post로도 가능
					url: url,
					data: { //전송시 첨부할 파라미터 정보
						usersNick:inputNick	//이름:값
					}
				};
	
				// Ajax 설정 (2) 통신 완료 시 동작 설정
				params.success = (resp) => {
					console.log("NickName 중복검사 요청 성공. 닉네임 : "+resp);
					if(resp == "CAN_USE") { //사용가능한 닉네임라면 다른 입력창에 대한 입력이 가능
						$(message).text("닉네임 사용 가능");
						submit.disabled = false;
					} else if(resp =="USED") { //닉네임이 중복이라면 다른 입력창에 대한 입력을 방지
						$(message).text("닉네임이 이미 사용중입니다");
						submit.disabled = true;
					}
				}
				
				// Ajax 설정 (3) 통신 실패 시 동작 설정
				params.error = (err) => { //통신 실패
					console.log("NickName 중복검사 요청 실패");
					console.log(err);
				}
				
				// Ajax 처리
				$.ajax(params);
				
            }else{
                console.log("닉네임 정규표현식 검사 실패");
                message.textContent = "영문, 한글, 숫자 2~10글자로 작성해주세요";
				submit.disabled = true;
            }
        }else{
            console.log("닉네임 미입력");
            message.textContent = "닉네임을 입력해 주세요";
			submit.disabled = true;
        }
    });

});