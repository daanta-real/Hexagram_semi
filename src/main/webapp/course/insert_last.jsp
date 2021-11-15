<%@page import="beans.CourseItemDto"%>
<%@page import="beans.CourseDao"%>
<%@page import="beans.CourseItemDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.HashSet"%>
<%@page import="beans.ItemDto"%>
<%@page import="java.util.List"%>
<%@page import="beans.ItemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 관광지 목록</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
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

<SECTION>
<!-- 페이지 내용 시작 -->
    <%
   
    String root = request.getContextPath();
    
//     최초 코스 번호는서블릿에서 생성한 번호를 받아준다. 이후에는 코스_아이템 항목 추가,삭제 서블릿에서 전달한 해당 시퀀스 값을 다시 받는다.
	int courseSequnce = Integer.parseInt(request.getParameter("courseSequnce"));
// 	최초로 지역을 먼저 설정하게 한다. 이것을 선택한 후에는 대부분 courseSequnce / city는 함께 파라미터로 움직여야 한다.
	
    ItemDao itemDao = new ItemDao();
    CourseItemDao courseItemDao = new CourseItemDao();
    
    List<CourseItemDto> courseItemList = courseItemDao.getByCourse(courseSequnce);
    
   	ItemDto getCityDto = itemDao.get( courseItemList.get(0).getItemIdx());

    String city;
   	if(getCityDto.getAdressCity().length() != 4) city=getCityDto.getAdressCity().substring(0,2);
   	else city = getCityDto.getAdressCity();
 

    %>
    
    <div class="container-800 cotainer-center">
<div class="row center">
<h1>최종 코스 작성란</h1>
</div>
    
    
    
<form action="insert_course.nogari" class="next-submit" method="post">
	<div class="row">
	<table class="table table-border">
		<tbody>
			<tr>
				<th>
					대상 지역
				</th>
				<td>
					<%=city%>
				</td>
			</tr>
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
		<div class="row right">
			<button class="btn form-btn">최종 제출</button>
			<span class="show-login"></span>
			<input type="hidden" name="courseSequnce" value="<%=courseSequnce%>">
	</div>
</form>

<div class = "row center"><h2> - 선택한 관광지명 확인 - </h2></div>
<%int index = 1;%>
<%for(CourseItemDto courseItemDto : courseItemList){ %>
	<%ItemDto itemDto = itemDao.get(courseItemDto.getItemIdx());%>
		<div class = "row center"><%=index++%>번 관광지 : <span><%=itemDto.getItemName()%></span></div>
<%} %>


<div class = "row">
	<form action="insert.jsp" method="get">
	<button class="form-btn">이전으로</button>
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