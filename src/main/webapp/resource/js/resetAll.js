

// 로드 이후 리스너 추가
window.addEventListener("load", () => {
 	
	// 초기화 버튼 클릭시 검사관련 메세지 초기화 하기
 	// = 모든 이벤트도 제거
	// = 새로고침으로 해결
	document.querySelector(".form-regexCheck .reset").addEventListener("click", function(){
		 console.log("회원가입 form 초기화 시작");
		 location.reload();
	});

});

