/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Tech;

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
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Nevets
 */
public class addPathoServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet addPathoServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet addPathoServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String input = request.getParameter("patIDPartial");
        ArrayList<Patient> patList = getPatientList(input);
        new Gson().toJson(patList, response.getWriter());

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String patientId = request.getParameter("pathPatientId");
        String status = addPathologyData(request);
        System.out.println("Yesss - " + patientId);
        request.setAttribute("msg", "Record added");
        RequestDispatcher rd = request.getRequestDispatcher("/Jsp-files/TechStaffPages/pathologyGraph.jsp");
        rd.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

    private String addPathologyData(HttpServletRequest request) {
        DBConnection dbconn = new DBConnection();
        int i = 0;
        String status = "";
        try (Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement("insert into vidur_pathologylab values "
                        + "(?,STR_TO_DATE(?, '%Y-%m-%d'),?,?,?,?,?,?,"
                        + "?,?,?,?,?,?,?,?,"
                        + "?,?,?,?,?,?,?,?,"
                        + "?,?,?,?,?,?,?)");
                psmt.setString(1, request.getParameter("pathPatientId"));
                psmt.setString(2, request.getParameter("pathDate"));
                psmt.setString(3, request.getParameter("pathHB"));
                psmt.setString(4, request.getParameter("pathWBC"));
                psmt.setString(5, request.getParameter("pathPlatelet"));
                psmt.setString(6, request.getParameter("pathBUN"));
                psmt.setString(7, request.getParameter("pathCrea"));
                psmt.setString(8, request.getParameter("pathUric"));
                psmt.setString(9, request.getParameter("pathNa"));
                psmt.setString(10, request.getParameter("pathK"));
                psmt.setString(11, request.getParameter("pathCl"));
                psmt.setString(12, request.getParameter("pathCa"));
                psmt.setString(13, request.getParameter("pathPo4"));
                psmt.setString(14, request.getParameter("pathAlb"));
                psmt.setString(15, request.getParameter("pathPTH"));
                psmt.setString(16, request.getParameter("pathBillrubin"));
                psmt.setString(17, request.getParameter("pathSGOT"));
                psmt.setString(18, request.getParameter("pathSGPT"));
                psmt.setString(19, request.getParameter("pathAlkPo4"));
                psmt.setString(20, request.getParameter("pathChol"));
                psmt.setString(21, request.getParameter("pathTri"));
                psmt.setString(22, request.getParameter("pathSFc"));
                psmt.setString(23, request.getParameter("pathTIBC"));
                psmt.setString(24, request.getParameter("pathTsat"));
                psmt.setString(25, request.getParameter("pathFerr"));
                psmt.setString(26, request.getParameter("pathHBAg"));
                psmt.setString(27, request.getParameter("pathHCV"));
                psmt.setString(28, request.getParameter("pathHIV"));
                psmt.setString(29, request.getParameter("pathCrc"));
                psmt.setString(30, request.getParameter("pathUreo"));
                psmt.setString(31, request.getParameter("pathProt"));
                i += psmt.executeUpdate();
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        if (i == 0) {
            status = "No records updated";
        } else {
            status = i + " no. of records added";
        }
        return status;
    }

    private ArrayList<Patient> getPatientList(String input) {
        DBConnection dbconn = new DBConnection();
        int i = 0;
        ArrayList<Patient> patArr = null;
        try (Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement("select * from vidur_patient where patient_id like '%?%'");
                psmt.setString(1, input);
                ResultSet rs = psmt.executeQuery();
                while (rs.next()) {                    
                    Patient patlist = new Patient();
                    patlist.setPatientId(rs.getString(1));
                    patlist.setPatientName(rs.getString(2));
                    patArr.add(patlist);
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
        }
        return patArr;
    }

}
