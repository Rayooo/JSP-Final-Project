package servlet;

import dbConnection.DbConnection;
import rayUtil.Confirmation;

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

//将user中isPass的属性改成1,验证用户模块
@WebServlet(name = "VerificationUser",urlPatterns = {"/verificationUser"})
public class VerificationUser extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(!Confirmation.isManager(request))
            return;

        String userId = request.getParameter("userId");
        try {
            DbConnection dbConnection = new DbConnection();
            Statement statement = dbConnection.connection.createStatement();
            String sql = "UPDATE user SET isPassed=1 WHERE id="+ userId;
            int rs = statement.executeUpdate(sql);
            PrintWriter writer = response.getWriter();
            if(rs > 0){
                writer.print("success");
            }
            else{
                writer.print("error");
            }
            writer.flush();
            dbConnection.closeConnection();
        }
        catch (SQLException e) {
            PrintWriter writer = response.getWriter();
            writer.print("error");
            writer.flush();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
