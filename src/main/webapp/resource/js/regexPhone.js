
 // 로드 이후 리스너 추가
window.addEventListener("load", () => {
	
    // PHONE 정규표현식 검사
    document.querySelector(".form-regexCheck input[name=usersPhone]").addEventListener("blur",  function(){

        var form  = document.querySelector('.form-regexCheck');
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
    });

});