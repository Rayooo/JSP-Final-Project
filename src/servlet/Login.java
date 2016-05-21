package servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dbConnection.DbConnection;

/**
 * Created by Ray on 16/5/13.
 */
@WebServlet(name = "Login",urlPatterns = {"/login"})
public class Login extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String userName = request.getParameter("userNameNavBar");
        String password = request.getParameter("passwordNavBar");
        int isPassed = 0;
        //查询数据库中是否存在该用户
        try {
            DbConnection dbConnection = new DbConnection();
            String sql = "SELECT * FROM user WHERE userName=? AND password=? AND user.isDeleted=0 ";
            PreparedStatement preparedStatement = dbConnection.connection.prepareStatement(sql);
            preparedStatement.setString(1,userName);
            preparedStatement.setString(2,password);

            ResultSet resultSet = preparedStatement.executeQuery();
            if(resultSet.next()){
                isPassed = resultSet.getInt("isPassed");
                if(isPassed == 1){
                    HttpSession session = request.getSession();
                    session.setAttribute("userId",resultSet.getInt("id"));
                    session.setAttribute("userName",resultSet.getString("userName"));
                    session.setAttribute("headImage",resultSet.getString("headImage"));
                    session.setAttribute("name",resultSet.getString("name"));
                    session.setAttribute("isManager",resultSet.getInt("isManager"));
                    session.setAttribute("isPassed",resultSet.getInt("isPassed"));
                }
            }
            else{
                //登录失败跳转
                request.setAttribute("message","您输入的帐号密码错误");
                request.setAttribute("isError",true);
                request.getRequestDispatcher("loginErrorPage.jsp").forward(request, response);
            }

            dbConnection.closeConnection();

            if(isPassed == 1){
                response.sendRedirect("index.jsp");
            }
            else{
                request.setAttribute("message","您未通过管理员验证,请联系管理员");
                request.setAttribute("isError",false);
                request.getRequestDispatcher("loginErrorPage.jsp").forward(request, response);
            }

        } catch (SQLException e) {
            request.setAttribute("message","服务器异常");
            request.setAttribute("isError",true);
            request.getRequestDispatcher("loginErrorPage.jsp").forward(request, response);
//            e.printStackTrace();
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
