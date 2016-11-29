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

/**
 * Created by Ray on 16/5/31.
 */
@WebServlet(name = "DuplicationUserName",urlPatterns = {"/duplicationUserName"})
public class DuplicationUserName extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String userName = request.getParameter("userName");
        PrintWriter writer = response.getWriter();
        try {
            DbConnection dbConnection = new DbConnection();
            Statement statement = dbConnection.getConnection().createStatement();
            String sql = "SELECT count(id) FROM user WHERE userName='"+userName+"'";
            ResultSet resultSet = statement.executeQuery(sql);
            if(resultSet != null){
                resultSet.next();
                int count = resultSet.getInt("count(id)");
                if(count == 1){
                    //已存在用户名相同
                    writer.print("error");
                }else{
                    writer.print("success");
                }
            }
            writer.flush();
            dbConnection.closeConnection();
        }catch (SQLException e){
            e.printStackTrace();
            writer.print("error");
            writer.flush();
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
