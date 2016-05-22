package rayUtil;

import java.text.SimpleDateFormat;

/**
 * Created by Ray on 16/5/22.
 */
public class SqlDate {
    public static String getSQLDateTime(){
        java.util.Date date = new java.util.Date();
        SimpleDateFormat sdformat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//24小时制
        return sdformat.format(date);
    }
}

