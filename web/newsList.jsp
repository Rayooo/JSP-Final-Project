<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/22
  Time: 19:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>新闻列表</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="sweetalert/dist/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="sweetalert/dist/sweetalert.css">
</head>
<body>
<%@include file="navbar.jsp"%>
<%@include file="confirmationManager.jsp"%>
<%
    //记录多少页
    double count = 0;
    try {
        DbConnection dbConnection = new DbConnection();
        Statement statement = dbConnection.getConnection().createStatement();
        String sql = "SELECT count(id) FROM news WHERE isDeleted=0";
        ResultSet resultSet = statement.executeQuery(sql);
        if(resultSet != null){
            resultSet.next();
            count = Math.ceil(resultSet.getInt("count(id)")/10.0);
        }
        dbConnection.closeConnection();
    }catch (SQLException e) {
        e.printStackTrace();
    }
%>
<%--内容--%>
<div id="newsListTable"></div>

<%--分页--%>
<nav class="text-center">
    <ul class="pagination pagination-lg" style="cursor:pointer">
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
    var currentPage = 1;
    //检查是否为最前面或最后页,如果是,则禁用按钮
    function checkPreviousAndNext() {
        if(currentPage == 1){
            $("#previous").addClass("disabled");
        }
        else{
            $("#previous").removeClass("disabled");
        }

        if(currentPage >= <%=count%>){
            $("#next").addClass("disabled");
        }
        else{
            $("#next").removeClass("disabled");
        }
    }

    $(document).ready(function () {
        $.post("newsListTable.jsp",{page:1},function (data) {
            $("#newsListTable").html(data);
            checkPreviousAndNext();
        })
    });

    $(".pagingA").click(function () {
        $(".paging").removeClass("active");
        $("#paging"+this.innerHTML).addClass("active");
        currentPage = parseInt(this.innerHTML);
        $.post("newsListTable.jsp",{page:this.innerHTML},function (data) {
            $("#newsListTable").html(data);
        });
        checkPreviousAndNext();
    });
    //上一页的按钮被按下
    $("#previous").click(function () {
        if(currentPage > 1){
            currentPage -= 1;
            $(".paging").removeClass("active");
            $("#paging" + currentPage).addClass("active");
            $.post("newsListTable.jsp", {page:currentPage}, function (data) {
                $("#newsListTable").html(data);
            });
            checkPreviousAndNext();
        }
    });
    //下一页的按钮被按下
    $("#next").click(function () {
        if(currentPage < <%=count%>){
            currentPage += 1;
            console.log(currentPage);
            $(".paging").removeClass("active");
            $("#paging" + currentPage).addClass("active");
            $.post("newsListTable.jsp", {page:currentPage}, function (data) {
                $("#newsListTable").html(data);
            });
            checkPreviousAndNext();
        }
    });

</script>


</body>
</html>
