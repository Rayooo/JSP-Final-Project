<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/18
  Time: 18:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>用户详细信息</title>

    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>

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

</head>
<body>
<%@include file="navbar.jsp"%>
<%@include file="confirmationManager.jsp"%>
<%
    session.setAttribute("location","userInfo");
    int userId = Integer.parseInt(request.getParameter("id"));
    String userName = null,password = null,headImage = null,mobile = null;
    int sex = 1;
    String name = null,introduction = null;
    try {
        DbConnection dbConnection = new DbConnection();
        Statement statement = dbConnection.connection.createStatement();
        String sql = "SELECT * FROM user WHERE id=" + Integer.toString(userId);
        ResultSet resultSet = statement.executeQuery(sql);
        if(resultSet.next()){
            userId = resultSet.getInt("id");
            userName = resultSet.getString("userName");
            headImage = resultSet.getString("headImage");
            mobile = resultSet.getString("mobile");
            sex = resultSet.getInt("sex");
            name = resultSet.getString("name");
            introduction = resultSet.getString("introduction");
        }
        if(resultSet != null)
            resultSet.close();
        if(statement != null)
            resultSet.close();
        dbConnection.closeConnection();
    }catch (SQLException e) {
        e.printStackTrace();
    }
%>

<div class="container">
    <form class="form-register form-horizontal" id="editInfoForm" onsubmit="return check()" action="/editInfo" method="post" enctype="multipart/form-data">
        <h2 class="form-signin-heading text-center">用户信息</h2>

        <div class="form-group"  id="headImageDiv">
            <div class="col-md-6" id="headImageDiv2">
                <img id="preview" src="<%=headImage%>" alt="...">
            </div>
        </div>

        <div class="form-group">
            <label for="userId" class="col-md-3 control-label">用户ID</label>
            <div class= "col-md-8">
                <input type="text" id="userId" name="userId" class="form-control" value="<%=userId%>" readonly>
            </div>
        </div>

        <div class="form-group">
            <label for="userName" class="col-md-3 control-label">用户名</label>
            <div class= "col-md-8">
                <input type="text" id="userName" name="userName" class="form-control" value="<%=userName%>" readonly>
            </div>
        </div>

        <div class="form-group">
            <label for="name" class="col-md-3 control-label">真实姓名</label>
            <div class= "col-md-8">
                <input type="text" id="name" name="name" class="form-control" value="<%=name%>" readonly>
            </div>
        </div>

        <div class="form-group">
            <label for="mobile" class="col-md-3 control-label">手机号</label>
            <div class= "col-md-8">
                <input type="text" id="mobile" name="mobile" class="form-control" value="<%=mobile==null? "":mobile%>" readonly>
            </div>
        </div>

        <div class="form-group">
            <label for="sex" class="col-md-3 control-label">性别</label>
            <div class= "col-md-8">
                <input type="text" id="sex" name="sex" class="form-control" value="<%=sex==1?"男":"女"%>" readonly>
            </div>
        </div>

        <div class="form-group">
            <label for="introduction" class="col-md-3 control-label">自我介绍</label>
            <div class= "col-md-8">
                <textarea type="text" id="introduction" name="introduction" class="form-control" readonly><%=introduction==null? "":introduction%></textarea>
            </div>
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

    function check() {
        var userName = document.getElementById("userName").value;
        console.log(userName);
        return true;
    }


</script>


