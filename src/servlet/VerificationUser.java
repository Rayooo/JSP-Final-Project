package servlet;

import dbConnection.DbConnection;

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
