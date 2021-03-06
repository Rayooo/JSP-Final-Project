<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/6/1
  Time: 18:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="confirmationManager.jsp"%>
<%
    String userInfo = request.getParameter("userInfo");
    int currentUserId = (Integer)session.getAttribute("userId");
    try{
        DbConnection dbConnection = new DbConnection();
        Statement statement = dbConnection.connection.createStatement();
        String sql = "SELECT * FROM user WHERE id!="+currentUserId+" AND isDeleted=0 AND (user.userName LIKE '%"+userInfo+"%' OR user.name LIKE '%"+userInfo+"%')";
        ResultSet resultSet = statement.executeQuery(sql);

        if(resultSet != null){
%>
            <div class='container alert alert-success text-center' role='alert'>以下是用户名或真实姓名带有 <%=userInfo%> 的用户信息</div>
            <div class='container text-center'>
                <table class="table table-striped table-hover table-bordered">
                    <tr>
                        <td>id</td>
                        <td>姓名</td>
                        <td>手机</td>
                        <td>用户名</td>
                        <td>性别</td>
                        <td>用户类别</td>
                        <td>是否通过验证</td>
                        <td>操作</td>
                    </tr>
            <%
                while (resultSet.next()){
                    int id = resultSet.getInt("id");
                    String userName = resultSet.getString("userName");
                    String sex = resultSet.getInt("sex") == 1? "男":"女";
                    String name = resultSet.getString("name");
                    String mobile = resultSet.getString("mobile");
                    String isManager = resultSet.getInt("isManager") == 1? "管理员":"用户";
                    String isPassed = resultSet.getInt("isPassed") == 1? "通过":"未通过";
                    if(isPassed.equals("未通过")){
                        out.println("<tr id='tr"+id+"' class='warning'>");
                    }
                    else{
                        out.println("<tr id='tr"+id+"'>");
                    }
          %>

                        <td><%=id%></td>
                        <td><%=name%></td>
                        <td><%=mobile==null? "":mobile%></td>
                        <td><%=userName%></td>
                        <td><%=sex%></td>
                        <td><%=isManager%></td>
                        <td><%=isPassed%></td>
                        <td>
                            <a style="cursor: pointer" class="showUserInfo" id="showUserInfo<%=id%>"><i class="fa fa-child" aria-hidden="true"></i></a>
                            <a target="_blank" href="userInfoEdit.jsp?id=<%=id%>"><i class="fa fa-cog" aria-hidden="true"></i></a>
                            <a class="delete" id="delete<%=id%>"><i class="fa fa-trash-o" aria-hidden="true"></i></a>
                        </td>
                    </tr>
            <%
                }
                out.println("</table>");
                out.println("</div>");
            }
            else{
                out.println("<div class='container alert alert-warning text-center' role='alert'>未查询到信息</div>");
            }
            if(resultSet !=null)
                resultSet.close();
            if(statement != null)
                statement.close();

            dbConnection.closeConnection();
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
%>

<div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" id="userInfoModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div style="max-width: 100%" id="userInfoModalContent">
            </div>
        </div>
    </div>
</div>

<script>
    $(".delete").click(function () {
        var userId = this.id.replace(/delete/,"");
        swal({
            title: "警告",
            text: "您确定要删除此用户?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function(){
            $.post("/deleteUser",{userId:userId},function (data) {
                if(data == "success"){
                    swal("成功", "已删除该用户", "success");
                    $("#tr"+userId).remove();
                }
                else{
                    swal("失败", "服务器异常", "error");
                }
            })
        });
    });
    $(".showUserInfo").click(function () {
        var userId = this.id.replace(/showUserInfo/,"");
        $.post("userInfo.jsp",{userId:userId},function (data) {
            if(data != ""){
                $("#userInfoModalContent").html(data);
                $("#userInfoModal").modal("show")
            }
        })

    })
</script>