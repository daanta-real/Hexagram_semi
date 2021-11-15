/**
 * 
 */

    //입력이 발생하면 or 입력을 마친후 사용자 몰래 입력한 아이디의 존재여부를 서버에 질문
    //-서버는 아이디가 존재하면"ID_ALREADY_USE" 존재하지않으면  "ID_CAN_USE"를 반환
    //-서버에서 돌아온 응답에 따라 메세지를 다르게 출력

    $(function(){
        $("input[name=usersId]").on("blur", function(){
            var inputId = $(this).val();
			if(inputId != ""){ //아이디 입력값이 빈값이 아니라면
	            $.ajax({
	                //준비 설정
	                //요청을 전달할 주소
	                url:"http://localhost:8080/Hexagram_semi/users/join_id_check.nogari",
	                type:"get", //전송방식 post로도 가능
	                data:{ //전송시 첨부할 파라미터 정보
	                    usersId:inputId  //이름:값
	                },  
					
	                //완료 처리
	                success:function(resp){
	                    console.log("ID 중복검사 요청 성공");
	                    console.log("ID : "+resp);
	                    if(resp == "CAN_USE"){
	                        $("input[name=usersId]").next().text("아이디 사용 가능");
							//사용가능한 아이디라면 다른 입력창에 대한 입력이 가능
							$("input").prop("disabled",false);
	                    }
	                    else if(resp =="USED"){
	                        $("input[name=usersId]").next().text("아이디가 이미 사용중입니다");
							//아이디가 중복이라면 다른 입력창에 대한 입력을 방지
							$("input").not($("input[name=usersId]")).prop("disabled",true);
	                    }
	
	                },
	                error:function(err){ //통신 실패
	                    console.log("ID 중복검사 요청 실패");
	                    console.log(err);
	                }
	            });
			}
			else{ // 아이디 입력값이 빈칸이라면
				  $("input[name=usersId]").next().text("아이디를 입력해 주세요");
			}
        });
    });