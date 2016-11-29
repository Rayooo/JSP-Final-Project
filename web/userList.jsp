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
    <script src="js/vue.js"></script>
    <link href="font-awesome/css/font-awesome.css">
    <script src="sweetalert/dist/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="sweetalert/dist/sweetalert.css">
</head>
<body>

<%@include file="navbar.jsp"%>
<%@include file="confirmationManager.jsp"%>
<%

    //记录有多少页
    double count = 0;
    try {
        DbConnection dbConnection = new DbConnection();
        Statement statement = dbConnection.getConnection().createStatement();
        String sql = "SELECT count(id) FROM user WHERE isDeleted=0";
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

<%--搜索用户--%>
<div class="container" style="margin-bottom: 2%">
    <div class="row">
        <div class="col-lg-12">
            <div class="input-group input-group-lg">
                <input type="text" class="form-control" placeholder="请输入用户名或用户真实姓名进行搜索" id="searchUser" v-model="userInfo">
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button" id="searchButton">搜索</button>
                </span>
            </div>
        </div>
    </div>
</div>

<%--搜索结果,一开始不显示--%>
<div id="searchResult"></div>

<%--内容--%>
<div id="userListTable"></div>

<%--分页--%>
<nav class="text-center" id="footerNav">
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
        $.post("userListTable.jsp",{page:1},function (data) {
            $("#userListTable").html(data);
            checkPreviousAndNext();
        })
    });

    $(".pagingA").click(function () {
        $(".paging").removeClass("active");
        $("#paging"+this.innerHTML).addClass("active");
        currentPage = parseInt(this.innerHTML);
        $.post("userListTable.jsp",{page:this.innerHTML},function (data) {
            $("#userListTable").html(data);
        });
        checkPreviousAndNext();
    });

    $("#previous").click(function () {
        if(currentPage > 1){
            currentPage -= 1;
            $(".paging").removeClass("active");
            $("#paging" + currentPage).addClass("active");
            $.post("userListTable.jsp", {page:currentPage}, function (data) {
                $("#userListTable").html(data);
            });
            checkPreviousAndNext();
        }
    });
    $("#next").click(function () {
        if(currentPage < <%=count%>){
            currentPage += 1;
            console.log(currentPage);
            $(".paging").removeClass("active");
            $("#paging" + currentPage).addClass("active");
            $.post("userListTable.jsp", {page:currentPage}, function (data) {
                $("#userListTable").html(data);
            });
            checkPreviousAndNext();
        }
    });



    //搜索
    var searchVue = new Vue({
        el:"#searchUser",
        data:{
            userInfo: ""
        }
    });
    searchVue.$watch('userInfo',function (val) {
        if(val.length > 0){
            $.post("searchUserData.jsp",{userInfo:val},function (data) {
                if(data != ""){
                    var searchResult = $("#searchResult");
                    searchResult.show();
                    $("#userListTable").hide();
                    $("#footerNav").hide();
                    searchResult.html(data);
                }
            })
        }else{
            $.post("userListTable.jsp",{page:currentPage},function (data) {
                $("#userListTable").html(data).show();
                checkPreviousAndNext();
                $("#searchResult").hide();
                $("#footerNav").show();
            });
        }

    })

</script>


</body>
</html>
