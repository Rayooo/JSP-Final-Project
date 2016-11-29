<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %><%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/29
  Time: 20:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="confirmationManager.jsp"%>
<%
    int currentPage = Integer.parseInt(request.getParameter("page"));
    try {
        DbConnection dbConnection = new DbConnection();
        Statement statement = dbConnection.getConnection().createStatement();
        String sql = "SELECT * FROM achievement WHERE isDeleted=0 ORDER BY id DESC LIMIT "+ Integer.toString((currentPage-1)*10) +",10";//(页数-1)*每页条数,每页条数
        ResultSet resultSet = statement.executeQuery(sql);

        if(resultSet != null){
%>
            <div class='container alert alert-success text-center' role='alert'>以下是所有成果的信息</div>
            <div class='container text-center'>
                <table class="table table-striped table-hover table-bordered">
                    <tr>
                        <td>标题</td>
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
                        <a target="_blank" href="achievementDetail.jsp?achievementId=<%=id%>"><i class="fa fa-newspaper-o" aria-hidden="true"></i></a>
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
        if(resultSet !=null)
            resultSet.close();
        if(statement != null)
            statement.close();

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
                    swal("失败", "服务器异常", "error");
                }
            })
        });
    });

    $(".tdTitle").click(function () {
        var achievementId = this.id.replace(/tdTitle/,"");
        window.open("achievementDetail.jsp?achievementId="+achievementId);
    })

</script>