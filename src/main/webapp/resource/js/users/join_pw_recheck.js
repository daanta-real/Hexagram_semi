/**
 * 
 */
    //입력한 비밀번호와 재확인 비밀번호 일치 여부에 따른 메세지 보여주기
 window.addEventListener("load", function(){
	//비밀번호 입력값 일치여부 검사시 템플릿안의 로그인에도 name=usersPw가 있어서 값을 못받아 오기때문에
	//form에 id=joinForm 을 부여하여 선택자 지정시킴  
    document.querySelector("#reInputPw").addEventListener("blur", function(){
		console.log("비번 재입력값 검사 시작");
		var form = document.querySelector('#joinForm');
		//비밀번호 입력값
		var usersPw = form.querySelector("input[name=usersPw]").value;
        //비밀번호 재확인 입력값
		var reInputPw = document.querySelector("#reInputPw").value;
		//.noticePw 클래스
		var noticePw = document.querySelector(".noticePw");
        
		console.log("[입력값]usersPw:"+usersPw, ", reInputPw:"+reInputPw);
		if(usersPw == "" || reInputPw == ""){
			noticePw.textContent = "비밀번호를 입력해 주세요";
            console.log("비번 미입력");
		}			
        else{
            if(usersPw == reInputPw){
                noticePw.textContent = "비밀번호 일치";
                console.log("비번 & 재확인비번 일치");	
			}
            if(usersPw != reInputPw){
                noticePw.textContent = "비밀번호가 일치하지 않습니다";
                console.log("비번 & 재확인비번 불일치");
			}
		}
        
    });
});
