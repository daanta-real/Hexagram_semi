<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%
   String root = request.getContextPath();
   int itemIdx = Integer.parseInt(request.getParameter("itemIdx")); // 해당 인덱스 글에 댓글을 쓰겠다.
   int usersIdx = (int)request.getSession().getAttribute("usersIdx");//해당 접속 회원이 댓글을 쓰겠다.
   
   %>
    <h4 align="center">[댓글 작성]</h4>
 <form action="<%=request.getContextPath()%>/jsp/item_reply/insert.nogari" method="post">  
   <!--    	댓글 내용 전송 -->
   <table align="center">
   	 <tbody>
   	 	<tr width="700">
   	 		<th>댓글 입력</th>
   	 		<td>
   	 			<textarea name="itemReplyDetail" align="center" placeholder="댓글 입력" required rows="3" cols="100"></textarea>
   	 		</td>
   	 	</tr>
   	 </tbody>
   	 <tfoot>
   	 <tr>
   	 	<td>

				<input type="submit" value="댓글 작성">

   	 	</td>
   	 </tr>
   	 </tfoot> 	 
   </table>
	<!--    	관광지 idx 전송 -->
   	<input type="hidden" name="itemIdx" value="<%=itemIdx%>">
   	<!--    	유저 idx 전송 -->
	<input type="hidden" name="usersIdx" value="<%=usersIdx%>">

 </form> 