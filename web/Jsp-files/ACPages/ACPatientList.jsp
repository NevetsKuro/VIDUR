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
            <div class="container mt-5 pt-5">
                <div class="row">
                    <div class="col-3"></div>
                    <div class="col-3">
                        <div class="form-group">
                            <label for="fromDate">From Date:</label>
                            <input type="date" id="fromDate" class="form-control" placeholder="">
                        </div>
                    </div>
                    <div class="col-3">
                        <div class="form-group">
                            <label for="toDate">To Date:</label>
                            <input type="date" id="toDate" class="form-control" placeholder="">
                        </div>
                    </div>
                    <div class="col-1">
                        <button id="searchByDate" type="button" class="btn btn-success mt-4"><i class="fas fa-search"></i></button>
                    </div>
                    <div class="col-2"></div>
                </div>
                <div class="row mb-5 ">
                    <div class="col-12">
                        <table id="patientListTable" class="table table-striped table-bordered compact" style="width: 100%">
                            <thead>
                                <tr>
                                    <th>Patient ID</th>
                                    <th>Patient Name</th>
                                    <th>Gender</th>
                                    <th>Age</th>
                                    <th>Access Point</th>
                                    <th>Referring Nephrologist</th>
                                    <th>Location</th>
                                    <th style="width: 100px">Added On</th>
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

                    $(".ACDhead").removeClass('active');
                    $(".AChead").removeClass('active');
                    $(".ACLhead").addClass('active');
                    $(".TChead").removeClass('active');
                    $(".DPhead").removeClass('active');

                    var patListDT = $('#patientListTable').DataTable({
                        columnDefs: [{
                                targets: 5,
                                render: function (data, type, row) {
                                    return data.length > 10 ?
                                            data.substr(0, 10) + '…' :
                                            data;
                                }
                            }]
                    });

                    $.ajax({
                        url: '/VIDUR/AC/PatientServlet?task=fetchAll',
                        type: "GET", dataType: "json",
                        success: function (patList) {
//                            console.log(patList);
                            $.each(patList, function (i, data) {
                                var tmp = data.updated_date.split(' ')[0].split('-');
                                var date = tmp[2] + "/" + tmp[1] + "/" + tmp[0];
                                var bday = (new Date().getFullYear() - new Date(data.Birthdate).getFullYear())
                                patListDT.row.add([
                                    data.patientId,
                                    data.patientName,
                                    data.Gender == "M" ? "Male" : "Female",
                                    bday,
                                    data.AccessPoint == "C" ? "Cannula" : "Fistula",
                                    data.Referring_Nephrologist,
                                    data.Location,
                                    date
                                ]).draw(false);
                            });
                        },
                        error: function (e) {
                            console.log(e.responseText);
                        }
                    })

                    $(document).on('click', '#searchByDate', function () {
                        $.ajax({
                            url: '/VIDUR/AC/PatientServlet?task=fetchByDate&fromDate=' + $('#fromDate').val() + '&toDate=' + $('#toDate').val(),
                            type: "GET",
                            dataType: "json",
                            success: function (patList) {
                                patListDT.clear();
                                if (patList.length > 0) {
                                    $.each(patList, function (i, data) {
                                        var tmp = data.updated_date.split(' ')[0].split('-');
                                        var date = tmp[2] + "/" + tmp[1] + "/" + tmp[0];
                                        var bday = (new Date().getFullYear() - new Date(data.Birthdate).getFullYear())
                                        patListDT.row.add([
                                            data.patientId,
                                            data.patientName,
                                            data.Gender == "M" ? "Male" : "Female",
                                            bday,
                                            data.AccessPoint == "C" ? "Cannula" : "Fistula",
                                            data.Referring_Nephrologist,
                                            data.updated_by,
                                            date
                                        ]).draw(false);
                                    });
                                } else {
                                    $.alert({
                                        title: 'Search Results',
                                        content: 'No Records Found',
                                        type: 'green',
                                        typeAnimated: true,
                                    });
                                }
                            },
                            error: function (e) {
                                console.log(e.responseText);
                            }
                        });
                    });
                });
            </script>
        <jsp:include page="../../UI-Template/footer.jsp"></jsp:include>
    </body>
</html>
