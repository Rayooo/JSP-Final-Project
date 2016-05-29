package servlet;

import dbConnection.DbConnection;
import rayUtil.Confirmation;
import rayUtil.SqlDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Created by Ray on 16/5/28.
 */
@WebServlet(name = "AddAchievementComment",urlPatterns = {"/addAchievementComment"})
public class AddAchievementComment extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(!Confirmation.isLogin(request)){
            return;
        }
        HttpSession session = request.getSession();
        int userId = (Integer)session.getAttribute("userId");
        String achievementId = request.getParameter("achievementId");
        String achievementComment = request.getParameter("achievementComment");
        try {
            DbConnection dbConnection = new DbConnection();
            Statement statement = dbConnection.connection.createStatement();
            String sql = "INSERT INTO achievementComment (content, userId, achievementId, createTime)" +
                    " VALUES ('"+achievementComment+"',"+Integer.toString(userId)+","+achievementId+",'"+ SqlDate.getSQLDateTime()+"')";
            int rs = statement.executeUpdate(sql);
            PrintWriter writer = response.getWriter();
            if(rs > 0){
                writer.print("success");
            }else{
                writer.print("error");
            }
            writer.flush();
            dbConnection.closeConnection();
        }catch (SQLException e) {
            e.printStackTrace();
            PrintWriter writer = response.getWriter();
            writer.print("error");
            writer.flush();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
