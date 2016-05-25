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
    <style>
        .commentAvatarImage{
            width:80px;
            height:80px;
            line-height: 0;	/* remove line-height */
            display: inline-block;	/* circle wraps image */
            border-radius: 50%;	/* relative value */
            -moz-border-radius: 50%;
            -webkit-border-radius: 50%;
            transition: linear 0.25s;
        }
    </style>
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
<%
                    try {
                        DbConnection dbConnection = new DbConnection();
                        Statement statement = dbConnection.connection.createStatement();
                        DbConnection userDbConnection = new DbConnection();
                        Statement userStatement = userDbConnection.connection.createStatement();

                        String sql = "SELECT *,count(id) FROM newsComment WHERE newsId="+newsId;
                        ResultSet resultSet = statement.executeQuery(sql);
                        if(resultSet != null){
                            while (resultSet.next()){
                                if(resultSet.getInt("count(id)") == 0){
                                    out.print("<div class='alert alert-info' role='alert'>暂时还没有评论,快来添加第一个评论吧</div>");
                                }

                                String userSql = "SELECT name,headImage FROM user WHERE id="+resultSet.getString("userId");
                                ResultSet userResultSet = userStatement.executeQuery(userSql);
                                if(userResultSet != null){
                                    userResultSet.next();
                                    String commentUserName = userResultSet.getString("name");
                                    String commentHeadImage = userResultSet.getString("headImage");
                                    String newsComment = resultSet.getString("content");
                                    String commentCreateTime = resultSet.getDate("createTime")+" "+resultSet.getTime("createTime");
                                    %>

                                    <!--媒体对象,一头像一评论-->
                                    <div class="media" style="margin-top: 3%;margin-bottom: 3%">
                                        <div class="media-left media-middle">
                                            <img class="media-object commentAvatarImage" src="<%=commentHeadImage%>" alt="...">
                                        </div>
                                        <div class="media-body">
                                            <h4 class="media-heading"><%=commentUserName%></h4>
                                            <%=commentCreateTime%><br>
                                            <%=newsComment%>
                                        </div>
                                    </div>

                        <%
                                }
                            }
                        }
                    }catch (SQLException e){
                        e.printStackTrace();
                    }
%>
                </div>
            </div>
        </div>
    </div>
</div>







<%--评论框--%>
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
                swal({
                    title: "成功",
                    text: "添加评论成功",
                    type: "success",
                    confirmButtonColor: "#79c9e0",
                    confirmButtonText: "确定",
                    closeOnConfirm: false
                }, function(){
                    location.reload();
                });
            }
            else{
                swal("失败", "添加评论失败", "error");
            }
        })
    })
</script>


</body>
</html>
