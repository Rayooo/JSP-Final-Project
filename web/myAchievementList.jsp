<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/29
  Time: 13:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>我的成果</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="sweetalert/dist/sweetalert-dev.js"></script>
    <link rel="stylesheet" href="sweetalert/dist/sweetalert.css">
</head>
<body>
<%@include file="navbar.jsp"%>
<%@include file="confirmationUser.jsp"%>
<%
    Integer userId = (Integer)session.getAttribute("userId");
    try {
        DbConnection dbConnection = new DbConnection();
        Statement statement = dbConnection.getConnection().createStatement();
        String sql = "SELECT * FROM achievement WHERE isDeleted=0 AND userId="+userId+" ORDER BY id DESC ";
        ResultSet resultSet = statement.executeQuery(sql);
        if(resultSet != null){
            %>
            <div class='container alert alert-success text-center' role='alert'>以下是您发表的成果</div>
            <div class='container text-center'>
                <table class="table table-striped table-hover table-bordered">
                    <tr>
                        <td>成果标题</td>
                        <td>创建时间</td>
                        <td>操作</td>
                    </tr>
<%
            while (resultSet.next()){
                int id = resultSet.getInt("id");
                String title = resultSet.getString("title");
                String createTime = resultSet.getDate("createTime")+" "+resultSet.getTime("createTime");
%>
                    <tr id="tr<%=id%>">
                        <td style="cursor:pointer" class="tdTitle" id="tdTitle<%=id%>"><%=title%></td>
                        <td><%=createTime%></td>
                        <td>
                            <a href="achievementDetail.jsp?achievementId=<%=id%>"><i class="fa fa-newspaper-o" aria-hidden="true"></i></a>
                            <a href="achievementEdit.jsp?achievementId=<%=id%>"><i class="fa fa-pencil" aria-hidden="true"></i></a>
                            <a style="cursor: pointer" class="delete" id="delete<%=id%>"><i class="fa fa-trash-o" aria-hidden="true"></i></a>
                        </td>
                    </tr>
            <%
                }
            %>

                </table>
            </div>
<%
        }
        else{
            out.println("<div class='container alert alert-warning text-center' role='alert'>未查询到信息</div>");
        }
        dbConnection.closeConnection();
    }catch (SQLException e){
        e.printStackTrace();
    }
%>
<script>
    $(".delete").click(function () {
        var achievementId = this.id.replace(/delete/,"");
        swal({
            title: "警告",
            text: "您确定要删除此成果?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function(){
            $.post("/deleteAchievement",{achievementId:achievementId},function (data) {
                if(data == "success"){
                    swal("成功", "已删除该成果", "success");
                    $("#tr"+achievementId).addClass("danger");
                }
                else{
                    swal("失败", data, "error");
                }
            })
        });
    });

    $(".tdTitle").click(function () {
        var achievementId = this.id.replace(/tdTitle/,"");
        window.location.href = "achievementDetail.jsp?achievementId="+achievementId;
    })

</script>
</body>
</html>
