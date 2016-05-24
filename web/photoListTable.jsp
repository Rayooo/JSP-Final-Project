<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/23
  Time: 20:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="confirmationLogin.jsp"%>
<%
    int currentPage = Integer.parseInt(request.getParameter("page"));
    try {
        DbConnection dbConnection = new DbConnection();
        Statement statement = dbConnection.connection.createStatement();
        String sql = "SELECT * FROM photo WHERE isDeleted=0 ORDER BY id DESC LIMIT "+ Integer.toString((currentPage-1)*9) +",9";//(页数-1)*每页条数,每页条数
        ResultSet resultSet = statement.executeQuery(sql);
        if(resultSet != null){
            int imageCount = 1;
            while (resultSet.next()){
                if(imageCount % 3 == 0){
                    out.println("<div class='row'>");
                }
%>
                <div class="col-sm-4 col-md-4">
                    <div class="thumbnail">
                        <img src="<%=resultSet.getString("url")%>" alt="">
                        <div class="caption">
                            <p>描述: <%=resultSet.getString("description").equals("")? "无" :resultSet.getString("description")%></p>
                            <p>上传时间: <%=resultSet.getDate("createTime")%>  <%=resultSet.getTime("createTime")%></p>
                            <p>url: <%=resultSet.getString("url")%></p>
                            <%
                                if(resultSet.getInt("userId")==(Integer)session.getAttribute("userId") || (Integer)session.getAttribute("isManager") == 1){
                                    out.print("<p><button class='btn btn-danger deleteButton' id='delete"+resultSet.getInt("id")+"'>删除</button></p>");
                                }
                            %>
                        </div>
                    </div>
                </div>
<%
                if(imageCount % 3 == 0){
                    out.println("</div>");
                }
                imageCount++;
            }

        }
    }catch (SQLException e){
        e.printStackTrace();
    }
%>
<script>
    $(".deleteButton").click(function () {
        var photoId = this.id.replace(/delete/,"");
        swal({
            title: "警告",
            text: "您确定要删除此照片?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function(){
            $.post("/deletePhoto",{photoId:photoId},function (data) {
                if(data == "success"){
                    swal("成功", "已删除该照片", "success");
                    var deleteButton = $("#delete"+photoId);
                    deleteButton.addClass("disabled");
                    deleteButton.html("已删除");
                    deleteButton.unbind("click");
                }
                else{
                    swal("失败", data, "error");
                }
            })
        });
    })
</script>
