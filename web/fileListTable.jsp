<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/24
  Time: 21:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="confirmationLogin.jsp"%>
<%
    int currentPage = Integer.parseInt(request.getParameter("page"));
    try {
        DbConnection dbConnection = new DbConnection();
        Statement statement = dbConnection.connection.createStatement();
        String sql = "SELECT * FROM file  WHERE isDeleted=0 ORDER BY id DESC LIMIT "+ Integer.toString((currentPage-1)*10) +",10";//(页数-1)*每页条数,每页条数
        ResultSet resultSet = statement.executeQuery(sql);

        if (resultSet != null){
            while (resultSet.next()){
                String originalFileName = resultSet.getString("fileName");
                String url = resultSet.getString("url");
                String createTime = resultSet.getDate("createTime") + " " + resultSet.getTime("createTime");
                String description = resultSet.getString("description");

                String uploadFileUserId = Integer.toString(resultSet.getInt("userId"));

                DbConnection userConnection = new DbConnection();
                Statement userStatement = userConnection.connection.createStatement();
                String userSql = "SELECT name FROM user WHERE id="+uploadFileUserId;
                ResultSet userResultSet = userStatement.executeQuery(userSql);
                String uploadFileUserName = "";
                if(userResultSet != null){
                    userResultSet.next();
                    uploadFileUserName = userResultSet.getString("name");
                }
                %>
                <div class="media col-md-6" style="margin-top: 0">
                    <div class="media-left">
                        <a href="#">
                            <img class="media-object" src="image/code.png" alt="...">
                        </a>
                    </div>
                    <div class="media-body">
                        <h4 class="media-heading">文件名:<%=originalFileName%></h4>
                        <p>上传者:<%=uploadFileUserName%></p>
                        <p>描述:<%=description.equals("")? "无":description%></p>
                        <p>引用链接:<%=url%></p>
                        <p>上传时间:<%=createTime%></p>
                        <p>
                            <%--<button class="btn btn-success">下载</button>--%>
                            <a class="btn btn-success" download="<%=resultSet.getString("fileName")%>" href="<%=resultSet.getString("url")%>">下载</a>
                            <button class="btn btn-danger">删除</button>
                        </p>
                    </div>
                </div>
<%
                if(userResultSet != null){
                    userResultSet.close();
                }
                if(userStatement != null){
                    userStatement.close();
                }
                userConnection.closeConnection();
            }
        }

    }catch (SQLException e){
        e.printStackTrace();
    }
%>