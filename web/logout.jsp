<%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/14
  Time: 16:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //退出模块
    session.invalidate();
    response.sendRedirect("index.jsp");
%>