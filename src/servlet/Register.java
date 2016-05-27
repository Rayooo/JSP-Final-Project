package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
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
        String[] choiceManager = request.getParameterValues("isManager");
        int isManager = 0;          //0代表不是管理员,因为要插到数据库中,不用bool
        if(choiceManager != null && choiceManager[0].equals("manager"))
            isManager = 1;

        boolean isError = false;
        String message = "提交注册成功,请等待管理员的审核";

        java.util.Date date = new java.util.Date();
        SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//24小时制
        String createTime = sdformat.format(date);

        String sql = "INSERT INTO user (userName, password, name, createTime, isManager, headImage)" +
                "VALUES('"+userName+"','"+password+"','"+name+"','"+createTime+"',"+isManager+",'image/headImage.png')";
        try {
            //插入数据库
            DbConnection dbConnection = new DbConnection();
            Statement statement = dbConnection.connection.createStatement();
            int rs = statement.executeUpdate(sql);
            if(rs > 0){
                isError = false;
            }
            else{
                isError = true;
                message = "存在相同的用户名,请修改用户名后重新提交";
            }
            dbConnection.closeConnection();

            request.setAttribute("message",message);
            request.setAttribute("isError",isError);
            request.getRequestDispatcher("registerMessage.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("message","存在相同的用户名,请修改用户名后重新提交");
            request.setAttribute("isError",true);
            request.getRequestDispatcher("registerMessage.jsp").forward(request, response);
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
