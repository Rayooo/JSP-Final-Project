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
    <title>注册</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="font-awesome/css/font-awesome.min.css">
    <script src="sweetalert/dist/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="sweetalert/dist/sweetalert.css">
    <style>
        body {
            margin: 0;
            font:normal 75% Arial, Helvetica, sans-serif;
            background-color: #eee;
        }
        .form-signin-heading{
            padding-top: 50px;
            margin-left: 15%;
            margin-right: 30%;
            position: absolute;
            text-align: center;
            width: 50%;
        }
        .form-horizontal{
            max-width: 550px;
            /*margin: auto;*/
            margin-left: 20%;
            margin-right: 30%;
            margin-top: 150px;
        }
        .formButton{
            width: 30%;
            margin: auto;
            margin-left: 10%;
        }
        .checkbox{
            padding-left: 30%;
        }
        canvas {
            display: block;
            vertical-align: bottom;
            position: absolute;
            width: 100%;
            height: 100%;
            background-color: #2aabd2;
            background-repeat: no-repeat;
            background-size: cover;
            background-position: 50% 50%;
        }
    </style>
</head>
<body>

<%--<div id="particles-js">--%>
<%--</div>--%>

<%--彩色魔方--%>
<div id="containerCube"></div>

<script src="js/three.js"></script>

<script src="js/Detector.js"></script>



<%--导航条,这里的导航条和主页其他导航条做区分--%>
<nav class="navbar navbar-default">
    <div class="container">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbarCollapse1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.jsp"><i class="fa fa-leaf" aria-hidden="true"></i>学生展示平台</a>
            </div>

            <div class="collapse navbar-collapse" id="navbarCollapse1">
                <ul class="nav navbar-nav navbar-right">
                    <a type='button' class='btn btn-primary navbar-btn' href='index.jsp'>返回</a>
                </ul>
            </div>
        </div>
    </div>
</nav>



<div class="container" style="color: white">

    <h1 class="form-signin-heading">欢迎您的到来</h1>
    <form class="form-horizontal" method="post" action="" onsubmit="return check();">
        <div class="form-group">
            <label for="userName" class="col-sm-3 control-label">用户名</label>
            <div class="col-sm-9 has-success">
                <input type="text" class="form-control" id="userName" name="userName" placeholder="用户名" required>
                <span class="glyphicon glyphicon-ok form-control-feedback" style="margin-right: 10px"></span>
            </div>
        </div>
        <div class="form-group">
            <label for="password" class="col-sm-3 control-label">密码</label>
            <div class="col-sm-9">
                <input type="password" class="form-control" id="password" name="password" placeholder="密码" required>
            </div>
        </div>
        <div class="form-group">
            <label for="password2" class="col-sm-3 control-label">重复密码</label>
            <div class="col-sm-9">
                <input type="password" class="form-control" id="password2" placeholder="重复密码" required>
            </div>
        </div>

        <div class="form-group">
            <label for="name" class="col-sm-3 control-label">真实姓名</label>
            <div class="col-sm-9">
                <input type="text" class="form-control" id="name" name="name" placeholder="真实姓名" required>
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
</div>

<%--<script src="js/particles.js"></script>--%>
<%--<script src="js/particlesSetting.js"></script>--%>

<script>
    function check() {
        var password1 = $('#password').val();
        var password2 = $('#password2').val();
        if(password1 != password2){
            swal("输入密码不一致", "请重新输入", "warning");
            return false;
        }else{
            return true;
        }
    }
</script>

<%--彩色魔方--%>
<script src="js/cube.js"></script>

</body>
</html>