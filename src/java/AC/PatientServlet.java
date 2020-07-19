/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AC;

import DBConnection.DBConnection;
import Models.Patient;
import Models.Patient_contacts;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Nevets
 */
public class PatientServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet PatientServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PatientServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String task = (String) request.getParameter("task");
        HttpSession sess = request.getSession();
        String locs = (String) sess.getAttribute("locs");
        switch (task) {
            case "fetchAll":

                ArrayList<Patient> patList = fetchEveryPatient(locs);
                new Gson().toJson(patList, response.getWriter());
                break;
            case "fetchById":
                String patid = request.getParameter("patID");
                Patient patient = fetchPatientName(patid, locs);
                new Gson().toJson(patient, response.getWriter());
                break;
            case "fetchByDate":
                String fromDate = request.getParameter("fromDate");
                String toDate = request.getParameter("toDate");
                ArrayList<Patient> patientList = fetchPatientByDate(fromDate, toDate, locs);
                new Gson().toJson(patientList, response.getWriter());
                break;
            default:
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        System.out.println("POST POST");
        String patient = (String) request.getParameter("data");
        Gson gson = new Gson();
        Type listType = new TypeToken<List<Patient>>() {
        }.getType();

        List<Patient> prodList = gson.fromJson(patient, listType);
        DBConnection dbconn = new DBConnection();
        Connection conn = dbconn.createConnection();
        String patId = AddPatient(conn, prodList);
        if (!patId.equals("")) {
            response.getWriter().write(gson.toJson("Patient Successfully generated with Patient ID : " + patId));
        } else if (patId.equals("0000")) {
            response.getWriter().write(gson.toJson("Patient Record already exist"));
        } else if (patId.equals("XXXX")) {
            response.getWriter().write(gson.toJson("Patient Failed to add Record"));
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

    private String AddPatient(Connection conn, List<Patient> prodList) {
        String result = "XXXX";
        for (Patient p : prodList) {
            String trunc = p.getPatientId().substring(0, p.getPatientId().length() - 1);
            try {
                int count = 0;
                PreparedStatement pst1 = conn.prepareStatement("SELECT count(*) from vidur_patient where patient_id like ?");
                pst1.setString(1, "%" + trunc + "%");
                ResultSet rst1 = pst1.executeQuery();
                if (rst1.next()) {
                    count = rst1.getInt(1);
                };
                if (count < 0) {
                    trunc = p.getPatientId();
                } else {
                    count = count + 1;
                    trunc = trunc + String.valueOf(count);
                }
                try {
//                PreparedStatement psmt = conn.prepareStatement("insert into vidur_patient "
//                        + "values (?,?,?,?,?,?,?,?,to_date(?,'yyyy-mm-dd'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,null)");
                    PreparedStatement psmt = conn.prepareStatement("insert into vidur_patient "
                            + "values (?,?,?,STR_TO_DATE(?, '%Y-%m-%d'),?,?,?,?,"
                            + "STR_TO_DATE(?, '%Y-%m-%d'),"
                            + "?,?,?,?,?,?,?,?,"
                            + "?,?,?,?,?,?,null,?,SYSDATE(),?,?)");
                    psmt.setString(1, p.getPatientName());
                    psmt.setString(2, p.getAccessPoint());
                    psmt.setString(3, p.getGender());
//                    psmt.setInt(4, Integer.parseInt(p.getAge()));
                    psmt.setString(4, p.getBirthdate());
                    psmt.setInt(5, Integer.parseInt(p.getPINCODE()));
                    psmt.setString(6, p.getAddress());
                    psmt.setString(7, p.getBlood_Group());
                    psmt.setString(8, p.getReferring_Nephrologist());
                    psmt.setString(9, (p.getFisrt_Session().contains("-") ? p.getFisrt_Session() : "2000-12-12"));
                    psmt.setInt(10, Integer.parseInt(p.getNo_of_Dialysis()));
                    psmt.setString(11, p.getAwaiting_Transplant());
                    psmt.setString(12, p.getCKD_5D());
                    psmt.setString(13, p.getSU_Decision());
                    psmt.setString(14, p.getHeart_Fun());
                    psmt.setString(15, p.getInjection_Frac());
                    psmt.setString(16, p.getBP_Stable());
                    psmt.setString(17, p.getLiver_Fun());
                    psmt.setString(18, p.getType_of_Diet());
                    psmt.setString(19, p.getIni_Ano());
                    psmt.setString(20, p.getIni_Vom());
                    psmt.setString(21, p.getIni_Nau());
                    psmt.setString(22, p.getIni_Dia());
                    psmt.setString(23, trunc);
                    psmt.setString(24, "SYSTEM");
                    psmt.setInt(25, p.getPatient_rotations());
                    psmt.setString(26, p.getLocation());
                    int i = psmt.executeUpdate();
                    if (i > 0) {
                        result = trunc;
                        try {
                            PreparedStatement pst2 = conn.prepareStatement("insert into vidur_patient_contacts values"
                                    + "(?,?,?)");
                            for (Patient_contacts cons : p.getArrPatCont()) {
                                pst2.setString(1, trunc);
                                pst2.setString(2, cons.getContact_type());
                                pst2.setString(3, cons.getContactNumber());
                                pst2.executeUpdate();
                            }
                        } catch (Exception e) {
                            System.out.println(e);
                            result = "XXXX";
                        }
                    }
                } catch (Exception e) {
                    System.out.println(e);
                    result = "XXXX";
                    if (e.getMessage().contains("unique")) {
                        result = "0000";
                    }
                }

            } catch (Exception e) {
                System.out.println(e);
                result = "XXXX";
            }
        }
        return result;
    }

    private ArrayList<Patient> fetchEveryPatient(String locs) {

        ArrayList<Patient> patList = new ArrayList<>();
        DBConnection dbconn = new DBConnection();
        try (Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement("SELECT patient_id, name, gender, age, access_point, refer_nephro, patient_location, updated_date FROM vidur_patient where patient_location = ?");
                psmt.setString(1, locs);
                ResultSet rs = psmt.executeQuery();
                //SELECT patient_id, name, gender,age,access_point,address, REFER_NEPHRO 
                while (rs.next()) {
                    Patient pat = new Patient();
                    pat.setPatientId(rs.getString(1));
                    pat.setPatientName(rs.getString(2));
                    pat.setGender(rs.getString(3));
                    pat.setBirthdate(rs.getString(4));
                    pat.setAccessPoint(rs.getString(5));
                    pat.setReferring_Nephrologist(rs.getString(6));
                    pat.setLocation(rs.getString(7));
                    pat.setUpdated_date(rs.getString(8));
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

    private Patient fetchPatientName(String patid, String locs) {
        DBConnection dbconn = new DBConnection();
        Patient pat = new Patient();
        try (
                Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement("Select patient_id, name from vidur_patient where patient_id = ? AND patient_location = ?");
                psmt.setString(1, patid);
                psmt.setString(2, locs);
                ResultSet rs = psmt.executeQuery();
                if (rs.next()) {
                    pat.setPatientId(rs.getString(1));
                    pat.setPatientName(rs.getString(2));
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return pat;
    }

    private ArrayList<Patient> fetchPatientByDate(String fromDate, String toDate, String locs) {
        DBConnection dbconn = new DBConnection();
        ArrayList<Patient> patList = new ArrayList<>();
        try (
                Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement("Select patient_id, name, gender, age, access_point, refer_nephro, updated_by, updated_date from vidur_patient "
                        + " where updated_date between STR_TO_DATE(?, '%Y-%m-%d')  and STR_TO_DATE(?, '%Y-%m-%d') AND patient_location = ?");
                psmt.setString(1, fromDate);
                psmt.setString(2, toDate);
                psmt.setString(3, locs);
                ResultSet rs = psmt.executeQuery();
                while (rs.next()) {
                    Patient pat = new Patient();
                    pat.setPatientId(rs.getString(1));
                    pat.setPatientName(rs.getString(2));
                    pat.setGender(rs.getString(3));
                    pat.setBirthdate(rs.getString(4));
                    pat.setAccessPoint(rs.getString(5));
                    pat.setReferring_Nephrologist(rs.getString(6));
                    pat.setUpdated_by(rs.getString(7));
                    pat.setUpdated_date(rs.getString(8));
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
}
