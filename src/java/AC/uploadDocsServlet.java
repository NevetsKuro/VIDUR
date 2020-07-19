/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package AC;

import DBConnection.DBConnection;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author Nevets
 */
@MultipartConfig
public class uploadDocsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //
        System.out.println("GET FUNC uploadDocsServlet");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("POST FUNC uploadDocsServlet");
        String[] strArr = new String[3];
        String patientId = request.getParameter("patientDocId");
        Part file1 = request.getPart("patientDocImage");
        Part file2 = request.getPart("patientDocFile");
        String str = file1.getSubmittedFileName();
        if (str.contains(".png")) {
            strArr[0] = AddPatientImage(patientId, file1);
        }
        if (file2.getSize() > 0) {
            strArr[1] = AddPatientDoc(patientId, file2);
        }
        request.setAttribute("str1", strArr[0]);
        request.setAttribute("str2", strArr[1]);
        RequestDispatcher rd = request.getRequestDispatcher("/Jsp-files/ACPages/ACUploader.jsp");
        rd.forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

    private String AddPatientImage(String patientId, Part file1) {
        String status = "processing..";
        DBConnection dbconn = new DBConnection();
        try (Connection conn = dbconn.createConnection();
                InputStream is = file1.getInputStream();) {
            PreparedStatement psmt = conn.prepareStatement("select * from vidur_patient_doc where l̥ = ?");
            psmt.setString(1, patientId);
            ResultSet rs = psmt.executeQuery();
            if (rs.next()) {
                PreparedStatement psmtU = conn.prepareStatement("UPDATE vidur_patient_doc SET FILE_UPLOADED = ?,FILE_NAME = ?, "
                        + "FILE_TYPE = ?,FILE_CTYPE = ? ,UPDATED_BY = ?,UPDATED_DATE = SYSDATE() where PATIENT_ID = ? and FILE_TYPE = 'IM'");
                psmtU.setBinaryStream(1, is, is.available());
                psmtU.setString(2, file1.getName());
                psmtU.setString(3, "IM");
                psmtU.setString(4, file1.getContentType());
                psmtU.setString(5, "SYSTEM");
                psmtU.setString(6, patientId);
                int i = psmtU.executeUpdate();
                if (i > 0) {
                    status = "Updated Image with patient Id : " + patientId;
                } else {
                    status = "Something went wrong..";
                }
            } else {
                PreparedStatement psmtI = conn.prepareStatement("insert into vidur_patient_doc values (?,?,?,?,?,SYSDATE(),(select MAX(X.FILE_ID)+1 from (Select * from VIDUR_PATIENT_DOC) X),?)");
                psmtI.setString(1, patientId);
                psmtI.setBinaryStream(2, is, is.available());
                psmtI.setString(3, file1.getSubmittedFileName());
                psmtI.setString(4, "IM");
                psmtI.setString(5, "SYSTEM");
                psmtI.setString(6, file1.getContentType());
                int i = psmtI.executeUpdate();
                if (i > 0) {
                    status = "Successfully uploaded new image";
                } else {
                    status = "Something went wrong..";
                }
                status = "Add new Image for patient Id :" + patientId;
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

    private String AddPatientDoc(String patientId, Part file2) {
        String status = "";
        DBConnection dbconn = new DBConnection();
        Part file1 = file2;
        try (Connection conn = dbconn.createConnection();
                InputStream is = file2.getInputStream();) {
            PreparedStatement psmt = conn.prepareStatement("Insert into vidur_patient_doc values (?,?,?,?,?,SYSDATE(),(select COALESCE(MAX(V.FILE_ID),1000)+1 from (Select * from VIDUR_PATIENT_DOC) V),?)");
            psmt.setString(1, patientId);
            psmt.setBinaryStream(2, is, is.available());
            psmt.setString(3, file2.getSubmittedFileName());
            psmt.setString(4, "OD");
            psmt.setString(5, "SYSTEM");
            psmt.setString(6, file2.getContentType());
            int i = psmt.executeUpdate();
            if (i > 0) {
                status = "Successfully uploaded new document against patient";
            } else {
                status = "Something went wrong..";
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return status;
    }

}
