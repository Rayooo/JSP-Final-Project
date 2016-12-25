
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //判断是管理员,才能进入到下一步,如果不是管理员,直接跳到首页
    String userNameConfirmation = (String)session.getAttribute("userName");
    Integer isManagerConfirmation = (Integer)session.getAttribute("isManager");
    if(userNameConfirmation == null || isManagerConfirmation == null || isManagerConfirmation != 1){
        response.sendRedirect("index.jsp");
    }
%>