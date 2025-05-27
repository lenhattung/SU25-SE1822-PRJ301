/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.ArrayList;

/**
 *
 * @author tungi
 */
public class UserDAO {
    ArrayList<UserDTO> list;

    public UserDAO() {
        this.list = new ArrayList<>();
        list.add(new UserDTO("admin", "admin", "Administrator", "AD", true));
        list.add(new UserDTO("se123", "hcm", "Nguyen Van A", "MB", true));
        list.add(new UserDTO("se456", "hcm", "Hoa Hau TT", "MB", true));
    }
    
    public boolean login(String userID, String password){
        for (UserDTO userDTO : list) {
            if(userDTO.getUserID().equalsIgnoreCase(userID)
                    && userDTO.getPassword().equals(password)){
                return true;
            }
        }
        return false;
    }
    
    public UserDTO getUserById(String id){
        for (UserDTO userDTO : list) {
            if(userDTO.getUserID().equalsIgnoreCase(id)){
                return userDTO;
            }
        }
        return null;
    }
    
}
