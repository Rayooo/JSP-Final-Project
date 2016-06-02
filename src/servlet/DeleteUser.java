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
import java.sql.SQLException;
import java.sql.Statement;

/**
 * Created by Ray on 16/5/22.
 */
@WebServlet(name = "DeleteUser",urlPatterns = {"/deleteUser"})
public class DeleteUser extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(!Confirmation.isManager(request))
            return;
        String userId = request.getParameter("userId");
        HttpSession session = request.getSession();
        PrintWriter writer = response.getWriter();
        boolean isError = true;
        if(Integer.parseInt(userId) == (Integer)session.getAttribute("userId")){
            return;
        }
        DbConnection dbConnection = new DbConnection();
        try {
            //开始一个事务
            dbConnection.connection.setAutoCommit(false);

            Statement statement = dbConnection.connection.createStatement();
            String sql = "UPDATE user SET isDeleted=1 WHERE id="+ userId;
            int rs = statement.executeUpdate(sql);

            if(rs > 0){
                //将其所有的成果都删除
                sql = "UPDATE achievement SET isDeleted=1 WHERE userId="+userId;
                int rs2 = statement.executeUpdate(sql);
                if(rs2 > 0){
                    writer.print("success");
                    dbConnection.connection.commit();
                    isError = false;
                }
            }
            if(isError){
                writer.print("error");
                dbConnection.connection.rollback();
            }
            writer.flush();
            dbConnection.closeConnection();
        }
        catch (SQLException e) {
//        e.printStackTrace();
            writer.print("error");
            writer.flush();
            try {
                dbConnection.connection.rollback();
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
