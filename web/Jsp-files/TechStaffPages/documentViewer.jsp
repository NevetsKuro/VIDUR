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
            <div class="container">
                <div class="row">
                    <div class="col">
                        <h2>Documents Viewer</h2>
                    </div>
                </div>
                <div class="row">
                    <input type="hidden" id="hiddPatId" value="">
                    <div class="col-4">
                        <div class="form-group">
                            <label for="doc_patient_id">Patient ID:</label>
                            <input type="text" list="browsers" id="doc_patient_id" class="form-control" placeholder="Enter Patient ID" value="">
                            <datalist id="browsers" class="appendPatients">
                            </datalist>
                        </div>
                    </div>
                    <div class="col-6">
                        <div class="form-group">
                            <label for="doc_patient_name">Patient Name:</label>
                            <input type="text" id="doc_patient_name" class="form-control" readonly>
                        </div>
                    </div>
                    <div class="col-2">
                        <button id="fetchDocs" class="btn btn-success mt-4">Get Documents</button>
                    </div>
                </div>
                <div class="row">
                    <div class="col mb-5 mt-3">
                        <table id="techDocTable" class="table table-striped table-bordered compact" style="width: 100%">
                            <thead>
                                <tr>
                                    <th>Sr. No</th>
                                    <th>Document Name</th>
                                    <th>Document type</th>
                                    <th>Uploaded By</th>
                                    <th>Uploaded Date</th>
                                    <th>Download File</th>
                                </tr>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>

                    </div>
                </div>
            </div>
            <script>
                $(document).ready(function () {
                    $(".DVhead").addClass('active');
                    $(".DPhead").removeClass('active');

                    var docDT = $("#techDocTable").DataTable();

                    $(document).on('change', '#doc_patient_id', function (e) {
                        e.preventDefault();
                        var patient_id = $(this).val();
                        if (patient_id.length > 8) {
                            $.ajax({
                                url: '/VIDUR/Tech/getPatientDocServlet',
                                type: "GET",
                                data: {patId: patient_id},
                                dataType: "json",
                                success: function (data) {
                                    if (data.patientName) {
                                        $('#doc_patient_name').val(data.patientName);
                                        $('#hiddPatId').val(patient_id);
                                    } else {
                                        $('#doc_patient_name').val("");
                                        $('#hiddPatId').val(patient_id);
                                        $.alert({
                                            title: 'No Record Found',
                                            content: "No Patient Data with patient Id: " + patient_id,
                                            type: 'red',
                                            typeAnimated: true,
                                        });
                                    }
                                },
                                error: function (e) {
                                    $('#doc_patient_name').val("");
                                    console.log(e.responseText);
                                }
                            });
                        }
                    });

                    $(document).on('click', '#fetchDocs', function () {
                        var patId = $('#hiddPatId').val();
                        if (patId) {
                            $.ajax({
                                url: '/VIDUR/Tech/getPatientDocServlet?pat_id=' + patId,
                                type: "POST",
                                dataType: "json",
                                success: function (data) {
                                    console.log(data);
                                    docDT.clear();
                                    if (data.length > 0) {
                                        $.each(data, function (i, v) {
                                            docDT.row.add([
                                                i + 1,
                                                v.fileName,
                                                v.fileType,
                                                v.uploadedBy,
                                                v.uploadTime,
                                                '<center data-id="' + v.fileId + '">' +
                                                        '<form action="/VIDUR/Tech/getDocumentFiles?file_Id=' + v.fileId + '" method="POST">' +
                                                        '<i class="fas fa-download downloadFile cursorOnHover"></i></form></center>'
                                            ]).draw(false);
                                        });
                                    } else {
                                        $.alert({
                                            title: 'Error',
                                            content: "No Files Attached to this Patient",
                                            type: 'red',
                                            typeAnimated: true,
                                        });
                                    }
                                },
                                error: function (e) {
                                    console.log(e.responseText);
                                }
                            });
                        }
                    });

                    $(document).on('click', '.downloadFile', function () {
                        var fileId = $(this).parents('center').data('id');
                        if (fileId) {
                            $(this).parents("form").submit();
                        }
                    });
                });
            </script>
        <jsp:include page="../../UI-Template/footer.jsp"></jsp:include>
    </body>
</html>