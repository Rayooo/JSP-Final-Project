<%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/15
  Time: 13:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //判断是否登录,如果登录才能进入下一步
    String userNameConfirmation = (String)session.getAttribute("userName");
    if(userNameConfirmation == null){
        response.sendRedirect("index.jsp");
    }
%>