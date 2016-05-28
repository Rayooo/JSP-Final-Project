<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/22
  Time: 19:59
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>重新编辑新闻</title>
    <script src="sweetalert/dist/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="sweetalert/dist/sweetalert.css">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="tinymce/tinymce.js"></script>
    <script>
        tinymce.init({
            selector: '#newsTextArea',
            language: 'zh_CN',
            height: 400,
            plugins: [
                'advlist autolink link image lists charmap preview hr anchor pagebreak',
                'searchreplace wordcount visualblocks visualchars fullscreen insertdatetime nonbreaking',
                'save table contextmenu directionality template paste textcolor'
            ],
            content_css: 'css/content.css',
            toolbar: 'insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image | preview fullpage | forecolor backcolor emoticons'
        });
    </script>
</head>
<body>
<%@include file="navbar.jsp"%>
<%@include file="confirmationManager.jsp"%>
<%
    String newsId = request.getParameter("newsId");
    String title = null;
    String content = null;
    try {
        DbConnection dbConnection = new DbConnection();
        Statement statement = dbConnection.connection.createStatement();
        String sql = "SELECT * FROM news WHERE isDeleted=0 AND id="+newsId;
        ResultSet resultSet = statement.executeQuery(sql);
        if(resultSet != null){
            resultSet.next();
            title = resultSet.getString("title");
            content = resultSet.getString("content");
        }
        dbConnection.closeConnection();
    }catch (SQLException e){
        e.printStackTrace();
    }
%>


<div class="container text-center">

    <div class="form-horizontal">
        <div class="form-group" style="max-width: 70%;margin: auto;margin-top: 5%;margin-bottom: 5%">
            <div class="col-md-12">
                <input type="text" class="form-control" id="newsTitle" placeholder="新闻标题" value="<%=title%>">
            </div>
        </div>
    </div>

    <div id="newsTextArea"><%=content%></div>

    <button class="btn btn-primary btn-lg" id="btn">提交</button>
    <button class="btn btn-default btn-lg" id="cancel">取消</button>
</div>


<script>
    $("#btn").click(function () {
        var newsContent = tinymce.get('newsTextArea').getContent();
        var newsTitle = $("#newsTitle").val();
        var newsId = <%=newsId%>;
        if(!newsContent || !newsTitle){
            swal("警告", "请填写完整标题或内容", "warning");
        }
        else if(!newsId){
            swal("错误", "未获取到新闻ID","error");
        }
        else{
            $.post("/editNews", {newsContent:newsContent,newsId:newsId,newsTitle:newsTitle}, function (data) {
                if(data == "success"){
                    swal({
                        title: "成功",
                        text: "成功修改该文章",
                        type: "success",
                        confirmButtonColor: "#79c9e0",
                        confirmButtonText: "确定",
                        closeOnConfirm: false
                    }, function(){
                        window.close();
                    });
                }
                else{
                    swal("失败", "服务器异常", "error");
                }
            })
        }
    });
    $("#cancel").click(function () {
        window.close();
    })
</script>


</body>
</html>
