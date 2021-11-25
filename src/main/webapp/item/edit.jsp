<%@page import="beans.ItemFileDto"%>
<%@page import="beans.ItemFileDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="beans.ItemDto"%>
<%@page import="java.util.List"%>
<%@page import="beans.ItemDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 관광지 수정</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
		$(function(){
		
		    //.find-address-btn을 누르면 주소 검색창 출력
		    $(".find-address-btn").click(function(e){
		        e.preventDefault();//a태그일 경우를 대비하여 넘어가는걸 방지한다
		        findAddress();
		    });
		
		    function findAddress() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		                console.log(data);
		                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
		
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var addr = ''; // 주소 변수
		
		                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
		                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
		                    addr = data.roadAddress;
		                } else { // 사용자가 지번 주소를 선택했을 경우(J)
		                    addr = data.jibunAddress;
		                }
		
		                // 주소 정보를 해당 필드에 넣는다
		
		                document.querySelector(".address-select").value = addr;
		            }
		        }).open();
		    }
		});
		
		window.addEventListener("load", function(){
			document.querySelector(".confirm-link").addEventListener("click", function(e){
				varchoice = confirm("정말 완료 하시겠습니까?");
				if(!choice){
					e.preventDefault();
				}
			})
		});
</script>

<style>

* {
    box-sizing: border-box;
}
.row {
    margin-top: 10px;
    margin-bottom: 10px;
}
.container-500 {
    width: 500px;
}
.left {
    text-align: left;
}

.center {
    text-align: center;
}

.right {
    text-align: right;
}
.container-left {
    margin-left: 0;
    margin-right: auto;
}

.container-center {
    margin-left: auto;
    margin-right: auto;
}

.container-right {
    margin-left: auto;
    margin-right: 0;
}

textarea {
    resize: none;
}

textarea.vertical {
    resize: vertical;
    min-height: 200px;
}
.form-input,
.form-btn {
    width: 100%;
    font-size: 20px;
    padding: 10px;
}

.form-input {
    border: 1px solid rgb(43, 48, 90);
}

.form-btn {
    color: rgb(77, 25, 25);
    background-color: rgb(232, 193, 125);
    font-weight: bold;
}

.form-block {
    display: block;
}

.form-inline {
    width: auto;
}
</style>

<%-- 페이지에 필요한 변수 저장 및 변수 선언 --%>
 <% 
 //usersIdx를 변수에 저장
 int usersIdx = (int)request.getSession().getAttribute("usersIdx");
 //usersId를 변수에 저장
 String usersId = (String)request.getSession().getAttribute("usersId");
 //usersGrade를 변수에 저장
 String usersGrade = (String)request.getSession().getAttribute("usersGrade");
//경로 설정을 위해 index.jsp를 변수 저장
 String root = request.getContextPath();
 //관리자 권한으로 게시글 생성.=> 일반회원 X
 %>

<%-- 기존 작성 불러오기 위한 단일 조회 --%>
<%
	//기존에 등록된 내용을 입력창에 출력해주기 위해 itemIdx을 전달받아 단일조회 한다
	int itemIdx = Integer.parseInt(request.getParameter("itemIdx"));
	ItemDao itemDao = new ItemDao();
	ItemDto itemDto = itemDao.get(itemIdx);	
%>
<h3>게시글 수정(관리자 페이지)</h3>
	<form action="edit.nogari" method="post" enctype="multipart/form-data">
        <div class="container-500 container-center">
            <div class="row">
                <label>작성자</label>
                <input type="hidden" name="itemIdx" value="<%=itemDto.getItemIdx() %>" required class="form-input">
				<%=usersId %>
            </div>
            <div class="row">
                <label>관광지명</label>
                <input type="text" name="itemName" placeholder="관광지명 입력" required value="<%=itemDto.getItemName() %>" class="form-input">
            </div>
            <div class="row">
                <label>카테고리</label>
                <select name="itemType" value="<%=itemDto.getItemType() %>" class="form-input">
						<option>관광지</option>
						<option>축제</option>
				</select>
            </div>
            <div class="row">
                <label>주소</label>
                <button type="button" class="form-btn form-inline find-address-btn">주소 찾기</button>
                <textarea name="itemAddress" rows="1" cols="50" placeholder="주소를 입력하세요" required class="form-input address-select"><%=itemDto.getItemAddress() %></textarea>
            </div>
            <div class="row">
                <label>내용</label>
                <textarea name="itemDetail" rows="20" cols="50" placeholder="내용을 입력하세요" required class="form-input"><%=itemDto.getItemDetail() %></textarea>
            </div>
            <div class="row">
                <label>기간</label>
                <input type="text" name="itemPeriods" placeholder="기간 입력" value="<%=itemDto.getItemPeriod()%>"  class="form-input">
            </div>
            <div class="row">
                <label>운영시간</label>
                <input type="text" name="itemTime" placeholder="운영시간 입력" value="<%=itemDto.getItemTime()%>" class="form-input">
            </div>
            <div class="row">
                <label>홈페이지</label>
                <input type="url" name="itemHomepage" placeholder="홈페이지 입력" value="<%=itemDto.getItemHomepage()%>" class="form-input">
            </div>
            <div class="row">
                <label>주차</label>
                <input type="text" name="itemParking" placeholder="주차가능여부 입력" value="<%=itemDto.getItemParking()%>" class="form-input">
            </div>
            <div class="row">
                <label>이미지</label>
                <input type="file" name="attach" accept="image/*">
            </div>
            <div class="row center">
                <input type="submit" value="수정" class="form-btn confirm-link">
            </div>
        </div>
    </form>



<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>