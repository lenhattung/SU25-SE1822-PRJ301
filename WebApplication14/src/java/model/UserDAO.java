/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import utils.DbUtils;

/**
 *
 * @author tungi
 */
public class UserDAO {

    public UserDAO() {

    }

    public boolean login(String userID, String password) {
        UserDTO user = getUserById(userID);
        if (user != null) {
            if (user.getPassword().equals(password)) {
                if (user.isStatus()) {
                    return true;
                }
            }
        }
        return false;
    }

    public UserDTO getUserById(String id) {
        UserDTO user = null;
        try {
            // B0 - Tao sql
            String sql = "SELECT * FROM tblUsers WHERE userID=?";

            // B1 - ket noi
            Connection conn = DbUtils.getConnection();

            // B2 - Tao cong cu de thuc thi cau lenh sql
            // Statement st = conn.createStatement();
            PreparedStatement pr = conn.prepareStatement(sql);
            pr.setString(1, id);

            // B3 - Thuc thi cau lenh
            ResultSet rs = pr.executeQuery();

            // B4 - Duyet bang
            while (rs.next()) {
                String userID = rs.getString("userID");
                String fullName = rs.getString("fullName");
                String password = rs.getString("password");
                String roleID = rs.getString("roleID");
                boolean status = rs.getBoolean("status");

                user = new UserDTO(userID, password, fullName, roleID, status);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return user;
    }

    /**
     * CREATE - Insert new user
     */
    public boolean insertUser(UserDTO user) {
        String sql = "INSERT INTO tblUsers (userID, fullName, password, roleID, status) VALUES (?, ?, ?, ?, ?)";

        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, user.getUserID());
            ps.setString(2, user.getFullName());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRoleID());
            ps.setBoolean(5, user.isStatus());

            int result = ps.executeUpdate();
            return result > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<UserDTO> getAllUsers() {
        List<UserDTO> userList = new ArrayList<>();
        String sql = "SELECT userID, fullName, password, roleID, status FROM tblUsers ORDER BY userID";
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserDTO user = new UserDTO();
                user.setUserID(rs.getString("userID"));
                user.setFullName(rs.getString("fullName"));
                user.setPassword(rs.getString("password"));
                user.setRoleID(rs.getString("roleID"));
                user.setStatus(rs.getBoolean("status"));
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }

    /**
     * READ - Get active users only
     */
    public List<UserDTO> getActiveUsers() {
        List<UserDTO> userList = new ArrayList<>();
        String sql = "SELECT userID, fullName, password, roleID, status FROM tblUsers WHERE status = 1 ORDER BY userID";
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserDTO user = new UserDTO();
                user.setUserID(rs.getString("userID"));
                user.setFullName(rs.getString("fullName"));
                user.setPassword(rs.getString("password"));
                user.setRoleID(rs.getString("roleID"));
                user.setStatus(rs.getBoolean("status"));
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }

    /**
     * UPDATE - Update user information
     */
    public boolean updateUser(UserDTO user) {
        String sql = "UPDATE tblUsers SET fullName = ?, roleID = ?, status = ? WHERE userID = ?";
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getRoleID());
            ps.setBoolean(3, user.isStatus());
            ps.setString(4, user.getUserID());
            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * UPDATE - Update user password
     */
    public boolean updatePassword(String userID, String newPassword) {
        String sql = "UPDATE tblUsers SET password = ? WHERE userID = ?";
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setString(2, userID);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * DELETE - Delete user by ID
     */
    public boolean deleteUser(String userID) {
        String sql = "DELETE FROM tblUsers WHERE userID = ?";
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userID);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * SOFT DELETE - Deactivate user (set status = false)
     */
    public boolean deactivateUser(String userID) {
        String sql = "UPDATE tblUsers SET status = 0 WHERE userID = ?";
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userID);
            int result = ps.executeUpdate();
            return result > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * AUTHENTICATION - Check login credentials
     */
    public UserDTO checkLogin(String userID, String password) {
        String sql = "SELECT userID, fullName, password, roleID, status FROM tblUsers WHERE userID = ? AND password = ? AND status = 1";
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userID);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                UserDTO user = new UserDTO();
                user.setUserID(rs.getString("userID"));
                user.setFullName(rs.getString("fullName"));
                user.setPassword(rs.getString("password"));
                user.setRoleID(rs.getString("roleID"));
                user.setStatus(rs.getBoolean("status"));
                return user;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * SEARCH - Search users by name
     */
    public List<UserDTO> searchUsersByName(String searchName) {
        List<UserDTO> userList = new ArrayList<>();
        String sql = "SELECT userID, fullName, password, roleID, status FROM tblUsers WHERE fullName LIKE ? ORDER BY fullName";
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + searchName + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserDTO user = new UserDTO();
                user.setUserID(rs.getString("userID"));
                user.setFullName(rs.getString("fullName"));
                user.setPassword(rs.getString("password"));
                user.setRoleID(rs.getString("roleID"));
                user.setStatus(rs.getBoolean("status"));
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }

    /**
     * VALIDATION - Check if userID exists
     */
    public boolean isUserIDExists(String userID) {
        String sql = "SELECT COUNT(*) FROM tblUsers WHERE userID = ?";
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, userID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    /**
     * UTILITY - Get users by role
     */
    public List<UserDTO> getUsersByRole(String roleID) {
        List<UserDTO> userList = new ArrayList<>();
        String sql = "SELECT userID, fullName, password, roleID, status FROM tblUsers WHERE roleID = ? ORDER BY userID";
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, roleID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                UserDTO user = new UserDTO();
                user.setUserID(rs.getString("userID"));
                user.setFullName(rs.getString("fullName"));
                user.setPassword(rs.getString("password"));
                user.setRoleID(rs.getString("roleID"));
                user.setStatus(rs.getBoolean("status"));
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userList;
    }

    /**
     * UTILITY - Count total users
     */
    public int getTotalUsers() {
        String sql = "SELECT COUNT(*) FROM tblUsers";
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    /**
     * UTILITY - Count active users
     */
    public int getActiveUserCount() {
        String sql = "SELECT COUNT(*) FROM tblUsers WHERE status = 1";
        try {
            Connection conn = DbUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
