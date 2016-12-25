
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //判断是否登录,如果登录才能进入下一步
    String userNameConfirmation = (String)session.getAttribute("userName");
    if(userNameConfirmation == null){
        response.sendRedirect("index.jsp");
    }
%>