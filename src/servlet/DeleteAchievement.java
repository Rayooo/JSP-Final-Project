package servlet;

import dbConnection.DbConnection;
import rayUtil.Confirmation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Created by Ray on 16/5/29.
 */
@WebServlet(name = "DeleteAchievement",urlPatterns = {"/deleteAchievement"})
public class DeleteAchievement extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(!Confirmation.isLogin(request)){
            return;
        }
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        boolean canDelete = false;
        String achievementId = request.getParameter("achievementId");

        DbConnection dbConnection = new DbConnection();
        HttpSession session = request.getSession();

        //如果是管理员能够直接删除,如果是用户则要判断是不是他发表的
        if((Integer)session.getAttribute("isManager") == 1){
            canDelete = true;
        }else{
            try {
                Statement statement = dbConnection.connection.createStatement();
                String sql = "SELECT userId FROM achievement WHERE isDeleted=0 AND id="+achievementId;
                ResultSet resultSet = statement.executeQuery(sql);
                if(resultSet != null){
                    resultSet.next();
                    if(resultSet.getInt("userId") == (Integer)session.getAttribute("userId")){
                        canDelete = true;
                    }
                }
            }catch (SQLException e){
                e.printStackTrace();
            }
        }
        if(canDelete){
            try {

                Statement statement = dbConnection.connection.createStatement();
                String sql = "UPDATE achievement SET isDeleted=1 WHERE id="+achievementId;
                int rs = statement.executeUpdate(sql);
                PrintWriter writer = response.getWriter();
                if(rs > 0){
                    writer.print("success");
                }else{
                    writer.print("删除失败");
                }
                writer.flush();
                dbConnection.closeConnection();
            }catch (SQLException e){
                e.printStackTrace();
                PrintWriter writer = response.getWriter();
                writer.print("删除失败");
                writer.flush();
            }
        }else{
            PrintWriter writer = response.getWriter();
            writer.print("您没有权限删除");
            writer.flush();
        }



    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
