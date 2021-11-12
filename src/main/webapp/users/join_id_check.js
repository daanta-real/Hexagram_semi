
    //입력이 발생하면 or 입력을 마친후 사용자 몰래 입력한 아이디의 존재여부를 서버에 질문
    //-서버는 아이디가 존재하면"ID_ALREADY_USE" 존재하지않으면  "ID_CAN_USE"를 반환
    //-서버에서 돌아온 응답에 따라 메세지를 다르게 출력

    $(function(){
        $("input[name=usersId]").on("blur", function(e){
            e.preventDefault();
            var inputId = $("input[name=usersId]").val();
            $.ajax({
                //준비 설정
                //요청을 전달할 주소
                url:"http://localhost:8080/Hexagram_semi//users/join_id_check.nogari",
                type:"get", //전송방식 post로도 가능
                data:{ //전송시 첨부할 파라미터 정보
                    usersId:inputId  //이름:값
                },  

                //완료 처리
                success:function(resp){ //통신성공 NNNNN(중복) / NNNNY(사용가능) 중 하나가 돌아옴
                    console.log("성공");
                    console.log(resp);
                    if(resp == "ID_CAN_USE"){
                        $("input[name=usersId]").next().text("아이디 사용 가능");
                    }
                    else if(resp =="ID_ALREADY_USE"){
                        $("input[name=usersId]").next().text("아이디가 이미 사용중입니다");
                    }

                },
                error:function(err){ //통신 실패
                    console.log("실패");
                    console.log(err);
                }
            });
        });
    });
