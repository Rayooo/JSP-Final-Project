<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/24
  Time: 21:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="confirmationLogin.jsp"%>
<%
    int currentPage = Integer.parseInt(request.getParameter("page"));
    try {
        DbConnection dbConnection = new DbConnection();
        Statement statement = dbConnection.getConnection().createStatement();
        DbConnection userConnection = new DbConnection();
        Statement userStatement = userConnection.getConnection().createStatement();

        String sql = "SELECT * FROM file  WHERE isDeleted=0 ORDER BY id DESC LIMIT "+ Integer.toString((currentPage-1)*10) +",10";//(页数-1)*每页条数,每页条数
        ResultSet resultSet = statement.executeQuery(sql);
        int fileCount = 1;
        if (resultSet != null){
            while (resultSet.next()){
                int fileId = resultSet.getInt("id");
                String originalFileName = resultSet.getString("fileName");
                String url = resultSet.getString("url");
                String createTime = resultSet.getDate("createTime") + " " + resultSet.getTime("createTime");
                String description = resultSet.getString("description");

                String uploadFileUserId = Integer.toString(resultSet.getInt("userId"));

                String userSql = "SELECT name FROM user WHERE id="+uploadFileUserId;
                ResultSet userResultSet = userStatement.executeQuery(userSql);
                String uploadFileUserName = "";
                if(userResultSet != null){
                    userResultSet.next();
                    uploadFileUserName = userResultSet.getString("name");
                }
                if(fileCount % 2 == 0){
                    out.println("<div class='row'>");
                }
                String[] fileNameArr = originalFileName.split("\\.");
                String suffix = fileNameArr[fileNameArr.length - 1];
%>
                <div class="media col-md-6" style="margin-top: 0">
                    <div class="media-left">
                        <a href="#">
                            <%
                                if(suffix.equals("avi") || suffix.equals("doc") ||
                                        suffix.equals("html") || suffix.equals("js") ||
                                        suffix.equals("mp3") || suffix.equals("mp4") ||
                                        suffix.equals("pdf") || suffix.equals("xls") ||
                                        suffix.equals("zip") || suffix.equals("docx") ||
                                        suffix.equals("xlsx")){
                                    out.print("<img class='media-object' src='image/"+suffix+".png' alt='...'>");
                                }
                                else {
                                    out.print("<img class='media-object' src='image/file.png' alt='...'>");
                                }
                            %>
                        </a>
                    </div>
                    <div class="media-body">
                        <h4 class="media-heading">文件名:<%=originalFileName%></h4>
                        <p>上传者:<%=uploadFileUserName%></p>
                        <p>描述:<%=description.equals("")? "无":description%></p>
                        <p>引用链接:<%=url%></p>
                        <p>上传时间:<%=createTime%></p>
                        <p>
                            <a class="btn btn-success" id="download<%=fileId%>" download="<%=resultSet.getString("fileName")%>" href="<%=resultSet.getString("url")%>">下载</a>
                            <%
                                if(resultSet.getInt("userId")==(Integer)session.getAttribute("userId") || (Integer)session.getAttribute("isManager") == 1){
                                    out.print("<button class='btn btn-danger deleteButton' id='delete"+fileId+"'>删除</button>");
                                }
                            %>
                        </p>
                    </div>
                </div>
<%
                if(fileCount % 2 == 0){
                    out.println("</div>");
                }
                fileCount++;
            }
        }
        dbConnection.closeConnection();
        userConnection.closeConnection();
    }catch (SQLException e){
        e.printStackTrace();
    }
%>

<script>
    $(".deleteButton").click(function () {
        var fileId = this.id.replace(/delete/,"");
        swal({
            title: "警告",
            text: "您确定要删除此文件?",
            type: "warning",
            showCancelButton: true,
            cancelButtonText: "取消",
            confirmButtonColor: "#DD6B55",
            confirmButtonText: "删除",
            closeOnConfirm: false
        }, function(){
            $.post("/deleteFile",{fileId:fileId},function (data) {
                if(data == "success"){
                    swal("成功", "已删除该文件", "success");
                    var deleteButton = $("#delete"+fileId);
                    deleteButton.addClass("disabled");
                    deleteButton.html("已删除");
                    deleteButton.unbind("click");
                    $("#download"+fileId).remove();
                }
                else{
                    swal("失败", data, "error");
                }
            })
        });
    })
</script>
