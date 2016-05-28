<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/28
  Time: 15:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String newsTitle = request.getParameter("newsTitle");
    try {
        DbConnection dbconnection = new DbConnection();
        Statement statement = dbconnection.connection.createStatement();
        String sql = "SELECT * FROM news WHERE title LIKE '%"+ newsTitle +"%'";
        ResultSet resultSet = statement.executeQuery(sql);

        if(resultSet != null){
%>
            <div class='container alert alert-success text-center' role='alert'>以下是新闻标题带有 <span class="text-primary"><%=newsTitle%></span> 的信息</div>
            <div class='container text-center'>
                <table class="table table-hover">
<%
                    while (resultSet.next()){
                        int id = resultSet.getInt("id");
                        String title = resultSet.getString("title");
                        String createTime = resultSet.getDate("createTime")+" "+resultSet.getTime("createTime");
%>
                    <tr id="news<%=id%>" class="newsTr" style="cursor: pointer">
                        <td><%=title%></td>
                        <td style="text-align: right"><%=createTime%></td>
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

    }catch (SQLException e){
        e.printStackTrace();
    }

%>
<script>
    $(".newsTr").click(function () {
        var newsId = this.id.replace(/news/,"");
        location.href = "newsDetail.jsp?newsId="+newsId;
    })
</script>