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
@WebServlet(name = "EditAchievement",urlPatterns = {"/editAchievement"})
public class EditAchievement extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(!Confirmation.isUser(request)){
            return;
        }
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        String title = request.getParameter("achievementTitle");
        String content = request.getParameter("achievementContent");
        String achievementId = request.getParameter("achievementId");

        //只有用户自己才能编辑
        boolean canEdit = false;

        DbConnection dbConnection = new DbConnection();
        try {
            Statement statement = dbConnection.connection.createStatement();
            String sql = "SELECT userId FROM achievement WHERE isDeleted=0 AND id="+achievementId;
            ResultSet resultSet = statement.executeQuery(sql);
            if(resultSet != null){
                resultSet.next();
                if(resultSet.getInt("userId") == (Integer)session.getAttribute("userId")){
                    canEdit = true;
                }
            }
        }catch (SQLException e){
            e.printStackTrace();
        }

        if(canEdit){
            try {
                Statement statement = dbConnection.connection.createStatement();
                String sql = "UPDATE achievement SET title='"+title+"',content='"+content+"' WHERE isDeleted=0 AND id="+achievementId;
                int rs = statement.executeUpdate(sql);
                PrintWriter writer = response.getWriter();
                if(rs > 0){
                    writer.print("success");
                }else{
                    writer.print("编辑文章发生错误");
                }
                writer.flush();
                dbConnection.closeConnection();
            }catch (SQLException e){
                e.printStackTrace();
                PrintWriter writer = response.getWriter();
                writer.print("编辑文章发生错误");
                writer.flush();
            }
        }else{
            PrintWriter writer = response.getWriter();
            writer.print("您没有权限编辑该文章");
            writer.flush();
        }

        dbConnection.closeConnection();


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
