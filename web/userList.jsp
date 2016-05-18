<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/17
  Time: 21:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>成员信息</title>
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link href="font-awesome/css/font-awesome.css">
</head>
<body>

<%@include file="navbar.jsp"%>
<%@include file="confirmationManager.jsp"%>
<%
    session.setAttribute("location","userList");

    try{
        DbConnection dbConnection = new DbConnection();
        Statement statement = dbConnection.connection.createStatement();
        String sql = "SELECT id,userName,sex,name,mobile,isManager FROM user WHERE isDeleted=0";
        ResultSet resultSet = statement.executeQuery(sql);

        if(resultSet != null){
            %>
        <div class='container alert alert-success text-center' role='alert'>以下是所有成员的信息</div>
        <div class='container text-center'>
            <table class="table table-striped table-hover table-bordered">
                <tr>
                    <td>id</td>
                    <td>姓名</td>
                    <td>手机</td>
                    <td>用户名</td>
                    <td>性别</td>
                    <td>用户类别</td>
                    <td>操作</td>
                </tr>
<%
            while (resultSet.next()){
                int id = resultSet.getInt("id");
                String userName = resultSet.getString("userName");
                String sex = resultSet.getInt("sex") == 1? "男":"女";
                String name = resultSet.getString("name");
                String mobile = resultSet.getString("mobile");
                String isManager = resultSet.getInt("isManager") == 1? "管理员":"用户";
                %>
                <tr>
                    <td><%=id%></td>
                    <td><%=name%></td>
                    <td><%=mobile%></td>
                    <td><%=userName%></td>
                    <td><%=sex%></td>
                    <td><%=isManager%></td>
                    <td>
                        <a target="_blank" href="userInfo.jsp?id=<%=id%>"><i class="fa fa-child" aria-hidden="true"></i></a>
                        <a target="_blank" href="userInfoEdit.jsp?id=<%=id%>"><i class="fa fa-cog" aria-hidden="true"></i></a>
                        <a href="#"><i class="fa fa-trash-o" aria-hidden="true"></i></a>
                    </td>
                </tr>
<%
            }
            out.println("</table>");
            out.println("</div>");
        }
        else{
            out.println("<div class='container alert alert-warning text-center' role='alert'>未查询到信息</div>");
        }
        if(resultSet !=null)
            resultSet.close();
        if(statement != null)
            resultSet.close();
        dbConnection.closeConnection();


    }catch (SQLException e) {
        e.printStackTrace();
    }


%>



</body>
</html>
