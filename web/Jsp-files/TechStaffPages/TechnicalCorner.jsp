<%-- 
    Document   : AdministratorCorner
    Created on : 24 Jul, 2019, 8:52:31 PM
    Author     : Nevets
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <div class="container pt-1">
                <fieldset style="padding: 50px;margin: 50px;border: 3px solid grey;border-radius: 5px">
                    <h1><center>Tech Corner</center></h1>
                    <div class="row ">
                        <h2 class="ACheader" style="color: #461b2f;">Add Patient Session Data</h2>
                    </div>
                    <div class="row startDiv" style="padding: 50px;margin-bottom: 50px;">
                        <div class="col-3"></div>
                        <div class="col-6"> 
                            <button type="button" class="btn btn-success btn-lg btn-block startSession">Start Session >> </button>
                        </div>
                    </div>
                    <div class="row fieldDiv" style="display: none;">
                        <div class="col-6">
                            <div class="form-group">
                                <label for="techPatientId">Patient Id:<span class="text-danger">*</span></label>
                                <input type="text" list="browsers" class="form-control" id="techPatientId" aria-describedby="inputName" placeholder="Enter patient ID " maxlength="30" value="">
                                <datalist id="browsers" class="appendPatients">
                                </datalist>
                                <small class="form-text text-muted">Kindly enter Patient's ID for adding a new session data</small>
                            </div>
                        </div>
                        <div class="col-4">
                            <div class="form-group">
                                <label for="">Centre:<span class="text-danger">*</span></label>
                                <select id="techCentre" class="form-control" disabled>
                                    <option value="">Select</option>
                                    <option value="GORAI">Gorai</option>
                                    <option value="MIRAROAD">Mira Road</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <form class="patientSessionRecords" style="display: none;" novalidate>
                        <!--// style="display: none;">-->
                        <br>
                        <hr>
                        <br>
                        <div id="dialysisSheet">
                            <input id="hidnPatientId" type="hidden" class="form-control" value="">
                            <input id="techPatRotations" type="hidden" class="form-control" value="">
                            <div class="row ">
                                <div class="col-6">
                                    <div class="form-group">
                                        <label for="inputName">Patient Name:</label>
                                        <input type="text" class="form-control" id="techPatName" aria-describedby="inputName" placeholder="First Name | Middle Name | LastName" value="" readonly>
                                        <small id="inputName" class="form-text text-muted">Kindly enter your full name.</small>            
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="form-group">
                                        <label for="techAccessPoint">Access Point:<span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="techAccessPoint" aria-describedby="inputName" placeholder="Enter Patient ID" value="NA" readonly>
                                    </div>
                                </div>
                            </div>
                            <div class="row ">
                                <div class="col-6">
                                    <div class="form-group">
                                        <label for="inputAPCond">Condition of Access point:<span class="text-danger">*</span></label>
                                        <select class="form-control" id="inputCondition" required>
                                            <option value="normal">Normal</option>
                                            <option value="inflammed">Inflammed</option>
                                            <option value="infection">Infection</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="form-group">
                                        <label for="inputCondition">Condition:<span class="text-danger">*</span></label>
                                        <select class="form-control" id="inputCondition" required>
                                            <option>Normal</option>
                                            <option>Vomiting</option>
                                            <option>High BP</option>
                                            <option>Fever</option>
                                            <option>Chest pain</option>
                                            <option>Dizziness</option>
                                        </select>
                                    </div>
                                </div>

                            </div>
                            <div class="row">
                                <div class="col">
                                    <div class="form-group">
                                        <label for="techStartTime">Start Time:<span class="text-danger">*</span></label>
                                        <input id="techStartTime" type="time" class="form-control" value="" required>
                                    </div>
                                </div>
                                <div class="col">
                                    <div class="form-group">
                                        <label for="techEndTime">End Time:<span class="text-danger">*</span></label>
                                        <input id="techEndTime" type="time" class="form-control" value="" required>
                                    </div>
                                </div>
                            </div>
                            <div class="row ">
                                <div class="col-lg-3 col-md-6">
                                    <div class="form-group">
                                        <label for="techDiagID">Dialyzer ID:<span class="text-danger">*</span></label>
                                        <input type="text" id="techDiagID" class="form-control" placeholder="" value="" maxlength="15" required>
                                    </div>
                                </div>
                                <div class="col-lg-3 col-md-6">
                                    <div class="form-group">
                                        <label for="techMachID">Machine ID:<span class="text-danger">*</span></label>
                                        <select id="techMachID" class="form-control" required>
                                            <option value="">Select..</option>
                                        <c:forEach items="${sessionScope.MachCommons}" var="mach">
                                            <option>${mach}</option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                            <!--<input type="text" id="techMachID" class="form-control" placeholder="" value="H23" required>-->
                            <div class="col-lg-3 col-md-6">
                                <div class="form-group">
                                    <label for="techOpenID">Opening Technician ID:<span class="text-danger">*</span></label>
                                    <select id="techOpenID" class="form-control" required>
                                        <option value="">Select..</option>
                                        <c:forEach items="${sessionScope.TechCommons}" var="data">
                                            <option>${data}</option>
                                        </c:forEach>
                                    </select>
                                    <!--<input type="text" id="techOpenID" class="form-control" placeholder="" value="sakshi" required>-->
                                </div>
                            </div>
                            <div class="col-lg-3 col-md-6">
                                <div class="form-group">
                                    <label for="techCloseID">Closing Technician ID:<span class="text-danger">*</span></label>
                                    <select id="techCloseID" class="form-control" required>
                                        <option value="">Select..</option>
                                        <c:forEach items="${sessionScope.TechCommons}" var="data">
                                            <option>${data}</option>
                                        </c:forEach>
                                    </select>
                                    <!--<input type="text" id="techCloseID" class="form-control" placeholder="" value="sakshi" required>-->
                                </div>
                            </div>
                        </div>
                        <div class="row ">
                            <div class="col-lg-3 col-md-6">
                                <div class="form-group">
                                    <label for="emerData">Scheduled/Emergency</label>
                                    <select class="form-control" id="emerData" required>
                                        <option value="">Select..</option>
                                        <option value="0">Scheduled</option>
                                        <option value="1">Emergency</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="row text-center">
                            <div class="col">
                                <h2 class="ACheader" style="color: #461b2f;">Pre-Dialysis Assessment</h2>
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="tectSiteCondn">Access Site Condition Acceptable:</label>
                                    <select class="form-control" id="techAccsSiteCondn">
                                        <option value="" selected>Select..</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="tectSiteCondnNO">If NO, Explain:</label>
                                    <input type="text" id="tectSiteCondnNO" class="form-control" placeholder="Enter Reason" maxlength="90" value="">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <label for="">Patient Condition:</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <div class="form-group form-check-inline row pl-4">
                                    <div class="custom-control custom-checkbox pr-5">
                                        <input type="checkbox" id="techCBPreDiagBPH" class="custom-control-input preDialChk" data-id="1" value="">
                                        <label class="custom-control-label" for="techCBPreDiagBPH">
                                            BP High
                                        </label>
                                    </div>
                                    <div class="custom-control custom-checkbox pr-5">
                                        <input type="checkbox" id="techCBPreDiagBPL" class="custom-control-input preDialChk" data-id="2" value="">
                                        <label class="custom-control-label" for="techCBPreDiagBPL">
                                            BP Low
                                        </label>
                                    </div>
                                    <div class="custom-control custom-checkbox pr-5">
                                        <input type="checkbox" id="techCBPreDiagNau" class="custom-control-input preDialChk" data-id="3" value="">
                                        <label class="custom-control-label" for="techCBPreDiagNau">
                                            Nausea
                                        </label>
                                    </div>
                                    <div class="custom-control custom-checkbox pr-5">
                                        <input type="checkbox" id="techCBPreDiagVom" class="custom-control-input preDialChk" data-id="4" value="">
                                        <label class="custom-control-label" for="techCBPreDiagVom">
                                            Vomiting
                                        </label>
                                    </div>
                                    <div class="custom-control custom-checkbox pr-5">
                                        <input type="checkbox" id="techCBPreDiagSB" class="custom-control-input preDialChk" data-id="5" value="">
                                        <label class="custom-control-label" for="techCBPreDiagSB">
                                            Short Breath
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group form-check-inline row pl-4">
                                    <div class="custom-control custom-checkbox pr-5">
                                        <input type="checkbox" id="techCBPreDiagBleed" class="custom-control-input preDialChk" data-id="6" value="">
                                        <label class="custom-control-label" for="techCBPreDiagBleed">
                                            Bleeding
                                        </label>
                                    </div>
                                    <div class="custom-control custom-checkbox pr-5">
                                        <input type="checkbox" id="techCBPreDiagEdema" class="custom-control-input preDialChk" data-id="7" value="">
                                        <label class="custom-control-label" for="techCBPreDiagEdema">
                                            Edema
                                        </label>
                                    </div>
                                    <div class="custom-control custom-checkbox pr-5">
                                        <input type="checkbox" id="techCBPreDiagStomDis" class="custom-control-input preDialChk" data-id="8" value="">
                                        <label class="custom-control-label" for="techCBPreDiagStomDis">
                                            Stomach Distend
                                        </label>
                                    </div>
                                    <div class="custom-control custom-checkbox pr-5">
                                        <input type="checkbox" id="techCBPreDiagDiarr" class="custom-control-input preDialChk" data-id="9" value="">
                                        <label class="custom-control-label" for="techCBPreDiagDiarr">
                                            Diarrhea
                                        </label>
                                    </div>
                                    <div class="custom-control custom-checkbox pr-5">
                                        <input type="checkbox" id="techCBPreDiagOther" class="custom-control-input preDialChk" data-id="10" value="">
                                        <label class="custom-control-label" for="techCBPreDiagOther">
                                            Other
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6">
                                <div class="form-group">
                                    <label for="inputprediagWeight">Pre-Dialysis weight:<span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="inputprediagWeight" placeholder="Enter weight(DD.d KG)" step="any" value="" required>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="display: none;">
                            <div class="col">
                                <table id="preDialCondn" border="1" cellpadding="2">
                                    <tbody>
                                        <tr>
                                            <td class="cell1">BP High : <i>No</i></td>
                                            <td class="cell2">BP Low : <i>No</i></td>
                                            <td class="cell3">Nausea : <i>No</i></td>
                                            <td class="cell4">Vomiting : <i>No</i></td>
                                            <td class="cell5">Short Breath : <i>No</i></td>
                                        </tr>
                                        <tr>
                                            <td class="cell6">Bleeding : <i>No</i></td>
                                            <td class="cell7">Edema : <i>No</i></td>
                                            <td class="cell8">Stomach Distend : <i>No</i></td>
                                            <td class="cell9">Diarrhea : <i>No</i></td>
                                            <td class="cell10">Other : <i>No</i></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="techPreNote">Notes:</label>
                                    <textarea class="form-control" id="techPreNote"></textarea>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="row text-center">
                            <div class="col">
                                <h2 class="ACheader" style="color: #461b2f;">Patient Parameter during Dialysis:</h2>
                            </div>
                        </div>
                        <br>

                        <div class="row ">
                            <div class="col">
                                <table id="makeEditable" data-tid="tableDur" class="table table-bordered table-striped table-responsive-md" border="2" cellpadding="2">
                                    <thead class="text-center">
                                        <tr>									
                                            <th style="width: 110px;">Time</th>
                                            <th>BP</th>
                                            <th>Pulse</th>
                                            <th style="width: 87px">UF Rate</th>
                                            <th style="width: 110px">UF Volume</th>
                                            <th>BF Rate</th>
                                            <th>AP</th>
                                            <th>VP</th>
                                            <th>TMP</th>
                                            <th>KT/V</th>
                                            <th>URR</th>
                                        </tr>
                                    </thead>
                                    <tbody>

                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-2 offset-md-10">
                                <button id="patientParaAdd" type="button" class="btn btn-primary preventDefault" title="Add Parameters" title="Click to add a new row">Add</button>
                            </div>
                        </div>
                        <div class="row ">
                            <div class="col-6">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="form-group">
                                            <label for="techDurDiagDrugs">Drugs Given:<span class="text-danger">*</span></label>
                                            <select class="form-control" id="inputDrugs" required>
                                                <option value="None" selected>None</option>
                                                <c:forEach items="${sessionScope.DrugsCommons}" var="data">
                                                    <option>${data}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <div class="form-group">
                                            <label for="techDurDiagHepar">Heparinization:<span class="text-danger">*</span></label>
                                            <input type="number" id="techDurDiagHepar" class="form-control" placeholder="" maxlength="10" value="" required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <div class="form-group">
                                            <label for="techDurDiagUF">UF:<span class="text-danger">*</span></label>
                                            <input type="number" id="techDurDiagUF" class="form-control" placeholder="" maxlength="10" value="" required>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="form-group">
                                            <label for="techDurDiagIssues">Issues:</label>
                                            <textarea rows="8" id="techDurDiagIssues" class="form-control" placeholder="" maxlength="240"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <hr>
                        <div class="row text-center">
                            <div class="col">
                                <h2 class="ACheader" style="color: #461b2f;">Post-Dialysis Assessment:</h2>
                            </div>
                        </div>
                        <br>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="tectSiteCondn">Access Site Condition Acceptable:</label>
                                    <select class="form-control" id="techAccsSiteCondnPost">
                                        <option value="" selected>Select..</option>
                                        <option value="Y">Yes</option>
                                        <option value="N">No</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="tectSiteCondnNO">If NO, Explain:</label>
                                    <input type="text" id="tectSiteCondnNOPost" class="form-control" placeholder="Enter Reason" maxlength="90" value="">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <label for="">Patient Condition:</label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12">
                                <div class="form-group form-check-inline row pl-4">
                                    <div class="custom-control custom-checkbox pr-5">
                                        <input type="checkbox" id="techCBPostDiagBPH" class="custom-control-input postDialChk" data-id="1" value="">
                                        <label class="custom-control-label" for="techCBPostDiagBPH">
                                            BP High
                                        </label>
                                    </div>
                                    <div class="custom-control custom-checkbox pr-5">
                                        <input type="checkbox" id="techCBPostDiagBPL" class="custom-control-input postDialChk" data-id="2" value="">
                                        <label class="custom-control-label" for="techCBPostDiagBPL">
                                            BP Low
                                        </label>
                                    </div>
                                    <div class="custom-control custom-checkbox pr-5">
                                        <input type="checkbox" id="techCBPostDiagNau" class="custom-control-input postDialChk" data-id="3" value="">
                                        <label class="custom-control-label" for="techCBPostDiagNau">
                                            Nausea
                                        </label>
                                    </div>
                                    <div class="custom-control custom-checkbox pr-5">
                                        <input type="checkbox" id="techCBPostDiagVom" class="custom-control-input postDialChk" data-id="4" value="">
                                        <label class="custom-control-label" for="techCBPostDiagVom">
                                            Vomiting
                                        </label>
                                    </div>
                                    <div class="custom-control custom-checkbox pr-5">
                                        <input type="checkbox" id="techCBPostDiagSB" class="custom-control-input postDialChk" data-id="5" value="">
                                        <label class="custom-control-label" for="techCBPostDiagSB">
                                            Short Breath
                                        </label>
                                    </div>
                                    <div class="custom-control custom-checkbox pr-5">
                                        <input type="checkbox" id="techCBPostDiagBleed" class="custom-control-input postDialChk" data-id="6" value="">
                                        <label class="custom-control-label" for="techCBPostDiagBleed">
                                            Bleeding
                                        </label>
                                    </div>
                                </div>
                                <div class="form-group form-check-inline row pl-4">
                                    <div class="custom-control custom-checkbox pr-5">
                                        <input type="checkbox" id="techCBPostDiagEdema" class="custom-control-input postDialChk" data-id="7" value="">
                                        <label class="custom-control-label" for="techCBPostDiagEdema">
                                            Edema
                                        </label>
                                    </div>
                                    <div class="custom-control custom-checkbox pr-5">
                                        <input type="checkbox" id="techCBPostDiagHypo" class="custom-control-input postDialChk" data-id="8" value="">
                                        <label class="custom-control-label" for="techCBPostDiagHypo">
                                            Hypoglycemia
                                        </label>
                                    </div>
                                    <div class="custom-control custom-checkbox pr-5">
                                        <input type="checkbox" id="techCBPostDiagDiarr" class="custom-control-input postDialChk" data-id="9" value="">
                                        <label class="custom-control-label" for="techCBPostDiagDiarr">
                                            Diarrhea
                                        </label>
                                    </div>
                                    <div class="custom-control custom-checkbox pr-5">
                                        <input type="checkbox" id="techCBPostDiagOrtho" class="custom-control-input postDialChk" data-id="10" value="">
                                        <label class="custom-control-label" for="techCBPostDiagOrtho">
                                            Orthostatic Hypotension 
                                        </label>
                                    </div>
                                    <div class="custom-control custom-checkbox pr-5">
                                        <input type="checkbox" id="techCBPostDiagDizz" class="custom-control-input postDialChk" data-id="11" value="">
                                        <label class="custom-control-label" for="techCBPostDiagDizz">
                                            Dizziness
                                        </label>
                                    </div>
                                    <div class="custom-control custom-checkbox pr-5">
                                        <input type="checkbox" id="techCBPostDiagOther" class="custom-control-input postDialChk" data-id="12" value="">
                                        <label class="custom-control-label" for="techCBPostDiagOther">
                                            Other
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-6">
                                <div class="form-group">
                                    <label for="techPostDiagWeight">Post-Dialysis weight:<span class="text-danger">*</span></label>
                                    <input type="number" class="form-control" id="techPostDiagWeight" placeholder="Enter weight (DD.d KG)" step="any" value="" required>
                                </div>
                            </div>
                        </div>
                        <div class="row" style="display: none;">
                            <div class="col">
                                <table id="postDialCondn" border="1" cellpadding="2">
                                    <tbody>
                                        <tr>
                                            <td class="cell1">BP High: <i>No</i></td>
                                            <td class="cell2">BP Low: <i>No</i></td>
                                            <td class="cell10">Orthostatic Hypotension: <i>No</i></td>
                                            <td class="cell4">Vomiting: <i>No</i></td>
                                            <td class="cell5">Short Breath: <i>Yes</i></td>
                                            <td class="cell6">Bleeding: <i>No</i></td>
                                        </tr>
                                        <tr>
                                            <td class="cell3">Nausea: <i>No</i></td>
                                            <td class="cell7">Edema: <i>No</i></td>
                                            <td class="cell8">Hypoglycemia: <i>Yes</i></td>
                                            <td class="cell9">Diarrhea: <i>No</i></td>
                                            <td class="cell11">Dizziness: <i>No</i></td>
                                            <td class="cell12">Other: <i>No</i></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="techPostNote">Notes:</label>
                                    <textarea class="form-control" id="techPostNote"></textarea>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="">Discharge:<span class="text-danger">*</span></label>
                                    <select id="techDischarge" class="form-control" required>
                                        <option value="">Select..</option>
                                        <option>Walking</option>
                                        <option>Wheelchair</option>
                                        <option>Ambulance</option>
                                        <option>Human Support</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="techEarlyDis">Early Discharge:</label>
                                    <select id="techEarlyDis" class="form-control">
                                        <option value="" selected>Select..</option>
                                        <option value="1">Yes</option>
                                        <option value="0">No</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="techDietNote">Dietician Notes:</label>
                                    <textarea class="form-control" id="techDietNote" maxlength="90"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row justify-content-md-center">
                        <div class="col-md-2">
                            <button id="jsPDF-dialysis" class="btn btn-light btn-lg">Print Dialysis Sheet</button>
                        </div>
                    </div>
                    <div class="row ">
                        <div class="col text-left">
                            <h2 class="ACheader" style="color: #461b2f;"><center>Pharmacy Bill</center></h2>
                        </div>
                    </div>
                    <br>
                    <!--                        
                    <div class="col">
                        <div class="form-group">
                            <label for="pharmItem">Item:</label>
                            <select id="pharmItem" class="form-control">
                                <option>Select..</option>
                                <option selected="">Dialyzer</option>
                                <option>Iron Sucrose</option>
                                <option>EPO</option>
                                <option>Blood Tubing</option>
                    -->
                    <div class="row">
                        <div class="col-12">
                            <table id="PharmTable" class="table table-bordered table-striped table-responsive-md">
                                <thead class="text-center">
                                    <tr>
                                        <th>Items</th>
                                        <th>Quantity</th>
                                        <th>Bill No.</th>
                                        <th>Action</th>
                                        <!--                                        <th>CUT</th>
                                                                                    <th>Price</th>-->
                                    </tr>
                                </thead>
                                <tbody class="text-center">
                                    <tr>
                                        <td>
                                            <select class="tabPharmItem form-control" required>
                                                <option value="none">None</option>
                                                <option>Iron sucrose</option>
                                                <option>Antibotic</option>
                                                <option>Multivitamin</option>
                                                <option>EPO 4000</option>
                                                <option>EPO Renocel 10000</option>
                                            </select>
                                        </td>
                                        <td><input type="number" class="tabPharmNumber form-control" required></td>
                                        <td><input type="text" class="tabPharmBillNo form-control"  maxlength="15" required></td>
                                        <td></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-2 offset-md-10">
                            <button id="addPharmTab" class="btn btn-primary preventDefault" title="Add item to below table">Add Item</button>
                            <!--<button id="patientBillAdd" class="btn btn-primary preventDefault" title="Add item to below table">Add Item</button>-->
                        </div>
                    </div>
                    <div class="row ">
                        <div class="col text-left">
                            <h2 class="ACheader" style="color: #461b2f;"><center>Billings:</center></h2>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-2 col-md-4">
                            <div class="form-group">
                                <label for="techPUData">Paid/Unpaid:<span class="text-danger">*</span></label>
                                <select class="form-control" id="techPUData" required>
                                    <option selected value="">Select..</option>
                                    <option value="paid">Paid</option>
                                    <option value="unpaid">Unpaid</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-4">
                            <div class="form-group">
                                <label for="regFee">Registration Fee:<span class="text-danger">*</span></label>
                                <input type="number" id="regFee" class="form-control calcTotsAmt" placeholder="" value="" required>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-4">
                            <div class="form-group">
                                <label for="therFee">Therapy Fee:<span class="text-danger">*</span></label>
                                <input type="number" id="therFee" class="form-control calcTotsAmt" placeholder="" value="" required>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-4">
                            <div class="form-group">
                                <label for="dialFee">Dialyzer Fee:<span class="text-danger">*</span></label>
                                <input type="number" id="dialFee" class="form-control calcTotsAmt" placeholder="" value="" required>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-4">
                            <div class="form-group">
                                <label for="dialFee">Other Service Fee:<span class="text-danger">*</span></label>
                                <input type="number" id="othServFee" class="form-control calcTotsAmt" placeholder="" value="        " required>
                            </div>
                        </div>
                        <div class="col-lg-2 col-md-4">
                            <div class="form-group">
                                <label for="dialFee">Other Services:<span class="text-danger">*</span></label>
                                <input type="text" id="othServ" class="form-control calcTotsAmt" placeholder="" value="" required>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-lg-3 col-md-4">
                            <div class="form-group">
                                <label for="staticTots">Total:</label>
                                <input type="text" readonly class="form-control" id="staticTots">
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-4 billingsShow" style="display: none;">
                            <div class="form-group">
                                <label for="billingNo">Billins No.:</label>
                                <input type="text" class="form-control" id="billingNo" name="billingNo">
                            </div>
                        </div>
                    </div>

                    <div class="row text-center">
                        <div class="col text-left">
                            <h2 class="ACheader" style="color: #461b2f;">Consumables</h2>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col">
                            <div class="form-group">
                                <label for="tectConsumCat">Category:<span class="text-danger">*</span></label>
                                <input id="tectConsumCat" class="form-control" readonly value="">
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="tectConsumIVSet">IV Set:<span class="text-danger">*</span></label>
                                <select id="tectConsumIVSet" class="form-control">
                                    <option>0</option>
                                    <option selected>1</option>
                                    <option>2</option>
                                </select>
                                <!--<input type="number" id="tectConsumIVSet" class="form-control" placeholder="" value="1" required>-->
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="tectConsumHA">Heparin Ampule:<span class="text-danger">*</span></label>
                                <input type="number" id="tectConsumHA" class="form-control" placeholder="" value="" readonly>
                                <!--                            <select id="tectConsumHA" class="form-control">
                                                                <option>0</option>
                                                                <option>1</option>
                                                                <option>2</option>
                                                            </select>-->
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="tectConsumHepMl">HEPARIN in ML:<span class="text-danger">*</span></label>
                                <input type="number" id="tectConsumHepMl" class="form-control" placeholder="" value="" required>
                                <!--                            <select id="tectConsumHepMl" class="form-control">
                                                                <option>0</option>
                                                                <option>1</option>
                                                                <option>2</option>
                                                            </select>-->
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="form-group">
                                <label for="tectConsumTubing">TUBING:<span class="text-danger">*</span></label>
                                <select id="tectConsumTubing" class="form-control">
                                    <option selected>0</option>
                                    <option>1</option>
                                    <option>2</option>
                                </select>
                                <!--<input type="number" id="tectConsumTubing" class="form-control" placeholder="" value="1" required>-->
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="tectConsumNS500">NS 500:<span class="text-danger">*</span></label>
                                <select id="tectConsumNS500" class="form-control">
                                    <option selected>0</option>
                                    <option>1</option>
                                    <option>2</option>
                                </select>
                                <!--<input type="number" id="tectConsumNS500" class="form-control" placeholder="" value="1" required>-->
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="tectConsumNS1k">NS 1K:<span class="text-danger">*</span></label>
                                <select id="tectConsumNS1k" class="form-control">
                                    <option selected>0</option>
                                    <option>1</option>
                                    <option>2</option>
                                </select>
                                <!--<input type="number" id="tectConsumNS1k" class="form-control" placeholder="" value="0" required>-->
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="tectConsumKit">ON/OFF KIT:<span class="text-danger">*</span></label>
                                <select id="tectConsumKit" class="form-control">
                                    <option selected>0</option>
                                    <option>1</option>
                                    <option>2</option>
                                </select>
                                <!--<input type="number" id="tectConsumKit" class="form-control" placeholder="" value="1" required>-->
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="form-group">
                                <label for="tectConsumSyringe10ml">SYRINGE 10ML:<span class="text-danger">*</span></label>
                                <select id="tectConsumSyringe10ml" class="form-control">
                                    <option selected>0</option>
                                    <option>1</option>
                                    <option>2</option>
                                </select>
                                <!--<input type="number" id="tectConsumSyringe10ml" class="form-control" placeholder="" value="1" required>-->
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="tectConsumF6">F6:<span class="text-danger">*</span></label>
                                <select id="tectConsumF6" class="form-control">
                                    <option selected>0</option>
                                    <option>1</option>
                                    <option>2</option>
                                </select>
                                <!--<input type="number" id="tectConsumF6" class="form-control" placeholder="" value="1" required>-->
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="tectConsumTP">TP:<span class="text-danger">*</span></label>
                                <select id="tectConsumTP" class="form-control">
                                    <option selected>0</option>
                                    <option>1</option>
                                    <option>2</option>
                                </select>
                                <!--<input type="number" id="tectConsumTP" class="form-control" placeholder="" value="0" required>-->
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="tectConsumF8">F8:<span class="text-danger">*</span></label>
                                <select id="tectConsumF8" class="form-control">
                                    <option selected>0</option>
                                    <option>1</option>
                                    <option>2</option>
                                </select>
                                <!--<input type="number" id="tectConsumF8" class="form-control" placeholder="" value="0" required>-->
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="form-group">
                                <label for="tectConsumSyringe20ML">SYRINGE 20ML:<span class="text-danger">*</span></label>
                                <select id="tectConsumSyringe20ML" class="form-control">
                                    <option selected>0</option>
                                    <option>1</option>
                                    <option>2</option>
                                </select>
                                <!--<input type="number" id="tectConsumSyringe20ML" class="form-control" placeholder="" value="1" required>-->
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="tectConsum16GNeedle">16G NEEDLE:<span class="text-danger">*</span></label>
                                <select id="tectConsum16GNeedle" class="form-control">
                                    <option selected>0</option>
                                    <option>1</option>
                                    <option>2</option>
                                </select>
                                <!--<input type="number" id="tectConsum16GNeedle" class="form-control" placeholder="" value="1" required>-->
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="tectConsum17GNeedle">17G Needle:<span class="text-danger">*</span></label>
                                <select id="tectConsum17GNeedle" class="form-control">
                                    <option selected>0</option>
                                    <option>1</option>
                                    <option>2</option>
                                </select>
                                <!--<input type="number" id="tectConsum17GNeedle" class="form-control" placeholder="" value="1" required>-->
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="tectConsumAPart">A PART:<span class="text-danger">*</span></label>
                                <input id="tectConsumAPart" class="form-control" readonly value="0.5">
                                <!--<input type="number" id="tectConsumAPart" class="form-control" placeholder="" value="1" required>-->
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="form-group">
                                <label for="tectConsumBPart">B PART:<span class="text-danger">*</span></label>
                                <select id="tectConsumBPart" class="form-control">
                                    <option>0</option>
                                    <option selected>1</option>
                                    <option>2</option>
                                </select>
                                <!--<input type="number" id="tectConsumBPart" class="form-control" placeholder="" value="0" required>-->
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="tectConsumD25per">D25%:<span class="text-danger">*</span></label>
                                <select id="tectConsumD25per" class="form-control">
                                    <option selected>0</option>
                                    <option>1</option>
                                    <option>2</option>
                                </select>
                                <!--<input type="number" id="tectConsumD25per" class="form-control" placeholder="" value="1" required>-->
                            </div>
                        </div>
                        <div class="col">
                            <div class="form-group">
                                <label for="tectConsumBsheet">Bedsheets:<span class="text-danger">*</span></label>
                                <select id="tectConsumBsheet" class="form-control">
                                    <option>0</option>
                                    <option selected>1</option>
                                    <option>2</option>
                                </select>
                                <!--<input type="number" id="tectConsumBsheet" class="form-control" placeholder="" value="1" required>-->
                            </div>
                        </div>
                    </div>
                    <div class="row text-center">
                        <div class="col text-left">
                            <h2 class="ACheader" style="color: #461b2f;">Investigation</h2>
                        </div>
                    </div>
                    <br>
                    <div class="row">
                        <div class="col">
                            <div class="form-group">
                                <label for="techInsNote">Doctor Notes:</label>
                                <textarea class="form-control" id="techInsNote">NA</textarea>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-8">

                        </div>
                        <div class="col-4">
                            <button onClick="refreshPage()" class="btn btn-success">Reset</button>
                            <button id="TechSubmit" class="btn btn-success preventDefault">Submit</button>
                        </div>
                    </div>
                </form>
            </fieldset>
        </div>
        <script>
            function refreshPage() {
                window.location.reload();
            }
            $(document).ready(function () {
                
                $(".TChead").addClass('active');
                $(".DPhead").removeClass('active');
                $(".AChead").removeClass('active');
                $(".DVhead").removeClass('active');
                $(".PLhead").removeClass('active');
                
                if ("${sessionScope.locs}") {
                    $('#techCentre').val("${sessionScope.locs}");
                }

                $(document).on("change", ".calcTotsAmt", function (e) {
                    if ($('#othServFee').val() && $('#regFee').val() && $('#therFee').val() && $('#dialFee').val()) {
                        $('#staticTots').val(parseInt($('#othServFee').val()) + parseInt($('#regFee').val()) + parseInt($('#therFee').val()) + parseInt($('#dialFee').val()));
                    } else {
                        $('#staticTots').val('Fill above fields');
                    }
                });

                $(document).on('change', '#tectConsumHepMl', function () {
                    var HepMI = $(this).val();
                    $('#tectConsumHA').val(HepMI / 25000);
                });

                $(document).on("click", ".startSession", function (e) {
                    $('.startDiv').css('display', 'none');
                    $('.fieldDiv').css('display', '');

                });

                $(document).on('click', '#jsPDF-dialysis', function (e) {
                    e.preventDefault();

                    $('.preDialChk').each(function () {
                        if ($(this).prop('checked')) {
                            $('#preDialCondn > tbody').find('.cell' + $(this).data('id')).find('i').text("Yes");
                        } else {
                            $('#preDialCondn > tbody').find('.cell' + $(this).data('id')).find('i').text("No");
                        }
                    });
                    $('.postDialChk').each(function () {
                        if ($(this).prop('checked')) {
                            $('#postDialCondn > tbody').find('.cell' + $(this).data('id')).find('i').text("Yes");
                        } else {
                            $('#postDialCondn > tbody').find('.cell' + $(this).data('id')).find('i').text("No");
                        }
                    });

                    var doc = new jsPDF();
                    var img = new Image();
                    img.crossOrigin = "";
                    img.src = "/VIDUR/resources/images/Header-DS.PNG";
                    img.onload = function () {
                        doc.addImage(img, 'JPEG', 15, 10, 180, 30);

                        doc.setFontSize(10);
                        doc.text(15, 48, "Patient Id : " + $("#hidnPatientId").val());
                        doc.text(15, 55, "Patient Name : " + $("#techPatName").val());
                        doc.text(80, 55, "Patient Arrival Time: " + new Date().toDateString().slice(4) + " at " + $('#techStartTime').val());
                        doc.text(15, 65, "(SCH/EMG) : " + $("#emerData option:selected").text());
                        doc.text(80, 65, "Dialyzer ID : " + $("#techDiagID").val());
                        doc.text(150, 65, "Machine ID : " + $("#techMachID").val());
                        doc.text(15, 75, "Access AVF/CAN : " + $("#techAccessPoint").val());
                        doc.text(80, 75, "Opening Technician ID : " + $("#techOpenID").val());
                        doc.text(150, 75, "Closing Technician ID : " + $("#techCloseID").val());
                        doc.setFontSize(15);
                        doc.text(50, 85, "PRE-DIALSIS ASSESSMENT");
                        doc.setFontSize(10);
                        doc.text(15, 95, "Site Condition Acceptable : " + $("#techAccessPoint").val());
                        doc.text(90, 95, "If NO, Explain : " + $("#techAccessPoint").val());
                        doc.text(15, 105, "1. Patient Condition (Tick all applicalble)         Pre-Dialysis Patient Weight : " + $("#techAccessPoint").val() + "(DD.d KG)");
                        var res = doc.autoTableHtmlToJson($('#preDialCondn').get(0), true);
                        var res2 = doc.autoTableHtmlToJson($('#postDialCondn').get(0), true);
                        var para = doc.autoTableHtmlToJson($('#makeEditable').get(0), true);
                        console.log(res);
                        doc.autoTable(res.columns, res.data, {margin: {top: 115}, pageBreak: 'avoid'});
                        doc.text(15, doc.autoTable.previous.finalY + 10, "Notes :" + $("#techPreNote").val());
                        doc.setFontSize(15);
                        doc.text(50, doc.autoTable.previous.finalY + 25, "PATIENT PARAMETER DURING DIALYSIS");
                        doc.setFontSize(10);
                        doc.autoTable(para.columns, para.data, {
                            theme: 'striped',
                            margin: {top: doc.autoTable.previous.finalY + 35},
                            pageBreak: 'auto',
                            showHeader: 'everyPage',
                        });
                        doc.setFontSize(10);
                        doc.text(15, doc.autoTable.previous.finalY + 10, "Drugs Given : " + $('#inputDrugs').val());
                        doc.text(90, doc.autoTable.previous.finalY + 10, "Heparinization : " + $('#techDurDiagHepar').val());
                        doc.text(160, doc.autoTable.previous.finalY + 10, "UF : " + $('#techDurDiagUF').val());
                        doc.text(15, doc.autoTable.previous.finalY + 20, "Issues : " + $('#techDurDiagIssues').val());
                        doc.setFontSize(15);
                        var y = 0;
                        if (doc.autoTable.previous.finalY + 110 > doc.internal.pageSize.height) {
                            y = 0
                            doc.addPage();
                        } else {
                            y = doc.autoTable.previous.finalY + 20;
                        }
                        doc.text(50, y + 25, "POST-DIALYSIS ASSESSMENT");
                        doc.setFontSize(10);
                        doc.text(15, y + 31, "1. Patient Condition (Tick all applicalble)         Pre-Dialysis Patient Weight : " + $('#techPostDiagWeight').val());
                        doc.autoTable(res2.columns, res2.data, {margin: {top: y + 40}});
                        doc.text(15, doc.autoTable.previous.finalY + 10, "Notes : " + $('#techPostNote').val());
                        doc.text(15, doc.autoTable.previous.finalY + 20, "Discharge : " + $('#techDischarge').val());
                        doc.text(15, doc.autoTable.previous.finalY + 30, "Dietician Notes : " + $('#techDietNote').val());
                        doc.text(15, doc.autoTable.previous.finalY + 40, "Technician Signature/Date : _________________");
                        doc.save("dialysis.pdf");
                    };
                });
            });
        </script>
        <jsp:include page="../../UI-Template/footer.jsp"></jsp:include>
    </body>
</html>