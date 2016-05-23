<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/23
  Time: 20:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="confirmationLogin.jsp"%>
<%
    int currentPage = Integer.parseInt(request.getParameter("page"));
    try {
        DbConnection dbConnection = new DbConnection();
        Statement statement = dbConnection.connection.createStatement();
        String sql = "SELECT * FROM photo WHERE isDeleted=0 LIMIT "+ Integer.toString((currentPage-1)*9) +",9";//(页数-1)*每页条数,每页条数
        ResultSet resultSet = statement.executeQuery(sql);
        if(resultSet != null){
            int imageCount = 1;
            while (resultSet.next()){
                if(imageCount % 3 == 0){
                    out.println("<div class='row'>");
                }
%>
                <div class="col-sm-4 col-md-4">
                    <div class="thumbnail">
                        <img src="<%=resultSet.getString("url")%>" alt="">
                        <div class="caption">
                            <%--<h3>Thumbnail label</h3>--%>
                            <p><%=resultSet.getString("description")%></p>
                            <p>url: <%=resultSet.getString("url")%></p>
                            <%--<p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>--%>
                        </div>
                    </div>
                </div>
<%
                if(imageCount % 3 == 0){
                    out.println("</div>");
                }
                imageCount++;
            }

        }
    }catch (SQLException e){
        e.printStackTrace();
    }
%>