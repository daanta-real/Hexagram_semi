<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%
   String root = request.getContextPath();
   String item_idx = request.getParameter("item_idx"); // 해당 인덱스 글에 댓글을 쓰겠다.
   int users_idx = (int)request.getSession().getAttribute("users_key");//해당 접속 회원이 댓글을 쓰겠다.
   
   %>
    <h4>[댓글 작성]</h4>
 <form action="<%=request.getContextPath()%>/jsp/item_reply/insert.nogari" method="post">  
   <!--    	댓글 내용 전송 -->
   <table>
   	 <tbody>
   	 	<tr width="900">
   	 		<th>댓글 입력</th>
   	 		<td>
   	 			<textarea name="item_reply_detail" align="center" placeholder="댓글 입력" required rows="3" cols="110"></textarea>
   	 		</td>
   	 	</tr>
   	 </tbody>
   </table>
	<!--    	관광지 idx 전송 -->
   	<input type="hidden" name="item_idx" value="<%=item_idx%>">
   	<!--    	유저 idx 전송 -->
	<input type="hidden" name="users_idx" value="<%=users_idx%>">
<br>
<!-- 회원이 로그인 되어 있을 경우에만 댓글 작성가능 -->
<%if(request.getSession().getAttribute("users_key") != null) {%>
<input type="submit" value="댓글 작성">
<%}else{ %>
<input type="button" value="로그인 후 가능">
<%} %>
	
 </form> 