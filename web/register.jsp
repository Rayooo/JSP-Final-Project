<%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/13
  Time: 15:21
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
    <title>注册</title>
    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>

    <link href="css/register.css" rel="stylesheet">
</head>
<body>
<%--<div id="particles-js">--%>
<%--</div>--%>

<%@include file="navbar.jsp"%>

<div class="container">

    <h1 class="form-signin-heading">欢迎您的到来</h1>
    <form class="form-horizontal" method="post" action="/register">
        <div class="form-group">
            <label for="userName" class="col-sm-3 control-label">用户名</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" id="userName" name="userName" placeholder="用户名">
            </div>
        </div>
        <div class="form-group">
            <label for="password" class="col-sm-3 control-label">密码</label>
            <div class="col-sm-9">
                <input type="password" class="form-control" id="password" name="password" placeholder="密码">
            </div>
        </div>
        <div class="form-group">
            <label for="password2" class="col-sm-3 control-label">重复密码</label>
            <div class="col-sm-9">
                <input type="password" class="form-control" id="password2" placeholder="重复密码">
            </div>
        </div>

        <div class="form-group">
            <label for="name" class="col-sm-3 control-label">真实姓名</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" id="name" name="name" placeholder="真实姓名">
            </div>
        </div>

        <div class="form-group">
            <div class="checkbox">
                <label>
                    <input type="checkbox" name="isManager" value="manager"> 我要注册为管理员
                </label>
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-12">
                <button class="btn btn-lg btn-success formButton" type="submit">注册</button>
                <a class="btn btn-lg btn-default formButton" href="index.jsp">取消</a>
            </div>
        </div>
    </form>
</div> <!-- /container -->

<script src="js/particles.js"></script>
<script src="js/particlesSetting.js"></script>

</body>
</html>