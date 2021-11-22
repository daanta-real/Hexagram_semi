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

    <%
    
    String root = request.getContextPath();
    
    int pa;
    try{
    	pa =Integer.parseInt(request.getParameter("pa"));
    	if(pa<=0 && pa>1) throw new Exception();
    }catch(Exception e){
    	pa = 0;
    }
    
    %>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 관광지 목록</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<style>
.my-hide{
	display: none;
}

</style>

<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>

    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script>
        $(function(){
       
            $(".item-add-btn").on("click", function(){
                var course_Idx = $(this).attr("data-course_idx");
                var item_Idx = $(this).attr("data-item_idx");
                var item_address = $(this).attr("data-item_address");
                var item_name = $(this).attr("data-item_name");

                $.ajax({
                    //준비 설정
                    url:"<%=root%>/course/ajax_item_add.nogari",
                    type:"get",//전송 방식
                    data:{//전송 시 첨부할 파라미터 정보
                    	itemIdx : item_Idx,
                    	courseIdx : course_Idx
                    },
                    //완료 처리
                    success:function(resp){//NNNNN, NNNNY 중 하나가 돌아왔다(통신이 성공)
     						console.log(resp);
                         if(resp == "NNNNS"){
                        	 $(".remove-result").text("동일 지역을 선택하세요!").css("color","red");
                         }
                         else if(resp == "NNNNC"){
                        	 $(".remove-result").text(" 이미 선택한 관광지입니다~!").css("color","red");
                         }
                         else if(resp == "NNNNO"){
                        	 $(".remove-result").text("관광지가 8개를 초과하였습니다.").css("color","red");
                         }
                         else{
                            var tr = $("<tr>").addClass("count-row"); 
                         	var td1 = $("<td>").append(item_address);
                         	var td2 = $("<td>").append(item_name);
                         	var td3 = $("<td>");
                         	var button3 = $("<button>").addClass("item-remove-new-btn").attr("data-course_idx",course_Idx).attr("data-item_idx",item_Idx);
                         	
                         	$(".item-add").append(tr);
                         	tr.append(td1).append(td2);
                         	tr.append(td3.append(button3.append("삭제하기")));
                         	
                             $(".remove-result").text("추가 완료").css("color","blue");
                             $(".remove-result-number").text(resp).addClass("my-hide");
                             
                            $(".item-remove-new-btn").click(function(){
                            	 if(parseInt($(".remove-result-number").text())>3){
                             	$(this).parents("tr").hide();
                             		
                             	var new_course_Idx = $(this).attr("data-course_idx");
                                 var new_item_Idx = $(this).attr("data-item_idx");
                                 
                                 console.log(course_Idx);
                                 console.log(item_Idx);
                                 console.log("new");
                                 $.ajax({
                                     //준비 설정
                                     url:"<%=root%>/course/ajax_delete_item2.nogari",
                                     type:"get",//전송 방식
                                     data:{//전송 시 첨부할 파라미터 정보
                                     	itemIdx : new_item_Idx,
                                     	courseIdx : new_course_Idx
                                     },
                                     //완료 처리
                                     success:function(response){//NNNNN, NNNNY 중 하나가 돌아왔다(통신이 성공)
                                     	if(response == "NNNNN"){
     
                                              $(".remove-result").text("최소 3개의 관광지가 필요합니다.new").css("color","red");
                                              $(".remove-result-number").text($(".remove-result-number").text()).addClass("my-hide");
   
                                     		}
                                          else{
                                         	 $(".remove-result").text("삭제 완료!").css("color","blue");
                                         	 $(".remove-result-number").text(response).addClass("my-hide");
                                          }
                                     },
                                     error:function(err){//통신이 실패했다.
                                         console.log("실패");
                                         console.log(err);
                                     }        	
                             	});
                            	 
                                 
                                 

                            	 }else{
                                 	$(".remove-result").text("최소 3개의 관광지가 필요합니다.n").css("color","red");
                                     $(".remove-result-number").text($(".remove-result-number").text()).addClass("my-hide");
                                 }         
                                 
                                 
                        		 });
                             
                             
                         }
                    },
                    error:function(err){//통신이 실패했다.
                        console.log("실패");
                        console.log(err);
                    }

                });
                
            });
            

            $(".item-remove-btn").click(function(){
            	if(parseInt($(".remove-result-number").text())>3){
            	$(this).parents("tr").hide();
 
            	var course_Idx = $(this).attr("data-course_idx");
                var item_Idx = $(this).attr("data-item_idx");
                
                console.log(course_Idx);
                console.log(item_Idx);
                console.log("old");
                
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
                    		   $(".remove-result").text("최소 3개의 관광지가 필요합니다.old").css("color","red");
                               $(".remove-result-number").text($(".remove-result-number").text()).addClass("my-hide");

                    	} else{
                        	 $(".remove-result").text("삭제 완료!").css("color","blue");
                         	 $(".remove-result-number").text(resp).addClass("my-hide");
                        	 console.log(resp);
                         }
                    },
                    error:function(err){//통신이 실패했다.
                        console.log("실패");
                        console.log(err);
                    }        	
            	});
            }else{
            	$(".remove-result").text("최소 3개의 관광지가 필요합니다.o").css("color","red");
                $(".remove-result-number").text($(".remove-result-number").text()).addClass("my-hide");
            }  
       		 });
            
            
            var pa = <%=pa%>;
            $(".page").hide();
            $(".page").eq(pa).show();

            
            $(".btn-name").click(function(e){
                e.preventDefault();

                pa++;
                $(".page").hide();
                $(".page").eq(pa).show();
            });
            
            $(".btn-city").click(function(e){
                e.preventDefault();

                pa--;
                $(".page").hide();
                $(".page").eq(pa).show();
            });

            
            $(".next-submit").on("submit",function(e){
            	var text = $(".add-result-number").text();
            	if(parseInt(text)<3){
            		e.preventDefault();
            		$(this).next().next().text("3개이상 선택하세요..!").css("color","red");
            	}
            });
            
        });
		
        
        var total = 1;
        $(".count-row").each(function(){
        	total++;
        });
        $(".count").text(total);
        console.log("행의 총 개수 : ");
        console.log(total);
    </script>
	
<SECTION>
<!-- 페이지 내용 시작 -->
    <%
    
    
//  최초 코스 번호는서블릿에서 생성한 번호를 받아준다. 이후에는 코스_아이템 항목 추가,삭제 서블릿에서 전달한 해당 시퀀스 값을 다시 받는다.
	int courseSequnce = Integer.parseInt(request.getParameter("courseSequnce"));
//	최초로 지역을 먼저 설정하게 한다. 이것을 선택한 후에는 대부분 courseSequnce / city는 함께 파라미터로 움직여야 한다.
 String city = request.getParameter("city");
	
 ItemDao itemDao = new ItemDao();
 CourseItemDao courseItemDao = new CourseItemDao();
 
 List<CourseItemDto> courseItemList = courseItemDao.getByCourse(courseSequnce);
//  3개이상만 가능하게 하는 기능 / 목록을 보여주고 삭제 옵션을 주는 기능
	boolean isLogin = request.getSession().getAttribute("usersIdx") != null;

    String column = request.getParameter("column");
    String keyword = request.getParameter("keyword");
    
    boolean searchByName = column != null && keyword != null && !column.equals("") && !keyword.equals("");
    boolean searchByCity = city != null && !city.equals("");
   
 
    
    int psize = 5;
    int p;
    try{
    	p=Integer.parseInt(request.getParameter("p"));
    	if(p<=0) throw new Exception();
    }catch(Exception e){
    	p = 1;
    }
    
    int end = p * psize;
    int begin = end - (psize-1);
    
    int bsize = 5;
    int count;
    
   
    if(searchByName){
    	count = itemDao.count(column,keyword);
    }else if(searchByCity){
//오류일어나서 여기 주석맥였습니다    	count =itemDao.countLastSearch(city);
    }else{
    	count =itemDao.count();
    }
    
    int lastBlock =  0;////오류일어나서 여기 주석맥였습니다(count-1)/psize+1;
    
	int startBlock = (p - 1) / bsize * bsize + 1;
	int finishBlock = startBlock + (bsize - 1);
    
	 List<ItemDto> list = null;;
    if(searchByName){
    	list = itemDao.search(column,keyword,begin,end);
    }else if(searchByCity){
    	//오류일어나서 여기 주석맥였습니다   	list = itemDao.searchList(city,begin,end);
    }else{
    	list = itemDao.list(begin,end);
    }
    
    %>

<div class="page">
<!-- 지역 선택(그 지역에 한해서 한정 선택할 수 있다.) -->
<form action="update.jsp" method="get">
	<select name="city" required>
		<%if(city == null) {%>
		<option disabled>선택</option>
		<%}else{ %>
		<option disabled>선택</option>
		<%} %>
	
		<%if(city != null && city.equals("서울")) {%>
		<option value="서울" selected>서울특별시</option>
		<%}else{ %>
		<option value="서울">서울특별시</option>
		<%} %>
		
		<%if(city != null && city.equals("부산")) {%>
		<option value="부산" selected>부산광역시</option>
		<%}else{ %>
		<option value="부산">부산광역시</option>
		<%} %>
		
		<%if(city != null && city.equals("인천")) {%>
		<option value="인천" selected>인천광역시</option>
		<%}else{ %>
		<option value="인천">인천광역시</option>
		<%} %>
		
		<%if(city != null && city.equals("대구")) {%>
		<option value="대구" selected>대구광역시</option>
		<%}else{ %>
		<option value="대구">대구광역시</option>
		<%} %>
		
		<%if(city != null && city.equals("대전")) {%>
		<option value="대전" selected>대전광역시</option>
		<%}else{ %>
		<option value="대전">대전광역시</option>
		<%} %>
		
		<%if(city != null && city.equals("광주")) {%>
		<option value="광주" selected>광주광역시</option>
		<%}else{ %>
		<option value="광주">광주광역시</option>
		<%} %>
		
		<%if(city != null && city.equals("울산")) {%>
		<option value="울산" selected>울산광역시</option>
		<%}else{ %>
		<option value="울산">울산광역시</option>
		<%} %>
		
		<%if(city != null && city.equals("경기도")) {%>
		<option selected>경기도</option>
		<%}else{ %>
		<option>경기도</option>
		<%} %>
		
		<%if(city != null && city.equals("세종특별자치시")) {%>
		<option selected>세종특별자치시</option>
		<%}else{ %>
		<option>세종특별자치시</option>
		<%} %>
		
		<%if(city != null && city.equals("강원도")) {%>
		<option selected>강원도</option>
		<%}else{ %>
		<option>강원도</option>
		<%} %>																		
		
		<%if(city != null && city.equals("제주")) {%>
		<option value="제주" selected>	제주특별자치도</option>
		<%}else{ %>
		<option value="제주">제주특별자치도</option>
		<%} %>
		
		<%if(city != null && city.equals("경상북도")) {%>
		<option selected>경상북도</option>
		<%}else{ %>
		<option>경상북도</option>
		<%} %>
		
		
		<%if(city != null && city.equals("경상남도")) {%>
		<option selected>경상남도</option>
		<%}else{ %>
		<option>경상남도</option>
		<%} %>
		
		<%if(city != null && city.equals("전라남도")) {%>
		<option selected>전라남도</option>
		<%}else{ %>
		<option>전라남도</option>
		<%} %>
		
		
		<%if(city != null && city.equals("전라북도")) {%>
		<option selected>전라북도</option>
		<%}else{ %>
		<option>전라북도</option>
		<%} %>
		
		<%if(city != null && city.equals("충청남도")) {%>
		<option selected>충청남도</option>
		<%}else{ %>
		<option>충청남도</option>
		<%} %>
		
		
		<%if(city != null && city.equals("충청북도")) {%>
		<option selected>충청북도</option>
		<%}else{ %>
		<option>충청북도</option>
		<%} %>				
	</select>
	
	<input type="hidden" name="courseSequnce" value="<%=courseSequnce%>">
<!-- 	핵심이다.. courseSequnce는 무슨일이 있어서 최초 생성하고 잃어서는 안될 고유 번호이다. -->
	<input type="hidden" name="pa" value="<%=0%>">
	
	<input type="submit" value="지역 선택 완료">
</form>

<button class="btn btn-name">관광지명 또는 키워드로 검색하기</button>
</div>

<div class="page">
<form action="update.jsp" method="get">
		<select name="column" required>
			<option disabled>선택</option>
			
			<%if(column != null && column.equals("item_name")){ %>
			<option value="item_name" selected>관광지명</option>
			<%}else{ %>
			<option value="item_name">관광지명</option>
			<%} %>
			
			<%if(column != null && column.equals("item_detail")){ %>
			<option value="item_detail" selected>내용</option>
			<%}else{ %>
			<option value="item_detail">내용</option>
			<%} %>
		</select>
		
		<%if(keyword != null){ %>
		<input type="text" value="<%=keyword%>" name="keyword" required autocomplete="off" placeholder="검색어 입력">
		<%}else{ %>
		<input type="text" name="keyword" required autocomplete="off" placeholder="검색어 입력">
		<%} %>
			<input type="hidden" name="pa" value="<%=1%>">
			<input type="hidden" name="courseSequnce" value="<%=courseSequnce%>">
			<!-- 	핵심이다.. courseSequnce는 무슨일이 있어서 최초 생성하고 잃어서는 안될 고유 번호이다. -->
			<input type="submit" value="검색">
</form>
<button class="btn btn-city">지역으로 검색하기</button>
</div>

<br><br>

<!-- //오류일어나서 여기 주석맥였습니다 총 갯수  : <%=0/*count*/%>  -->
<br><br>


<h3>관광지 목록</h3>
<%if(list.isEmpty()) {%>
	<h3>결과가 없습니다.</h3>
<%}else{ %>
<!-- 		추후에 이 목록 리스트 선택란을 페이지네이션으로 구현할것임. -->
		<%if(!list.isEmpty()){ %>
			<table border="1" width="800px">
				<tbody>
						<tr>
							<th>지역</th>
							<th>관광지명</th>
							<th>메뉴</th>
						</tr>
						

						<%for(ItemDto itemDto : list) {%>
							<tr class="count-row">
								<td><%=itemDto.getAdressCity()%></td>
								<td><%=itemDto.getItemName()%></td>
								<td><button class="item-add-btn" data-course_idx="<%=courseSequnce%>"  data-item_idx="<%=itemDto.getItemIdx()%>" data-item_address="<%=itemDto.getAdressCity()%>" data-item_name="<%=itemDto.getItemName()%>">추가하기</button></td>
							</tr>
						<%} %>

				</tbody>
			</table>
						<%} %>
<%} %>
	<div>		
	<%if(startBlock > 1){ %>
		<%if(searchByName){ %>
			<!-- 검색용 링크 -->
			<a href="update.jsp?column=<%=column%>&keyword=<%=keyword%>&p=<%=startBlock-1%>&courseSequnce=<%=courseSequnce%>&pa=<%=pa%>">&lt;</a>
		<%} else if(searchByCity) { %>
			<!-- 검색용 링크 -->
			<a href="update.jsp?p=<%=startBlock-1%>&city=<%=city%>&courseSequnce=<%=courseSequnce%>&pa=<%=pa%>">&lt;</a>
		<%} else { %>
			<!-- 목록용 링크 -->
			<a href="update.jsp?p=<%=startBlock-1%>&courseSequnce=<%=courseSequnce%>&pa=<%=pa%>">&lt;</a>
		<%} %>
	<%} else { %>
		 <a>&lt;</a>
	<%} %> 
			
			
	<%for(int i = startBlock; i <= Math.min(finishBlock, lastBlock); i++){ %>
		<%if(searchByName){ %>
		<!-- 검색용 링크 -->
		<a href="update.jsp?column=<%=column%>&keyword=<%=keyword%>&p=<%=i%>&courseSequnce=<%=courseSequnce%>&pa=<%=pa%>"><%=i%></a>
		<%}else if(searchByCity){ %>
		<!-- 검색용 링크 -->
		<a href="update.jsp?p=<%=i%>&city=<%=city%>&courseSequnce=<%=courseSequnce%>&pa=<%=pa%>"><%=i%></a>
		<%}else{ %>
		<!-- 목록용 링크 -->
		<a href="update.jsp?p=<%=i%>&courseSequnce=<%=courseSequnce%>&pa=<%=pa%>"><%=i%></a>
		<%} %>
	<%} %>
	
	
	<%if(finishBlock < lastBlock){ %>
		<%if(searchByName){ %>
			<!-- 검색용 링크 -->
			<a href="update.jsp?column=<%=column%>&keyword=<%=keyword%>&p=<%=finishBlock+1%>&courseSequnce=<%=courseSequnce%>&pa=<%=pa%>">&gt;</a>
			<%}else if(searchByCity){ %>
			<!-- 검색용 링크 -->
			<a href="update.jsp?p=<%=finishBlock+1%>&city=<%=city%>&courseSequnce=<%=courseSequnce%>&pa=<%=pa%>">&gt;</a>
		<%} else { %>
			<!-- 목록용 링크 -->
			<a href="update.jsp?p=<%=finishBlock+1%>&courseSequnce=<%=courseSequnce%>&pa=<%=pa%>">&gt;</a>
		<%} %> 
	<%} else {%>
		<a>&gt;</a>
	<%} %>
	</div>

<div><h3>- 내가 선택한 관광지 목록 -</h3></div>

	<div>
			<table border="1" width="800px">
				<tbody class="item-add">
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
	</div>

<div>
<span class="remove-result"></span>
<span class="remove-result-number my-hide"><%=courseItemList.size()%></span>
</div>

<div class="count">
	<span></span>
</div>

<div>
	<form action="update_last.jsp" class="next-submit">
		<button>다음 단계로(제목/내용/선택한 목록 조회 및 수정)</button>
		<span></span>
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