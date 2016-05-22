package rayUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by Ray on 16/5/22.
 */
public class Confirmation {
    public static boolean isManager(HttpServletRequest request){
        HttpSession session = request.getSession();
        Integer isManager = (Integer)session.getAttribute("isManager");
        Integer isPassed = (Integer)session.getAttribute("isPassed");
        return isManager != null && isManager == 1 && isPassed == 1;
    }

    public static boolean isUser(HttpServletRequest request){
        HttpSession session = request.getSession();
        Integer isManager = (Integer)session.getAttribute("isManager");
        Integer isPassed = (Integer)session.getAttribute("isPassed");
        return isManager != null && isManager == 0 && isPassed == 1;
    }

    public static boolean isLogin(HttpServletRequest request){
        HttpSession session = request.getSession();
        Integer isPassed = (Integer)session.getAttribute("isPassed");
        return isPassed == 1;
    }

}
