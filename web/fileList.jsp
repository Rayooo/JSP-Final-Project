<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/24
  Time: 21:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>文件库</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="sweetalert/dist/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="sweetalert/dist/sweetalert.css">
</head>
<body>
<%@include file="navbar.jsp"%>
<%@include file="confirmationLogin.jsp"%>

<div class="container bg-info" style="padding-top: 5%;padding-bottom: 5%;margin-bottom: 5%">
    <h1 class="text-center">这里可以上传文件,与朋友们分享</h1>
    <form class="form-horizontal" method="post" action="/uploadImage" enctype="multipart/form-data">
        <div class="row" style="margin-top: 3%">
            <div class="col-xs-12 col-sm-12 col-md-12" style="margin-bottom: 3%">
                <input class="form-control" type="text" name="description" placeholder="可照片填写描述">
            </div>
            <div class="col-xs-7 col-sm-7 col-md-7" style="padding-top: 1%">
                <input type="file" style="float: right" accept="image/*" name="uploadImage" id="uploadImage" required>
            </div>
            <div class="col-xs-5 col-sm-5 col-md-5">
                <button type="submit" class="btn btn-info" id="uploadImageButton">上传</button>
            </div>
        </div>
    </form>
</div>


<%
    //记录有多少页
    double count = 0;
    try {
        DbConnection dbConnection = new DbConnection();
        Statement statement = dbConnection.connection.createStatement();
        String sql = "SELECT count(id) FROM file WHERE isDeleted=0";
        ResultSet resultSet = statement.executeQuery(sql);
        if(resultSet != null){
            resultSet.next();
            count = Math.ceil(resultSet.getInt("count(id)")/10.0);
        }
    }catch (SQLException e) {
        e.printStackTrace();
    }
%>


<div class="container">
    <div class="media col-md-6">
        <div class="media-left">
            <a href="#">
                <img class="media-object" src="image/code.png" alt="...">
            </a>
        </div>
        <div class="media-body">
            <h4 class="media-heading">文件名</h4>
            <p>上传者</p>
            <p>描述</p>
            <p>引用链接</p>
            <p>上传时间</p>
            <p>
                <button class="btn btn-success">下载</button>
                <button class="btn btn-danger">删除</button>
            </p>
        </div>
    </div>

    <div class="media col-md-6" style="margin-top: 0">
        <div class="media-left">
            <a href="#">
                <img class="media-object" src="image/code.png" alt="...">
            </a>
        </div>
        <div class="media-body">
            <h4 class="media-heading">文件名</h4>
            <p>上传者</p>
            <p>描述</p>
            <p>引用链接</p>
            <p>上传时间</p>
            <p>
                <button class="btn btn-success">下载</button>
                <button class="btn btn-danger">删除</button>
            </p>
        </div>
    </div>
</div>

<%--内容--%>
<div class="container" id="fileListTable"></div>


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
        $.post("fileListTable.jsp",{page:1},function (data) {
            $("#fileListTable").html(data);
            checkPreviousAndNext();
        })
    });

    $(".pagingA").click(function () {
        $(".paging").removeClass("active");
        $("#paging"+this.innerHTML).addClass("active");
        currentPage = parseInt(this.innerHTML);
        $.post("fileListTable.jsp",{page:this.innerHTML},function (data) {
            $("#fileListTable").html(data);
        });
        checkPreviousAndNext();
    });

    $("#previous").click(function () {
        if(currentPage > 1){
            currentPage -= 1;
            $(".paging").removeClass("active");
            $("#paging" + currentPage).addClass("active");
            $.post("fileListTable.jsp", {page:currentPage}, function (data) {
                $("#fileListTable").html(data);
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
            $.post("fileListTable.jsp", {page:currentPage}, function (data) {
                $("#fileListTable").html(data);
            });
            checkPreviousAndNext();
        }
    });

</script>


</body>
</html>
