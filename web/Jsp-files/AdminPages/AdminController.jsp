<%-- 
    Document   : AdministratorCorner
    Created on : 24 Jul, 2019, 8:52:31 PM
    Author     : Nevets
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%
        session = request.getSession(false);
        String sessname = (String) session.getAttribute("sessname");
        System.out.print("Session : " + sessname);
        if (sessname == null || sessname == "") {
            System.out.print("(IN)Session : " + sessname);
            response.sendRedirect("/VIDUR");
            return;
        }
    %>
    <jsp:include page="../../UI-Template/header.jsp"></jsp:include>
        <body>
            <div class="container-fluid pt-3">
                <fieldset class="mt-4">
                    <h1><center>Administrator Controller</center></h1>
                    <div class="row">
                        <div class="col">
                            <center><h3>Get Excel Sheet of Pharmacy</h3></center>
                        </div>
                    </div>
                    <form action="/VIDUR/Admin/AdminFilesServlet" method="POST">
                        <div class="row justify-content-md-center">
                            <input type="hidden" name="fileFor" value="Pharmacy"/>
                            <div class="col-2">
                                <div class="form-group">
                                    <label for="fromDate">From Date:</label>
                                    <input type="date" id="fromDateAdminP" name="fromDate" class="form-control" placeholder="">
                                </div>
                            </div>
                            <div class="col-2">
                                <div class="form-group">
                                    <label for="toDate">To Date:</label>
                                    <input type="date" id="toDateAdminP" name="toDate" class="form-control" placeholder="">
                                </div>
                            </div>
                            <div class="col-1">
                                <button id="searchByDateAdminP" name="actions"  type="submit" class="btn btn-success mt-4" title="Get Excel Sheet" value="ByDate">Get Report By Date</button>
                            </div>

                        </div>
                        <div class="row mb-4 justify-content-md-center">
                            <div class="col-1"></div>
                            <div class="col-2">
                                <button id="searchByDateAdminP" name="actions" type="submit" class="btn btn-success btn-block mt-4" title="Get Excel Sheet of last 1 months" value="By1Mnth">Last 1 mos.</button>
                            </div>
                            <div class="col-2">
                                <button id="searchByDateAdminP" name="actions"  type="submit" class="btn btn-success btn-block mt-4" title="Get Excel Sheet of last 3 months" value="By3Mnth">Last 3 mos.</button>
                            </div>
                            <div class="col-2">
                                <button id="searchByDateAdminP" name="actions"  type="submit" class="btn btn-success btn-block mt-4" title="Get Excel Sheet of last 6 months" value="By6Mnth">Last 6 mos.</button>
                            </div>

                        </div>
                    </form>
                    <div>
                        <p class="small text-center">For downloading the list of pharmacy details of every patient between the given dates.</p>
                    </div>
                    <hr/>
                    <div class="row">
                        <div class="col">
                            <center><h3>Get Excel Sheet of Dialysis Sheet</h3></center>
                        </div>
                    </div>
                    <form action="/VIDUR/Admin/AdminFilesServlet" method="POST">
                        <div class="row justify-content-md-center">
                            <input type="hidden" name="fileFor" value="Dialysis"/>
                            <div class="col-2">
                                <div class="form-group">
                                    <label for="fromDate">From Date:</label>
                                    <input type="date" id="fromDateAdminD" name="fromDate" class="form-control" placeholder="">
                                </div>
                            </div>
                            <div class="col-2">
                                <div class="form-group">
                                    <label for="toDate">To Date:</label>
                                    <input type="date" id="toDateAdminD" name="toDate" class="form-control" placeholder="">
                                </div>
                            </div>
                            <div class="col-1">
                                <button id="searchByDateAdminD" name="actions"  type="submit" class="btn btn-success mt-4" title="Get Excel Sheet" value="ByDate">Get Report By Date</button>
                            </div>
                        </div>
                        <div class="row mb-4 justify-content-md-center">
                            <div class="col-1"></div>
                            <div class="col-md-2">
                                <button id="searchByDateAdminD" name="actions" type="submit" class="btn btn-success btn-block mt-4" title="Get Excel Sheet of last 1 months" value="By1Mnth">Last 1 mos.</button>
                            </div>
                            <div class="col-md-2">
                                <button id="searchByDateAdminD" name="actions"  type="submit" class="btn btn-success btn-block mt-4" title="Get Excel Sheet of last 3 months" value="By3Mnth">Last 3 mos.</button>
                            </div>
                            <div class="col-md-2">
                                <button id="searchByDateAdminD" name="actions"  type="submit" class="btn btn-success btn-block mt-4" title="Get Excel Sheet of last 6 months" value="By6Mnth">Last 6 mos.</button>
                            </div>
                        </div>
                    </form>
                    <div>
                        <p class="small text-center">For downloading the list of pharmacy details of every patient between the given dates.</p>
                    </div>
                    <hr/>
                    <div class="row">
                        <div class="col">
                            <center><h3>Get Excel Sheet of Consumbales</h3></center>
                        </div>
                    </div>
                    <form action="/VIDUR/Admin/AdminFilesServlet" method="POST">
                        <div class="row">
                            <input type="hidden" name="fileFor" value="Consumables"/>
                            <div class="col-3"></div>
                            <div class="col-3">
                                <div class="form-inline">
                                    <label for="fromDate">From Date: &nbsp;&nbsp;&nbsp;&nbsp;</label>
                                    <input type="date" id="fromDateAdminC" name="fromDate" class="form-control" placeholder="" required>
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="form-inline">
                                    <label for="toDate">To Date: &nbsp;&nbsp;&nbsp;&nbsp; </label>
                                    <input type="date" id="toDateAdminC" name="toDate" class="form-control" placeholder="" required>
                                </div>
                            </div>
                            <div class="col-1">

                            </div>
                            <div class="col-2"></div>
                        </div>
                        <div class="row mt-4 justify-content-md-center">
                            <div class="col-md-2 col-sm-3">
                                <div class="form-group">
                                    <label for="toIVSet">IVSet:</label>
                                    <input type="number" id="toIVSet" name="IVSet" class="form-control" placeholder="" step="any" value="6.72">
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-3">
                                <div class="form-group">
                                    <label for="toHep">Heparin:</label>
                                    <input type="number" id="toHep" name="Hep" class="form-control" placeholder="" step="any" value="94">
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-3">
                                <div class="form-group">
                                    <label for="toTubing">Tubing:</label>
                                    <input type="number" id="toTubing" name="Tubing" class="form-control" placeholder="" step="any" value="145.6">
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-3">
                                <div class="form-group">
                                    <label for="tons500">NS 500:</label>
                                    <input type="number" id="tons500" name="NS500" class="form-control" placeholder="" step="any" value="19.04">
                                </div>
                            </div>
                        </div>
                        <div class="row justify-content-md-center">
                            <div class="col-md-2 col-sm-3">
                                <div class="form-group">
                                    <label for="tons1k">NS 1K:</label>
                                    <input type="number" id="tons1k" name="NS1k" class="form-control" placeholder="" step="any" value="31.36">
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-3">
                                <div class="form-group">
                                    <label for="toKit">ON/OFF KIT:</label>
                                    <input type="number" id="toKit" name="KIT" class="form-control" placeholder="" step="any" value="22.04">
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-3">
                                <div class="form-group">
                                    <label for="tosyringe10ml">Syringe 10ML:</label>
                                    <input type="number" id="tosyringe10ml" name="S10ML" class="form-control" placeholder="" step="any" value="7.28">
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-3">
                                <div class="form-group">
                                    <label for="toTP">TP</label>
                                    <input type="number" id="toTP" name="TP" class="form-control" placeholder="" step="any" value="14">
                                </div>
                            </div>
                        </div>
                        <div class="row justify-content-md-center">
                            <div class="col-md-2 col-sm-3">
                                <div class="form-group">
                                    <label for="tosyringe20ml">Syringe 20ML:</label>
                                    <input type="number" id="tosyringe20ml" name="S20ML" class="form-control" placeholder="" step="any" value="10.75">
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-3">
                                <div class="form-group">
                                    <label for="to16needle">16G NEEDLE:</label>
                                    <input type="number" id="to16needle" name="N16" class="form-control" placeholder="" step="any" value="33.6">
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-3">
                                <div class="form-group">
                                    <label for="to17needle">17G NEEDLE:</label>
                                    <input type="number" id="to17needle" name="N17" class="form-control" placeholder="" step="any" value="33.6">
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-3">
                                <div class="form-group">
                                    <label for="toABPart">A/B Part:</label>
                                    <input type="number" id="toABPart" name="BPart" class="form-control" placeholder="" step="any" value="103.6">
                                </div>
                            </div>
                        </div>
                        <div class="row justify-content-md-center">
                            <div class="col-md-2 col-sm-3">
                                <div class="form-group">
                                    <label for="toD25">D25%:</label>
                                    <input type="number" id="toD25" name="D25" class="form-control" placeholder="" step="any" value="15.12">
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-3">
                                <div class="form-group">
                                    <label for="toF6">Bedsheet:</label>
                                    <input type="number" id="toBedsheet" name="Bedsheet" class="form-control" placeholder="" step="any" value="6.5">
                                </div>
                            </div>
                            <div class="col-md-2 col-sm-4">
                                <div class="form-group m-4">
                                    <button id="searchByDateAdminC" type="submit" class="btn btn-success" title="Get Excel Sheet for Consumables">Get Report</button>
                                </div>
                            </div>
                        </div>
                    </form>
                    <div>
                        <p class="small text-center">For downloading the list of consumables details of every patient between the given dates.</p>
                    </div>
                    <!--                for dynamic values    -->
                    <hr/>
                    <div class="row">
                        <div class="col">
                            <center><h3>Common Data</h3></center>
                        </div>
                    </div>
                    <form>
                        <div class="row">
                            <div class="col-3">
                            </div>
                            <!--
                        <%
                            String str1 = " ";
                            List<String> technicians = (List<String>) session.getAttribute("TechCommons");
                            if (technicians != null) {
                                for (String ele : technicians) {
                                    str1 += ele + ",";
                                }
                            }
                            String str2 = " ";
                            List<String> drugs = (List<String>) session.getAttribute("DrugsCommons");
                            if (drugs != null) {
                                for (String ele : drugs) {
                                    str2 += ele + ",";
                                }
                            }
                            String str3 = " ";
                            List<String> mach = (List<String>) session.getAttribute("MachCommons");
                            if (mach != null) {
                                for (String ele : mach) {
                                    str3 += ele + ",";
                                }
                            }
                        %>
                        -->
                        <div class="col-3">
                            <div class="form-group">
                                <label for="adminTech">All Technicians:</label>
                                <input type="text" id="adminTech" class="form-control" placeholder="Use ',' as a delimiter" value="<%=str1%>">
                            </div>
                        </div>
                        <div class="col-3">
                            <div class="form-group">
                                <label for="adminMach">Machine IDs:</label>
                                <input type="text" id="adminMach" class="form-control" placeholder="Use ',' as a delimiter" value="<%=str2%>">
                            </div>
                        </div>
                        <div class="col-2"></div>
                        <div class="col-3"></div>
                        <div class="col-6">
                            <div class="form-group">
                                <label for="adminDrugs">Drugs Available:</label>
                                <input type="text" id="adminDrugs" class="form-control" placeholder="Use ',' as a delimiter" value="<%=str3%>">
                            </div>
                        </div>
                        <div class="col-1">
                            <button id="updateAdminRecords" type="button" class="btn btn-success mt-4" title="Update common records">Update</button>
                        </div>
                        <div class="col-2"></div>
                    </div>
                </form>
                <div>
                    <p class="small text-center">For Commons field values.</p>
                </div>
                <!--                for dynamic Price values    -->
                <hr/>
                <div class="row">
                    <div class="col">
                        <center><h3>Pharmacy Items</h3></center>
                    </div>
                </div>
                <form>
                    <div class="row justify-content-md-center">
                        <div class="col-1">
                        </div>
                        <div class="col-2">
                            <div class="form-group">
                                <label for="priceIS">Iron Sucrose:</label>
                                <input type="number" id="priceIS" class="form-control" placeholder="12.5">
                            </div>
                        </div>
                        <div class="col-2">
                            <div class="form-group">
                                <label for="priceIS">SGST:</label>
                                <input type="number" id="priceISsgst" class="form-control" placeholder="12.5">
                            </div>
                        </div>
                        <div class="col-2">
                            <div class="form-group">
                                <label for="priceIS">CGST:</label>
                                <input type="number" id="priceIScgst" class="form-control" placeholder="12.5">
                            </div>
                        </div>
                        <div class="col-1">
                            <button data-id="Iron" data-item="Iron Sucrose" type="button" class="btn btn-success mt-4 updateAdminPriceRecords" title="Update item prices">Update</button>
                        </div>
                    </div>
                    <div class="row justify-content-md-center">
                        <div class="col-1">
                        </div>
                        <div class="col-2">
                            <div class="form-group">
                                <label for="priceMulti">Multivitamin:</label>
                                <input type="number" id="priceMulti"  class="form-control" placeholder="">
                            </div>
                        </div>
                        <div class="col-2">
                            <div class="form-group">
                                <label for="priceMulti">SGST:</label>
                                <input type="number" id="priceMultisgst"  class="form-control" placeholder="">
                            </div>
                        </div>
                        <div class="col-2">
                            <div class="form-group">
                                <label for="priceMulti">CGST:</label>
                                <input type="number" id="priceMulticgst"  class="form-control" placeholder="">
                            </div>
                        </div>
                        <div class="col-1">
                            <button data-id="Multivitamin" data-item="Multivitamin" type="button" class="btn btn-success mt-4 updateAdminPriceRecords" title="Update item prices">Update</button>
                        </div>
                    </div>
                    <div class="row justify-content-md-center">
                        <div class="col-1">
                        </div>
                        <div class="col-2">
                            <div class="form-group">
                                <label for="priceEPO1000">EPO Renocel 10000:</label>
                                <input type="number" id="priceEPO1000" class="form-control" placeholder="">
                            </div>
                        </div>
                        <div class="col-2">
                            <div class="form-group">
                                <label for="priceEPO1000">SGST:</label>
                                <input type="number" id="priceEPO1000sgst" class="form-control" placeholder="">
                            </div>
                        </div>
                        <div class="col-2">
                            <div class="form-group">
                                <label for="priceEPO1000">CGST:</label>
                                <input type="number" id="priceEPO1000cgst" class="form-control" placeholder="">
                            </div>
                        </div>
                        <div class="col-1">
                            <button data-id="EPO1" data-item="EPO Renocel 10000" type="button" class="btn btn-success mt-4 updateAdminPriceRecords" title="Update item prices">Update</button>
                        </div>
                    </div>
                    <div class="row justify-content-md-center">
                        <div class="col-1">
                        </div>
                        <div class="col-2">
                            <div class="form-group">
                                <label for="priceEPO4000">EPO Renocel 4000:</label>
                                <input type="number" id="priceEPO4000" class="form-control" placeholder="">
                            </div>
                        </div>
                        <div class="col-2">
                            <div class="form-group">
                                <label for="priceEPO4000">SGST:</label>
                                <input type="number" id="priceEPO4000sgst" class="form-control" placeholder="">
                            </div>
                        </div>
                        <div class="col-2">
                            <div class="form-group">
                                <label for="priceEPO4000">CGST:</label>
                                <input type="number" id="priceEPO4000cgst" class="form-control" placeholder="">
                            </div>
                        </div>
                        <div class="col-1">
                            <button data-id="EPO4" data-item="EPO Renocel 4000" type="button" class="btn btn-success mt-4 updateAdminPriceRecords" title="Update item prices">Update</button>
                        </div>
                    </div>
                    <div class="row justify-content-md-center">
                        <div class="col-1">
                        </div>
                        <div class="col-2">
                            <div class="form-group">
                                <label for="priceAnti">Anitbotic:</label>
                                <input type="number" id="priceAnti" class="form-control" placeholder="">
                            </div>
                        </div>
                        <div class="col-2">
                            <div class="form-group">
                                <label for="priceAnti">SGST:</label>
                                <input type="number" id="priceAntisgst" class="form-control" placeholder="">
                            </div>
                        </div>
                        <div class="col-2">
                            <div class="form-group">
                                <label for="priceAnti">CGST:</label>
                                <input type="number" id="priceAnticgst" class="form-control" placeholder="">
                            </div>
                        </div>
                        <div class="col-1">
                            <button data-id="Anitbotic" data-item="Anitbotic" type="button" class="btn btn-success mt-4 updateAdminPriceRecords" title="Update item prices">Update</button>
                        </div>
                    </div>
                </form>
                <div>
                    <p class="small text-center">For Items's price values.</p>
                </div>
            </fieldset>
        </div>
    </body>
</html>