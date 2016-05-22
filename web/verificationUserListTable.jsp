<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/21
  Time: 19:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="confirmationManager.jsp"%>
<%
    int pageCount = Integer.parseInt(request.getParameter("page"));
    try {
        DbConnection dbConnection = new DbConnection();
        Statement statement = dbConnection.connection.createStatement();
        String sql = "SELECT id,userName,sex,name,mobile,isManager FROM user WHERE isPassed=0 LIMIT "+ Integer.toString((pageCount-1)*5) +",5";//(页数-1)*每页条数,每页条数
        ResultSet resultSet = statement.executeQuery(sql);

        if(resultSet != null){
%>
            <div class='container alert alert-warning text-center' role='alert'>以下是所有成员的信息,未验证通过的用户无法登录</div>
            <div class='container text-center'>
                <table class="table table-striped table-hover table-bordered">
                    <tr>
                        <td>id</td>
                        <td>姓名</td>
                        <td>用户名</td>
                        <td>用户类别</td>
                        <td>确认通过</td>
                    </tr>
                        <%
                while (resultSet.next()){
                    int id = resultSet.getInt("id");
                    String userName = resultSet.getString("userName");
                    String name = resultSet.getString("name");
                    String isManager = resultSet.getInt("isManager") == 1? "管理员":"用户";
          %>
                    <tr id="tr<%=id%>">
                        <td><%=id%></td>
                        <td><%=name%></td>
                        <td><%=userName%></td>
                        <td><%=isManager%></td>
                        <td>
                            <a class="pass" id="pass<%=id%>"><i class="fa fa-check-square-o" aria-hidden="true"></i></a>
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
            resultSet.close();

        dbConnection.closeConnection();
    }
    catch (SQLException e) {
        e.printStackTrace();
    }
%>
<script>
    $(".pass").click(function () {
        console.log("AAA");
        var userId = this.id.replace(/pass/,"");
        $.post("/verificationUser",{userId:userId},function (data) {
            if(data == "success"){
                swal("成功", "该用户已通过验证", "success");
                $("#tr"+userId).addClass("success");
            }
            else{
                swal("失败", "服务器异常", "error");
            }
        })
    })
</script>