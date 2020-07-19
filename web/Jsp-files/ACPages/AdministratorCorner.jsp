<%-- 
    Document   : AdministratorCorner
    Created on : 24 Jul, 2019, 8:52:31 PM
    Author     : Nevets
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%
        session = request.getSession(false);
        String sessname = (String) session.getAttribute("sessname");
//        System.out.print("Session : " + sessname);
        if (sessname == null || sessname == "") {
//            System.out.print("(IN)Session : " + sessname);
            response.sendRedirect("/VIDUR");
            return;
        }
    %>
    <jsp:include page="../../UI-Template/header.jsp"></jsp:include>
        <body>
            <div class="container-fluid pt-2">
                <fieldset style="padding: 50px;margin: 50px;border: 3px solid grey;border-radius: 5px">
                    <h1><center>Registration Corner</center></h1>
                    <div class="row ">
                        <div class="col">
                            <h2 class="ACheader" style="color: #461b2f;">Add Patient Data</h2>
                        </div>
                    </div>
                    <form id="AC_form" class="needs-validation" novalidate>
                        <div class="row">
                            <div class="col-8">
                                <div class="form-group">
                                    <label for="inputName">Patient Name:<span class="text-danger">*</span></label>
                                    <input type="text" class="form-control" id="inputName" name="inputName" aria-describedby="inputName" placeholder="First Name | Middle Name | LastName" value="" maxlength="45" required>
                                    <small class="form-text text-muted">Kindly enter your full name.</small>
                                    <div class="valid-feedback">
                                        Looks good!
                                    </div>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="form-group">
                                    <label for="inputAP">Access Point:<span class="text-danger">*</span></label>
                                    <select class="form-control" id="inputAP" name="inputAP" required>
                                        <option value="">Select..</option>
                                        <option value="C">Cannula</option>
                                        <option value="F">Fistula</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Select an option!!
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-3">
                                <div class="form-group">
                                    <label for="inputGender">Gender:<span class="text-danger">*</span></label>
                                    <select id="inputGender" name="inputGender" class="form-control" required>
                                        <option value="">Select Gender..</option>
                                        <option value="M">Male</option>
                                        <option value="F">Female</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Select an option!!
                                    </div>
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="form-group">
                                    <label for="inputDate">Birth date:<span class="text-danger">*</span></label>
                                    <input id="inputDate" name="inputDate" type="date" class="form-control" value="" required>
                                    <div class="invalid-feedback">
                                        Enter Birth Date!!
                                    </div>
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="form-group">
                                    <label for="inputPincode">PINCODE :<span class="text-danger">*</span></label>
                                    <input type="number" id="inputPincode" name="inputPincode" class="form-control" placeholder="Enter Pincode" value="" maxlength="10" required>
                                    <div class="invalid-feedback">
                                        Enter Countries PINCODE !!
                                    </div>
                                </div>
                            </div>
                            <div class="col-3">
                                <div class="form-group">
                                    <label for="inputSessIntr">Session Intervals :<span class="text-danger">*</span></label>
                                    <input type="number" id="inputSessIntr" name="inputSessIntr" class="form-control" placeholder="In Minutes (default:60)" value="" required>
                                    <div class="invalid-feedback">
                                        Enter Session Intervals
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-8">
                                <div class="form-group">
                                    <label for="inputAddress">Address:</label>
                                    <textarea class="form-control" id="inputAddress" name="inputAddress" rows="3" style="width: 100%" maxlength="150" required></textarea>
                                    <div class="invalid-feedback">
                                        Enter your current address.
                                    </div>
                                </div>
                            </div>
                            <div class="col-4">
                                <div class="form-group">
                                    <label for="inputCentre">Centre:<span class="text-danger">*</span></label>
                                    <select id="inputCentre" class="form-control" disabled>
                                        <option value="">Select</option>
                                        <option value="GORAI">Gorai</option>
                                        <option value="MIRAROAD">Mira Road</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="table table-bordered p-3 tableContact">
                            <div class="row">
                                <div class="col-12 mb-2 border-bottom border-primary titleTable">Contact List:</div>
                                <hr>
                                <div class="col-3">
                                    <div class="form-group">
                                        <label for="inputTypeContacts">Contact Type</label>
                                    </div>
                                </div>
                                <div class="col-7">
                                    <div class="form-group">
                                        <label for="inputEmergContacts">Contact Number</label>
                                    </div>
                                </div>
                                <div class="col-2">
                                    <div class="form-group">
                                        <label for="">Remove</label>
                                    </div>
                                </div>
                            </div>
                            <div class="row tableConRow">
                                <div class="col-3">
                                    <div class="form-group">
                                        <select class="form-control inputTypeContacts" id="inputTypeContacts">
                                            <option value="">Select..</option>
                                            <option value="Primary">Primary</option>
                                            <option value="Emergency">Emergency</option>
                                            <option value="Others">Others</option>
                                        </select>
                                        <!--                                        <input type="number" class="form-control" id="inputTypeContacts" placeholder="Enter Primary" minlength="8" maxlength="14">-->
                                    </div>
                                </div>
                                <div class="col-7">
                                    <div class="form-group">
                                        <input type="number" id="inputEmergContacts" class="form-control inputEmergContacts" placeholder="Enter Number" minlength="8" maxlength="12" value="">
                                    </div>
                                </div>
                                <div class="col-2">
                                    <div class="form-group text-danger text-center">

                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row cursorOnHover mb-4" title="Click here to add a new row for contacts">
                            <button type="button" class="contactBar btn btn-primary offset-md-10 col-2 align-self-end">Add Contact</button>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="inputBloodgrp">Blood Group:<span class="text-danger">*</span></label>
                                    <select class="form-control" id="inputBloodgrp" required>
                                        <option value="">Select..</option>
                                        <option value="HH">HH</option>
                                        <option value="O+">O+</option>
                                        <option value="A+">A+</option>
                                        <option value="B+">B+</option>
                                        <option value="AB+">AB+</option>
                                        <option value="O-">O-</option>
                                        <option value="A-">A-</option>
                                        <option value="B-">B-</option>
                                        <option value="AB-">AB-</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Select an option!!
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="inputReferNephro">Referring Nephrologist:<span class="text-danger">*</span></label>
                                    <input type="text" id="inputReferNephro" class="form-control" placeholder="Enter reference" value="" maxlength="45" required>
                                    <div class="invalid-feedback">
                                        A Nephrologist is mandatory.
                                    </div>
                                </div>  
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="dateSess">First Dialysis Session:<span class="text-danger">*</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="text-danger"> Not given??</span>&nbsp;&nbsp;<input type="checkbox" class="align-self-end TBHvalue"></label>
                                    <input type="date" id="dateSess" class="form-control" value="">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="noofdialysis">No. of Dialysis Recommended per month:<span class="text-danger">*</span></label>
                                    <input type="number" id="noofdialysis" class="form-control" placeholder="Enter by per month basis" maxlength="2" value="" required>
                                    <div class="invalid-feedback">
                                        Enter number of dialysis per month.
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="awaiTrans">Awaiting Transplant:</label>
                                    <select id="awaiTrans" class="form-control" required>
                                        <option value="">Select..</option>
                                        <option>Yes</option>
                                        <option>No</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Select an option!!
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="ureCalc">CKD 5D, HTN, Right upper ureteric calculus:</label>
                                    <select id="ureCalc" class="form-control">
                                        <option value="">Select..</option>
                                        <option>Yes</option>
                                        <option>No</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Select an option!!
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="stabDec">Stable/Unstable Decision:</label>
                                    <select id="stabDec" class="form-control">
                                        <option value="">Select..</option>
                                        <option>Stable</option>
                                        <option>Unstable</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Select an option!!
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="heartFun">Heart Function:<span class="text-danger">*</span></label>
                                    <select id="heartFun" class="form-control" required>
                                        <option value="">Select..</option>
                                        <option>Normal</option>
                                        <option>ESC</option>
                                        <option>MES</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Select an option!!
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="injFrac">Injection Fraction < 40%</label>
                                    <select id="injFrac" class="form-control">
                                        <option value="">Select..</option>
                                        <option>Yes</option>
                                        <option>No</option>
                                    </select>
                                </div>
                                <div class="invalid-feedback">
                                    Select an option!!
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="bpStable">BP Stable Y/N:<span class="text-danger">*</span></label>
                                    <select id="bpStable" class="form-control" required>
                                        <option value="">Select..</option>
                                        <option>Yes</option>
                                        <option>No</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Select an option!!
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pastHab">Past Habits:</label>
                                    <select id="pastHab" class="form-control">
                                        <option value="">Select..</option>
                                        <option>Tobacco</option>
                                        <option>Alcohol</option>
                                        <option>Restricted Drugs</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Select an option!!
                                    </div>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="lvrFunTest">RFT Test:</label>
                                    <input type="text" id="lvrFunTest" class="form-control" placeholder="" maxlength="30" value="Cirrhosis">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <label for="ecgArr">ECG Arrhythmias:</label>
                                <select id="ecgArr" class="form-control">
                                    <option value="">Select..</option>
                                    <option>Yes</option>
                                    <option>No</option>
                                </select>
                            </div>
                            <div class="col">
                                <label for="typeOfDiet">Type of Diet:</label>
                                <select id="typeOfDiet" class="form-control">
                                    <option value="">Select..</option>
                                    <option>Veg</option>
                                    <option>Non-Veg</option>
                                    <option>Eggovegetarian</option>
                                </select>
                            </div>
                            <div class="col">
                                <label for="iniSymAno">Initial Symptoms - Anorexia</label>
                                <select id="iniSymAno" class="form-control">
                                    <option value="">Select..</option>
                                    <option>Yes</option>
                                    <option>No</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <label for="iniSymVom">Initial Symptoms - Vomiting</label>
                                <select id="iniSymVom" class="form-control">
                                    <option value="">Select..</option>
                                    <option>Yes</option>
                                    <option>No</option>
                                </select>
                            </div>
                            <div class="col">
                                <label for="iniSymNau">Initial Symptoms - Nausea</label>
                                <select id="iniSymNau" class="form-control">
                                    <option value="">Select..</option>
                                    <option>Yes</option>
                                    <option>No</option>
                                </select>
                            </div>
                            <div class="col">
                                <label for="iniSymDia">Initial Symptoms - Diarrhea</label>
                                <select id="iniSymDia" class="form-control">
                                    <option value="">Select..</option>
                                    <option>Yes</option>
                                    <option>No</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-12 text-right m-4">
                                <button onClick="refreshPage()" class="btn btn-success">Reset</button>
                                <button id="ACSubmit" class="btn btn-success">Submit</button>
                            </div>
                        </div>
                    </form>
                </fieldset>
            </div>
            <script>
                function refreshPage() {
                    window.location.reload();
                    $('#inputName').focus();
                }


                $(document).ready(function () {
                    $(".AChead").addClass('active');
                    $(".TChead").removeClass('active');
                    $(".DPhead").removeClass('active');

                    if ("${sessionScope.locs}") {
                        $('#inputCentre').val("${sessionScope.locs}");
                    }
                    $(document).on("click", ".TBHvalue", function (e) {
                        if ($(this).prop('checked')) {
                            $('#dateSess').attr('type', 'text').val("TBA");
                        } else {
                            $('#dateSess').attr('type', 'date').val("");
                        }
                    });
                });
        </script>
        <jsp:include page="../../UI-Template/footer.jsp"></jsp:include>
    </body>
</html>
