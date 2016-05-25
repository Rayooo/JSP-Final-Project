package servlet;

import dbConnection.DbConnection;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import rayUtil.Confirmation;
import rayUtil.SqlDate;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Random;

/**
 * Created by Ray on 16/5/24.
 */
@WebServlet(name = "UploadFile",urlPatterns = {"/uploadFile"})
public class UploadFile extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if(!Confirmation.isLogin(request))
            return;

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        //表单信息
        String description = null;

        //文件信息
        String suffix = null;   //后缀名
        String fileDir = getServletContext().getRealPath("/upload/file");
        String relativePath = null;
        String message = "上传文件成功";
        String address = "";
        boolean isError = false;

        if(ServletFileUpload.isMultipartContent(request)){
            DiskFileItemFactory factory = new DiskFileItemFactory();
            factory.setSizeThreshold(20 * 1024);
            ServletFileUpload upload = new ServletFileUpload(factory);

            List formLists = null;
            try{
                formLists = upload.parseRequest(request);
            }
            catch (FileUploadException e){
                e.printStackTrace();
                isError = true;
                request.setAttribute("message","上传文件失败");
                request.setAttribute("isError", true);
                request.getRequestDispatcher("uploadFileMessage.jsp").forward(request, response);
                return;
            }

            Iterator iterator = formLists.iterator();
            while (iterator.hasNext()){
                FileItem formItem = (FileItem) iterator.next();
                if(!formItem.isFormField()){
                    String fileName = formItem.getName();

                    String adjunctsize = Long.toString(formItem.getSize());
                    if((fileName == null) || (fileName.equals("")) && adjunctsize.equals("0"))
                        continue;

                    suffix = fileName.substring(fileName.lastIndexOf(".")+1,fileName.length());

                    //文件名 年月日时分秒+5位随机数
                    Date now = new Date();
                    SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
                    Random random = new Random();
                    int rannum = (int) (random.nextDouble() * (99999 - 10000 + 1)) + 10000;// 获取5位随机数
                    String fileNameRandom = simpleDateFormat.format(now) + Integer.toString(rannum) + "." + suffix;

                    relativePath = "upload/file/" + fileNameRandom;
                    address = fileDir + "/" + fileNameRandom;   //文件上传地址
                    File saveFile = new File(address);
                    try {
                        formItem.write(saveFile);   //向文件写数据
                    } catch (Exception e) {
                        e.printStackTrace();
                        message = "上传文件失败";
                        isError = true;
                    }
                }
                else{
                    String fieldName = formItem.getFieldName();
                    if(fieldName.equals("description")){
                        description = formItem.getString("UTF-8");
                    }
                }
            }
            HttpSession session = request.getSession();
            int userId = (Integer)session.getAttribute("userId");

            try {
                //如果上传图片
                DbConnection dbConnection = new DbConnection();
                String sql = "INSERT INTO file (userId, description, url, createTime) " +
                        "VALUES ("+Integer.toString(userId)+",'"+description+"','"+relativePath+"','"+ SqlDate.getSQLDateTime()+"') ";
                Statement statement = dbConnection.connection.createStatement();
                int rs = statement.executeUpdate(sql);
                if(rs>0){
                    System.out.println("上传文件成功");
                }
                dbConnection.closeConnection();

                request.setAttribute("message",message);
                request.setAttribute("isError",isError);
                request.getRequestDispatcher("uploadFileMessage.jsp").forward(request, response);

            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("message","上传文件失败");
                request.setAttribute("isError",true);
                request.getRequestDispatcher("uploadFileMessage.jsp").forward(request, response);
            }

        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
