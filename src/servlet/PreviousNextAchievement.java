package servlet;

import dbConnection.DbConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


@WebServlet(name = "PreviousNextAchievement",urlPatterns = {"/previousNextAchievement"})
public class PreviousNextAchievement extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String choice = request.getParameter("choice");
        int currentAchievementId = Integer.parseInt(request.getParameter("currentAchievementId"));
        Integer returnAchievementId = null;

        try {
            DbConnection dbConnection = new DbConnection();
            Statement statement = dbConnection.getConnection().createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
            String sql = "SELECT id FROM achievement WHERE isDeleted = 0";
            ResultSet resultSet = statement.executeQuery(sql);
            if(resultSet != null){
                while (resultSet.next()){
                    if(currentAchievementId == resultSet.getInt("id")){
                        if(choice.equals("previous")){
                            resultSet.previous();
                            returnAchievementId = resultSet.getInt("id");
                            break;
                        }else if(choice.equals("next")) {
                            resultSet.next();
                            returnAchievementId = resultSet.getInt("id");
                            break;
                        }
                    }
                }
            }
            PrintWriter writer = response.getWriter();
            writer.print(returnAchievementId);
            writer.flush();
            dbConnection.closeConnection();
        }catch (SQLException e){
            e.printStackTrace();
            PrintWriter writer = response.getWriter();
            writer.print("noAchievement");
            writer.flush();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
