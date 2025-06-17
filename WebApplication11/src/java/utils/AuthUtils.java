package utils;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import model.UserDTO;

public class AuthUtils {
    public static UserDTO getCurrentUser(HttpServletRequest request){
        HttpSession session = request.getSession();
        if(session!=null){
            return (UserDTO) session.getAttribute("user");
        }
        return null;
    }
    
    public static boolean isLoggedIn(HttpServletRequest request){
        return getCurrentUser(request)!=null;
    }
    
    public static boolean hasRole(HttpServletRequest request, String role){
        UserDTO user = getCurrentUser(request);
        if(user!=null){
            return user.getRoleID().equals(role);
        }
        return false;
    }
    
    public static boolean isAdmin(HttpServletRequest request){
        return hasRole(request, "AD");
    }
    
    public static boolean isManager(HttpServletRequest request){
        return hasRole(request, "MA");
    }
    
    public static boolean isUser(HttpServletRequest request){
        return hasRole(request, "MB");
    }
    
    public static String getLoginURL(){
        return "MainController";
    }
    
    public static String getAccessDeniedMessage(String action){
        return "You can not access to "+action+". Please contact administrator.";
    }
}
