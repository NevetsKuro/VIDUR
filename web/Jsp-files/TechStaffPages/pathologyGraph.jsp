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
                    <h1><center>Pathology Lab</center></h1>
                    <div class="row ">
                        <div class="col">
                            <h2 class="ACheader" style="color: #461b2f;">Add Patient Pathology Data</h2>
                        </div>
                    </div>
                    <form id="Path_form" action="/VIDUR/Tech/addPathoServlet" method="POST">
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathPatientId">Patient Id:<span class="text-danger">*</span></label>
                                    <input type="text" list="browsers" id="pathPatientId" name="pathPatientId" class="form-control"  value="" required>
                                    <datalist id="browsers" class="appendPatients">
                                    </datalist>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathDate">Date:<span class="text-danger">*</span></label>
                                    <input type="date" id="pathDate" name="pathDate" class="form-control" value="" max="" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathHB">Hb:<span class="text-danger">*</span></label>
                                    <input type="number" id="pathHB" name="pathHB" class="form-control" step="any" min="0" max="20" value="0" required>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathWBC">WBC:<span class="text-danger">*</span></label>
                                    <input type="number" id="pathWBC" name="pathWBC" class="form-control" step="any" min="4000" max="11000" value="0" required>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathPlatelet">Platelet:<span class="text-danger">*</span></label>
                                    <input type="number" id="pathPlatelet" name="pathPlatelet" class="form-control" step="any" min="1000" max="150000" step="any" placeholder="" value="0" required>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathBUN">BUN:</label>
                                    <input type="number" id="pathBUN" name="pathBUN" class="form-control" step="any" placeholder="" value="0">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathCrea">Creatinie:</label>
                                    <input type="number" id="pathCrea" name="pathCrea" class="form-control" step="any" placeholder="" value="0">
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathUric">Uric Acid:</label>
                                    <input type="number" id="pathUric" name="pathUric" class="form-control" step="any" placeholder="" value="0">
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathUreo">Sr. Ureo:</label>
                                    <input type="number" id="pathUreo" name="pathUreo" class="form-control" step="any" placeholder="" value="0">
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathNa">Na:</label>
                                    <input type="number" id="pathNa" name="pathNa" class="form-control" step="any" placeholder="" value="0">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathK">K:</label>
                                    <input type="number" id="pathK" name="pathK" class="form-control" step="any" placeholder="" value="0">
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathCl">Cl:</label>
                                    <input type="number" id="pathCl" name="pathCl" class="form-control" step="any" placeholder="" value="0">
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathProt">Sr. Protein:</label>
                                    <input type="number" id="pathProt" name="pathProt" class="form-control" step="any" placeholder="" value="0">
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathCa">Ca:</label>
                                    <input type="number" id="pathCa" name="pathCa" class="form-control" step="any" placeholder="" value="0">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathPo4">Po4:</label>
                                    <input type="number" id="pathPo4" name="pathPo4" class="form-control" step="any" placeholder="" value="0">
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathAlb">Alb:</label>
                                    <input type="number" id="pathAlb" name="pathAlb" class="form-control" step="any" placeholder="" value="0">
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathPTH">PTH:</label>
                                    <input type="number" id="pathPTH" name="pathPTH" class="form-control" step="any" placeholder="" value="0"/>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathBillrubin">Billrubin:</label>
                                    <input type="number" id="pathBillrubin" name="pathBillrubin" class="form-control" step="any" placeholder="" value="0">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathSGOT">SGOT:</label>
                                    <input type="number" id="pathSGOT" name="pathSGOT" class="form-control" step="any" placeholder="" value="0">
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathSGPT">SGPT:</label>
                                    <input type="number" id="pathSGPT" name="pathSGPT" class="form-control" step="any" placeholder="" value="0"/>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathAlkPo4">Alk Po4:</label>
                                    <input type="number" id="pathAlkPo4" name="pathAlkPo4" class="form-control" step="any" placeholder="" value="0">
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathChol">Cholesterol:</label>
                                    <input type="number" id="pathChol" name="pathChol" class="form-control" step="any" placeholder="" value="0">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathTri">Triglyceride:</label>
                                    <input type="number" id="pathTri" name="pathTri" class="form-control" step="any" placeholder="" value="0"/>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathSFc">S. Fc:</label>
                                    <input type="number" id="pathSFc" name="pathSFc" class="form-control" step="any" placeholder="" value="0">
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathTIBC">TIBC:</label>
                                    <input type="number" id="pathTIBC" name="pathTIBC" class="form-control" step="any" placeholder="" value="0">
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathTsat">T. sat:</label>
                                    <input type="number" id="pathTsat" name="pathTsat" class="form-control" step="any" placeholder="" value="0"/>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathFerr">Ferratin:</label>
                                    <input type="number" id="pathFerr" name="pathFerr" class="form-control" step="any" placeholder="" value="0">
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathHBAg">HBsAg:</label>
                                    <input type="number" id="pathHBAg" name="pathHBAg" class="form-control" step="any" placeholder="" value="0">
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathHCV">HCV:</label>
                                    <input type="number" id="pathHCV" name="pathHCV" class="form-control" step="any" placeholder="" value="0"/>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathHIV">HIV:</label>
                                    <select id="pathHIV" name="pathHIV" class="form-control">
                                        <option value="">Select..</option>
                                        <option value="0">Negative</option>
                                        <option value="1">Positive</option>
                                    </select>
                                    <!--<input type="number" id="pathHIV" name="pathHIV" class="form-control" step="any" placeholder="" value="0">-->
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="pathCrc">U.CrCl/jt/V:</label>
                                    <input type="number" id="pathCrc" name="pathCrc" class="form-control" step="any" placeholder="" value="0">
                                </div>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-8"></div>
                            <div class="col-4">
                                <button onClick="refreshPage()" class="btn btn-success">Reset</button>
                                <button id="PathSubmit" type="submit" class="btn btn-success">Submit</button>
                            </div>
                        </div>
                    </form>
                </fieldset>
            </div>
            <script>
                function refreshPage() {
                    window.location.reload();
                }
                var msg = '${requestScope.msg}';
                console.log(msg);
                if (msg) {
                    $.alert({
                        title: 'Successful',
                        content: msg,
                        type: 'green',
                        typeAnimated: true,
                    });
                }
                $(document).ready(function () {
                    $(".PLhead").addClass('active');
                    $(".TChead").removeClass('active');
                    $(".DPhead").removeClass('active');
                    $(".AChead").removeClass('active');
                    $(".DVhead").removeClass('active');

                });
        </script>
        <jsp:include page="../../UI-Template/footer.jsp"></jsp:include>
    </body>
</html>
