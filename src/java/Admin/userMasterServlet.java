/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Admin;

import DBConnection.DBConnection;
import Models.Patient;
import Models.Users;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Nevets
 */
public class userMasterServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ArrayList<Users> userList = new ArrayList<>();
        userList = getUserList();
        new Gson().toJson(userList, response.getWriter());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String result = "";
        HttpSession sess = request.getSession();
        Users user = new Users();
        switch (request.getParameter("action")) {
            case "switchUser":
                String toRole = (String) request.getParameter("toRole");
                if (!sess.getAttribute("tempChange").equals("-")) {
                    if ("AC".equals(toRole)) {
                        sess.setAttribute("role", "AC");
                        sess.setAttribute("tempChange", "AC");
                    } else if ("TECH".equals(toRole)) {
                        sess.setAttribute("role", "TECH");
                        sess.setAttribute("tempChange", "TECH");
                    } else if ("DOC".equals(toRole)) {
                        sess.setAttribute("role", "DOCTOR");
                        sess.setAttribute("tempChange", "DOCTOR");
                    } else if ("ADMIN".equals(toRole)) {
                        sess.setAttribute("role", "ADMIN");
                        sess.setAttribute("tempChange", "ADMIN");
                    }
                    new Gson().toJson("Role Changed", response.getWriter());
                } else {
                    new Gson().toJson("Only Admin user is allowed to switch the role", response.getWriter());
                }
                break;
            case "Add":
                user.setUname(request.getParameter("userName"));
                user.setUpassword(request.getParameter("userPwd"));
                user.setUrole(request.getParameter("userRole"));
                user.setLocation(request.getParameter("userLoc"));
                result = addUsers(user);
                new Gson().toJson(result, response.getWriter());
                break;
            case "Update":
                user.setUid(request.getParameter("uid"));
                user.setUname(request.getParameter("userName"));
                user.setUpassword(request.getParameter("userPwd"));
                user.setUrole(request.getParameter("userRole"));
                user.setLocation(request.getParameter("userLoc"));
                result = updateUsers(user);
                new Gson().toJson(result, response.getWriter());
                break;
            case "Delete":
                user.setUid(request.getParameter("userId"));
                result = deleteUsers(user);
                new Gson().toJson(result, response.getWriter());
                break;
            default:
                new Gson().toJson("No such request available", response.getWriter());
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

    private String addUsers(Users user) {
        String result = "";
        DBConnection dbconn = new DBConnection();
        try (Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement("Insert into vidur_users values ((select COALESCE(MAX(u.USER_ID)+1,101) from vidur_users u),?,?,'SYSTEM',SYSDATE(),?,?)");
                psmt.setString(1, user.getUname());
                psmt.setString(2, user.getUrole());
                psmt.setString(3, user.getUpassword());
                psmt.setString(4, user.getLocation());
                int i = psmt.executeUpdate();
                if (i == 1) {
                    result = "New User Added Successfully";
                } else {
                    result = "Failed to Insert";
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }

    private String updateUsers(Users user) {
        String result = "";
        DBConnection dbconn = new DBConnection();
        try (Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement("Update vidur_users SET user_name = ?, password = ?, role = ?, location = ?, updated_by = 'SYSTEM', updated_date = SYSDATE() where user_id = ? ");
                psmt.setString(1, user.getUname());
                psmt.setString(2, user.getUpassword());
                psmt.setString(3, user.getUrole());
                psmt.setString(4, user.getLocation());
                psmt.setString(5, user.getUid());
                int i = psmt.executeUpdate();
                if (i == 1) {
                    result = "User " + user.getUname() + " Updated Successfully";
                } else {
                    result = "Failed to Update " + user.getUname();
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }

    private String deleteUsers(Users user) {
        String result = "";
        DBConnection dbconn = new DBConnection();
        try (Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement("Delete from vidur_users where user_id = ?");
                psmt.setString(1, user.getUid());
                int i = psmt.executeUpdate();
                if (i == 1) {
                    result = "User Deleted Successfully";
                } else {
                    result = "Failed to Delete";
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }

    private ArrayList<Users> getUserList() {
        ArrayList<Users> userList = new ArrayList<>();
        DBConnection dbconn = new DBConnection();
        try (Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement("SELECT USER_ID, USER_NAME, ROLE, LOCATION, PASSWORD, UPDATED_DATE FROM vidur_users");
                ResultSet rs = psmt.executeQuery();
                while (rs.next()) {
                    Users user = new Users();
                    user.setUid(rs.getString(1));
                    user.setUname(rs.getString(2));
                    user.setUrole(rs.getString(3));
                    user.setLocation(rs.getString(4));
                    user.setUpassword(rs.getString(5));
                    user.setUpdatedDate(rs.getString(6));
                    userList.add(user);
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return userList;
    }

}
