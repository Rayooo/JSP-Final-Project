<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/14
  Time: 18:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <title>编辑个人信息</title>

    <!-- Bootstrap -->
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>

</head>
<body>

<%@include file="navbar.jsp"%>
<%@include file="confirmationLogin.jsp"%>

<%
    session.setAttribute("location","editMyInfo");
    String userName = null,password = null,headImage = null;
    int sex = 1;
    String name = null,introduction = null;
    try{
        DbConnection dbConnection = new DbConnection();
        int id = (Integer) session.getAttribute("userId");
        String sql = "SELECT * FROM user WHERE id="+Integer.toString(id);
        Statement statement = dbConnection.connection.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
        if(resultSet.next()){
            userName = resultSet.getString("userName");
            password = resultSet.getString("password");
            headImage = resultSet.getString("headImage");
            sex = resultSet.getInt("sex");
            name = resultSet.getString("name");
            introduction = resultSet.getString("introduction");
        }
    }catch (SQLException e) {
        e.printStackTrace();
    }
%>

<div class="container">
    <form class="form-register form-horizontal" id="editInfoForm" onsubmit="return check()" action="" method="post" enctype="multipart/form-data">
        <h2 class="form-signin-heading text-center">编辑信息</h2>

        <div class="form-group"  id="headImageDiv">
            <div class="col-md-6" id="headImageDiv2">
                <img id="preview" src="<%=headImage%>" alt="...">
                <div class="caption">
                    <input type="file" name="image" id="uploadImage">
                </div>
            </div>
        </div>


        <div class="form-group">
            <label for="userName" class="col-md-3 control-label">用户名(必填)</label>
            <div class= "col-md-8">
                <input type="text" id="userName" name="userName" class="form-control" placeholder="用户名" value="<%=userName%>" required autofocus>
            </div>
        </div>

        <div class="form-group">
            <label for="password" class="col-md-3 control-label">密码(必填)</label>
            <div class= "col-md-8">
                <input type="text" id="password" name="password" class="form-control" placeholder="密码" value="<%=password%>" required>
            </div>
        </div>

        <div class="form-group">
            <label for="name" class="col-md-3 control-label">真实姓名(必填)</label>
            <div class= "col-md-8">
                <input type="text" id="name" name="name" class="form-control" placeholder="真实姓名" value="<%=name%>" required>
            </div>
        </div>

        <div class="form-group">
            <label for="sex" class="col-md-3 control-label">性别</label>
            <div class= "col-md-8">
                <select id="sex" name="sex" class="form-control">
                    <%
                        if(sex == 1){
                            out.println("<option value='1' selected>男</option>");
                            out.println("<option value='0'>女</option>>");
                        }
                        else if(sex == 0){
                            out.println("<option value='1'>男</option>");
                            out.println("<option value='0'selected>女</option>>");
                        }
                    %>
                </select>
            </div>
        </div>

        <div class="form-group">
            <label for="introduction" class="col-md-3 control-label">自我介绍</label>
            <div class= "col-md-8">
                <textarea type="text" id="introduction" name="introduction" class="form-control" placeholder="自我介绍"><%=introduction==null? "":introduction%></textarea>
            </div>
        </div>

        <div class="text-center" id="buttonDiv">
            <button class="btn btn-lg btn-primary" type="submit">确定</button>
            <a class="btn btn-lg btn-default" type="button" href="index.jsp">取消</a>
        </div>

    </form>
</div>


</body>
</html>

<script>
    function preview(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#preview').attr('src', e.target.result);
            };
            reader.readAsDataURL(input.files[0]);
        }
    }

    $("body").on("change", "#uploadImage", function (){
        preview(this);
    });
</script>

<style>
    #editInfoForm{
        max-width: 550px;
        margin: 0 auto;
    }
    #headImageDiv{
        width: 80%;
        margin: auto;
        margin-bottom: 5%;
    }
    #headImageDiv2{
        width: 80%;
        margin-left: 25%;
    }
    #buttonDiv{
        margin-top: 5%;
        margin-bottom: 20%;
    }
    #preview{
        width:200px;
        height:200px;
        line-height: 0;	/* remove line-height */
        display: inline-block;	/* circle wraps image */
        border-radius: 50%;	/* relative value */
        -moz-border-radius: 50%;
        -webkit-border-radius: 50%;
        transition: linear 0.25s;
    }
</style>

