package dbConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Created by Ray on 16/5/13.
 */
public class DbConnection {

    public Connection connection = null;

    //连接数据库
    public DbConnection(){
        try {
            Class.forName("com.mysql.jdbc.Driver");
            //本地mysql
            connection = DriverManager.getConnection("jdbc:mysql://localhost:8889/JSPFinalProject?useUnicode=true&characterEncoding=utf-8","root","root");
            //部署服务器的mysql
//            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/JSPFinalProject?useUnicode=true&characterEncoding=utf-8","root","");

            System.out.println("连接数据库成功");

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    //关闭数据库
    public void closeConnection(){
        if(connection!=null){
            try {
                connection.close();
                System.out.println("断开数据库成功");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
