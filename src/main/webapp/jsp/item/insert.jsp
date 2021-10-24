<%@page import="beans.ItemDao"%>
<%@page import="beans.ItemDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <% 
 Integer users_idx = (Integer)request.getSession().getAttribute("users_key");
 String users_grade = (String)session.getAttribute("users_grade");
 String root = request.getContextPath();
 //관리자 권한으로 게시글 생성.=> 일반회원 X
 %>
 
<jsp:include page="/template/header.jsp">
	<jsp:param name="pageTitle" value="메인" />
</jsp:include>
    

 <h2>관광지 등록</h2>

<form action="insert.nogari" method="post">
	<table border="1" width="500">
		<tbody>
			<tr>
				<td>작성자</td>
				<td>
				<input type="hidden" name="users_idx" value="<%=users_idx %>" required>
				<%=users_idx %>
				</td>
			</tr>
			<tr>
				<td>카테고리</td>
				<td>
					<select name="item_type">
						<option>관광지</option>
						<option>축제</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>관광지명</td>
				<td>
				<input type="text" name="item_name" placeholder="관광지명 입력" required>
				</td>
			</tr>
			<tr>
				<td>주소</td>
				<td>
				<textarea name="item_address" rows="1" cols="20" placeholder="주소 입력">
				</textarea>
				</td>
			</tr>
			<tr>
				<td>내용</td>
				<td>
				<textarea name="item_detail" rows="20" cols="50" placeholder="내용 입력" wrap="virtual">
				</textarea>
				</td>
			</tr>
			<tr>
				<td>태그</td>
				<td><input type="text" name="item_tag" placeholder="태그 입력"></td>
			</tr>
			<tr>
				<td>기간</td>
				<td><input type="text" name="item_periods" placeholder="기간 입력"></td>
			</tr>
			<tr>
				<td>운영시간</td>
				<td><input type="text" name="item_time" placeholder="운영시간 입력"></td>
			</tr>
			<tr>
				<td>홈페이지</td>
				<td><input type="url" name="item_homepage" placeholder="홈페이지 입력"></td>
			</tr>
			<tr>
				<td>주차</td>
				<td><input type="text" name="item_parking" placeholder="주차가능여부 입력"></td>
			</tr>
		</tbody>
		<tfoot>
			<tr align="center">
				<td colspan="3">
				<input type="submit" value="등록">
				</td>
			</tr>
		</tfoot>
	</table>
</form>

 
 <jsp:include page="/template/footer.jsp"></jsp:include>