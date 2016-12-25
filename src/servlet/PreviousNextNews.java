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


@WebServlet(name = "PreviousNextNews",urlPatterns = {"/previousNextNews"})
public class PreviousNextNews extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String choice = request.getParameter("choice");
        int currentNewsId = Integer.parseInt(request.getParameter("currentNewsId"));
        Integer returnNewsId = null;

        try {
            DbConnection dbConnection = new DbConnection();
            Statement statement = dbConnection.getConnection().createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY);
            String sql = "SELECT id FROM news WHERE isDeleted = 0";
            ResultSet resultSet = statement.executeQuery(sql);
            if(resultSet != null){
                while (resultSet.next()){
                    if(currentNewsId == resultSet.getInt("id")){
                        if(choice.equals("previous")){
                            resultSet.previous();
                            returnNewsId = resultSet.getInt("id");
                            break;
                        }else if(choice.equals("next")) {
                            resultSet.next();
                            returnNewsId = resultSet.getInt("id");
                            break;
                        }
                    }
                }
            }
            PrintWriter writer = response.getWriter();
            writer.print(returnNewsId);
            writer.flush();
            dbConnection.closeConnection();
        }catch (SQLException e){
            e.printStackTrace();
            PrintWriter writer = response.getWriter();
            writer.print("noNews");
            writer.flush();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
