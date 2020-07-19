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
        System.out.print("Session : " + sessname);
        if (sessname == null || sessname == "") {
            System.out.print("(IN)Session : " + sessname);
            response.sendRedirect("/VIDUR");
            return;
        }
    %>
    <jsp:include page="../../UI-Template/header.jsp"></jsp:include>
        <body>
            <div class="container-fluid pt-2">
                <fieldset style="padding: 50px;margin: 50px;border: 3px solid grey;border-radius: 5px">
                    <h1><center>Registration Corner Documents</center></h1>

                    <form action="/VIDUR/AC/uploadDocsServlet" method="POST" enctype="multipart/form-data">
                        <div class="form-group row">
                            <label for="patientDocId" class="col-sm-2 col-form-label"><b>Patient ID:</b></label>
                            <div class="col-sm-4">
                                <input type="text" list="browsers" id="patientDocId" name="patientDocId" class="form-control" placeholder="" value="" maxlength="30" required>
                                <datalist id="browsers" class="appendPatients">
<!--                                    <option value="191016DK1">
                                    <option value="191016JM1">
                                    <option value="191030JP1">-->
                                </datalist>
                            </div>
                            <label for="patientDocName" class="col-sm-2 col-form-label"><b>Patient Name:</b></label>
                            <div class="col-sm-4">
                                <input type="text" id="patientDocName" name="patientDocName" class="form-control" placeholder="" value="" readonly required>
                            </div>
                        </div>
                        <div class="form-group row">
                            <label for="inputPassword3" class="col-sm-2 col-form-label"><b>Patient Image:</b></label>
                            <div class="col-sm-4">
                                <input type="file" id="patientDocImage" name="patientDocImage" class="form-control-file">
                            </div>
                            <label for="inputPassword3" class="col-sm-2 col-form-label"><b>Patient Other Docs:</b></label>
                            <div class="col-sm-4">
                                <input type="file" id="patientDocFile" name="patientDocFile" class="form-control-file">
                            </div>
                        </div>
                        <div class="row">
                            <div class="col">
                                <button id="patientDocUpload" class="btn btn-primary" type="submit">Upload</button>
                            </div>
                        </div>
                    </form>
                </fieldset>
            </div>
            <script>
                $(document).ready(function () {
                    $(document).on('change', '#patientDocId', function () {
                        if ($(this).val().length > 7) {
                            $.ajax({
                                url: '/VIDUR/AC/PatientServlet?task=fetchById&patID=' + $('#patientDocId').val(),
                                type: "GET",
                                dataType: "json",
                                success: function (data) {
                                    $('#patientDocName').val(data.patientName);
                                },
                                error: function (e) {
                                    console.log(e.responseText);
                                }
                            });
                        }
                    });

                    var strJoin = "";
                    if ("${str1}") {
                        strJoin += "${str1}";
                    }
                    if ("${str2}") {
                        strJoin += "\n ${str2}";
                    }
                    if (strJoin) {
                        $.alert({
                            title: 'Successful',
                            content: strJoin,
                            type: 'green',
                            typeAnimated: true,
                        });
                    }
                    $(".ACDhead").addClass('active');
                    $(".AChead").removeClass('active');
                    $(".ACLhead").removeClass('active');
                    $(".TChead").removeClass('active');
                    $(".DPhead").removeClass('active');
                });
        </script>
        <jsp:include page="../../UI-Template/footer.jsp"></jsp:include>
    </body>
</html>
