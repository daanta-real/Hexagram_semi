


window.addEventListener("load", () => {
	
    // PW 정규표현식 검사
    document.querySelector(".form-regexCheck input[name=usersPw]").addEventListener("blur", function(){

        var form  = document.querySelector('.form-regexCheck');
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
    });

});