package Doctor;

import DBConnection.DBConnection;
import Models.Patient;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Nevets
 */
public class getDataByParamServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String paramNo = request.getParameter("params");
        switch (paramNo) {
            case "1":
                String dateFrom = request.getParameter("fromDate");
                String dateTo = request.getParameter("toDate");
                List<Patient> patient1 = getPatientbyDate(dateTo, dateFrom);
                new Gson().toJson(patient1, response.getWriter());
                break;
            case "2":
                String preCondn = request.getParameter("preCondn");
                String postCondn = request.getParameter("postCondn");
                List<Patient> patient2 = getPatientbyCondn(preCondn, postCondn);
                new Gson().toJson(patient2, response.getWriter());
                break;
            case "3":
                String uhbLevel = request.getParameter("uhblevel");
                String lhbLevel = request.getParameter("lhblevel");
                List<Patient> patient3 = getPatientbyHBlvl(uhbLevel, lhbLevel);
                new Gson().toJson(patient3, response.getWriter());
                break;
            default:
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private List<Patient> getPatientbyDate(String dateTo, String dateFrom) {
        DBConnection dbconn = new DBConnection();
        ArrayList<Patient> patList = new ArrayList<>();
        try (
                Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement("Select patient_id, name, access_point, FIRST_SESSION, UPDATED_BY, UPDATED_DATE from VIDUR_PATIENT "
                        + "Where updated_date between STR_TO_DATE(?, '%Y-%m-%d') and STR_TO_DATE(?, '%Y-%m-%d')");
                psmt.setString(1, dateFrom);
                psmt.setString(2, dateTo);
                ResultSet rs = psmt.executeQuery();
                if (rs.next()) {
                    Patient pat = new Patient();
                    pat.setPatientId(rs.getString(1));
                    pat.setPatientName(rs.getString(2));
                    pat.setAccessPoint(rs.getString(3));
                    pat.setFisrt_Session(rs.getString(4));
                    pat.setUpdated_date(rs.getString(5));
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

    private List<Patient> getPatientbyCondn(String preCondn, String postCondn) {
        DBConnection dbconn = new DBConnection();
        ArrayList<Patient> patList = new ArrayList<>();
        try (
                Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement("select p.patient_id, p.name, p.access_point, p.first_session, p.updated_date from vidur_patient p inner join vidur_dialysis_session s on p.patient_id = s.patient_id where pre_diag_patient_condition like '%?%' and post_diag_patient_condition like '%?%'");
                psmt.setString(1, preCondn);
                psmt.setString(2, postCondn);
                ResultSet rs = psmt.executeQuery();
                if (rs.next()) {
                    Patient pat = new Patient();
                    pat.setPatientId(rs.getString(1));
                    pat.setPatientName(rs.getString(2));
                    pat.setAccessPoint(rs.getString(3));
                    pat.setFisrt_Session(rs.getString(4));
                    pat.setUpdated_date(rs.getString(5));
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

    private List<Patient> getPatientbyHBlvl(String uhbLevel, String lhbLevel) {
        DBConnection dbconn = new DBConnection();
        ArrayList<Patient> patList = new ArrayList<>();
        try (
                Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement("Select patient_id, name, access_point, FIRST_SESSION, UPDATED_BY, UPDATED_DATE from VIDUR_PATIENT");
                psmt.setString(1, uhbLevel);
                psmt.setString(2, lhbLevel);
                ResultSet rs = psmt.executeQuery();
                if (rs.next()) {
                    Patient pat = new Patient();
                    pat.setPatientId(rs.getString(1));
                    pat.setPatientName(rs.getString(2));
                    pat.setAccessPoint(rs.getString(3));
                    pat.setFisrt_Session(rs.getString(4));
                    pat.setUpdated_date(rs.getString(5));
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
