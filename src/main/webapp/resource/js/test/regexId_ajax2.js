
// 회원가입 정규표현식 검사 
//- 검사결과에 따른 메세지를 보여줄 div에 class="message" 부여
//- 입력값이 있을 경우에만 검사하도록 설정. 
//- 아이디 정규표현식 검사 통과 후 아이디 중복검사 진행


function checkId(){
        
		//아이디 정규표현식 검사
        var form  = document.querySelector('.form-regexCheck');
        var regex = /^(?=[a-z].*)[a-z_0-9]{4,20}$/;
        var inputId = form.querySelector("input[name=usersId]").value;	
        var message = form.querySelector("input[name=usersId] + .message");

        if(inputId != ""){
           if(regex.test(inputId)){
                console.log("아이디 정규표현식 검사 통과");
                message.textContent = "";
                    
                //아이디 중복검사(Ajax)  
                console.log("중복검사 시작");
                var url = sysurl +"/users/register_id_check.nogari";
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
                    	$(form).attr('onsubmit', 'event.addEvenetListener();');
                    } else if(resp =="USED") { //아이디가 중복이라면 다른 입력창에 대한 입력을 방지
                        $(message).text("아이디가 이미 사용중입니다");
						form.querySelector("input[name=usersId]").focus();
						$(form).attr('onsubmit', 'event.preventDefault();');
						
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
					form.querySelector("input[name=usersId]").focus();
					$(form).attr('onsubmit', 'event.preventDefault();');
            }
        }
}