<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/13
  Time: 11:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>主页</title>
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link href="css/index.css" rel="stylesheet">
    <style>
        .commentAvatarImage{
            width:64px;
            height:64px;
            line-height: 0;	/* remove line-height */
            display: inline-block;	/* circle wraps image */
            border-radius: 50%;	/* relative value */
            -moz-border-radius: 50%;
            -webkit-border-radius: 50%;
            transition: linear 0.25s;
        }
        .thumbnail{
            border: 0;
        }
        /* ---- reset ---- */
        canvas {
            display: block;
            vertical-align: bottom;
        }
        /* ---- particles.js container ---- */
        #particles-js {
            position:fixed;
            z-index: -10;
            width: 100%;
            height: 100%;
            background-color: #2aabd2;
            background-repeat: no-repeat;
            background-size: cover;
            background-position: 50% 50%;
        }
        #jumbotron{
            padding: 0;
            position: relative;
        }
        #welcome{
            text-align: right;
            position: absolute;
            top:10%;
            right: 5%;
        }

    </style>
</head>

<body>

<div id="particles-js"></div>
<script src="js/particles.js"></script>
<script src="js/particlesSetting.js"></script>
<%@ include file="navbar.jsp"%>
<%
    session.setAttribute("location","index");
%>
<div class="jumbotron" id="jumbotron">
    <div class="container" id="welcome">
        <h1>Welcome</h1>
        <a>新闻</a><br>
        <a>成果展示</a><br>
        <a>个人介绍</a><br>
    </div>
    <img src="image/indexBackground.jpg" class="img-responsive">
</div>


<div class="container">
    <div class="row">
        <div class="col-sm-12 col-md-12">
            <div class="thumbnail">
                <div class="caption">
                    <h3>新闻展示 <button class="btn btn-default" style="float: right">更多</button></h3>

                    <%--<form role="search">--%>
                        <%--<div class="form-group">--%>
                            <%--<input type="text" class="form-control" placeholder="Search">--%>
                        <%--</div>--%>
                        <%--<button type="submit" class="btn btn-default">Submit</button>--%>
                    <%--</form>--%>

                    <div class="list-group">
                        <%
                            try {
                                DbConnection dbConnection = new DbConnection();
                                Statement statement = dbConnection.connection.createStatement();
                                String sql = "SELECT id,title,createTime FROM news WHERE isDeleted=0 ORDER BY id DESC ";
                                ResultSet resultSet = statement.executeQuery(sql);
                                if(resultSet != null){
                                    while (resultSet.next()){
                        %>
                                    <a href="newsDetail.jsp?newsId=<%=resultSet.getInt("id")%>" class="list-group-item"><%=resultSet.getString("title")%><span style="float: right"><%=resultSet.getDate("createTime")%>  <%=resultSet.getTime("createTime")%></span></a>
                        <%
                                    }
                                }
                                dbConnection.closeConnection();
                            }catch (SQLException e){
                                e.printStackTrace();
                            }
                        %>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-sm-12 col-md-12">
            <div class="thumbnail">
                <div class="caption">

                    <h3>成果展示</h3>

                    <div class="list-group">
                        <a href="#" class="list-group-item">超链接成果展示</a>
                        <a href="#" class="list-group-item">超链接成果展示</a>
                        <a href="#" class="list-group-item">超链接成果展示</a>
                        <a href="#" class="list-group-item">超链接成果展示</a>
                    </div>

                    <p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>
                </div>
            </div>
        </div>
    </div>



    <div class="row">
        <div class="col-sm-12 col-md-12">
            <div class="thumbnail">
                <div class="caption">
                    <h3>成员介绍</h3>

                    <!--媒体对象,一头像一评论-->
                    <%
                        try {
                            DbConnection dbConnection = new DbConnection();
                            Statement statement = dbConnection.connection.createStatement();
                            String sql = "SELECT name,headImage,introduction FROM user WHERE isDeleted=0 AND isPassed=1 AND isManager=0";
                            ResultSet resultSet = statement.executeQuery(sql);
                            if(resultSet != null){
                                while (resultSet.next()){
                                    %>
                                        <div class="media">
                                            <div class="media-left media-middle">
                                                <img class="media-object commentAvatarImage" src="<%=resultSet.getString("headImage")%>" alt="...">
                                            </div>
                                            <div class="media-body">
                                                <h4 class="media-heading"><%=resultSet.getString("name")%></h4>
                                                <%=resultSet.getString("introduction") == null? "":resultSet.getString("introduction")%>
                                            </div>
                                        </div>
                    <%
                                }
                            }
                            dbConnection.closeConnection();
                        }catch (SQLException e){
                            e.printStackTrace();
                        }
                    %>

                </div>
            </div>
        </div>
    </div>

</div>

</body>
</html>