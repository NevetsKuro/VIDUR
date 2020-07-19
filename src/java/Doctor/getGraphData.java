/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Doctor;

import DBConnection.DBConnection;
import Models.DialysisSession;
import Models.PathologyLab;
import Models.Patient;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Nevets
 */
public class getGraphData extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet getGraphData</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet getGraphData at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String caseFor = request.getParameter("caseFor");

        switch (caseFor) {
            case "1":
                String patId = request.getParameter("patId");
                String subCase = request.getParameter("subCase");
                if (subCase.equals("1")) {
                    List<PathologyLab> pLab = getPatientHBData(patId);
                    new Gson().toJson(pLab, response.getWriter());
                } else if(subCase.equals("2")) {
                    List<DialysisSession> dial = getPatientDrugUse(patId);
                    new Gson().toJson(dial, response.getWriter());
                }
                break;
            case "2":
                String patId1 = request.getParameter("patId");
                List<HashMap<String,String>> patCondn = getPatientCondition(patId1);
                new Gson().toJson(patCondn, response.getWriter());
                break;
            case "3":
                String patId2 = request.getParameter("patId");
                List<DialysisSession> dial2 = getPatientSessTime(patId2);
                new Gson().toJson(dial2, response.getWriter());

                break;
            default:
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

    private List<DialysisSession> getPatientDrugUse(String patId) {
        DBConnection dbconn = new DBConnection();
        List<DialysisSession> patList = new ArrayList<>();
        try (Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement("Select dur_diag_drugs,updated_date from vidur_dialysis_session where patient_id = ?");
                psmt.setString(1, patId);
                ResultSet rs = psmt.executeQuery();
                while (rs.next()) {
                    DialysisSession pat = new DialysisSession();
                    pat.setDrugs_given(rs.getString(1));
                    pat.setDate(rs.getString(2));
                    patList.add(pat);
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return patList;
    }

    private List<DialysisSession> getPatientSessTime(String patId) {
        DBConnection dbconn = new DBConnection();
        List<DialysisSession> patList = new ArrayList<>();
        try (Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement("select updated_date, START_TIME, END_TIME from vidur_dialysis_session where patient_id = ?");
                psmt.setString(1, patId);
                ResultSet rs = psmt.executeQuery();
                while (rs.next()) {
                    DialysisSession pat = new DialysisSession();
                    pat.setDate(rs.getString(1));
                    pat.setPatStart_time(rs.getString(2));
                    pat.setPatEnd_time(rs.getString(3));
                    patList.add(pat);
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return patList;
    }

    private List<HashMap<String,String>> getPatientCondition(String patId) {
        DBConnection dbconn = new DBConnection();
        List<HashMap<String,String>> hmList = new ArrayList<>();
        try (Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement("Select post_diag_patient_condition, updated_date from vidur_dialysis_session where patient_id = ? ");
                psmt.setString(1, patId);
                ResultSet rs = psmt.executeQuery();
                while (rs.next()) {
                    HashMap<String,String> hm = new HashMap<>();
                    hm.put("condn",rs.getString(1));
                    hm.put("date",rs.getString(2));
                    hmList.add(hm);
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return hmList;
    }

    private List<PathologyLab> getPatientHBData(String patId) {
        DBConnection dbconn = new DBConnection();
        List<PathologyLab> pLabList = new ArrayList<>();
        try (Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement("Select patho_hb,Date from vidur_pathologylab where patient_id = ?");
                psmt.setString(1, patId);
                ResultSet rs = psmt.executeQuery();
                while (rs.next()) {
                    PathologyLab pat = new PathologyLab();
                    pat.setPathHB(rs.getString(1));
                    pat.setDate(rs.getString(2));
                    pLabList.add(pat);
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return pLabList;
    }
}
