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
    <title>主页</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <style>
        .commentAvatarImage{
            width:64px;
            height:64px;
            line-height: 0;
            display: inline-block;
            border-radius: 50%;
            -moz-border-radius: 50%;
            -webkit-border-radius: 50%;
        }
        .thumbnail{
            border: 0;
        }
        canvas {
            display: block;
            vertical-align: bottom;
        }
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

<div class="jumbotron" id="jumbotron">
    <div class="container" id="welcome">
        <h1>Welcome</h1>
        <a href="#newsA" style="font-size: 25px;color: #a6e22d">新闻</a><br>
        <a href="#achievementA" style="font-size: 25px;color: #a6e22d">成果展示</a><br>
        <a href="#introductionA" style="font-size: 25px;color: #a6e22d">个人介绍</a><br>
    </div>
    <img src="image/indexBackground.jpg" class="img-responsive">
</div>


<div class="container">
    <div class="row" id="newsA">
        <div class="col-sm-12 col-md-12">
            <div class="thumbnail" style="background-color: rgba(255, 255, 255, 0.6);">
                <div class="caption">
                    <h3>新闻展示 <a class="btn btn-info" style="float: right" href="searchNews.jsp">所有新闻</a></h3>

                    <div class="list-group" style="margin-top: 2%">
                        <%
                            try {
                                DbConnection dbConnection = new DbConnection();
                                Statement statement = dbConnection.connection.createStatement();
                                String sql = "SELECT id,title,createTime FROM news WHERE isDeleted=0 ORDER BY id DESC LIMIT 10";
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

    <div class="row" id="achievementA">
        <div class="col-sm-12 col-md-12">
            <div class="thumbnail"  style="background-color: rgba(255, 255, 255, 0.6);">
                <div class="caption">
                    <h3>成果展示 <a class="btn btn-info" style="float: right" href="searchAchievement.jsp">所有成果</a></h3>

                    <div class="list-group" style="margin-top: 2%" >
                        <%
                            try {
                                DbConnection dbConnection = new DbConnection();
                                Statement statement = dbConnection.connection.createStatement();
                                String sql = "SELECT id,title,createTime FROM achievement WHERE isDeleted=0 ORDER BY id DESC LIMIT 10";
                                ResultSet resultSet = statement.executeQuery(sql);
                                if(resultSet != null){
                                    while (resultSet.next()){
                        %>
                                        <a href="achievementDetail.jsp?achievementId=<%=resultSet.getInt("id")%>" class="list-group-item"><%=resultSet.getString("title")%><span style="float: right"><%=resultSet.getDate("createTime")%>  <%=resultSet.getTime("createTime")%></span></a>
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



    <div class="row" id="introductionA">
        <div class="col-sm-12 col-md-12">
            <div class="thumbnail" style="background-color: rgba(255, 255, 255, 0.9);">
                <div class="caption">
                    <h3>活跃成员(按发布成果数排序)</h3>
                    <%
                        //按照成员发布成果数量排序
                        int countActiveUser = 0;
                        try {
                            DbConnection dbConnection = new DbConnection();
                            DbConnection userDbconnection = new DbConnection();

                            Statement statement = dbConnection.connection.createStatement();
                            String sql = "SELECT userId,count(id) FROM achievement WHERE isDeleted=0 GROUP BY userId ORDER BY count(id) DESC";
                            ResultSet resultSet = statement.executeQuery(sql);
                            if(resultSet != null){
                                while (resultSet.next()){
                                    Statement userStatement = userDbconnection.connection.createStatement();
                                    String userSql = "SELECT name,headImage,introduction FROM user WHERE isDeleted=0 AND isManager=0 AND isPassed=1 AND id="+resultSet.getString("userId");
                                    ResultSet userResultSet = userStatement.executeQuery(userSql);
                                    if(userResultSet != null){
                                        if(userResultSet.next()){
                                            countActiveUser++;
                                            if(countActiveUser > 10)
                                                break;
                                            %>
                                            <div class="media" style="margin-top: 3%">
                                                <div class="media-left media-middle">
                                                    <img class="media-object commentAvatarImage" src="<%=userResultSet.getString("headImage")%>">
                                                </div>
                                                <div class="media-body">
                                                    <h4 class="media-heading"><%=userResultSet.getString("name")%></h4>
                                                    <h5>发表成果数:<%=resultSet.getInt("count(id)")%></h5>
                                                    <%=userResultSet.getString("introduction") == null? "":userResultSet.getString("introduction")%>
                                                </div>
                                            </div>
                                            <%
                                        }
                                    }

                                }
                            }
                            userDbconnection.closeConnection();
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