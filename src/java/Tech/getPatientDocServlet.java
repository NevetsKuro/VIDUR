/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Tech;

import DBConnection.DBConnection;
import Models.FileDetails;
import Models.Patient;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Nevets
 */
public class getPatientDocServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    public static int BUFFER_SIZE = 1024 * 100;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet getPatientDocServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet getPatientDocServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("patId");
        DBConnection dbconn = new DBConnection();
        Connection conn = dbconn.createConnection();
        Patient p = fetchPatientData(conn, id);
        new Gson().toJson(p, response.getWriter());
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("pat_id");
        DBConnection dbconn = new DBConnection();
        Connection conn = dbconn.createConnection();
        ArrayList<FileDetails> fd = fetchDocData(conn, id);
        new Gson().toJson(fd, response.getWriter());
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("file_Id");

        DBConnection dbconn = new DBConnection();
        Connection conn = dbconn.createConnection();
        try {
            PreparedStatement psmt = conn.prepareStatement("select file_name, file_uploaded, file_ctype from vidur_patient_doc where file_id = ?");
            psmt.setString(1, id);
            ResultSet rs = psmt.executeQuery();
            if (rs.next()) {
                Blob blob = rs.getBlob(2);
                ServletOutputStream out;
                try (InputStream is = blob.getBinaryStream()) {
                    byte[] buffer = new byte[BUFFER_SIZE];
                    int bytesRead = -1;
                    out = resp.getOutputStream();
                    String mimetype = "application/x-download";
                    mimetype = rs.getString(3);
                    while ((bytesRead = is.read(buffer)) != -1) {
                        out.write(buffer, 0, bytesRead);
                    }
                    is.close();
                    resp.addHeader("Content-Disposition", "attachment; filename=" + rs.getString(1));
                    resp.setHeader("Content-Length", Integer.toString(buffer.length));
                    resp.setContentType(mimetype);
                }
                out.flush();
                out.close();
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    private Patient fetchPatientData(Connection conn, String id) {
        Patient p = new Patient();
        try {
            PreparedStatement psmt = conn.prepareStatement("Select name, age, access_point, first_session from vidur_patient where patient_id = ?");
            psmt.setString(1, id);
            ResultSet rs = psmt.executeQuery();
            if (rs.next()) {
                p.setPatientName(rs.getString(1));
                p.setBirthdate(rs.getString(2));
                p.setAccessPoint(rs.getString(3));
                p.setFisrt_Session(rs.getString(4));
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return p;
    }

    private ArrayList<FileDetails> fetchDocData(Connection conn, String id) {
        ArrayList<FileDetails> fd = new ArrayList<>();
        try {
            PreparedStatement psmt = conn.prepareStatement("select file_id, file_name, file_type, updated_by, updated_date from VIDUR_PATIENT_DOC where patient_id = ?");
            psmt.setString(1, id);
            ResultSet rs = psmt.executeQuery();
            while (rs.next()) {
                FileDetails f = new FileDetails();
                f.setFileId(rs.getString(1));
                f.setFileName(rs.getString(2));
                f.setFileType(rs.getString(3));
                f.setUploadedBy(rs.getString(4));
                f.setUploadTime(rs.getString(5));
                fd.add(f);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return fd;
    }
}
