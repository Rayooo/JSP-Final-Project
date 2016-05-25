<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Date" %><%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/22
  Time: 15:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>新闻</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="sweetalert/dist/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="sweetalert/dist/sweetalert.css">
</head>
<body>
<%@include file="navbar.jsp"%>
<%
    String newsId = request.getParameter("newsId");
    String newsTitle = null;
    String newsContent = null;
    String createDate = null;
    String createTime = null;
    try {
        DbConnection dbConnection = new DbConnection();
        Statement statement = dbConnection.connection.createStatement();
        String sql = "SELECT * FROM news WHERE isDeleted=0 AND id="+newsId;
        ResultSet resultSet = statement.executeQuery(sql);
        if(resultSet != null){
            resultSet.next();
            newsTitle = resultSet.getString("title");
            newsContent = resultSet.getString("content");
            createTime = String.valueOf(resultSet.getTime("createTime"));
            createDate = String.valueOf(resultSet.getDate("createTime"));
        }
    }catch (SQLException e){
        e.printStackTrace();
    }
%>
<%--新闻标题--%>
<div class="container text-center">
    <div class="title">
        <h1><%=newsTitle%></h1>
        <div>
        <span class="post-time">发表于
            <span><%=createDate%> <%=createTime%></span>
        </span>
        </div>
    </div>
</div>

<%--新闻内容--%>
<div class="container"><%=newsContent%></div>

<div class="container" style="margin-top: 5%;margin-bottom: 5%">
    <a id="previous" type="button" class="btn btn-info btn-lg">（大按钮）Large button</a>
    <a id="next" type="button" class="btn btn-info btn-lg" style="float: right">（大按钮）Large button</a>
</div>


<div class="container">
    <div class="row" id="comment">
        <div class="col-sm-12 col-md-12">
            <div class="thumbnail">
                <div class="caption">
                    <h3>评论</h3>
                    <!--媒体对象,一头像一评论-->
                    <div class="media">
                        <div class="media-left media-middle">
                            <img class="media-object commentAvatarImage" src="image/5.png" alt="...">
                        </div>
                        <div class="media-body">
                            <h4 class="media-heading">评论</h4>
                            aaaaaaaaaaaaaaaaaaaaaaaa
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container" style="margin-bottom: 10%">
    <div class="row">
        <div class="col-lg-12">
            <div class="input-group input-group-lg">
                <input type="text" class="form-control" placeholder="说一句吧" id="newsComment">
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button" id="addComment">评论</button>
                </span>
            </div>
        </div>
    </div>
</div>
<script>
    $("#addComment").click(function () {
        if(<%=(String)session.getAttribute("userName") == null%>){
            //没有登录
            swal("评论失败", "请先登录", "warning");
            return;
        }
        var newsId = <%=newsId%>;
        var newsComment = $("#newsComment").val();
        $.post("/addNewsComment",{newsId:newsId,newsComment:newsComment},function (data) {
            if(data == "success"){
                swal("成功", "添加评论成功", "success");
            }
            else{
                swal("失败", "添加评论失败", "error");
            }
        })
    })
</script>


</body>
</html>
