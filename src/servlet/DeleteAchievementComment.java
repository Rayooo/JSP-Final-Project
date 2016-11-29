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
@WebServlet(name = "DeleteAchievementComment",urlPatterns = {"/deleteAchievementComment"})
public class DeleteAchievementComment extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(!Confirmation.isLogin(request)){
            return;
        }
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String achievementCommentId = request.getParameter("achievementCommentId");
        String achievementAuthor = request.getParameter("achievementAuthor");

        boolean canDelete = false;
        HttpSession session = request.getSession();
        //管理员有权限删除所有,发布该成果的用户有权限删除所有
        if((Integer)session.getAttribute("isManager") == 1 || Integer.parseInt(achievementAuthor) == (Integer)session.getAttribute("userId")){
            canDelete = true;
        }else {
            //发布该评论的用户有权限删除自己的评论
            try {
                DbConnection dbConnection = new DbConnection();
                Statement statement = dbConnection.getConnection().createStatement();
                String sql = "SELECT userId FROM achievementComment WHERE id="+achievementCommentId;
                ResultSet resultSet = statement.executeQuery(sql);
                if(resultSet != null){
                    resultSet.next();
                    if(resultSet.getInt("userId") == (Integer)session.getAttribute("userId")){
                        canDelete = true;
                    }
                }
                dbConnection.closeConnection();
            } catch (SQLException e){
                e.printStackTrace();
                PrintWriter writer = response.getWriter();
                writer.print("服务器异常");
                writer.flush();
            }
        }
        if(canDelete){
            try {
                DbConnection dbConnection = new DbConnection();
                Statement statement = dbConnection.getConnection().createStatement();
                String sql = "UPDATE achievementComment SET isDeleted=1 WHERE id="+achievementCommentId;
                int rs = statement.executeUpdate(sql);
                PrintWriter writer = response.getWriter();
                if(rs > 0){
                    writer.print("success");
                }else {
                    writer.print("删除失败");
                }
                writer.flush();
                dbConnection.closeConnection();
            }catch (SQLException e){
                e.printStackTrace();
                PrintWriter writer = response.getWriter();
                writer.print("服务器异常");
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
