<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/21
  Time: 16:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="confirmationManager.jsp"%>
<%
    String userId = request.getParameter("userId");
    try {
        DbConnection dbConnection = new DbConnection();
        Statement statement = dbConnection.connection.createStatement();
        String sql = "UPDATE user SET isDeleted=1 WHERE id="+ userId;
        int rs = statement.executeUpdate(sql);
        if(rs > 0){
            out.print("success");
        }
        else{
            out.print("error");
        }
    }
    catch (SQLException e) {
//        e.printStackTrace();
        out.print("error");
    }
%>
