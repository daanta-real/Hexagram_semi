/**
 * 
 */
//function deleteConfirm의 매개변수로 usersId로 설정하고 onclick설정한 버튼에 매개변수로 usersDto.getUsersId()로 설정 
function deleteConfirm(usersId){
	var deleteConfirm = window.confirm("탈퇴를 진행할까요?");
	console.log(deleteConfirm);
	if(deleteConfirm == true){
		console.log("[관리자-회원관리]탈퇴진행");
		location.href="unregister.nogari?usersId="+usersId;
	}else{
			console.log("[관리자-회원관리]탈퇴취소");
	}
}
