

// 로드 이후 리스너 추가
window.addEventListener("load", () => {
 	
	// 초기화 버튼 클릭시 검사관련 메세지 초기화 하기
 	// = 모든 이벤트도 제거
	// = 새로고침으로 해결
	document.querySelector(".reset").addEventListener("click", function(){
		 console.log("form 초기화 시작");
		 location.reload();
	});
	
	// 모든 메세지란도 제거
	document.querySelectorAll(".message").forEach((el) => {
		console.log("메세지 제거 대상: ", el);
		el.textContent = "";
	})

});

