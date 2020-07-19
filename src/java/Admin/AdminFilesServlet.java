/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Admin;

import DBConnection.DBConnection;
import Models.Consumable;
import Models.DialysisSession;
import Models.PharmacyBill;
import com.google.gson.Gson;
import java.io.ByteArrayOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

/**
 *
 * @author Nevets
 */
public class AdminFilesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String fileFor = request.getParameter("fileFor");
        String actions = request.getParameter("actions");

        switch (fileFor) {
            case "Pharmacy":
                List<PharmacyBill> pharm = fetchPharmList(fromDate, toDate, actions);
                convertAndCreateExcelPharm(pharm, response);
                break;
            case "Dialysis":
                List<DialysisSession> dial = fetchDialList(fromDate, toDate, actions);
                convertAndCreateExcelDial(dial, response);
                break;
            case "Consumables":
                List<Consumable> cons = fetchConsList(fromDate, toDate);
                convertAndCreateExcelCons(cons, request, response);
                break;
            case "updateCommon":
                String tech = request.getParameter("tech");
                String drugs = request.getParameter("drugs");
                String mach = request.getParameter("mach");

                String newTech = editString(tech);
                String newDrugs = editString(drugs);
                String newMach = editString(mach);
                String result = addUpdatedValues(newTech, newDrugs, newMach);
                new Gson().toJson(result, response.getWriter());
                break;
            case "updatePrice":
                String item = request.getParameter("Item");
                String price = request.getParameter("Price");
                String SGST = request.getParameter("SGST");
                String CGST = request.getParameter("CGST");

                String result1 = addPriceForItem(item, price, SGST, CGST);
                new Gson().toJson(result1, response.getWriter());
                break;
            default:
                break;

        }
    }

    private void convertAndCreateExcelPharm(List<PharmacyBill> pharm, HttpServletResponse response) throws FileNotFoundException, IOException {
        Workbook workbook = new HSSFWorkbook();

//        OutputStream fileOut = new FileOutputStream("PharmacyReport.xlsx");
        ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
//        FileOutputStream out = new FileOutputStream(new File("Geekz.xlsx")); 
        Sheet sheet1 = workbook.createSheet("Pharmacy Bills");

//        Date	Item	Bill No.	Qty	CUT	Price	SGST	
//              CGST	Total	Final	Who Pays	TRP Credit      
        Map<String, Object[]> data = new TreeMap<String, Object[]>();
        data.put("1", new Object[]{"DATE", "PATIENT NAME", "ITEM NAME", "BILL NO.", "QUANTITY", "CUT",
            "PRICE", "SGST", "CGST", "TOTAL", "FINAL", "WHO PAYS", "TRP CREDIT"});
        int count = 1;
        for (PharmacyBill pb : pharm) {
            count++;
            int tots = pb.getCut() + pb.getPrice() + pb.getSgst() + pb.getCgst();
            int finals = tots * (int) (Float.parseFloat(pb.getQty()));
            data.put(String.valueOf(count), new Object[]{
                pb.getPharm_date(),
                pb.getPatient_name(),
                pb.getItemName(),
                pb.getBill_no(),
                pb.getQty(),
                String.valueOf(pb.getCut()),
                String.valueOf(pb.getPrice()),
                String.valueOf(pb.getSgst()),
                String.valueOf(pb.getCgst()),
                tots,//String.valueOf(pb.getTotal(),
                finals,//String.valueOf(pb.getFinalTots()),
                pb.getWho_pays(),
                String.valueOf(pb.getTrp_credit())
            });
        }

        // Iterate over data and write to sheet 
        Set<String> keyset = data.keySet();
        int rownum = 0;
        for (String key : keyset) {
            // this creates a new row in the sheet 
            Row row = sheet1.createRow(rownum++);
            Object[] objArr = data.get(key);
            int cellnum = 0;
            for (Object obj : objArr) {
                // this line creates a cell in the next column of that row 
                Cell cell = row.createCell(cellnum++);
                if (obj instanceof String) {
                    cell.setCellValue((String) obj);
                } else if (obj instanceof Integer) {
                    cell.setCellValue((Integer) obj);
                }
            }
        }

        // write it as an excel attachment
        workbook.write(outByteStream);
        byte[] outArray = outByteStream.toByteArray();
        response.setContentType("application/ms-excel");
        response.setContentLength(outArray.length);
        response.setHeader("Expires:", "0"); // eliminates browser caching
        response.setHeader("Content-Disposition", "attachment; filename=PharmacyReport.xls");
        OutputStream outStream = response.getOutputStream();
        outStream.write(outArray);
        outStream.flush();
    }

    private void convertAndCreateExcelCons(List<Consumable> cons, HttpServletRequest request, HttpServletResponse response) throws FileNotFoundException, IOException {
        Workbook workbook = new HSSFWorkbook();

//        OutputStream fileOut = new FileOutputStream("ConsumableReport.xlsx");
        ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
//        FileOutputStream out = new FileOutputStream(new File("Geekz.xlsx")); 
        Sheet sheet1 = workbook.createSheet("Consumables Report");

        Map<String, Object[]> data = new TreeMap<String, Object[]>();

        data.put("1", new Object[]{"Sr. no",
            "Date", "Patient ID", "Category", "IV Set", "Heparin in AMP", "Heparin in ML", "Tubing",
            "NS 500", "NS 1K", "ON/OFF KIT", "SYRINGE 10ML", "F6", "TP", "F8", "SYRINGE 20ML",
            "16G Needle", "17G Needle", "A Part", "B Part", "D25%", "Bsheet", "IVSet", "Heparin",
            "Tubing", "NS 500", "NS 1K", "Syringe 10ML", "TP", "Syringe 20ML", "16G Needle",
            "17G Needle", "B Part", "D25%", "Bedsheet"});//headers

        int count = 1;
        for (Consumable cb : cons) {
            Double f1 = Double.parseDouble(cb.getIV_SET()) * Double.parseDouble(request.getParameter("IVSet"));
            Double f2 = Double.parseDouble(cb.getHeparin_amp()) * Double.parseDouble(request.getParameter("Hep"));
            Double f3 = Double.parseDouble(cb.getTubing()) * Double.parseDouble(request.getParameter("Tubing"));
            Double f4 = Double.parseDouble(cb.getNS_500()) * Double.parseDouble(request.getParameter("NS500"));
            Double f5 = Double.parseDouble(cb.getNS_1K()) * Double.parseDouble(request.getParameter("NS1k"));
            Double f6 = Double.parseDouble(cb.getSyringe_10ml()) * Double.parseDouble(request.getParameter("S10ML"));
            Double f7 = Double.parseDouble(cb.getTP()) * Double.parseDouble(request.getParameter("TP"));
            Double f8 = Double.parseDouble(cb.getSyringe_20ml()) * Double.parseDouble(request.getParameter("S20ML"));
            Double f9 = Double.parseDouble(cb.getG_needle16()) * Double.parseDouble(request.getParameter("N16"));
            Double f10 = Double.parseDouble(cb.getG_needle17()) * Double.parseDouble(request.getParameter("N17"));
            Double f11 = Double.parseDouble(cb.getB_part()) * Double.parseDouble(request.getParameter("BPart"));
            Double f12 = Double.parseDouble(cb.getD25()) * Double.parseDouble(request.getParameter("D25"));
            Double f13 = Double.parseDouble(cb.getBedsheet()) * Double.parseDouble(request.getParameter("Bedsheet"));
            count++;
            data.put(String.valueOf(count), new Object[]{
                count - 1,
                cb.getDate(),
                cb.getPatient_name(),
                cb.getCategory(),
                cb.getIV_SET(),
                String.format("%.2f", Double.parseDouble(cb.getHeparin_amp())),
                cb.getHeparin_ml(),
                cb.getTubing(),
                cb.getNS_500(),
                cb.getNS_1K(),
                cb.getOnoff_kit(),
                cb.getSyringe_10ml(),
                cb.getF6(),
                cb.getTP(),
                cb.getF8(),
                cb.getSyringe_20ml(),
                cb.getG_needle16(),
                cb.getG_needle17(),
                cb.getA_part(),
                cb.getB_part(),
                cb.getD25(),
                cb.getBedsheet(),
                f1.toString(),
                String.format("%.2f", f2),//.toString(),
                f3.toString(),
                f4.toString(),
                f5.toString(),
                f6.toString(),
                f7.toString(),
                f8.toString(),
                f9.toString(),
                f10.toString(),
                f11.toString(),
                f12.toString(),
                f13.toString()
            });
        }

        // Iterate over data and write to sheet 
        Set<String> keyset = data.keySet();
        int rownum = 0;
        for (String key : keyset) {
            // this creates a new row in the sheet 
            Row row = sheet1.createRow(rownum++);
            Object[] objArr = data.get(key);
            int cellnum = 0;
            for (Object obj : objArr) {
                // this line creates a cell in the next column of that row 
                Cell cell = row.createCell(cellnum++);
                if (obj instanceof String) {
                    cell.setCellValue((String) obj);
                } else if (obj instanceof Integer) {
                    cell.setCellValue((Integer) obj);
                }
            }
        }

        // write it as an excel attachment
        workbook.write(outByteStream);
        byte[] outArray = outByteStream.toByteArray();
        response.setContentType("application/ms-excel");
        response.setContentLength(outArray.length);
        response.setHeader("Expires:", "0"); // eliminates browser caching
        response.setHeader("Content-Disposition", "attachment; filename=ConsumableReport.xls");
        OutputStream outStream = response.getOutputStream();
        outStream.write(outArray);
        outStream.flush();
    }

    private List<PharmacyBill> fetchPharmList(String fromDate, String toDate, String actions) {
        List<PharmacyBill> pharmList = new ArrayList<>();
        DBConnection dbconn = new DBConnection();
        String pattern = "yyyy-MM-dd";
        java.util.Date date = new java.util.Date(new java.util.Date().getTime() + 86400000);
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        switch (actions) {
            case "ByDate":
                //nothing
                break;
            case "By1Mnth":
                java.util.Date da1 = new java.util.Date();
                Calendar cal = Calendar.getInstance();
                cal.setTime(da1);
                cal.add(Calendar.MONTH, -1);
                fromDate = simpleDateFormat.format(cal.getTime());
                toDate = simpleDateFormat.format(date);
                break;
            case "By3Mnth":
                java.util.Date da2 = new java.util.Date();
                Calendar cal1 = Calendar.getInstance();
                cal1.setTime(da2);
                cal1.add(Calendar.MONTH, -3);
                fromDate = simpleDateFormat.format(cal1.getTime());
                toDate = simpleDateFormat.format(date);
                break;
            case "By6Mnth":
                java.util.Date da3 = new java.util.Date();
                Calendar cal3 = Calendar.getInstance();
                cal3.setTime(da3);
                cal3.add(Calendar.MONTH, -6);
                fromDate = simpleDateFormat.format(cal3.getTime());
                toDate = simpleDateFormat.format(date);
                break;
            default:
                break;
        }
        try (Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement(""
                        + "select ph.pharm_date, p.name ,ph.pharm_item_name, ph.bill_no, ph.quantity, "
                        + "ph.cut, ph.price, ph.sgst, ph.cgst, ph.total, ph.who_pays, ph.trp_credit "
                        + "from vidur_pharmacy_bill ph inner join vidur_patient p on ph.patient_id = p.patient_id "
                        + "where ph.pharm_date between STR_TO_DATE(?, '%Y-%m-%d') and STR_TO_DATE(?, '%Y-%m-%d')");
                psmt.setString(1, fromDate);
                psmt.setString(2, toDate);
                ResultSet rs = psmt.executeQuery();
                while (rs.next()) {
                    //code required by excel
                    PharmacyBill ph = new PharmacyBill();
                    ph.setPharm_date(rs.getString(1));
                    ph.setPatient_name(rs.getString(2));
                    ph.setItemName(rs.getString(3));
                    ph.setBill_no(rs.getString(4));
                    ph.setQty(rs.getString(5));
                    ph.setCut(rs.getInt(6));
                    ph.setPrice(rs.getInt(7));
                    ph.setSgst(rs.getInt(8));
                    ph.setCgst(rs.getInt(9));
                    ph.setTotal(rs.getInt(10));
                    ph.setWho_pays(rs.getString(11));
                    ph.setTrp_credit(rs.getInt(12));
                    pharmList.add(ph);
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return pharmList;
    }

    private List<Consumable> fetchConsList(String fromDate, String toDate) {
        List<Consumable> consList = new ArrayList<>();
        DBConnection dbconn = new DBConnection();
        java.util.Date date = new java.util.Date(new java.util.Date().getTime() + 86400000);
        String pattern = "yyyy-MM-dd";
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        toDate = simpleDateFormat.format(date);
        try (Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement(""
                        + "Select c.updated_date, p.name, c.category, c.iv_set, c.heparin_amp, "
                        + "c.heparin_ml, c.tubing, c.ns_500, c.ns_1k, c.onoff_kit, c.syringe_10ml, "
                        + "c.f6, c.tp, c.f8, c.syringe_20ml, c.d_16g_needle, c.d_17g_needle, c.a_part, "
                        + "c.b_part, c.d25, c.bed_sheet from vidur_consumables c "
                        + "inner join vidur_patient p on c.patient_id = p.patient_id "
                        + "where c.updated_date between STR_TO_DATE(?, '%Y-%m-%d') and STR_TO_DATE(?, '%Y-%m-%d')");
                psmt.setString(1, fromDate);
                psmt.setString(2, toDate);
                ResultSet rs = psmt.executeQuery();
                while (rs.next()) {
                    //code required by excel
                    Consumable c = new Consumable();
                    c.setDate(rs.getString(1));
                    c.setPatient_name(rs.getString(2));
                    c.setCategory(rs.getString(3));
                    c.setIV_SET(rs.getString(4));
                    c.setHeparin_amp(rs.getString(5));
                    c.setHeparin_ml(rs.getString(6));
                    c.setTubing(rs.getString(7));
                    c.setNS_500(rs.getString(8));
                    c.setNS_1K(rs.getString(9));
                    c.setOnoff_kit(rs.getString(10));
                    c.setSyringe_10ml(rs.getString(11));
                    c.setF6(rs.getString(12));
                    c.setTP(rs.getString(13));
                    c.setF8(rs.getString(14));
                    c.setSyringe_20ml(rs.getString(15));
                    c.setG_needle16(rs.getString(16));
                    c.setG_needle17(rs.getString(17));
                    c.setA_part(rs.getString(18));
                    c.setB_part(rs.getString(19));
                    c.setD25(rs.getString(20));
                    c.setBedsheet(rs.getString(21));
                    consList.add(c);
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return consList;
    }

    private String editString(String inputString) {
        String newString = "";
        String temp = "";
        for (String techs : inputString.split(",")) {
            temp = techs.trim();
            if (!temp.isEmpty()) {
                newString += temp.toUpperCase() + ",";
            }
        }
        newString = newString.substring(0, newString.length() - 1);
        return newString;
    }

    private String addUpdatedValues(String newTech, String newDrugs, String newMach) {
        DBConnection dbconn = new DBConnection();
        int i = 0;
        try (Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt1 = conn.prepareStatement("update vidur_control_table set value = ? where param = 'Techinician'");
                PreparedStatement psmt2 = conn.prepareStatement("update vidur_control_table set value = ? where param = 'Drugs_Given'");
                PreparedStatement psmt3 = conn.prepareStatement("update vidur_control_table set value = ? where param = 'Machine_ID'");
                psmt1.setString(1, newTech);
                psmt2.setString(1, newDrugs);
                psmt3.setString(1, newMach);
                i += psmt1.executeUpdate();
                i += psmt2.executeUpdate();
                i += psmt3.executeUpdate();
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        String result = "";
        if (i == 0) {
            result = "No records updated";
        } else {
            result = i + " no. of records updated";
        }
        return result;
    }

    private String addPriceForItem(String item, String price, String SGST, String CGST) {
        DBConnection dbconn = new DBConnection();
        String result = "";
        int i = 0;
        try (Connection conn = dbconn.createConnection();) {
            try {
                PreparedStatement psmt = conn.prepareStatement("Update vidur_item_manage set item_price = ?, ITEM_SGST = ?, ITEM_CGST = ? where item_name = ?");
                psmt.setInt(1, Integer.parseInt(price));
                psmt.setString(2, SGST);
                psmt.setString(3, CGST);
                psmt.setString(4, item);
                i = psmt.executeUpdate();
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        if (i != 0) {
            result = i + " record updated";
        } else {
            result = "No records updated";
        }
        return result;
    }

    private List<DialysisSession> fetchDialList(String fromDate, String toDate, String actions) {
        List<DialysisSession> dialList = new ArrayList<>();
        DBConnection dbconn = new DBConnection();
        String pattern = "yyyy-MM-dd";
        java.util.Date date = new java.util.Date(new java.util.Date().getTime() + 86400000);
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat(pattern);
        switch (actions) {
            case "ByDate":
                //nothing
                break;
            case "By1Mnth":
                java.util.Date da1 = new java.util.Date();
                Calendar cal = Calendar.getInstance();
                cal.setTime(da1);
                cal.add(Calendar.MONTH, -1);
                fromDate = simpleDateFormat.format(cal.getTime());
                toDate = simpleDateFormat.format(date);
                break;
            case "By3Mnth":
                java.util.Date da2 = new java.util.Date();
                Calendar cal1 = Calendar.getInstance();
                cal1.setTime(da2);
                cal1.add(Calendar.MONTH, -3);
                fromDate = simpleDateFormat.format(cal1.getTime());
                toDate = simpleDateFormat.format(date);
                break;
            case "By6Mnth":
                java.util.Date da3 = new java.util.Date();
                Calendar cal3 = Calendar.getInstance();
                cal3.setTime(da3);
                cal3.add(Calendar.MONTH, -6);
                cal3.add(Calendar.DATE, 1);
                fromDate = simpleDateFormat.format(cal3.getTime());
                toDate = simpleDateFormat.format(date);
                break;
            default:
                break;
        }
        try (Connection conn = dbconn.createConnection();) {
            try {

//        Date	Patient Name	Patient ID	Start Time	End Time
//      Therapy	Dialyzer	Reg	Overtime	Total	EMER=1	P/U	
//      M/C ID	Bill ID	Bill No.	Note	Tech	Hospital Cut	Nephro Cut
                //select updated_date, patient_id, start_time, end_time, therafee, dialfee, regfee, otherservamt, type_of from vidur_dialysis_session
                PreparedStatement psmt = conn.prepareStatement(""
                        + "select d.updated_date, d.patient_id, p.name, d.start_time, d.end_time, d.therafee, d.dialfee, "
                        + "d.regfee, d.otherservamt, d.machid, d.PAID_UNPAID, d.EMERG  from vidur_dialysis_session d inner join "
                        + "vidur_patient p on d.patient_id = p.patient_id where d.updated_date between "
                        + "STR_TO_DATE(?, '%Y-%m-%d')  and STR_TO_DATE(?, '%Y-%m-%d')");
                psmt.setString(1, fromDate);
                psmt.setString(2, toDate);
                ResultSet rs = psmt.executeQuery();
                while (rs.next()) {
                    //code required by excel
                    DialysisSession dial = new DialysisSession();
                    dial.setDate(rs.getString(1));
                    dial.setPatientId(rs.getString(2));
                    dial.getPatient().setPatientName(rs.getString(3));
                    dial.setPatStart_time(rs.getString(4));
                    dial.setPatEnd_time(rs.getString(5));
                    dial.setTech_thera(rs.getString(6));
                    dial.setTech_dial(rs.getString(7));
                    dial.setTech_reg(rs.getString(8));
                    dial.setTech_othservamt(rs.getString(9));
                    dial.setMach_id(rs.getString(10));
                    dial.setPaid(rs.getString(11));
                    dial.setSch_emrg(rs.getString(12));
                    dialList.add(dial);
                }
            } catch (Exception e) {
                System.out.println(e);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return dialList;
    }

    private void convertAndCreateExcelDial(List<DialysisSession> dial, HttpServletResponse response) throws FileNotFoundException, IOException {
        Workbook workbook = new HSSFWorkbook();

//        OutputStream fileOut = new FileOutputStream("PharmacyReport.xlsx");
        ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
//        FileOutputStream out = new FileOutputStream(new File("Geekz.xlsx")); 
        Sheet sheet1 = workbook.createSheet("Pharmacy Bills");

//        Date	Patient Name	Patient ID	Start Time	End Time
//      Therapy	Dialyzer	Reg	Overtime	Total	EMER=1	P/U	
//      M/C ID	Bill ID	Bill No.	Note	Tech	Hospital Cut	Nephro Cut
        Map<String, Object[]> data = new TreeMap<String, Object[]>();
        data.put("1", new Object[]{"DATE", "Patient ID", "Patient Name", "Start Time", "End Time", "Therapy",
            "Dialyzer", "Reg", "Other", "Total", "EMER", "Paid/Unpaid", "M/C ID", "Bill ID", "Bill No.", "Note", "Tech",
            "Hosital Cut", "Nephro Cut"});
        int count = 1;
        for (DialysisSession di : dial) {
            count++;
            int tots = Integer.parseInt(di.getTech_thera()) + Integer.parseInt(di.getTech_reg())
                    + Integer.parseInt(di.getTech_dial()) + Integer.parseInt(di.getTech_othservamt());
            int hosp = Integer.parseInt(di.getTech_thera()) * 15 / 100;
            int nephro = (Integer.parseInt(di.getSch_emrg()) + 1) * 100;
            data.put(String.valueOf(count), new Object[]{
                di.getDate(),
                di.getPatientId(),
                di.getPatient().getPatientName(),
                changeFormat(di.getPatStart_time()),
                changeFormat(di.getPatEnd_time()),
                di.getTech_thera(),
                di.getTech_dial(),
                di.getTech_reg(),
                di.getTech_othservamt(),
                String.valueOf(tots),
                di.getSch_emrg(),
                di.getPaid(),
                di.getMach_id(),
                "",
                "",
                "NA",
                "",
                String.valueOf(hosp),
                String.valueOf(nephro)
            });
        }

        // Iterate over data and write to sheet 
        Set<String> keyset = data.keySet();
        int rownum = 0;
        for (String key : keyset) {
            // this creates a new row in the sheet 
            Row row = sheet1.createRow(rownum++);
            Object[] objArr = data.get(key);
            int cellnum = 0;
            for (Object obj : objArr) {
                // this line creates a cell in the next column of that row 
                Cell cell = row.createCell(cellnum++);
                if (obj instanceof String) {
                    cell.setCellValue((String) obj);
                } else if (obj instanceof Integer) {
                    cell.setCellValue((Integer) obj);
                }
            }
        }

        // write it as an excel attachment
        workbook.write(outByteStream);
        byte[] outArray = outByteStream.toByteArray();
        response.setContentType("application/ms-excel");
        response.setContentLength(outArray.length);
        response.setHeader("Expires:", "0"); // eliminates browser caching
        response.setHeader("Content-Disposition", "attachment; filename=DialysisReport.xls");
        OutputStream outStream = response.getOutputStream();
        outStream.write(outArray);
        outStream.flush();
    }

    private String changeFormat(String patStart_time) {
        String tmp[] = patStart_time.split(":");
        int firstStr = Integer.parseInt(tmp[0]) % 12;
        String appendStr = (Integer.parseInt(tmp[0]) / 12 == 1 ? " pm" : " am");
        String res = (String.valueOf(firstStr).length() == 1 ? "0" + firstStr : firstStr) + ":" + tmp[1] + appendStr;
        return res;
    }
}
