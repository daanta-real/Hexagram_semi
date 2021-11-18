


 // 로드 이후 리스너 추가
window.addEventListener("load", () => {
 
    // NICK 정규표현식 검사
    document.querySelector(".form-regexCheck input[name=usersNick]").addEventListener("blur", function(){

        var form  = document.querySelector('.form-regexCheck');
        var regex = /^[a-zA-Zㄱ-ㅎ가-힣0-9]{2,10}$/;
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
    });

});