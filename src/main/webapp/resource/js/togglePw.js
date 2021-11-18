

// 로드 이후 리스너 추가
window.addEventListener("load", () => {
   
   // 비밀번호 숨김/보기 토글
   document.querySelector(".form-regexCheck input[type=checkbox]").addEventListener("input", function() {
    
        //type이 password면 text로 바꾸고 text면 password로 바꾼다
        var form = document.querySelector('.form-regexCheck');
        var input = form.querySelector("input[name=usersPw]");
        if (input.type == "password") {
            input.type = "text";
        } else {
            input.type = "password"
        }
    });	
   
});