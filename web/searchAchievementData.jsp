<%--
  Created by IntelliJ IDEA.
  User: Ray
  Date: 16/5/31
  Time: 18:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="dbConnection.DbConnection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String achievementTitle = request.getParameter("achievementTitle");
    try {
        DbConnection dbconnection = new DbConnection();
        Statement statement = dbconnection.getConnection().createStatement();
        String sql = "SELECT * FROM achievement WHERE isDeleted=0 AND title LIKE '%"+ achievementTitle +"%'";
        ResultSet resultSet = statement.executeQuery(sql);

        if(resultSet != null){
%>
            <div class='container alert alert-success text-center' role='alert'>以下是成果标题带有 <span class="text-primary"><%=achievementTitle%></span> 的信息</div>
            <div class='container text-center'>
                <table class="table table-hover">
                <%
                    while (resultSet.next()){
                        int id = resultSet.getInt("id");
                        String title = resultSet.getString("title");
                        String createTime = resultSet.getDate("createTime")+" "+resultSet.getTime("createTime");
                %>
                            <tr id="achievement<%=id%>" class="achievementTr" style="cursor: pointer">
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
        dbconnection.closeConnection();
    }catch (SQLException e){
        e.printStackTrace();
    }

%>
<script>
    $(".achievementTr").click(function () {
        var achievementId = this.id.replace(/achievement/,"");
        location.href = "achievementDetail.jsp?achievementId="+achievementId;
    })
</script>