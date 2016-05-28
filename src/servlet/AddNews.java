package servlet;

import dbConnection.DbConnection;
import rayUtil.Confirmation;
import rayUtil.SqlDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Created by Ray on 16/5/22.
 */
@WebServlet(name = "AddNews", urlPatterns = {"/addNews"})
public class AddNews extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(!Confirmation.isManager(request))
            return;

        String newsContent = request.getParameter("newsContent");
        String newsTitle = request.getParameter("newsTitle");
        String userId = request.getParameter("userId");
        try {
            DbConnection dbConnection = new DbConnection();
            Statement statement = dbConnection.connection.createStatement();
            String sql = "INSERT INTO news (userId, title, content, createTime)" +
                    "VALUES ("+userId+",'"+newsTitle+"','"+newsContent+"','"+ SqlDate.getSQLDateTime()+"')";

            int rs = statement.executeUpdate(sql);
            PrintWriter writer = response.getWriter();
            if(rs > 0){
                writer.print("success");
            }else{
                writer.print("error");
            }
            writer.flush();
            dbConnection.closeConnection();
        }catch (SQLException e){
            e.printStackTrace();
            PrintWriter writer = response.getWriter();
            writer.print("error");
            writer.flush();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
