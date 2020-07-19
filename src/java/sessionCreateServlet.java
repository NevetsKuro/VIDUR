/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import DBConnection.DBConnection;
import Models.Commons;
import Models.PharmacyBill;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import static jdk.nashorn.internal.runtime.Debug.id;

/**
 *
 * @author Nevets
 */
public class sessionCreateServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<title>Servlet sessionCreateServlet</title>");

        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sess = request.getSession();
        String roleChange = request.getParameter("roles");
        if (roleChange != null) {
            if (roleChange.equals("TECH")) {
                sess.setAttribute("role", "TECH");
                System.out.println("role changed to TECH");
            } else if (roleChange.equals("AC")) {
                sess.setAttribute("role", "AC");
                System.out.println("role changed to AC");
            }
        }
        RequestDispatcher rd = request.getRequestDispatcher("/Jsp-files/Front/dashboardPage.jsp");
        rd.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sess = request.getSession();
        String name = request.getParameter("loginName").toLowerCase();
        sess.setAttribute("sessname", name);
        String pwd = request.getParameter("loginPwd").toLowerCase();
        String joinStr = getRoleByName(name, pwd);
        String role = "", locs = "";
        if (!"".equals(joinStr)) {
            role = joinStr.split("-")[0];
            locs = joinStr.split("-")[1];
        }
        Commons comms = getFieldDefaultValues();
//        HashMap<String, String> hm = getPharmFieldDefaultValues();
        sess.setAttribute("TechCommons", comms.getTechnicians());
        sess.setAttribute("DrugsCommons", comms.getDurgs());
        sess.setAttribute("MachCommons", comms.getMachineIds());
        if (role.equals("ADMIN") && sess.getAttribute("tempChange")!=null) {
            role = (String) sess.getAttribute("tempChange");
        } else {
            sess.setAttribute("tempChange", "-");
        }
        switch (role.trim().toLowerCase()) {
            case "admin":
                sess.setAttribute("role", "ADMIN");
                sess.setAttribute("tempChange", "ADMIN");
                break;
            case "ac":
                sess.setAttribute("role", "AC");
                sess.setAttribute("locs", locs);

                break;
            case "tech":
                sess.setAttribute("role", "TECH");
                sess.setAttribute("locs", locs);

                break;
            case "doctor":
                sess.setAttribute("role", "DOCTOR");
                sess.setAttribute("locs", locs);

                break;
            default:
                sess.setAttribute("role", "NONE");
        }
        RequestDispatcher rd = null;
        if ((String) sess.getAttribute("role") == "NONE") {
            try (PrintWriter out = response.getWriter()) {
                out.println("<html><body><h2><strong>No User exist as such</strong><br><a href='/VIDUR/index.jsp'>Go Back</a><body></html>");
            }
        } else {
            rd = request.getRequestDispatcher("/Jsp-files/Front/dashboardPage.jsp");
        }
        rd.forward(request, response);
    }

    private Commons getFieldDefaultValues() {
        Commons com = new Commons();
        DBConnection dbconn = new DBConnection();
        try (Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement("Select * from vidur_control_table");
                ResultSet rs = psmt.executeQuery();
                while (rs.next()) {
                    String field = rs.getString(1);
                    String tmp = "";
                    switch (field) {
                        case "Techinician":
                            tmp = rs.getString(2);
                            List<String> technicians = convertToArray(tmp);
                            com.setTechnicians(technicians);
                            break;
                        case "Drugs_Given":
                            tmp = rs.getString(2);
                            List<String> drugs = convertToArray(tmp);
                            com.setDurgs(drugs);
                            break;
                        case "Machine_ID":
                            tmp = rs.getString(2);
                            List<String> mach = convertToArray(tmp);
                            com.setMachineIds(mach);
                            break;
                    }
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return com;
    }

    private List<String> convertToArray(String tmp) {
        List<String> str = new ArrayList<>();
        for (String s : tmp.split(",")) {
            str.add(s);
        }
        return str;
    }

    private String getRoleByName(String trim, String pwd) {
        DBConnection dbconn = new DBConnection();
        String result = "";
        try (Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement("select ROLE, LOCATION from vidur_users where user_name = ? AND password = ?");
                psmt.setString(1, trim);
                psmt.setString(2, pwd);
                ResultSet rs = psmt.executeQuery();
                while (rs.next()) {
                    result = rs.getString(1);
                    result = result + "-" + rs.getString(2);
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }

//    private HashMap<String, String> getPharmFieldDefaultValues() {
//        DBConnection dbconn = new DBConnection();
//        HashMap<String, String> hm = new HashMap<>();
//        try (Connection conn = dbconn.createConnection();) {
//            try {
//                PreparedStatement psmt = conn.prepareStatement("select ROLE, LOCATION from vidur_users ");
//                
//                ResultSet rs = psmt.executeQuery();
//                while (rs.next()) {
//                    hm.put("IS1", rs.getString(1));
//                    hm.put("IS2", rs.getString(2));
//                    hm.put("IS3", rs.getString(3));
//                }
//            } catch (Exception e) {
//                System.out.println(e);
//            }
//        } catch (Exception e) {
//            System.out.println(e);
//        }
//        return hm;
//    }
}
