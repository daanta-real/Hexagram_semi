<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

   <%
   String root = request.getContextPath();
   String item_idx = request.getParameter("item_idx"); // 해당 인덱스 글에 댓글을 보여주겠다.
   
   int users_idx = (int)request.getSession().getAttribute("users_key");//
   
   
   %>