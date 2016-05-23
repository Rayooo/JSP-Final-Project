<%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/23
  Time: 18:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>图片库</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="sweetalert/dist/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="sweetalert/dist/sweetalert.css">
</head>
<body>
<%@include file="navbar.jsp"%>
<%@include file="confirmationLogin.jsp"%>

<div class="container bg-success" style="padding-top: 5%;padding-bottom: 5%">
    <h1 class="text-center">这里可以上传照片,记录我们的点滴</h1>
    <form method="post" action="/uploadImage" enctype="multipart/form-data">
        <div class="row" style="margin-top: 3%">
            <div class="col-xs-7 col-sm-7 col-md-7" style="padding-top: 1%">
                <input type="file" style="float: right" accept="image/*" name="uploadImage" id="uploadImage">
                <input type="text" name="description" placeholder="可填写描述">
            </div>
            <div class="col-xs-5 col-sm-5 col-md-5">
                <button type="submit" class="btn btn-info" id="uploadImageButton">上传</button>
            </div>
        </div>
    </form>
</div>

<div class="container">
    <div class="row">
        <div class="col-sm-6 col-md-4">
            <div class="thumbnail">
                <img src="..." alt="...">
                <div class="caption">
                    <h3>Thumbnail label</h3>
                    <p>...</p>
                    <p><a href="#" class="btn btn-primary" role="button">Button</a> <a href="#" class="btn btn-default" role="button">Button</a></p>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
//    $("#uploadImageButton").click(function () {
//        if(!$("#uploadImage").val()){
//            swal("失败", "服务器异常", "warning");
//        }else{
//            //post请求
//        }
//    })
</script>

</body>
</html>
