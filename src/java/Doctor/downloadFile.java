/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Doctor;

import DBConnection.DBConnection;
import static Doctor.getPatientDataServlet.BUFFER_SIZE;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Nevets
 */
public class downloadFile extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet downloadFile</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet downloadFile at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("file_Id");
        String mimetype = "application/x-download";

        DBConnection dbconn = new DBConnection();
        Connection conn = dbconn.createConnection();
        try {
            PreparedStatement psmt = conn.prepareStatement("select file_name, file_uploaded, file_ctype from vidur_patient_doc where file_id = ?");
            psmt.setString(1, id);
            ResultSet rs = psmt.executeQuery();
            if (rs.next()) {
                response.addHeader("Content-Disposition", "attachment; filename=" + rs.getString(1));
                mimetype = rs.getString(3);
                Blob blob = rs.getBlob(2);
                ServletOutputStream out;
                try (InputStream is = blob.getBinaryStream()) {
                    byte[] buffer = new byte[BUFFER_SIZE];
                    int bytesRead = -1;
                    out = response.getOutputStream();
                    while ((bytesRead = is.read(buffer)) != -1) {
                        out.write(buffer, 0, bytesRead);
                    }
                    response.setHeader("Content-Length", Integer.toString(buffer.length));
                    response.setContentType(mimetype);
                    is.close();
                }
                out.flush();
                out.close();
            }
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
