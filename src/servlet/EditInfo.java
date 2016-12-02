package servlet;

import dbConnection.DbConnection;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import rayUtil.Confirmation;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import static rayUtil.Password.getSaltedHash;
/**
 * Created by Ray on 16/5/15.
 */
@WebServlet(name = "EditInfo",urlPatterns = {"/editInfo"})
public class EditInfo extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(!Confirmation.isLogin(request))
            return;

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        //表单中的信息
        String userName = null;
        String password = null;
        String name = null;
        String mobile = null;
        int sex = 1;
        String introduction = null;
        int id = 0;
        //文件信息
        String suffix = null;
        String fileDir = getServletContext().getRealPath("/upload/headImage");
        String relativePath = null;
        String message = "修改信息成功";
        String address = "";
        boolean isError = false;

        if(ServletFileUpload.isMultipartContent(request)){
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(20 * 1024);
            ServletFileUpload upload = new ServletFileUpload(factory);

            int size = 5 * 1024 * 1024;
            List formLists = null;
            try {
                formLists = upload.parseRequest(request);
            } catch (FileUploadException e) {
                e.printStackTrace();
                request.setAttribute("message","修改信息失败");
                request.setAttribute("isError",true);
                request.getRequestDispatcher("editInfoMessage.jsp").forward(request, response);
            }

            Iterator iter = formLists.iterator();
            while(iter.hasNext()){
                FileItem formitem = (FileItem) iter.next();
                if(formitem.isFormField()){
                    String fieldName = formitem.getFieldName();
                    if(fieldName.equals("userName")){
                        userName = formitem.getString("UTF-8");
                    }
                    else if(fieldName.equals("password")){
                        password = formitem.getString("UTF-8");
                    }
                    else if(fieldName.equals("name")){
                        name = formitem.getString("UTF-8");
                    }
                    else if(fieldName.equals("mobile")){
                        mobile = formitem.getString("UTF-8");
                    }
                    else if(fieldName.equals("sex")){
                        sex = Integer.parseInt(formitem.getString("UTF-8"));
                    }
                    else if(fieldName.equals("introduction")){
                        introduction = formitem.getString("UTF-8");
                    }
                    else if(fieldName.equals("userId")){
                        id = Integer.parseInt(formitem.getString("UTF-8"));
                    }
                }
                else{
                    String fileName = formitem.getName();
                    if(formitem.getSize() > size){
                        message = "您上传的文件太大,请选择不超过5M的文件";
                        isError = true;
                        break;
                    }

                    String adjunctsize = Long.toString(formitem.getSize());
                    if((fileName == null) || (fileName.equals("")) && adjunctsize.equals("0"))
                        continue;

                    suffix = fileName.substring(fileName.lastIndexOf(".")+1,fileName.length());

                    //文件名 年月日时分秒+5位随机数
                    Date now = new Date();
                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
                    Random random = new Random();
                    int rannum = (int) (random.nextDouble() * (99999 - 10000 + 1)) + 10000;// 获取5位随机数
                    String fileNameRandom = simpleDateFormat.format(now) + Integer.toString(rannum) + "." + suffix;

                    relativePath = "upload/headImage/" + fileNameRandom;
                    address = fileDir + "/" + fileNameRandom;   //文件上传地址
                    File saveFile = new File(address);
                    try {
                        formitem.write(saveFile);   //向文件写数据
                    } catch (Exception e) {
                        e.printStackTrace();
                        isError = true;
                        request.setAttribute("message","修改信息失败");
                        request.setAttribute("isError",true);
                        request.getRequestDispatcher("editInfoMessage.jsp").forward(request, response);
                    }

                }
            }

        }
        try {
            DbConnection dbConnection = new DbConnection();
            String sql = "SELECT * FROM user WHERE id="+Integer.toString(id);
            Statement statement = dbConnection.getConnection().createStatement();
            ResultSet resultSet = statement.executeQuery(sql);
            if(resultSet.next()){
                String PasswordInDb = resultSet.getString("password");
                if(!password.equals(PasswordInDb)){
                    password = getSaltedHash(password);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }


//        HttpSession session = request.getSession();
//        int id = (Integer)session.getAttribute("userId");
        if(relativePath == null){
            try {
                //如果没有上传图片
                DbConnection dbConnection = new DbConnection();
                String sql = "UPDATE user SET userName=?,password=?,sex=?,name=?,introduction=?,mobile=? WHERE id=?";
                PreparedStatement preparedStatement = dbConnection.getConnection().prepareStatement(sql);
                preparedStatement.setString(1,userName);
                preparedStatement.setString(2,password);
                preparedStatement.setInt(3,sex);
                preparedStatement.setString(4,name);
                preparedStatement.setString(5,introduction);
                preparedStatement.setString(6,mobile);
                preparedStatement.setInt(7,id);
                int rs = preparedStatement.executeUpdate();
                if(rs>0){
                    isError = false;
                }
                dbConnection.closeConnection();

                request.setAttribute("message",message);
                request.setAttribute("isError",false);
                request.getRequestDispatcher("editInfoMessage.jsp").forward(request, response);

            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("message","修改信息失败");
                request.setAttribute("isError",true);
                request.getRequestDispatcher("editInfoMessage.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        else{
            try {
                //如果上传图片
                DbConnection dbConnection = new DbConnection();
                String sql = "UPDATE user SET userName=?,password=?,sex=?,name=?,introduction=?,headImage=?,mobile=? WHERE id=?";
                PreparedStatement preparedStatement = dbConnection.getConnection().prepareStatement(sql);
                preparedStatement.setString(1,userName);
                preparedStatement.setString(2,password);
                preparedStatement.setInt(3,sex);
                preparedStatement.setString(4,name);
                preparedStatement.setString(5,introduction);
                preparedStatement.setString(6,relativePath);
                preparedStatement.setString(7,mobile);
                preparedStatement.setInt(8,id);
                int rs = preparedStatement.executeUpdate();
                if(rs>0){
                    isError = false;
                }
                dbConnection.closeConnection();

                request.setAttribute("message",message);
                request.setAttribute("isError",false);
                request.getRequestDispatcher("editInfoMessage.jsp").forward(request, response);

            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("message","修改信息失败");
                request.setAttribute("isError",true);
                request.getRequestDispatcher("editInfoMessage.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
