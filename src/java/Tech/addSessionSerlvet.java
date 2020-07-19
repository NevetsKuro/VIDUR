/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Tech;

import DBConnection.DBConnection;
import Models.Consumable;
import Models.DialysisSession;
import Models.DurDialSess;
import Models.Patient;
import Models.PharmacyBill;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.itextpdf.text.pdf.ArabicLigaturizer;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Nevets
 */
public class addSessionSerlvet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String patId = request.getParameter("patId");
        DBConnection dbconn = new DBConnection();
        Connection conn = dbconn.createConnection();
        Patient pat = fetchPatientData(conn, patId);
        new Gson().toJson(pat, response.getWriter());

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String patientSess = (String) request.getParameter("data");
        Gson gson = new Gson();
        Type listType = new TypeToken<List<DialysisSession>>() {
        }.getType();
        DialysisSession dialsys = new DialysisSession();
        List<DialysisSession> sessList = gson.fromJson(patientSess, listType);
        String result = addSessionData(sessList);
        new Gson().toJson("Success \n" + result, response.getWriter());
    }

    private Patient fetchPatientData(Connection conn, String id) {
        Patient p = new Patient();
        try {
            PreparedStatement psmt = conn.prepareStatement("Select patient_id,name,patient_rotation_sec, access_point, first_session from vidur_patient where patient_id = ?");
            psmt.setString(1, id);
            ResultSet rs = psmt.executeQuery();
            if (rs.next()) {
                p.setPatientId(rs.getString(1));
                p.setPatientName(rs.getString(2));
                p.setPatient_rotations(rs.getInt(3));
                p.setAccessPoint(rs.getString(4));
                p.setFisrt_Session(rs.getString(5));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return p;
    }

    private String addSessionData(List<DialysisSession> sessList) {
        String result = "";
        int sum = 0;
        DBConnection dbconn = new DBConnection();
        DialysisSession dial = sessList.get(0);
        try (Connection conn = dbconn.createConnection();) {
            conn.setAutoCommit(false);
            try {
                PreparedStatement psmtA = conn.prepareStatement("select COALESCE(MAX(SESS_ID)+1,1001) from vidur_dialysis_session where patient_id = ?");
                psmtA.setString(1, dial.getPatientId());
                ResultSet rst = psmtA.executeQuery();
                while (rst.next()) {
                    dial.setSess_id(rst.getString(1));
                }
            } catch (Exception e) {
                System.out.println(e);
            }
            try {
                PreparedStatement psmt = conn.prepareStatement("INSERT into vidur_dialysis_session values ("
                        + "?,?,?,(select name from vidur_patient where patient_id = ?),"
                        + "?,?,?,?,(select refer_nephro from vidur_patient where patient_id = ?),?,"
                        + "?,?,?,?,?,?,?,?,?,?,"
                        + "?,?,?,?,?,?,?,?,?,SYSDATE(),"
                        + "?,?,?,?,?,?,?,?,?,?,?)");
                psmt.setString(1, dial.getPatientId());
                psmt.setString(2, dial.getDiag_id());
                psmt.setString(3, dial.getSess_id());
                psmt.setString(4, dial.getPatientId());
                psmt.setString(5, dial.getArrDurDial().size() > 0 ? "P" : "A");
                psmt.setString(6, dial.getPatStart_time());
                psmt.setString(7, dial.getPatEnd_time());
                psmt.setString(8, dial.getAccess_point());

                psmt.setString(9, dial.getPatientId());
                psmt.setString(10, dial.getOpen_tech());
                psmt.setString(11, dial.getClose_tech());
                psmt.setString(12, dial.getMach_id());
                psmt.setString(13, dial.getPre_site_condn());
                psmt.setString(14, dial.getPre_condn_no_expl());
                psmt.setString(15, String.join(",", dial.getPre_patient_condns()));
                psmt.setString(16, dial.getPre_patientWeight());
                psmt.setString(17, dial.getPre_notes());
                psmt.setString(18, dial.getDrugs_given());
                psmt.setString(19, dial.getDrugs_issues());
                psmt.setString(20, dial.getHepari());
                psmt.setString(21, dial.getUF());
                psmt.setString(22, dial.getPost_site_condn());
                psmt.setString(23, dial.getPost_patientWeight());
                psmt.setString(24, dial.getPost_notes());
                psmt.setString(25, dial.getDischarge());
                psmt.setString(26, dial.getDiet_notes());
                psmt.setString(27, dial.getPost_condn_no_expl());
                psmt.setString(28, String.join(",", dial.getPost_patient_condns()));
                psmt.setString(29, "SYSTEM");
                psmt.setString(30, dial.getTech_reg());
                psmt.setString(31, dial.getTech_thera());
                psmt.setString(32, dial.getTech_dial());
                psmt.setString(33, dial.getTech_othserv());
                psmt.setString(34, dial.getTech_othservamt());
                psmt.setString(35, dial.getBillno());
                psmt.setString(36, dial.getPaid());
                psmt.setInt(37, Integer.parseInt(dial.getSch_emrg()));
                psmt.setInt(38, Integer.parseInt(dial.getEarlyDis()));
                psmt.setString(39, dial.getCentreNo());
                psmt.setInt(40, Integer.parseInt(dial.getBillingNo()));
                if (psmt.executeUpdate() > 0) {

                    sum++;
                    result += "Successfully executed first query" + "\n";
                    //during dialysis
                    try {
                        DurDialSess dur = dial.getArrDurDial().get(0);
                        PreparedStatement psmt1 = conn.prepareStatement("insert into vidur_durdialysis values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,SYSDATE())");
                        psmt1.setString(1, dial.getPatientId());
                        psmt1.setString(2, dial.getSess_id());
                        psmt1.setString(3, dur.getTime());
                        psmt1.setString(4, dur.getBP());
                        psmt1.setString(5, dur.getPulse());
                        psmt1.setString(6, dur.getUf_rate());
                        psmt1.setString(7, dur.getUf_volume());
                        psmt1.setString(8, dur.getBf_rate());
                        psmt1.setString(9, dur.getAp());
                        psmt1.setString(10, dur.getVp());
                        psmt1.setString(11, dur.getTmp());
                        psmt1.setString(12, dur.getKtv());
                        psmt1.setString(13, dur.getCbv());
                        psmt1.setString(14, "SYSTEM");
                        sum += psmt1.executeUpdate();
                        result += "Successfully executed second query" + "\n";
                    } catch (Exception e) {
                        System.out.println(e);
                        result += e.getMessage() + "\n";
                    }
                    //Pharmacy
                    try {
                        for (PharmacyBill pb : dial.getTech_pharm()) {
                            PreparedStatement psmt2 = conn.prepareStatement("insert into vidur_pharmacy_bill values"
                                    + "(?,SYSDATE(),?,?,?,?,"
                                    + "(select item_price from vidur_item_manage where item_name = ?),"
                                    + "(select item_sgst from vidur_item_manage where item_name = ?),"
                                    + "(select item_cgst from vidur_item_manage where item_name = ?),"
                                    + "?,?,?,?,?,?)");
                            psmt2.setString(1, dial.getSess_id());
    //                        psmt2.setDate(2, "SYSDATE()");
                            psmt2.setString(2, pb.getItemName());
                            psmt2.setInt(3, Integer.parseInt(pb.getQty()));
                            psmt2.setString(4, pb.getBill_no());
                            psmt2.setString(5, String.valueOf(pb.getCut()));
                            psmt2.setString(6, pb.getItemName());
                            psmt2.setString(7, pb.getItemName());
                            psmt2.setString(8, pb.getItemName());
                            psmt2.setInt(9, pb.getTotal());
                            psmt2.setInt(10, pb.getFinalTots());
                            psmt2.setString(11, "");
                            psmt2.setInt(12, 0);
                            psmt2.setString(13, "SYSTEM");
                            psmt2.setString(14, dial.getPatientId());
                            sum += psmt2.executeUpdate();
                        }
                        result += "Successfully executed third query" + "\n";
                    } catch (Exception e) {
                        System.out.println(e);
                        result += e.getMessage() + "\n";
                    }
                    //Consumables
                    try {
                        Consumable cons = dial.getTech_consumables().get(0);
                        PreparedStatement psmt3 = conn.prepareStatement("insert into vidur_consumables values"
                                + "( ?,?,?,?,?,?,?,?,?,?,"
                                + "  ?,?,?,?,?,?,?,?,?,?,"
                                + "  ?,?,?,SYSDATE())");
                        double trp = Float.parseFloat(cons.getIV_SET()) * 6.72 + Float.parseFloat(cons.getHeparin_amp()) * 94
                                + Float.parseFloat(cons.getTubing()) * 145.6 + Float.parseFloat(cons.getNS_500()) * 19.04
                                + Float.parseFloat(cons.getNS_1K()) * 31.36 + Float.parseFloat(cons.getOnoff_kit()) * 22.04
                                + Float.parseFloat(cons.getSyringe_10ml()) * 7.28 + Float.parseFloat(cons.getTP()) * 14
                                + Float.parseFloat(cons.getSyringe_20ml()) * 10.75 + Float.parseFloat(cons.getG_needle16())
                                + Float.parseFloat(cons.getG_needle16()) * 33.6 + Float.parseFloat(cons.getG_needle17()) * 33.6
                                + Float.parseFloat(cons.getB_part()) * 103.6 + Float.parseFloat(cons.getBedsheet()) * 6.5;
                        psmt3.setString(1, dial.getPatientId());
                        psmt3.setString(2, dial.getSess_id());
                        psmt3.setString(3, cons.getCategory());
                        psmt3.setDouble(4, Float.parseFloat(cons.getIV_SET()));// * 6.72);
                        psmt3.setDouble(5, Float.parseFloat(cons.getHeparin_amp()));// * 94);
                        psmt3.setDouble(6, Float.parseFloat(cons.getHeparin_ml()));
                        psmt3.setDouble(7, Float.parseFloat(cons.getTubing()));// * 145.6);
                        psmt3.setDouble(8, Float.parseFloat(cons.getNS_500()));// * 19.04);
                        psmt3.setDouble(9, Float.parseFloat(cons.getNS_1K()));// * 31.36);
                        psmt3.setDouble(10, Float.parseFloat(cons.getOnoff_kit()));// * 22.04);
                        psmt3.setDouble(11, Float.parseFloat(cons.getSyringe_10ml()));// * 7.28);
                        psmt3.setDouble(12, Float.parseFloat(cons.getF6()));
                        psmt3.setDouble(13, Float.parseFloat(cons.getTP()));// * 14);
                        psmt3.setDouble(14, Float.parseFloat(cons.getF8()));
                        psmt3.setDouble(15, Float.parseFloat(cons.getSyringe_20ml()));// * 10.75);
                        psmt3.setDouble(16, Float.parseFloat(cons.getG_needle16()));// * 33.6);
                        psmt3.setDouble(17, Float.parseFloat(cons.getG_needle17()));// * 33.6);
                        psmt3.setDouble(18, Float.parseFloat(cons.getA_part()));
                        psmt3.setDouble(19, Float.parseFloat(cons.getB_part()));// * 103.6);
                        psmt3.setDouble(20, Float.parseFloat(cons.getD25()));// * 15.12);
                        psmt3.setDouble(21, Float.parseFloat(cons.getBedsheet()));// * 6.5);
                        psmt3.setDouble(22, trp);
                        psmt3.setString(23, "SYSTEM");
                        sum += psmt3.executeUpdate();
                        result += "Successfully executed fourth query\n";
                    } catch (Exception e) {
                        System.out.println(e);
                        result += e.getMessage() + "\n";
                    }
                    if (sum >= 3) {
                        conn.commit();
                    } else {
                        conn.rollback();
                    }
                }
            } catch (Exception e) {
                System.out.println(e);
                result += e.getMessage() + "\n";
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }
}
