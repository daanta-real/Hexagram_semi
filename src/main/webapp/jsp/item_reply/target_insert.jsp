<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
   <%
   String root = request.getContextPath();
   int itemIdx = Integer.parseInt(request.getParameter("itemIdx")); // 해당 인덱스 글에 댓글을 쓰겠다.
   int usersIdx = (int)request.getSession().getAttribute("usersIdx");//해당 접속 회원이 댓글을 쓰겠다.
   int itemReplyTargetIdx = Integer.parseInt(request.getParameter("itemReplyTargetIdx")); //지금 쓰는 댓글에는 부모 댓글 번호가 있다.
   %>

   
 <form action="<%=request.getContextPath()%>/jsp/item_reply/target_insert.nogari" method="post">  
   <!--    	대댓글 내용 전송 -->
   <tr>
   	<td colspan="4">
   				<textarea name="itemReplyDetail" align="center" placeholder="대댓글 입력" required rows="3" cols="70"></textarea>
				
				<input type="hidden" name="usersIdx" value="<%=usersIdx%>">
				<input type="hidden" name="itemIdx" value="<%=itemIdx%>">
				<input type="hidden" name="itemReplyTargetIdx" value="<%=itemReplyTargetIdx%>">
				
				<input type="submit" value="대댓글 작성 완료">
		</td>
	</tr>
 </form>
	