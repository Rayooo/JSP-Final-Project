<%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/13
  Time: 11:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="font-awesome/css/font-awesome.min.css">
<%--导航条--%>
<nav class="navbar navbar-default">
    <div class="container">
        <div class="container-fluid">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1" aria-expanded="false">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#"><i class="fa fa-leaf" aria-hidden="true"></i>学生展示平台</a>
            </div>

            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <%
                        String userName = (String)session.getAttribute("userName");
                        out.println("<button type='button' class='btn btn-primary navbar-btn' data-toggle='modal' data-target='#exampleModal'>登陆</button>");


                    %>
                    <button type="button" class="btn btn-primary navbar-btn" data-toggle="modal" data-target="#exampleModal">登陆</button>
                    <a type="button" class="btn btn-primary navbar-btn" href="register.jsp">注册</a>
                </ul>
            </div>
        </div>
    </div>
</nav>
<!--登陆框-->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel">登陆</h4>
            </div>
            <div class="modal-body">
                <form method="post" action="/login">
                    <label for="userName" class="sr-only">用户名</label>
                    <input type="text" name="userName" id="userName" class="form-control" placeholder="用户名" required autofocus>
                    <label for="password" class="sr-only">密码</label>
                    <input type="password" name="password" id="password" class="form-control" placeholder="密码" required>
                    <button type="submit" class="btn btn-primary">登陆</button>
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                </form>
            </div>
        </div>
    </div>
</div>