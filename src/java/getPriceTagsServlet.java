/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import DBConnection.DBConnection;
import Models.Patient;
import Models.PharmacyBill;
import com.google.gson.Gson;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
public class getPriceTagsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sess = request.getSession();
        String locs = (String)sess.getAttribute("locs");
        switch (request.getParameter("for")) {
            case "1":
                List<PharmacyBill> itemList = new ArrayList<>();
                itemList = getItemPriceList();
                break;
            case "2":
                List<Patient> patList = new ArrayList<>();
                patList = getPatientList(locs);
                new Gson().toJson(patList, response.getWriter());
                break;
            case "3":
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private List<PharmacyBill> getItemPriceList() {
        DBConnection dbconn = new DBConnection();
        List<PharmacyBill> listPrice = new ArrayList<>();
        try (Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement("select * from vidur_price");
                ResultSet rs = psmt.executeQuery();
                while (rs.next()) {
                    PharmacyBill pb = new PharmacyBill();
                    pb.setItemName(rs.getString(1));
                    pb.setPrice(rs.getInt(2));
                    listPrice.add(pb);
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return listPrice;
    }

    private List<Patient> getPatientList(String locs) {
        DBConnection dbconn = new DBConnection();
        List<Patient> patList = new ArrayList<>();
        try (Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement("SELECT PATIENT_ID, NAME, AGE FROM vidur_patient where patient_location =?");
                psmt.setString(1, locs);
                ResultSet rs = psmt.executeQuery();
                while (rs.next()) {
                    Patient pat = new Patient();
                    pat.setPatientId(rs.getString(1));
                    pat.setPatientName(rs.getString(2));
                    pat.setBirthdate(rs.getString(3));
                    patList.add(pat);
                }

            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
            System.out.println("");
        }
        return patList;
    }

}
