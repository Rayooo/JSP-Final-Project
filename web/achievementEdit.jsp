<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/29
  Time: 14:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>重新编辑成果</title>
    <script src="sweetalert/dist/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="sweetalert/dist/sweetalert.css">
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="tinymce/tinymce.js"></script>
    <script>
        tinymce.init({
            selector: '#achievementTextArea',
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
<%@include file="confirmationUser.jsp"%>
<%
    String achievementId = request.getParameter("achievementId");
    String title = null;
    String content = null;
    Integer achievementUserId = null;
    try {
        DbConnection dbConnection = new DbConnection();
        Statement statement = dbConnection.connection.createStatement();
        String sql = "SELECT * FROM achievement WHERE isDeleted=0 AND id="+achievementId;
        ResultSet resultSet = statement.executeQuery(sql);
        if(resultSet != null){
            resultSet.next();
            title = resultSet.getString("title");
            content = resultSet.getString("content");
            achievementUserId = resultSet.getInt("userId");
        }
        dbConnection.closeConnection();
    }catch (SQLException e){
        e.printStackTrace();
    }
    //如果编辑成果的人和成果作者不同,则不能编辑,管理员也不能
    if(!(session.getAttribute("userId")).equals(achievementUserId)){
        %>
        <script>
            swal({
                title: "对不起",
                text: "您不能编辑该新闻",
                type: "error",
                confirmButtonColor: "#79c9e0",
                confirmButtonText: "确定",
                closeOnConfirm: false
            }, function(){
                window.location = "index.jsp";
            });
        </script>
<%
        return;
    }
%>

<div class="container text-center">

    <div class="form-horizontal">
        <div class="form-group" style="max-width: 70%;margin: auto;margin-top: 5%;margin-bottom: 5%">
            <div class="col-md-12">
                <input type="text" class="form-control" id="achievementTitle" placeholder="标题" value="<%=title%>">
            </div>
        </div>
    </div>

    <div id="achievementTextArea"><%=content%></div>


    <div style="margin-top: 3%;margin-bottom: 3%">
        <button class="btn btn-primary btn-lg" id="btn">提交</button>
        <button class="btn btn-default btn-lg" id="cancel">取消</button>
    </div>
</div>


<script>
    $("#btn").click(function () {
        var achievementContent = tinymce.get('achievementTextArea').getContent();
        var achievementTitle = $("#achievementTitle").val();
        var achievementId = <%=achievementId%>;
        if(!achievementContent || !achievementTitle){
            swal("警告", "请填写完整标题或内容", "warning");
        }
        else if(!achievementId){
            swal("错误", "未获取到成果ID","error");
        }
        else{
            $.post("/editAchievement", {achievementContent:achievementContent,achievementId:achievementId,achievementTitle:achievementTitle}, function (data) {
                if(data == "success"){
                    swal({
                        title: "成功",
                        text: "成功修改该文章",
                        type: "success",
                        confirmButtonColor: "#79c9e0",
                        confirmButtonText: "确定",
                        closeOnConfirm: false
                    }, function(){
                        history.back();
                    });
                }
                else{
                    swal("失败", data, "error");
                }
            })
        }
    });
    $("#cancel").click(function () {
        history.back();
    })
</script>





</body>
</html>
