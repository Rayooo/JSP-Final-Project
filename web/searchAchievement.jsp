<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/31
  Time: 18:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>搜索成果</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="sweetalert/dist/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="sweetalert/dist/sweetalert.css">
    <script src="js/vue.js"></script>
</head>
<body>
<%@include file="navbar.jsp"%>

<div class="container" style="margin-bottom: 3%">
    <div class="row">
        <div class="col-lg-12">
            <div class="input-group input-group-lg">
                <input type="text" class="form-control" placeholder="请输入成果标题" id="searchAchievement" v-model="achievementTitle">
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button" id="searchButton">搜索</button>
                </span>
            </div>
        </div>
    </div>
</div>

<%
    //记录多少页
    double count = 0;
    try {
        DbConnection dbConnection = new DbConnection();
        Statement statement = dbConnection.connection.createStatement();
        String sql = "SELECT count(id) FROM achievement WHERE isDeleted=0";
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

<%--搜索结果,一开始不显示--%>
<div id="searchResult"></div>

<%--内容--%>
<div id="achievementListTable"></div>

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
        $.post("searchAchievementTable.jsp",{page:1},function (data) {
            $("#achievementListTable").html(data);
            checkPreviousAndNext();
        })
    });

    $(".pagingA").click(function () {
        $(".paging").removeClass("active");
        $("#paging"+this.innerHTML).addClass("active");
        currentPage = parseInt(this.innerHTML);
        $.post("searchAchievementTable.jsp",{page:this.innerHTML},function (data) {
            $("#achievementListTable").html(data);
        });
        checkPreviousAndNext();
    });
    //上一页的按钮被按下
    $("#previous").click(function () {
        if(currentPage > 1){
            currentPage -= 1;
            $(".paging").removeClass("active");
            $("#paging" + currentPage).addClass("active");
            $.post("searchAchievementTable.jsp", {page:currentPage}, function (data) {
                $("#achievementListTable").html(data);
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
            $.post("searchAchievementTable.jsp", {page:currentPage}, function (data) {
                $("#achievementListTable").html(data);
            });
            checkPreviousAndNext();
        }
    });

    //搜索
    //    $("#searchButton").click(function () {
    //        var achievementTitle = $("#searchAchievement").val();
    //        $.post("searchAchievementData.jsp",{achievementTitle:achievementTitle},function (data) {
    //            if(data != ""){
    //                $("#achievementListTable").hide();
    //                $("#footerNav").hide();
    //                $("#searchResult").html(data);
    //            }
    //        })
    //    })
    //Vue优化查询,但是服务器压力会变大
    var searchVue = new Vue({
        el:"#searchAchievement",
        data:{
            achievementTitle: ""
        }
    });
    searchVue.$watch('achievementTitle',function (val) {
        if(val.length > 0){
            $.post("searchAchievementData.jsp",{achievementTitle:val},function (data) {
                if(data != ""){
                    var searchResult = $("#searchResult");
                    searchResult.show();
                    $("#achievementListTable").hide();
                    $("#footerNav").hide();
                    searchResult.html(data);
                }
            })
        }else{
            $("#searchResult").hide();
            $("#achievementListTable").show();
            $("#footerNav").show();
        }

    })


</script>



</body>
</html>