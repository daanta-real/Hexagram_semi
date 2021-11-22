
 
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
            } else{
                console.log("이메일 정규표현식 검사 실패");
                message.textContent = "이메일 형식에 맞지 않습니다";
            }			
        }else{
            console.log("이메일 미입력");
            message.textContent = "이메일을 입력해 주세요";
        }	
    });
 
});