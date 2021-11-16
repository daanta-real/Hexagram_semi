<%@page import="beans.ItemDao"%>
<%@page import="beans.ItemDto"%>
<%@page import="beans.UsersDto"%>
<%@page import="beans.UsersDao"%>
<%@page import="util.HexaLibrary" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<HTML>
<HEAD>
<TITLE>노가리투어 - 관광지 추가</TITLE>
<jsp:include page="/resource/template/header_head.jsp"></jsp:include>
</HEAD>
<BODY>
<jsp:include page="/resource/template/header_body.jsp"></jsp:include>
<SECTION>
<!-- 페이지 내용 시작 -->
 
 <% 
 String root = request.getContextPath();
 %>

 <h3>게시글 작성</h3>
 
 <form action="insert.nogari" method="post" enctype="multipart/form-data">
	<table border="1" width="500">
	
		<tbody>
			<tr>
				<td>카테고리</td>
				<td>
					<select name="itemType" required="required">
						<option selected="selected">관광지</option>
						<option>축제</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>관광지명</td>
				<td>
					<input type="text" name="itemName" placeholder="관광지명 입력" required>
				</td>
			</tr>
			<tr>
				<td>주소</td>
				<td>
					<textarea name="itemAddress" rows="1" cols="50" placeholder="주소를 입력하세요"></textarea>
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
					<textarea name="itemDetail" rows="20" cols="50" placeholder="내용을 입력하세요"></textarea>
				</td>
			</tr>
			<tr>
				<td>기간</td>
				<td>
					<input type="text" name="itemPeriod" placeholder="기간 입력">
				</td>
			</tr>
			<tr>
				<td>운영시간</td>
				<td>
					<input type="text" name="itemTime" placeholder="운영시간 입력">
				</td>
			</tr>
			<tr>
				<td>홈페이지</td>
				<td>
					<input type="url" name="itemHomepage" placeholder="홈페이지 입력">
				</td>
			</tr>
			<tr>
				<td>주차</td>
				<td>
					<input type="text" name="itemParking" placeholder="주차가능여부 입력">
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
					<input type="submit" value="작성 완료">
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