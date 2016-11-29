package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Objects;

import dbConnection.DbConnection;

/**
 * Created by Ray on 16/5/13.
 */
@WebServlet(name = "Register",urlPatterns = {"/register"})
public class Register extends HttpServlet {
    //注册模块
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String userName = request.getParameter("userName");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        int isManager = Integer.parseInt(request.getParameter("isManager"));         //0代表不是管理员,因为要插到数据库中,不用bool

        boolean isError = false;
        String message = "服务器异常";
        PrintWriter writer = response.getWriter();

        java.util.Date date = new java.util.Date();
        SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//24小时制
        String createTime = sdformat.format(date);

        String sql = "INSERT INTO user (userName, password, name, createTime, isManager, headImage)" +
                "VALUES('"+userName+"','"+password+"','"+name+"','"+createTime+"',"+isManager+",'image/headImage.png')";
        try {
            //插入数据库
            DbConnection dbConnection = new DbConnection();
            Statement statement = dbConnection.getConnection().createStatement();
            int rs = statement.executeUpdate(sql);
            if(rs > 0){
                isError = false;
            }
            else{
                isError = true;
                message = "存在相同的用户名,请修改用户名后重新提交";
            }
            dbConnection.closeConnection();

            if(!isError){
                writer.print("success");
            }else{
                writer.print(message);
            }
            writer.flush();

        } catch (SQLException e) {
            e.printStackTrace();
            writer.print("服务器异常");
            writer.flush();
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
