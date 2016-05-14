<%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/14
  Time: 19:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //判断是否为用户,是用户才能进入下一步,不是用户直接跳到首页
    String userNameConfirmation = (String)session.getAttribute("userName");
    Integer isManagerConfirmation = (Integer)session.getAttribute("isManager");
    if(userNameConfirmation == null || isManagerConfirmation == null || isManagerConfirmation != 0){
        response.sendRedirect("index.jsp");
    }
%>