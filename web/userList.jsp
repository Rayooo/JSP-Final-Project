<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%--
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
    //记录有多少页
    int count = 0;
    try {
        DbConnection dbConnection = new DbConnection();
        Statement statement = dbConnection.connection.createStatement();
        String sql = "SELECT count(id) FROM user WHERE isDeleted=0";
        ResultSet resultSet = statement.executeQuery(sql);
        if(resultSet != null){
            resultSet.next();
            count = resultSet.getInt("count(id)")/2;
        }
    }catch (SQLException e) {
        e.printStackTrace();
    }
%>

<%--内容--%>
<div id="userListTable"></div>

<%--分页--%>
<nav class="text-center">
    <ul class="pagination pagination-lg">
        <li id="previous"><a aria-label="Previous">&laquo;</a></li>

        <li class="active paging" id="paging1"><a class="pagingA">1</a></li>
        <%
            for(int i = 2;i <= count;++i){
                out.println("<li class='paging' id='paging"+i+"'><a class='pagingA'>"+i+"</a></li>");
            }
        %>

        <li id="next"><a aria-label="Previous">&raquo;</a></li>
    </ul>
</nav>

<script>
    $(document).ready(function () {
        $.post("userListTable.jsp",{page:1},function (data) {
            $("#userListTable").html(data);
        })
    });

    $(".pagingA").click(function () {
        $(".paging").removeClass("active");
        $("#paging"+this.innerHTML).addClass("active");
        $.post("userListTable.jsp",{page:this.innerHTML},function (data) {
            $("#userListTable").html(data);
        })
    });



</script>


</body>
</html>