<%@page import="beans.Pagination_users"%>
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

    <%
    String root = request.getContextPath();
    
// 최초 코스 번호는서블릿에서 생성한 번호를 받아준다. 
// 이후에는 코스_아이템 항목 추가,삭제 서블릿에서 전달한 해당 시퀀스 값을 다시 받는다.(코스 생성전까지 유지해줘야하는 항목)
	int courseSequnce = Integer.parseInt(request.getParameter("courseSequnce"));

	ItemDao itemDao = new ItemDao();
	Pagination_users<ItemDao, ItemDto> pn = new Pagination_users<>(request, itemDao);
	
	boolean isLogin = request.getSession().getAttribute("usersIdx") != null;
	boolean isSearchMode = pn.isSearchMode();
	pn.calculate();
	List<ItemDto> list = pn.getResultList();
	
	 CourseItemDao courseItemDao = new CourseItemDao();
	 List<CourseItemDto> courseItemList = courseItemDao.getByCourse(courseSequnce);
	// 생성한 시퀀스 번호에서 ajax로 처리한 데이터 결과값을 확인해주는 열할.(수정시에 span숫자 확인 용도 및 선택 목록 초기 화면 표시)
    %>
    
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 관광지 목록</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>

    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script>
        $(function(){
       		//코스_아이템DB 등록(비동기 통신)
            $(".item-add-btn").on("click", function(){
            	//코스에 추가할 아이템 목록들 내부에 data- 속성을 추가하여, ajax통신에 필요한 정보 및 추가한 항목으로 보낼 정보를 받아온다.
                var course_Idx = $(this).attr("data-course_idx");
                var item_Idx = $(this).attr("data-item_idx");
                var item_address = $(this).attr("data-item_address");//추가한 아이템 목록에 추가하였을때 보여줄 주소
                var item_name = $(this).attr("data-item_name");//추가한 아이템 목록에 추가하였을때 보여줄 명칭

                $.ajax({
                    url:"http://localhost:8080/Hexagram_semi/course/ajax_item_add.nogari",
                    type:"get",
                    data:{
                    	//전송 시 첨부할 파라미터 정보 => 아이템 번호와 코스 번호를 받아서
                    	// 아이템_코스 DB에 정보를 추가 / 삭제 / 명칭 및 지역 중복을 확인해주기 위함
                    	itemIdx : item_Idx,
                    	courseIdx : course_Idx
                    },
                    success:function(resp){
                         if(resp == "NNNNS"){//코스아이템DB 체크시 동일 지역이 아닐 경우
                        	 $(".result").text("동일 지역을 선택하세요!").css("color","red");
                         }
                         else if(resp == "NNNNC"){//코스아이템DB 체크시 동일명일 경우
                        	 $(".result").text(" 이미 선택한 관광지입니다~!").css("color","red");
                         }
                         else if(resp == "NNNNO"){//코스아이템DB 체크시 갯수가 8개가 넘는 경우
                        	 $(".result").text("관광지가 8개를 초과하였습니다.").css("color","red");
                         }
                         else{
                        	 //만약 코스-아이템DB에 추가하는데 무리가 없다면, 사용자가 볼수 있게 항목에 추가한다.
                        	 //이때 삭제가 가능해야 하므로, 삭제 버튼을 만들어서 $.ajax에 코스-아이템 삭제를 할 수 있게 해준다.
                            var tr = $("<tr>");
                         	var td1 = $("<td>").append(item_address);//추가한 아이템 목록에 추가하였을때 보여줄 주소
                         	var td2 = $("<td>").append(item_name);//추가한 아이템 목록에 추가하였을때 보여줄 명칭
                         	var td3 = $("<td>");
                         	//테이블에 추가할 사항들
                         	var button3 = $("<button>").attr("data-course_idx",course_Idx).attr("data-item_idx",item_Idx);
                         	//추가한 아이템 목록에서 삭제 될때도 courseidx , itemIdx가 필요하므로 설정해둔다.
                         	button3.on("click",function(){
							//버튼을 눌렀을때 삭제ajax 처리를 해주어야 하므로 (load시 설정이 되지 않았으므로 추가할때마다 설정해주어야함)
                               	 if(parseInt($(".result-number").text())>3){
                               		 //결과 span에 나오는 값의 수가 3개 이상일 경우 삭제를 처리하게 하였음.
                                	$(this).parents("tr").hide();
                                	//실제 데이터가 삭제되었음을 해당 아이템을 숨김표시로 처리하였음
                               		 
                                	var new_course_Idx = $(this).attr("data-course_idx");
                                    var new_item_Idx = $(this).attr("data-item_idx");
                                    
                                    $.ajax({
                                        url:"http://localhost:8080/Hexagram_semi/course/ajax_delete_item.nogari",
                                        type:"get",
                                        data:{//삭제 ajax에서 코스-아이템db를 삭제하기 위한 정보
                                        	itemIdx : new_item_Idx,
                                        	courseIdx : new_course_Idx
                                        },
                                        //완료 처리
                                        success:function(resp){
                                        	if(resp == "NNNNN"){//코스-아이템 db에 3개가 설정된것이 확인되면 삭제를 금지함(이중처리)
                                                 $(".result").text("최소 3개의 관광지가 필요합니다.").css("color","red");
                                        		}
                                             else{
                                            	 $(".result").text("삭제 완료!").css("color","blue");
                                            	 $(".result-number").text(resp);//결과 span에 나오는 값의 수를 변경시킴
                                            	 //resp에서는 문자열만 전달이 가능하지만 ajax에서 숫자를 문자로 변환 받아서 몇개인지 표시만 해주는 용도임.
                                             }
                                        },
                                        error:function(err){//통신이 실패했다.
                                            console.log("실패");
                                            console.log(err);
                                        }        	
                                	});
                               	 
                               	 }else{//앞으 조건절에서 ajax에서 받아온 정보들을 결과 span에 나오는 값에 실시간으로 옮겨서 확인한 값이 3개일때,
                                    	$(".result").text("최소 3개의 관광지가 필요합니다.").css("color","red");
                                        $(".result-number").text($(".result-number").text());
                                    }         
            		
                         	});
                         	//success:function(resp)부분에서 esle의 성공 부분이다. 즉
                         	//이부분에서 모든 설정(버튼의 이벤트 / ajax삭제 설정)을 해주었으면
                         	$(".item-add").append(tr);
                         	tr.append(td1).append(td2);
                         	tr.append(td3.append(button3.append("삭제하기")));
                         	//태그를 추가해준다.
                         	
                         	//결과span 및 알림창으로 현재 숫자 및 결과를 갱신해준다.
                             $(".result").text("추가 완료").css("color","blue");
                             $(".result-number").text(resp);
                             
                         }
                    },
                    error:function(err){//통신이 실패했다.
                        console.log("실패");
                        console.log(err);
                    }

                });
                
            });
         
            
            var searchSelector = <%=pn.getSearchSelector()%>;
            $(".page").hide();//모든 페이지를 숨기고
            $(".page").eq(searchSelector).show();//0,1로 설정된 곳을 나오게 한다.

            
            $(".btn-name").click(function(e){//키워드 검색을 누르면
                e.preventDefault();
	
                searchSelector++;
                $(".page").hide();
                $(".page").eq(searchSelector).show();
            });//키워드 검색을 할수 있게 1번으로 처리한다.
            
            $(".btn-city").click(function(e){//지역 검색을 누르면
                e.preventDefault();

                searchSelector--;
                $(".page").hide();
                $(".page").eq(searchSelector).show();
            });//지역 검색을 할 수 있게 0번으로 처리한다.

            
            $(".next-submit").on("submit",function(e){//다음으로 이동 버튼을 누를시, 선택한 아이템 수가 3개가 안된다면 submit을 막아준다(3차 방지)
      				if(parseInt($(".result-number").text())<3){//검색 span의 숫자가(문자열->숫자로 변환해서 확인해야함 기본적으로 문자이므로) 3보다 작을때,
            		e.preventDefault();
            		$(this).find("span").text("3개이상 선택하세요..!").css("color","red");//알림 span에다가 결과를 알려 막는다.
      				}
            });
            
        });
		

    </script>
	
<SECTION>
<!-- 페이지 내용 시작 -->
<div><h1>관광지 선택 메뉴(등록/삭제)</h1></div>

<div class="page">
<!-- 지역 선택(그 지역에 한해서 한정 선택할 수 있다.) -->
<form action="insert.jsp" method="get">
	<select name="keyword" required>
	
		<%if(pn.columnValExists("서울")) {%>
		<option value="서울" selected>서울특별시</option>
		<%}else{ %>
		<option value="서울">서울특별시</option>
		<%} %>
		
		<%if(pn.columnValExists("부산")) {%>
		<option value="부산" selected>부산광역시</option>
		<%}else{ %>
		<option value="부산">부산광역시</option>
		<%} %>
		
		<%if(pn.columnValExists("인천")) {%>
		<option value="인천" selected>인천광역시</option>
		<%}else{ %>
		<option value="인천">인천광역시</option>
		<%} %>
		
		<%if(pn.columnValExists("대구")) {%>
		<option value="대구" selected>대구광역시</option>
		<%}else{ %>
		<option value="대구">대구광역시</option>
		<%} %>
		
		<%if(pn.columnValExists("대전")) {%>
		<option value="대전" selected>대전광역시</option>
		<%}else{ %>
		<option value="대전">대전광역시</option>
		<%} %>
		
		<%if(pn.columnValExists("광주")) {%>
		<option value="광주" selected>광주광역시</option>
		<%}else{ %>
		<option value="광주">광주광역시</option>
		<%} %>
		
		<%if(pn.columnValExists("울산")) {%>
		<option value="울산" selected>울산광역시</option>
		<%}else{ %>
		<option value="울산">울산광역시</option>
		<%} %>
		
		<%if(pn.columnValExists("경기")) {%>
		<option value="경기" selected>경기도</option>
		<%}else{ %>
		<option>경기도</option>
		<%} %>
		
		<%if(pn.columnValExists("세종")) {%>
		<option value="세종" selected>세종특별자치시</option>
		<%}else{ %>
		<option>세종특별자치시</option>
		<%} %>
		
		<%if(pn.columnValExists("강원")) {%>
		<option value="강원" selected>강원도</option>
		<%}else{ %>
		<option>강원도</option>
		<%} %>																		
		
		<%if(pn.columnValExists("제주")) {%>
		<option value="제주" selected>	제주특별자치도</option>
		<%}else{ %>
		<option value="제주">제주특별자치도</option>
		<%} %>
		
		<%if(pn.columnValExists("경상북도")) {%>
		<option selected>경상북도</option>
		<%}else{ %>
		<option>경상북도</option>
		<%} %>
		
		
		<%if(pn.columnValExists("경상남도")) {%>
		<option selected>경상남도</option>
		<%}else{ %>
		<option>경상남도</option>
		<%} %>
		
		<%if(pn.columnValExists("전라남도")) {%>
		<option selected>전라남도</option>
		<%}else{ %>
		<option>전라남도</option>
		<%} %>
		
		
		<%if(pn.columnValExists("전라북도")) {%>
		<option selected>전라북도</option>
		<%}else{ %>
		<option>전라북도</option>
		<%} %>
		
		<%if(pn.columnValExists("충청남도")) {%>
		<option selected>충청남도</option>
		<%}else{ %>
		<option>충청남도</option>
		<%} %>
		
		
		<%if(pn.columnValExists("충청북도")) {%>
		<option selected>충청북도</option>
		<%}else{ %>
		<option>충청북도</option>
		<%} %>				
	</select>
	<input type="hidden" name="column" value="item_address">
	<input type="hidden" name="courseSequnce" value="<%=courseSequnce%>">
	<input type="hidden" name="searchSelector" value="<%=0%>">
<!-- 	핵심이다.. courseSequnce는 무슨일이 있어서 최초 생성하고 잃어서는 안될 고유 번호이다. -->
	
	<input type="submit" value="지역 검색">
</form>

<button class="btn btn-name">키워드로 검색</button>
</div>

<div class="page">
<form action="insert.jsp" method="get">
		<select name="column" required>
			<option disabled>선택</option>
			
			<%if(pn.columnValExists("item_name")){ %>
			<option value="item_name" selected>관광지명</option>
			<%}else{ %>
			<option value="item_name">관광지명</option>
			<%} %>
			
			<%if(pn.columnValExists("item_detail")){ %>
			<option value="item_detail" selected>내용</option>
			<%}else{ %>
			<option value="item_detail">내용</option>
			<%} %>
		</select>
		
		<input type="search" name="keyword" placeholder="검색어 입력"
			required value="<%=pn.getKeywordString()%>"  class="form-input form-inline">
		
			<input type="hidden" name="searchSelector" value="<%=1%>">
			<input type="hidden" name="courseSequnce" value="<%=courseSequnce%>">
			<!-- 	핵심이다.. courseSequnce는 무슨일이 있어서 최초 생성하고 잃어서는 안될 고유 번호이다. -->
			<input type="submit" value="검색">
</form>
<button class="btn btn-city">지역으로 검색</button>
</div>

<br>
<span>검색 결과  : <%=pn.getCount()%> 개의 관광지가 검색되었습니다.</span>
<br>


<h3>- 관광지 목록 -</h3>
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
							<tr>
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
	<%if(pn.hasPreviousBlock()){ %>
		<%if(isSearchMode){ %>
			<!-- 검색용 링크 -->
			<a href="insert.jsp?column=<%=pn.getColumn()%>&keyword=<%=pn.getKeyword()%>&page=<%=pn.getPreviousBlock()%>&courseSequnce=<%=courseSequnce%>&searchSelector=<%=pn.getSearchSelector()%>">&lt;</a>
		<%} else { %>
			<!-- 목록용 링크 -->
			<a href="insert.jsp?page=<%=pn.getPreviousBlock()%>&courseSequnce=<%=courseSequnce%>&searchSelector=<%=pn.getSearchSelector()%>">&lt;</a>
		<%} %>
	<%} else { %>
		 <a>&lt;</a>
	<%} %> 
			
			
	<%for(int i = pn.getStartBlock(); i <= pn.getRealLastBlock(); i++){ %>
		<%if(isSearchMode){ %>
		<!-- 검색용 링크 -->
		<a href="insert.jsp?column=<%=pn.getColumn()%>&keyword=<%=pn.getKeyword()%>&page=<%=i%>&courseSequnce=<%=courseSequnce%>&searchSelector=<%=pn.getSearchSelector()%>"><%=i%></a>
		<%}else{ %>
		<!-- 목록용 링크 -->
		<a href="insert.jsp?page=<%=i%>&courseSequnce=<%=courseSequnce%>&searchSelector=<%=pn.getSearchSelector()%>"><%=i%></a>
		<%} %>
	<%} %>
	
	
	<%if(pn.hasNextBlock()){ %>
		<%if(isSearchMode){ %>
			<!-- 검색용 링크 -->
			<a href="insert.jsp?column=<%=pn.getColumn()%>&keyword=<%=pn.getKeyword()%>&page=<%=pn.getNextBlock()%>&courseSequnce=<%=courseSequnce%>&searchSelector=<%=pn.getSearchSelector()%>">&gt;</a>
		<%} else { %>
			<!-- 목록용 링크 -->
			<a href="insert.jsp?page=<%=pn.getNextBlock()%>&courseSequnce=<%=courseSequnce%>&searchSelector=<%=pn.getSearchSelector()%>">&gt;</a>
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
<span class="result"></span>
</div>
<div>
현재 선택한 관광지 : <span class="result-number"><%=courseItemList.size()%></span> 개
</div>

<div>
	<form action="insert_last.jsp" class="next-submit">
		<button class="next-btn">다음 단계로(제목/내용/선택한 목록 조회 및 수정)</button>
		<span></span>
		<input type="hidden" name="courseSequnce" value="<%=courseSequnce%>">
	</form>
</div>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>