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
	<table border="1" style="width:500px;">
		<tbody>
			<tr>
				<td>작성자</td>
				<td>
					<input type="hidden" name="itemIdx" value="<%=itemDto.getItemIdx() %>" required>
					<%=usersId %>
				</td>
			</tr>
			<tr>
				<td>카테고리</td>
				<td>
					<select name="itemType" value="<%=itemDto.getItemType() %>">
						<option>관광지</option>
						<option>축제</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>관광지명</td>
				<td>
					<input type="text" name="itemName" placeholder="관광지명 입력" required value="<%=itemDto.getItemName() %>">
				</td>
			</tr>
			<tr>
				<td>주소</td>
				<td>
					<textarea name="itemAddress" rows="1" cols="50" placeholder="주소를 입력하세요"><%=itemDto.getItemAddress() %></textarea>
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea name="itemDetail" rows="20" cols="50" placeholder="내용을 입력하세요"><%=itemDto.getItemDetail() %></textarea>
				</td>
			</tr>
			
			<tr>
				<td>기간</td>
				<td>
					<input type="text" name="itemPeriods" placeholder="기간 입력" value="<%=itemDto.getItemPeriod()%>">
				</td>
			</tr>
			<tr>
				<td>운영시간</td>
				<td>
					<input type="text" name="itemTime" placeholder="운영시간 입력" value="<%=itemDto.getItemTime()%>">
				</td>
			</tr>
			<tr>
				<td>홈페이지</td>
				<td>
					<input type="url" name="itemHomepage" placeholder="홈페이지 입력" value="<%=itemDto.getItemHomepage()%>">
				</td>
			</tr>
			<tr>
				<td>주차</td>
				<td>
					<input type="text" name="itemParking" placeholder="주차가능여부 입력" value="<%=itemDto.getItemParking()%>">
				</td>
			</tr>
			<tr>
				<td>이미지</td>
				<td>
					<input type="file" name="attach" accept="image/*">
				</td>				
			</tr>
		</tbody>
		<tfoot>
			<tr align="center">
				<td colspan="3">
					<input type="submit" value="수정">
				</td>
			</tr>
		</tfoot>
	</table>
</form>

<!-- 페이지 내용 끝. -->
</SECTION>
<jsp:include page="/resource/template/footer.jsp"></jsp:include>
<SCRIPT TYPE="TEXT/JAVASCRIPT" SRC="<%=root%>/resource/js/footer.js"></SCRIPT>
</BODY>
</HTML>