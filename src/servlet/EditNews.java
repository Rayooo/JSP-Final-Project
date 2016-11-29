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
@WebServlet(name = "EditNews",urlPatterns = {"/editNews"})
public class EditNews extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(!Confirmation.isManager(request)){
            return;
        }
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String title = request.getParameter("newsTitle");
        String content = request.getParameter("newsContent");
        String newsId = request.getParameter("newsId");

        try {
            DbConnection dbConnection = new DbConnection();
            Statement statement = dbConnection.getConnection().createStatement();
            String sql = "UPDATE news SET title='"+title+"',content='"+content+"' WHERE isDeleted=0 AND id="+newsId;
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
            writer.flush();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
