<%@page import="servlet.item.ItemCityList"%>
<%@page import="beans.Pagination"%>
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
   		String subCity = request.getParameter("subCity");
    	//기존의 번호
    	int courseOriginSequnce = Integer.parseInt(request.getParameter("courseOriginSequnce"));
    	//복사를 위한 임시 번호
    	int courseSequnce = Integer.parseInt(request.getParameter("courseSequnce"));

    	ItemDao itemDao = new ItemDao();
    	//페이지네이션 모듈 사용
    	Pagination<ItemDao, ItemDto> pn = new Pagination<>(request, itemDao);
    	
    	//로그인 하였습니까?	
    	boolean isLogin = request.getSession().getAttribute("usersIdx") != null;
    	
    	//검색 모드입니까?
    	boolean isSearchMode = pn.isSearchMode();
    	//Item에 대한 데이터 정보를 계산해주세요.
    	pn.calculate();
    	//조건에 맞는 리스트를 반환해주세요.
    		List<ItemDto> list = new ArrayList<>();
			if(subCity != null){
				list = itemDao.subCityList(subCity,"item_idx", pn.getColumn(), pn.getKeyword(), pn.getBegin(), pn.getEnd());
				pn.setCount(itemDao.count(pn.getColumn(), pn.getKeyword(),subCity));
				pn.setLastBlock((pn.getCount()-1)/pn.getPageSize()+1); 
			}else{
				list = pn.getResultList();	
			}
    	
    	 CourseItemDao courseItemDao = new CourseItemDao();
    	// 복사를 위한 임시 번호(courseSequnce)에서 ajax로 처리한 데이터 결과값을 확인해주는 열할.(목록 초기 화면 표시 및 update_last.jsp에서 이전으로 눌렀을 때 선택화면 초기화 용도)
    	 List<CourseItemDto> courseItemList = courseItemDao.getByCourse(courseSequnce);
    %>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 관광지 목록</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<style>
		.form-input{
		
		}
        .row {
            margin-top: 10px;
            margin-bottom: 10px;
        }
        		*{
			box-sizing: border-box;
		}
		.form-input,
		.form-btn {
		    width: 100%;
		    font-size: 20px;
		    padding: 10px;
		}
		        
		.form-input {
		    border: 1px solid gray;
		}
		
		.form-btn {
		    color: white;
		    background-color: gray;
		    font-weight: bold;
		    height: 90%;
		}
		.form-btn:hover{
		 color: balck;
		}
		
		.form-block {
		    display: block;
		}
		
		.form-inline {
		    width: auto;
		}
</style>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>

    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script>
        $(function(){
       	//추가하기 버튼을 눌렀을 때,
            $(".item-add-btn").on("click", function(){
                var course_Idx = $(this).attr("data-course_idx");
                var item_Idx = $(this).attr("data-item_idx");
                var item_address = $(this).attr("data-item_address");
                var item_name = $(this).attr("data-item_name");
				//추가하기 버튼 태그안에는 위와같은 정보가 들어 있다.
				//courseIdx, itemIdx 는 내 item담기에 보여지는 것과 삭제하기 click이벤트를 태그 생성과 동시에 부여하기 위해서 필요한 정보
				//위의 두 정보와 더불어서 address 및 name은 내가 담은 태그에 보여질 정보들을 손쉽게 추가하기 위함.
				
                $.ajax({
                	//아이템추가 ajax로 비동기 통신을 한다.
                    url:"http://localhost:8080/Hexagram_semi/course/ajax_item_add.nogari",
                    type:"get",
                    data:{
                    	itemIdx : item_Idx,
                    	courseIdx : course_Idx
                    },
                    success:function(resp){
                         if(resp == "NNNNS"){//span(class=".result")에서 결과를 나타내주며,아이템추가 ajax에서 첫번째 추가한 도시명과 대상(현재 추가하기) 관광지명의 도시명을 비교하여 다르다면,
                        	 $(".result").text("동일 지역을 선택하세요!").css("color","red");
                         }
                         else if(resp == "NNNNC"){//span(class=".result")에서 결과를 나타내주며,아이템추가 ajax에서 ItemIdx를 통해서 indexOf메소드로 courseItemList의 대상 지역이 있는지 체크하여 반환
                        	 $(".result").text(" 이미 선택한 관광지입니다~!").css("color","red");
                         }
                         else if(resp == "NNNNO"){//span(class=".result")에서 결과를 나타내주며,아이템추가 ajax에서 courseItemList.size()가 8개일 경우
                        	 $(".result").text("관광지가 8개를 초과하였습니다.").css("color","red");
                         }
                         else{
                        	 //만약 코스-아이템DB에 추가하는데 무리가 없다면, 사용자가 볼수 있게 항목에 추가한다.
                           	 //이때 삭제가 가능해야 하므로, 삭제 버튼을 만들어서 $.ajax에 코스-아이템 삭제를 할 수 있게 해준다.
                            var tr = $("<tr>");
                         	var td1 = $("<td>").append(item_address);
                         	var td2 = $("<td>").append(item_name);
                         	//관광지 명칭과 관광지 명은 내가 선택한 목록에서 사용자가 직접 확인할 수 있도록 정보를 표시
                         	//테이블에 추가할 사항들
                         	var td3 = $("<td>");
                         	var button3 = $("<button>").addClass("item-remove-btn").attr("data-course_idx",course_Idx).attr("data-item_idx",item_Idx);
                         	//추가한 아이템 목록에서 삭제 될때도 courseidx , itemIdx가 필요하므로 설정해둔다.
                         	//또한 addClass("item-remove-btn")를 하게 된 이유는 이전화면으로 돌아오기 및 다시 courseItemList를 확인할때(특히 insert.jsp 부분)에서 이 이벤트가 등록이 되어있어야
                         	//156번째 줄의 이벤트가 로드시 자동 등록될 수 있다.
                         	button3.on("click",function(){
                         		//버튼을 눌렀을때 삭제ajax 처리를 해주어야 하므로 (load시 설정이 되지 않았으므로 추가할때마다 설정해주어야함)
                               	 if(parseInt($(".result-number").text())>3){//문자열로 반환받으므로 숫자변환 처리를 해주어야함.
                               		 //등록과는 다르게  <span class="result-number">에서 반환받은 값이 3이 아닐 경우에만 삭제 이벤트를 설정함.
                                	$(this).parents("tr").hide();
                                	//실제 데이터가 삭제되었음을 해당 아이템을 숨김표시로 처리하였음(실시간으로 화면에서 표현해주기 위함)
                                	var new_course_Idx = $(this).attr("data-course_idx");
                                    var new_item_Idx = $(this).attr("data-item_idx");
                                    
                                    $.ajax({//삭제 ajax에서 코스-아이템db를 삭제하기 위한 정보
                                        url:"http://localhost:8080/Hexagram_semi/course/ajax_delete_update_item.nogari",
                                        type:"get",
                                        data:{
                                        	itemIdx : new_item_Idx,
                                        	courseIdx : new_course_Idx
                                        },
                                        success:function(resp){
                                        	if(resp == "NNNNN"){//아이템 삭제 ajax에서 코스-아이템 db(즉 courseItemList.size())에 관광지가 적어도 3개는 들어가야하기 때문임.
                                        		//=>등록과는 다르게 수정에서는 기존에 설정한 것에서 크게 범위가 벗어나지 않아야되기 때문에 차별을 둔 것.
                                        		//즉 기본 관광지역은 동일하되 일부 코스 수정하는 개념이라고 보면 됨
                                                 $(".result").text("최소 3개의 관광지가 필요합니다.").css("color","red");
                                                 $(".result-number").text($(".result-number").text());
      
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
                               	 }else{ //등록과는 다르게  <span class="result-number">에서 반환받은 값이 3이 아닐 경우에만 삭제 이벤트를 설정함.
                                    	$(".result").text("최소 3개의 관광지가 필요합니다.").css("color","red");
                                        $(".result-number").text($(".result-number").text());
                                    }         
            		
                         	});
                         	
                         	$(".item-add").append(tr);
                         	tr.append(td1).append(td2);
                         	tr.append(td3.append(button3.append("삭제하기")));
                         	//각각의 태그들의 정보를 설정해주고 append를 통해 합치기 작업.
                             $(".result").text("추가 완료").css("color","blue");
                             $(".result-number").text(resp);
                             //완료 되었음을 아래 표시창에다가 표시하고, <span class="result-number">에다가 ajax에서 받은 courseItemList.size() 값을 반환해준다.
                         }
                    },
                    error:function(err){//통신이 실패했다.
                        console.log("실패");
                        console.log(err);
                    }

                });
                
            });
            
			//기존에 내 관광지 목록에 담긴 것들에 대한 설정이며, 91번째 줄에 추가시 생성되는 내 관광지(삭제 기능) 항목의 ajax와 완전히 동일하다.
			//이는 등록 완료후 수정시 / 등록 후 이전으로 돌아갈때, 38번째 줄의 List<CourseItemDto> courseItemList = courseItemDao.getByCourse(courseSequnce);
            //를 통해서 목록 리스트를 보여주고 이 리스트 하나하나에 삭제 이벤트를 넣어준다.
			$(".item-remove-btn").click(function(){
            	if(parseInt($(".result-number").text())>3){
            	$(this).parents("tr").hide();
 
            	var course_Idx = $(this).attr("data-course_idx");
                var item_Idx = $(this).attr("data-item_idx");

                $.ajax({
                    url:"http://localhost:8080/Hexagram_semi/course/ajax_delete_update_item.nogari",
                    type:"get",
                    data:{
                    	itemIdx : item_Idx,
                    	courseIdx : course_Idx
                    },
                    success:function(resp){

                    	if(resp == "NNNNN"){
                    		   $(".result").text("최소 3개의 관광지가 필요합니다.").css("color","red");
                               $(".result-number").text($(".result-number").text());
                    	} else{
                        	 $(".result").text("삭제 완료!").css("color","blue");
                         	 $(".result-number").text(resp);
                         }
                    },
                    error:function(err){
                        console.log(err);
                    }        	
            	});
            }else{
            	$(".result").text("최소 3개의 관광지가 필요합니다.").css("color","red");
                $(".result-number").text($(".result-number").text());
            }  
       		 });
            
            
	           $("select[name=keyword]").change(function(){
	        	   location.href =  $(this).find("option:selected").val();
	           })
	           
	          $("select[name=subCity]").change(function(){
	        	   location.href =  $(this).find("option:selected").val();
	           })
            
            
            var searchSelector = <%=pn.getSearchSelector()%>;
            $(".page").hide();//모든 페이지를 숨기고
            $(".page").eq(searchSelector).show();//0,1로 설정된 곳을 나오게 한다.

            
            $(".btn-name").click(function(e){//키워드 검색을 누르면
                e.preventDefault();//이벤트를 막고
	
                searchSelector++;//구분자를 1로 설정하고(구분자는 설정되지 않았을때 0으로 되도록 페이지네이션 모듈에 설정해 두었다.)
                $(".page").hide();//모두 숨긴후
                $(".page").eq(searchSelector).show();//키워드 검색을 할수 있게 1번 페이지를 보여준다.
            });
            
            $(".btn-city").click(function(e){//지역 검색을 누르면
                e.preventDefault();//이벤트를 막고

                searchSelector--;//구분자를 다시 0으로 설정하고,
                $(".page").hide();//모두 숨긴후
                $(".page").eq(searchSelector).show();//0번 페이지를 보여준다
            });//지역 검색을 할 수 있게 0번으로 처리한다.


            
            
            $(".next-submit").on("submit",function(e){//다음으로 이동 버튼을 누를시, 선택한 아이템 수가 3개가 안된다면 submit을 막아준다(3차 방지)
      				if(parseInt($(".result-number").text())<3){//검색 span의 숫자가(문자열->숫자로 변환해서 확인해야함 기본적으로 문자이므로) 3보다 작을때,
            		e.preventDefault();
            		$(this).find("span").text("코스에 관광지는 최소 3개이상 추가되어야 합니다..!").css("color","red");//알림 span에다가 결과를 알려 막는다.
      				}
            });
            
            
        });
		

    </script>
	
<SECTION>
<!-- 페이지 내용 시작 -->
<div><h1>관광지 선택 메뉴(등록/삭제)</h1></div>
<!-- 페이지 클래스는 지역으로 검색할지 키워드로 검색할지 사용자에게 편한 보기옵션을 선택한다 (화면 토글을 통해서 검색을 왔다리 갔다리할 수 있다) -->
<div class="page">
<!-- 지역 선택(그 지역에 한해서 한정 선택할 수 있다.) -->
	<h2 style="text-align: center; color: gray">지역 검색!</h2>
		<div class="row">
<!-- 	여기에서 큰 컨셉은 경상남도 전라북도와 같이 4글자로 딱 맞춰지는 도시는 4글자로 설정하였고 그 이외의 도시들은 2글자로 같은 도시인지를 구분하게 설정하였다 -->
<!-- 이는 insert_last.jsp , update_last.jsp에서 이전으로 돌아갈떄도 아이템_코스의 첫번째 데이터에 들어있는 도시를 선택하여 다시 값을 전달해줄때 확실한 방법이 될 수 있다. -->
<select name="keyword" required class="form-input form-inline">
			<%if(pn.getColumn()==null || !pn.getColumn().equals("item_address")) {%>
			<option selected disabled>지역 선택</option>
			<%}else{ %>
			<option disabled>지역 선택</option>
			<%} %>
			
			<%if(pn.keywordValExists("서울")) {%>
			<option value="서울" selected>서울특별시</option>
			<%}else{ %>
			<option value="http://localhost:8080/Hexagram_semi/course/update.jsp?searchSelector=0&courseOriginSequnce=<%=courseOriginSequnce%>&courseSequnce=<%=courseSequnce%>&column=item_address&keyword=서울">서울특별시</option>
			<%} %>
			
			<%if(pn.keywordValExists("부산")) {%>
			<option value="부산" selected>부산광역시</option>
			<%}else{ %>
			<option value="http://localhost:8080/Hexagram_semi/course/update.jsp?searchSelector=0&courseOriginSequnce=<%=courseOriginSequnce%>&courseSequnce=<%=courseSequnce%>&column=item_address&keyword=부산">부산광역시</option>
			<%} %>
			
			<%if(pn.keywordValExists("인천")) {%>
			<option value="인천" selected>인천광역시</option>
			<%}else{ %>
			<option value="http://localhost:8080/Hexagram_semi/course/update.jsp?searchSelector=0&courseOriginSequnce=<%=courseOriginSequnce%>&courseSequnce=<%=courseSequnce%>&column=item_address&keyword=인천">인천광역시</option>
			<%} %>
			
			<%if(pn.keywordValExists("대구")) {%>
			<option value="대구" selected>대구광역시</option>
			<%}else{ %>
			<option value="http://localhost:8080/Hexagram_semi/course/update.jsp?searchSelector=0&courseOriginSequnce=<%=courseOriginSequnce%>&courseSequnce=<%=courseSequnce%>&column=item_address&keyword=대구">대구광역시</option>
			<%} %>
			
			<%if(pn.keywordValExists("대전")) {%>
			<option value="대전" selected>대전광역시</option>
			<%}else{ %>
			<option value="http://localhost:8080/Hexagram_semi/course/update.jsp?searchSelector=0&courseOriginSequnce=<%=courseOriginSequnce%>&courseSequnce=<%=courseSequnce%>&column=item_address&keyword=대전">대전광역시</option>
			<%} %>
			
			<%if(pn.keywordValExists("광주")) {%>
			<option value="광주" selected>광주광역시</option>
			<%}else{ %>
			<option value="http://localhost:8080/Hexagram_semi/course/update.jsp?searchSelector=0&courseOriginSequnce=<%=courseOriginSequnce%>&courseSequnce=<%=courseSequnce%>&column=item_address&keyword=광주">광주광역시</option>
			<%} %>
			
			<%if(pn.keywordValExists("울산")) {%>
			<option value="울산" selected>울산광역시</option>
			<%}else{ %>
			<option value="http://localhost:8080/Hexagram_semi/course/update.jsp?searchSelector=0&courseOriginSequnce=<%=courseOriginSequnce%>&courseSequnce=<%=courseSequnce%>&column=item_address&keyword=울산">울산광역시</option>
			<%} %>
			
			<%if(pn.keywordValExists("경기")) {%>
			<option value="경기" selected>경기도</option>
			<%}else{ %>
			<option value="http://localhost:8080/Hexagram_semi/course/update.jsp?searchSelector=0&courseOriginSequnce=<%=courseOriginSequnce%>&courseSequnce=<%=courseSequnce%>&column=item_address&keyword=경기">경기도</option>
			<%} %>
			
			<%if(pn.keywordValExists("세종")) {%>
			<option value="세종" selected>세종특별자치시</option>
			<%}else{ %>
			<option value="http://localhost:8080/Hexagram_semi/course/update.jsp?searchSelector=0&courseOriginSequnce=<%=courseOriginSequnce%>&courseSequnce=<%=courseSequnce%>&column=item_address&keyword=세종">세종특별자치시</option>
			<%} %>
			
			<%if(pn.keywordValExists("강원")) {%>
			<option value="강원" selected>강원도</option>
			<%}else{ %>
			<option value="http://localhost:8080/Hexagram_semi/course/update.jsp?searchSelector=0&courseOriginSequnce=<%=courseOriginSequnce%>&courseSequnce=<%=courseSequnce%>&column=item_address&keyword=강원">강원도</option>
			<%} %>																		
			
			<%if(pn.keywordValExists("제주")) {%>
			<option value="제주" selected>	제주특별자치도</option>
			<%}else{ %>
			<option value="http://localhost:8080/Hexagram_semi/course/update.jsp?searchSelector=0&courseOriginSequnce=<%=courseOriginSequnce%>&courseSequnce=<%=courseSequnce%>&column=item_address&keyword=제주">제주특별자치도</option>
			<%} %>
			
			<%if(pn.keywordValExists("경상북도")) {%>
			<option selected>경상북도</option>
			<%}else{ %>
			<option value="http://localhost:8080/Hexagram_semi/course/update.jsp?searchSelector=0&courseOriginSequnce=<%=courseOriginSequnce%>&courseSequnce=<%=courseSequnce%>&column=item_address&keyword=경상북도">경상북도</option>
			<%} %>
		
			<%if(pn.keywordValExists("경상남도")) {%>
			<option selected>경상남도</option>
			<%}else{ %>
			<option value="http://localhost:8080/Hexagram_semi/course/update.jsp?searchSelector=0&courseOriginSequnce=<%=courseOriginSequnce%>&courseSequnce=<%=courseSequnce%>&column=item_address&keyword=경상남도">경상남도</option>
			<%} %>
			
			<%if(pn.keywordValExists("전라남도")) {%>
			<option selected>전라남도</option>
			<%}else{ %>
			<option value="http://localhost:8080/Hexagram_semi/course/update.jsp?searchSelector=0&courseOriginSequnce=<%=courseOriginSequnce%>&courseSequnce=<%=courseSequnce%>&column=item_address&keyword=전라남도">전라남도</option>
			<%} %>
	
			<%if(pn.keywordValExists("전라북도")) {%>
			<option selected>전라북도</option>
			<%}else{ %>
			<option value="http://localhost:8080/Hexagram_semi/course/update.jsp?searchSelector=0&courseOriginSequnce=<%=courseOriginSequnce%>&courseSequnce=<%=courseSequnce%>&column=item_address&keyword=전라북도">전라북도</option>
			<%} %>
			
			<%if(pn.keywordValExists("충청남도")) {%>
			<option selected>충청남도</option>
			<%}else{ %>
			<option value="http://localhost:8080/Hexagram_semi/course/update.jsp?searchSelector=0&courseOriginSequnce=<%=courseOriginSequnce%>&courseSequnce=<%=courseSequnce%>&column=item_address&keyword=충청남도">충청남도</option>
			<%} %>
		
			<%if(pn.keywordValExists("충청북도")) {%>
			<option selected>충청북도</option>
			<%}else{ %>
			<option value="http://localhost:8080/Hexagram_semi/course/update.jsp?searchSelector=0&courseOriginSequnce=<%=courseOriginSequnce%>&courseSequnce=<%=courseSequnce%>&column=item_address&keyword=충청북도">충청북도</option>
			<%} %>				
		</select>
<!-- 	select같은 경우, 내가 선택하는 것이 keyword이고 column값은 주소로 고정되있기 때문에 일반 input과는 반대로 처리해주었고, -->
<!-- 	이를 위해 모듈에 keywordValExists 키워드가 같은지 확인해주는 메소드를 넣었다. -->
<!-- 	핵심이다..courseOriginSequnce(기존코스번호) 및 courseSequnce(수정용 임시 코스번호)는 무슨일이 있어서 최초 생성하고 잃어서는 안될 고유 번호이다. -->
<!-- courseOriginSequnce(기존코스번호)는 등록 제일 끝에 덮어쓰는 용도 / courseSequnce(수정용 임시 코스번호)는 기존 내용을 받아서 내용을 갱신하는 용도 -->
<!-- 	검색 후 검색 옵션이 무엇이였는지 전달 도시명 검색 옵션은 구분자를 0번으로 지정한다.191~210번줄 참조-->
		<select name="subCity" required class="form-input form-inline">
			<%if(pn.getKeyword()==null) {%>
			<option selected disabled>시군구 선택</option>
			<%}else{ %>
			<option disabled>시군구 선택</option>
			<%} %>
			
			<%if(isSearchMode && pn.getColumn().equals("item_address")){
	            List<String> subCityList = ItemCityList.getSubcityList(pn.getKeyword());  
	            for(String s : subCityList){%>
	            
			<%if(subCity!=null && subCity.equals(s)) {%>
			<option value="<%=s%>" selected><%=s%></option>
			<%}else{ %>
			<option value="http://localhost:8080/Hexagram_semi/course/update.jsp?searchSelector=0&courseOriginSequnce=<%=courseOriginSequnce%>&courseSequnce=<%=courseSequnce%>&column=item_address&keyword=<%=pn.getKeyword()%>&subCity=<%=s%>"><%=s%></option>
			<%} %>
			
			<%} %>
			<%} %>
		</select>	
		
		
		</div>
		
		<div class="row">
		<button class="btn btn-name form-btn">키워드로 검색 >></button>
		</div>
<!-- 키워드 검색으로 누르게 되면 구분자의 숫자를 1으로 바꾸게 설정함 -->
</div>

<div class="page">
<h2 style="text-align: center;color: gray">키워드 검색!</h2>
<form action="update.jsp" method="get">
	<div class="row">
		<select name="column" required class="form-input form-inline">
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
		
				<%if(pn.getColumn() != null && pn.getColumn().equals("item_address")){ %>
					<input type="search" name="keyword" placeholder="검색어 입력"
					required class="form-input form-inline">
				<%}else{ %>
					<input type="search" name="keyword" placeholder="검색어 입력"
					required value="<%=pn.getKeywordString()%>" class="form-input form-inline">
				<%} %>
			
			<input type="hidden" name="searchSelector" value="<%=1%>">
			<!-- 	검색 후 검색 옵션이 무엇이였는지 전달 키워드 검색 옵션은 구분자를 1번으로 지정한다.191~210번줄 참조-->
			<input type="hidden" name="courseSequnce" value="<%=courseSequnce%>">
			<input type="hidden" name="courseOriginSequnce" value="<%=courseOriginSequnce%>">
			<!-- 	핵심이다..courseOriginSequnce(기존코스번호) 및 courseSequnce(수정용 임시 코스번호)는 무슨일이 있어서 최초 생성하고 잃어서는 안될 고유 번호이다. -->
			<!-- courseOriginSequnce(기존코스번호)는 등록 제일 끝에 덮어쓰는 용도 / courseSequnce(수정용 임시 코스번호)는 기존 내용을 받아서 내용을 갱신하는 용도 -->
			<input type="submit" value="검색" class="form-btn form-inline">
			</div>
</form>
<button class="btn btn-city"><< 지역으로 검색</button>
<!-- 지역 검색으로 누르게 되면 구분자의 숫자를 0으로바꾸게 설정함 -->
</div>

<br>
<span>검색 결과  : <%=pn.getCount()%> 개의 관광지가 검색되었습니다.</span>
<br>


<h3>- 관광지 목록 -</h3>
<%if(list.isEmpty()) {%>
	<h3>결과가 없습니다.</h3>
<%}else{ %>
		<%if(!list.isEmpty()){ %>
			<table border="1" width="800px">
				<tbody>
						<tr>
							<th>주소</th>
							<th>관광지명</th>
							<th>메뉴</th>
						</tr>					
						<%for(ItemDto itemDto : list) {%>
							<tr>
								<td><%=itemDto.getItemAddress()%></td>
								<td><%=itemDto.getItemName()%></td>
								<td><button class="item-add-btn" data-course_idx="<%=courseSequnce%>"  data-item_idx="<%=itemDto.getItemIdx()%>" data-item_address="<%=itemDto.getAdressCity()%>" data-item_name="<%=itemDto.getItemName()%>">추가하기</button></td>
<!-- 								button class="item-add-btn"에대한 이벤트 및 이 태그에 있는 정보는 53~60번째 줄에 정의됨 -->
							</tr>
						<%} %>
				</tbody>
			</table>
						<%} %>
<%} %>

<!-- 	아래에 있는 페이지네비게이터에서 넘어가는 정보에는 반드시 courseOriginSequnce(기존코스번호) 및 courseSequnce(수정용 임시 코스번호) (설명 343,344줄 참조) -->
<!-- 	searchSelector구분자 정보 => 내가 어떤 검색을 통해서 결과물을 얻었는지 확인해주어야한다.-->
	<div>		
	<%if(pn.hasPreviousBlock()){ %>
		<%if(isSearchMode){ %>
			<!-- 검색용 링크 -->
			<a href="update.jsp?column=<%=pn.getColumn()%>&keyword=<%=pn.getKeyword()%>&page=<%=pn.getPreviousBlock()%>&courseSequnce=<%=courseSequnce%>&searchSelector=<%=pn.getSearchSelector()%>&courseOriginSequnce=<%=courseOriginSequnce%>">&lt;</a>
		<%} else { %>
			<!-- 목록용 링크 -->
			<a href="update.jsp?page=<%=pn.getPreviousBlock()%>&courseSequnce=<%=courseSequnce%>&searchSelector=<%=pn.getSearchSelector()%>&courseOriginSequnce=<%=courseOriginSequnce%>">&lt;</a>
		<%} %>
	<%} else { %>
		 <a>&lt;</a>
	<%} %> 
			
			
	<%for(int i = pn.getStartBlock(); i <= pn.getRealLastBlock(); i++){ %>
		<%if(isSearchMode){ %>
		<!-- 검색용 링크 -->
		<a href="update.jsp?column=<%=pn.getColumn()%>&keyword=<%=pn.getKeyword()%>&page=<%=i%>&courseSequnce=<%=courseSequnce%>&searchSelector=<%=pn.getSearchSelector()%>&courseOriginSequnce=<%=courseOriginSequnce%>"><%=i%></a>
		<%}else{ %>
		<!-- 목록용 링크 -->
		<a href="update.jsp?page=<%=i%>&courseSequnce=<%=courseSequnce%>&searchSelector=<%=pn.getSearchSelector()%>&courseOriginSequnce=<%=courseOriginSequnce%>"><%=i%></a>
		<%} %>
	<%} %>
	
	
	<%if(pn.hasNextBlock()){ %>
		<%if(isSearchMode){ %>
			<!-- 검색용 링크 -->
			<a href="update.jsp?column=<%=pn.getColumn()%>&keyword=<%=pn.getKeyword()%>&page=<%=pn.getNextBlock()%>&courseSequnce=<%=courseSequnce%>&searchSelector=<%=pn.getSearchSelector()%>&courseOriginSequnce=<%=courseOriginSequnce%>">&gt;</a>
		<%} else { %>
			<!-- 목록용 링크 -->
			<a href="update.jsp?page=<%=pn.getNextBlock()%>&courseSequnce=<%=courseSequnce%>&searchSelector=<%=pn.getSearchSelector()%>&courseOriginSequnce=<%=courseOriginSequnce%>">&gt;</a>
		<%} %> 
	<%} else {%>
		<a>&gt;</a>
	<%} %>
	</div>

<div><h3>- 내가 선택한 관광지 목록 -</h3></div>

	<div>
			<table border="1" width="800px">
				<tbody class="item-add">
<!-- 				53번째 줄 참조 , tbody안에 기존에 있던 정보들이 모두 for문으로 list화 되었을때 그 뒤에 추가해서 보여주기 위해 append를 통해 태그를 추가해준다. -->
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
<!-- 							151~153번째 줄 참조 -->
							</tr>
						<%} %>
<!-- 			요부분이 내가 추가하기 버튼을 누르면 태그(삭제하기 이벤트 포함)가 추가되는 곳이다. -->
				</tbody>
			</table>
	</div>

<!-- 추가/삭제에 대한 결과를 출력해준다(자바스크립트 71~79번째 줄 참조)  -->
<div>
<span class="result"></span>
</div>
<!-- 현재 선택한 관광지의 개수를 보여준다 (처음에는 보여주는 용도이며, ajax에서 수정,삭제후 현재 db에 있는 갯수를 문자열로 반환해주는데 이를 다시 숫자로 변환하여 최신하 시켜주어 화면에 보여주는 역할) -->
<div>
현재 선택한 관광지 : <span class="result-number"><%=courseItemList.size()%></span> 개
</div>

<div>
	<form action="update_last.jsp" class="next-submit">
		<button>다음 단계로(제목/내용/선택한 목록 조회 및 수정)</button>
		<div>
		<span></span>
		</div>
		<input type="hidden" name="courseSequnce" value="<%=courseSequnce%>">
		<input type="hidden" name="courseOriginSequnce" value="<%=courseOriginSequnce%>">
<!-- 		이 값들이 넘어가야하는 이유 : 343,344 줄 참조 -->
	</form>
</div>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>