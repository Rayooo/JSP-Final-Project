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


@WebServlet(name = "DeletePhoto", urlPatterns = {"/deletePhoto"})
public class DeletePhoto extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(!Confirmation.isLogin(request)){
            return;
        }
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        String photoId = request.getParameter("photoId");

        boolean canDelete = false;
        HttpSession session = request.getSession();
        if((Integer)session.getAttribute("isManager") == 1) {
            canDelete = true;
        }else {
            try {
                DbConnection dbConnection = new DbConnection();
                Statement statement = dbConnection.getConnection().createStatement();
                String sql = "SELECT userId FROM photo WHERE id="+photoId;
                ResultSet resultSet = statement.executeQuery(sql);
                if(resultSet != null){
                    resultSet.next();
                    if(resultSet.getInt("userId") == (Integer)session.getAttribute("userId")){
                        canDelete = true;
                    }
                }
                dbConnection.closeConnection();
            }catch (SQLException e){
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
                String sql = "UPDATE photo SET isDeleted=1 WHERE id="+photoId;
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
