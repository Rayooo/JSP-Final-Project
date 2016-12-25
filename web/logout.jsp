
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //退出模块
    session.invalidate();
    response.sendRedirect("index.jsp");
%>