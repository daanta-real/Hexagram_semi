

// 로드 이후 리스너 추가
window.addEventListener("load", () => {
   
   // 비밀번호 숨김/보기 토글
   document.querySelector(".form-regexCheck input[type=checkbox]").addEventListener("input", function() {
    
        //type이 password면 text로 바꾸고 text면 password로 바꾼다
        var form = document.querySelector('.form-regexCheck');
        var inputPw = form.querySelector("input[name=usersPw]");
        if (inputPw.type == "password") {
            inputPw.type = "text";
        } else {
            input.type = "password"
        }
        var updatePw = form.querySelector("input[name=pwUpdate]");
        if (updatePw.type == "password") {
            updatePw.type = "text";
        } else {
            updatePw.type = "password"
        }
    });	
   
});