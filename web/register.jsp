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
    <script src="js/vue.js"></script>
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


<%--小鸟--%>
<div id="container"></div>
<script src="js/three.js"></script>
<script src="js/Detector.js"></script>
<script src="js/Projector.js"></script>
<script src="js/CanvasRenderer.js"></script>
<script src="js/stats.min.js"></script>
<script src="js/Bird.js"></script>
<script src="js/brids.js"></script>
<script>
    $("canvas")[0].remove();
</script>

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



<div class="container" id="vue">

    <h1 class="form-signin-heading">欢迎您的到来</h1>
    <form class="form-horizontal">
        <div class="form-group">
            <label for="userName" class="col-sm-3 control-label">用户名</label>
            <div class="col-sm-9 " v-bind:class="{'has-success':isOkUserName,'has-error':isErrorUserName}">
                <input type="text" class="form-control" id="userName" name="userName" placeholder="用户名" v-model="userName" required>
                <span class="glyphicon glyphicon-ok form-control-feedback" style="margin-right: 10px" v-show="isOkUserName"></span>
                <span class="glyphicon glyphicon-remove form-control-feedback" style="margin-right: 10px" v-show="isErrorUserName"></span>
            </div>
        </div>
        <div class="form-group">
            <label for="password" class="col-sm-3 control-label">密码</label>
            <div class="col-sm-9" v-bind:class="{'has-success':isOkPassword,'has-error':isErrorPassword}">
                <input type="password" class="form-control" id="password" name="password" placeholder="密码" v-model="password" required>
                <span class="glyphicon glyphicon-ok form-control-feedback" style="margin-right: 10px" v-show="isOkPassword"></span>
                <span class="glyphicon glyphicon-remove form-control-feedback" style="margin-right: 10px" v-show="isErrorPassword"></span>
            </div>
        </div>
        <div class="form-group">
            <label for="password2" class="col-sm-3 control-label">重复密码</label>
            <div class="col-sm-9" v-bind:class="{'has-success':isOkPassword2,'has-error':isErrorPassword2}">
                <input type="password" class="form-control" id="password2" placeholder="重复密码" v-model="password2" required>
                <span class="glyphicon glyphicon-ok form-control-feedback" style="margin-right: 10px" v-show="isOkPassword2"></span>
                <span class="glyphicon glyphicon-remove form-control-feedback" style="margin-right: 10px" v-show="isErrorPassword2"></span>
            </div>
        </div>

        <div class="form-group">
            <label for="name" class="col-sm-3 control-label">真实姓名</label>
            <div class="col-sm-9" v-bind:class="{'has-success':isOkRealName,'has-error':isErrorRealName}">
                <input type="text" class="form-control" id="name" name="name" placeholder="真实姓名" v-model="realName" required>
                <span class="glyphicon glyphicon-ok form-control-feedback" style="margin-right: 10px" v-if="isOkRealName"></span>
                <span class="glyphicon glyphicon-remove form-control-feedback" style="margin-right: 10px" v-show="isErrorRealName"></span>
            </div>
        </div>

        <div class="form-group">
            <div class="checkbox">
                <label>
                    <input type="checkbox" name="isManager" value="manager" id="isManager"> 我要注册为管理员
                </label>
            </div>
        </div>

        <div class="form-group">
            <div class="col-sm-offset-2 col-sm-12">
                <button class="btn btn-lg btn-success formButton" id="submitButton" type="button">注册</button>
                <a class="btn btn-lg btn-default formButton" href="index.jsp">取消</a>
            </div>
        </div>
    </form>
</div>


<script>
    $("#submitButton").click(function () {
        if(registerData.isOkUserName && registerData.isOkPassword2 && registerData.isOkRealName){
            var isManager = $("#isManager").is(':checked')==true? 1:0;
            $.post("/register",{userName:registerData.userName,password:registerData.password,name:registerData.realName,isManager:isManager},function (data) {
                if(data == "success"){
                    swal({
                        title: "成功",
                        text: "提交注册成功,请等待管理员的审核",
                        type: "success",
                        confirmButtonColor: "#79c9e0",
                        confirmButtonText: "确定",
                        closeOnConfirm: false
                    }, function(){
                        window.location.href = "index.jsp";
                    });
                }
                else{
                    swal("对不起", data, "error");
                }
            })
        }else{
            swal("表单信息有误,请重新更改后重新提交", "请重新输入", "warning");
        }
    });

    var registerData = new Vue({
        el: "#vue",
        data:{
            userName: "",
            password: "",
            password2: "",
            realName : "",
            duplicationUserName: false
        },
        computed:{
            isOkUserName: function () {
                return this.userName.length > 7 && this.userName.length < 15 && !this.duplicationUserName;
            },
            isErrorUserName: function () {
                return (this.userName.length >= 1 && this.userName.length <= 7) || this.userName.length >= 15 || this.duplicationUserName;
            },
            isOkPassword: function () {
                return this.password.length > 7 && this.password.length < 15;
            },
            isErrorPassword: function () {
                return (this.password.length >= 1 && this.password.length <= 7) || this.password.length >= 15;
            },
            isOkPassword2: function () {
                return this.password == this.password2 && this.password2.length > 7;
            },
            isErrorPassword2: function () {
                return this.password2.length >= 1 && (this.password != this.password2 ||this.isErrorPassword);
            },
            isOkRealName : function () {
                return this.realName.length > 1 && this.realName.length < 15;
            },
            isErrorRealName: function () {
                return this.realName.length == 1 || this.realName.length >= 15;
            }
        }
    });
    registerData.$watch('userName',function (val) {
        if(val.length > 7 && val.length < 15){
            $.post("/duplicationUserName",{userName:val},function (data) {
                registerData.duplicationUserName = data == "error";
            })
        }
    })


</script>


</body>
</html>