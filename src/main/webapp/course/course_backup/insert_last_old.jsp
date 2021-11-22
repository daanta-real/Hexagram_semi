<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@page import="beans.CourseItemDto"%>
<%@page import="beans.CourseDao"%>
<%@page import="beans.CourseItemDao"%>

<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>

<%@page import="beans.ItemDto"%>
<%@page import="beans.ItemDao"%>

<%String root = request.getContextPath();%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 관광지 목록</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
	<style>
	.container-800{width: 800px;}
	.container-left {
	    margin-left: 0;
	    margin-right: auto;
	}
	.container-center {
	    margin-left: auto;
	    margin-right:auto;
	}
	.container-right {
	    margin-left: auto;
	    margin-right:0;
	}

	.row{
	margin-top: 5px; margin-bottom: 5px;
	}
	
	.left {
	    text-align: left !important;
	}
	.center {
	    text-align: center !important;
	}
	.right {
	    text-align: right !important;
	}
	
		*{
			box-sizing: border-box;
		}
		
        textarea {
            resize:none;
        }
        .form-input,
		.form-btn {
		    width: 100%;
		    font-size: 20px;
		    padding: 10px;
		}
		        
		.form-input {
		    border: 1px solid rebeccapurple;
		}
		
		.form-btn {
		    color: white;
		    background-color: rebeccapurple;
		    font-weight: bold;
		    height: 90%;
		}
		.form-btn:hover{
		 color: red;
		}
		
		.form-block {
		    display: block;
		}
		
		.form-inline {
		    width: auto;
		}
		
		.form-in {
		   display: inline;
		}
     
     	.flex-container{
     		display: flex;
     	}
        .flex-container > .flex-reply-write-wrapper{
            flex-grow: 3;
        }
        .flex-container > .flex-reply-btn-wrapper{
            flex-grow: 1;
            margin-top: auto;
            margin-bottom: auto;
        }
     	
     	.image {
		    border: 2px solid transparent;
		    padding: 2rem;
		}
     	
     	.table{
			    width: 100%;
			}
			
			.table>thead>tr>th,
			.table>thead>tr>td,
			.table>tbody>tr>th,
			.table>tbody>tr>td,
			.table>tfoot>tr>th,
			.table>tfoot>tr>td{
			    padding: 0.5rem;
			    text-align: center;
			}
			
			.table>.tabheight{
				min-height: 300px;
			}
			
			.table.table-border {
			    border:1px solid black;
			    border-collapse: collapse;
			
			}
			.table.table-border > thead > tr > th, 
			.table.table-border > thead > tr > td,
			.table.table-border > tbody > tr > th,
			.table.table-border > tbody > tr > td,
			.table.table-border > tfoot > tr > th,
			.table.table-border > tfoot > tr > td {
			    border:1px solid black;
			
			}
			
			.form-link-btn
	        {
	            border:1px solid rebeccapurple;
	            text-decoration: none;
	            color:rebeccapurple;
	            padding:0.1rem 0.1rem;
         	    font-size:20px;
         	    margin: 0 0;
	        }
	      .form-link-btn:hover {
            border-color:red;
            color:red;
       		 }
	        	.flex-container > .reply-write-wrapper {
					width:80%;
				}
				.flex-container > .reply-send-wrapper {
					flex-grow:1;
				}
				.flex-container > .reply-send-wrapper > .form-btn,
				.flex-container > .reply-send-wrapper > .form-link-btn {
					width:100%;
					height:93%;
					display: flex;
					align-items:center;
					justify-content:center;
				}
				
				.gapy{
					margin-top: 2rem;
					margin-bottom: 2rem;
				}
	</style>
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script>
        
        $(function(){
           

            $(".item-remove-btn").click(function(){
            	
      
            	if(parseInt($(".remove-result-number").text())>3){
            	$(this).parent().parent().hide();
            	
            	var course_Idx = $(this).attr("data-course_idx");
                var item_Idx = $(this).attr("data-item_idx");
                
                console.log(course_Idx);
                console.log(item_Idx);
                
                $.ajax({
                    //준비 설정
                    url:"<%=root%>/course/ajax_delete_item.nogari",
                    type:"get",//전송 방식
                    data:{//전송 시 첨부할 파라미터 정보
                    	itemIdx : item_Idx,
                    	courseIdx : course_Idx
                    },
                    //완료 처리
                    success:function(resp){//NNNNN, NNNNY 중 하나가 돌아왔다(통신이 성공)
                    	console.log(resp);
                    	if(resp == "NNNNN"){
                             $(".remove-result").text("최소 3개의 관광지가 필요합니다.").css("color","red");
                             $(".remove-result-number").text($(".remove-result-number").text());
                         }
                         else{
                        	 $(".remove-result").text("삭제 완료!").css("color","blue");
                        	 $(".remove-result-number").text(resp);
                         }
                    },
                    error:function(err){//통신이 실패했다.
                        console.log("실패");
                        console.log(err);
                    
                    }        	
            	});
            }else{
            	$(".remove-result").text("최소 3개의 관광지가 필요합니다.").css("color","red");
                $(".remove-result.remove-result-number").text($(".remove-result.remove-result-number").text());
            }         
       		 });
            
            
            $(".next-submit").on("submit",function(e){
            	<%boolean isLogin = request.getSession().getAttribute("usersIdx") != null;%>
            	var login = <%=isLogin%>;
            	if(!login){
            		e.preventDefault();
            		$(".show-login").text("로그인하세요..!").css("color","red");
            	}
            });
              
        });
            </script>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>

<SECTION>
<!-- 페이지 내용 시작 -->
    <%
   
    
//     최초 코스 번호는서블릿에서 생성한 번호를 받아준다. 이후에는 코스_아이템 항목 추가,삭제 서블릿에서 전달한 해당 시퀀스 값을 다시 받는다.
	int courseSequnce = Integer.parseInt(request.getParameter("courseSequnce"));
// 	최초로 지역을 먼저 설정하게 한다. 이것을 선택한 후에는 대부분 courseSequnce / city는 함께 파라미터로 움직여야 한다.
    String city = request.getParameter("city");
	
    ItemDao itemDao = new ItemDao();
    CourseItemDao courseItemDao = new CourseItemDao();
    
    List<CourseItemDto> courseItemList = courseItemDao.getByCourse(courseSequnce);

    %>
    
    <div class="container-800 cotainer-center">
<div class="row center">
<h1>최종 코스 작성란</h1>
</div>
    
    
    
		<form action="insert_course.nogari" class="next-submit" method="post">
	<div class="row right">
			<button class="btn form-btn">최종 제출</button>
			<span class="show-login"></span>
			<input type="hidden" name="courseSequnce" value="<%=courseSequnce%>">
	</div>
	<div class="row">
	<table class="table table-border">
		<tbody>
			<tr>
				<th>제목</th>
				<td><input type="text" name="courseName" required placeholder="제목 입력" class="form-input"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><textarea name="courseDetail" rows="5" required placeholder="내용 입력" class="form-input"></textarea>
				</td>
			</tr>
		</tbody>
	</table>	
	</div>
</form>
    </div>



			<table border="1" width="800px">
				<tbody>
						<tr>
							<th>지역</th>
							<th>관광지명</th>
							<th>삭제</th>
						</tr>
						
						
						<%for(CourseItemDto courseItemDto : courseItemList) {%>
						<%ItemDto itemDto = itemDao.get(courseItemDto.getItemIdx()); %>
						
							<tr>
								<td><%=itemDto.getAdressCity()%></td>
								<td><%=itemDto.getItemName()%></td>
								<td><button class="item-remove-btn" data-course_idx="<%=courseSequnce%>"  data-item_idx="<%=itemDto.getItemIdx()%>">삭제하기</button></td>
							</tr>

						
						<%} %>

				</tbody>
			</table>

<span>
현재 관광지역 선택 상황 : <%=city%>
</span>


<div>
<span class="remove-result"></span>
현재 선택한 관광지 수 : <span class="remove-result-number"><%=courseItemList.size()%></span>
</div>


<div>
	<form action="insert.jsp" method="get">
	<button>이전으로</button>
	<input type="hidden" name="courseSequnce" value="<%=courseSequnce%>">
	<input type="hidden" name="city" value="<%=city%>">
	</form>
</div>
<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>