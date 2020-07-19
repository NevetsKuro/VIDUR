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
        <div class="container-fluid pt-5">
            <div class="row justify-content-around">
                <div class="col-3 p-0">
                    <fieldset class="card">
                        <div class="card-header">By Patient:</div>
                        <div class="card-body">
                            <div class="form-group ">
                                <div class="row">
                                    <div class="co1-10">
                                        <label for="byPatientId">&nbsp;&nbsp;&nbsp;<b>Patient:</b></label>
                                        <input type="text" list="browsers" id="graph_patient_id" class="form-control ml-2" placeholder="Enter Patient ID" maxlength="30" value="">
                                        <datalist id="browsers" class="appendPatients">
                                        </datalist>
                                    </div>
                                    <div class="col-2">
                                        <button id="graph_patient_search" class="btn btn-sm btn-info" style="margin-top: 32px;"><i class="fas fa-search"></i></button>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label><b>Name: </b><span id="graphName"></span></label><br>
                                <label><b>Age: </b><span id="graphAge"></span></label><br>
                                <label><b>First Session(Dialysis): </b><span id="graphFS"></span></label><br>
                                <label><b>Access Point: </b><span id="graphAP"></span></label><br>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-12 text-center mb-2">
                                        <button id="graph_patient_graph1" class="btn btn-sm btn-info" title="Fetch Graph of patient's Hemoglobin data">HB Trend <i class="fas fa-chart-line"></i></button>
                                    </div>
                                    <div class="col-12 text-center mb-2">
                                        <button id="graph_patient_graph2" class="btn btn-sm btn-info" title="Fetch Graph of patient's Conditions">Patient Condition History <i class="fas fa-chart-line"></i></button>
                                    </div>
                                    <!--                                    <div class="col-12 text-center mb-2">
                                                                            <button id="graph_patient_graph4" class="btn btn-sm btn-info" title="Fetch Graph of patient's Ferratin data">Ferratin Trend <i class="fas fa-chart-line"></i></button>
                                                                        </div>-->
                                    <!--                                    <div class="col">
                                                                            <button id="graph_patient_graph3" class="btn btn-sm btn-info"><i class="fas fa-table"></i></button>
                                                                        </div>-->
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </div>
                <div class="col-8 p-0">
                    <div class="card">
                        <div class="card-header">
                            Charts View:
                        </div>
                        <div class="card-body" style="position: relative;border: 3px solid black; ">
                            <div id="chart1" style="height: 400px;">

                            </div>
                            <div id="chart2" style="display: none;"></div>
                            <div id="calender_container" class="calender_container" style="display: none;">
                                <div id="calendarContainer" style="margin: 20px"></div>
                                <div id="organizerContainer" style="margin: 20px"></div>
                            </div>
                            <!--<canvas id="myChart" width="400" height="400"></canvas>-->
                            <div id="param_table" style="display: none;">
                                <table id="param_comm_table" class="display compact">
                                    <thead>
                                        <tr>
                                            <th>Sr. no</th>
                                            <th>Patient Id</th>
                                            <th>Patient Name</th>
                                            <th>Access Point</th>
                                            <th>First Session</th>
                                            <th>Created date</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>1</td>
                                            <td>19082019SF1</td>
                                            <td>Stark</td>
                                            <td>Cannula</td>
                                            <td>25-09-2019</td>
                                            <td>28-09-2019</td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!--//for PHASE 2-->
                <div class="col-3 p-0" style="display: none;width: 0px;">
                    <fieldset class="card">
                        <div class="card-header">By Parameters:</div>
                        <div class="card-body">
                            <div class="form-group">
                                <div class="row">
                                    <label for="byParameterList">Parameter List:</label>
                                    <select id="paraChange" class="form-control">
                                        <option value="">Select..</option>
                                        <option value="1">By Date</option>
                                        <option value="2">By Patient Condition</option>
                                        <option value="3">By HB levels</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group dateParam" style="display: none">
                                <div class="row">
                                    <label for="fromDate">From Date:</label>
                                    <input type="date" id="fromParaDate" class="form-control" value=""/>
                                </div>
                                <div class="row">
                                    <label for="toDate">To Date:</label>
                                    <input type="date" id="toParaDate" class="form-control" value=""/>
                                </div>
                            </div> 
                            <div class="form-group patCondParam" style="display: none">
                                <div class="row">
                                    <label for="patCondn">Patient Condition:</label>
                                    <select id="preCondn" class="form-control">
                                        <option>Select</option>
                                        <option>option 1</option>
                                        <option>option 2</option>
                                        <option>option 3</option>
                                    </select>
                                </div>
                                <div class="row">
                                    <label for="patCondn">Patient Condition:</label>
                                    <select id="postCondn" class="form-control">
                                        <option>Select</option>
                                        <option>option 1</option>
                                        <option>option 2</option>
                                        <option>option 3</option>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group hbParam" style="display: none">
                                <div class="row">
                                    <label class="col-12" for="patCondn">HB Range:</label>
                                    <div class="col-6">
                                        <input type="number" id="hbUpperRange" class="form-control" placeholder="">
                                    </div>
                                    <div class="col-6">
                                        <input type="number" id="hbLowerRange" class="form-control" placeholder="">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group ParamBtn" style="display: none">
                                <div class="row ">
                                    <div class="col text-center">
                                        <button id="graph_patient_para_search" class="btn btn-sm btn-info" style="margin-top: 32px;">Find</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </fieldset>
                </div>
            </div>
        </div>
        <script>
            /*
             // this function will generate output in this format
             // data = [
             [timestamp, 23],
             [timestamp, 33],
             [timestamp, 12]
             ...
             ]
             */
            function generateDayWiseTimeSeries(baseval, count, yrange) {
                var i = 0;
                var series = [];
                while (i < count) {
                    var y = Math.floor(Math.random() * (yrange.max - yrange.min + 1)) + yrange.min;

                    series.push([baseval, y]);
                    baseval += 86400000;
                    i++;
                }
                return series;
            }
            function convertDate(date) {
                var convertedDate = "";
                var resDate = date.split(' ')[0].split('-');
                if (date) {
                    convertedDate = resDate[2] + '/' + resDate[1] + '/' + resDate[0];
                } else {
                    convertedDate = "No Date given";
                }

                return convertedDate;
            }

            $(document).ready(function () {
                $(".DPhead").addClass('active');
                $(".DVhead").removeClass('active');

                var paramDT = $('#param_comm_table').DataTable({
                    "paging": true,
                    "ordering": false,
                    "info": false
                });

                $(document).on('click', '#graph_patient_para_search', function () {
                    var paraChange = $('#paraChange').val();
                    var fromDate = $('#fromParaDate').val();
                    var toDate = $('#toParaDate').val();
                    var preCondn = $('#preCondn').val();
                    var postCondn = $('#postCondn').val();
                    var uhblevel = $('#hbUpperRange').val();
                    var lhblevel = $('#hbLowerRange').val();
                    if (paraChange) {
                        var data = {
                            "params": paraChange,
                            "fromDate": fromDate,
                            "toDate": toDate,
                            "preCondn": preCondn,
                            "postCondn": postCondn,
                            "hblevel": uhblevel,
                            "hblevel": lhblevel
                        }
                        $.ajax({
                            url: '/VIDUR/Doctor/getDataByParamServlet',
                            type: "POST",
                            data: data,
                            dataType: "json",
                            success: function (data) {
                                console.log(data);
                                paramDT.clear();
                                $.each(data, function (i, v) {
                                    paramDT.row.add([
                                        i + 1,
                                        v.patientId,
                                        v.patientName.split(' ')[0],
                                        v.AccessPoint,
                                        convertDate(v.Fisrt_Session),
                                        v.updated_date
                                    ]).draw(false);
                                });
                            },
                            error: function (e) {
                                console.log(e.responseText);
                            }
                        });
                    }
                });
                $(document).on('change', '#paraChange', function () {
                    switch ($(this).val()) {
                        case "1":
                            $('.ParamBtn').css('display', 'block');
                            $('.dateParam').css('display', 'block');
                            $('.patCondParam').css('display', 'none');
                            $('.hbParam').css('display', 'none');
                            break;
                        case "2":
                            $('.ParamBtn').css('display', 'block');
                            $('.dateParam').css('display', 'none');
                            $('.patCondParam').css('display', 'block');
                            $('.hbParam').css('display', 'none');
                            break;
                        case "3":
                            $('.ParamBtn').css('display', 'block');
                            $('.dateParam').css('display', 'none');
                            $('.patCondParam').css('display', 'none');
                            $('.hbParam').css('display', 'block');
                            break;
                        default :
                            $('.ParamBtn').css('display', 'none');
                            $('.dateParam').css('display', 'none');
                            $('.patCondParam').css('display', 'none');
                            $('.hbParam').css('display', 'none');
                            break;
                    }
                });

                $(document).on('click', '#graph_patient_para_search', function () {
                    $('#chart1').css('display', 'none');
                    $('#chart2').css('display', 'none');
                    $('#calender_container').css('display', 'none');
                    $('#param_table').css('display', 'block');
                });

                $(document).on('click', '#graph_patient_graph1', function () {
                    $('#param_table').css('display', 'none');
                    $('#chart2').css('display', 'none');
                    $('#calender_container').css('display', 'none');
                    $('#chart1').css('display', 'block');
                });
//                $(document).on('click', '#graph_patient_graph2', function () {
//                    $('#chart1').css('display', 'none');
//                    $('#calender_container').css('display', 'none');
//                    $('#chart2').css('display', 'block');
//                });
//                $(document).on('click', '#graph_patient_graph3', function () {
//                    $('#chart1').css('display', 'none');
//                    $('#chart2').css('display', 'none');
//                    $('#calender_container').css('display', 'block');
//                });
                $(document).on('click', '', function () {
                    $('#graph_patient_graph1').val();
                });

                $(document).on('click', '#graph_patient_search', function () {
                    var patient_id = $('#graph_patient_id').val();
                    $.ajax({
                        url: '/VIDUR/Doctor/getPatientDataServlet',
                        type: "GET",
                        data: {patId: patient_id},
                        dataType: "json",
                        success: function (data) {
                            if (data) {
                                $('#graphName').text(data.patientName.toUpperCase());
                                if (data.Birthdate != "") {
                                    var bday = (new Date().getFullYear() - new Date(data.Birthdate).getFullYear())
                                    $('#graphAge').text(bday);
                                }
                                var date = convertDate(data.Fisrt_Session);
                                $('#graphFS').html((date == "12/12/2000" ? "<b>TBA</b>" : date));
                                $('#graphAP').text(data.AccessPoint == "F" ? "Fistula" : "Cannula");
                            }
                        },
                        error: function (e) {
                            console.log(e.responseText);
                        }
                    });
                });

//////////////////////////           Charts 3                            ////////////////////////////////////
//
//
//Get your data
//                var data = {};//JSON data
//                var cal_container = document.getElementById('calender_container');
//                $.ajax({
//                    url: '/VIDUR/resources/js/newJson.json',
//                    type: "GET",
//                    dataType: "json",
//                    success: function (data1) {
//                        data = data1;
//                        //Initialize Calendar
//                        var calendar = new AttendanceCalendar(cal_container, data.month, data.year, data.month_index, data.attendance);
//                        //Create Calendar
//                        calendar.Create();
//                    },
//                    error: function (e) {
//                        console.log(e.responseText);
//                    }
//                });
//

                $(document).on("click", "#graph_patient_graph3", function (e) {
                    e.preventDefault();
                    $('#param_table').css('display', 'none');
                    var patId = $('#graph_patient_id').val();
                    if (patId) {
                        $.ajax({
                            url: '/VIDUR/Doctor/getGraphData?caseFor=3&patId=' + patId,
                            type: "GET",
                            dataType: "json",
                            success: function (data) {
                                console.log(data);

                                var calendar = new Calendar("calendarContainer", "small",
                                        ["Monday", 3],
                                        ["#ffc107", "#ffa000", "#ffffff", "#ffecb3"],
                                        {
                                            days: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"],
                                            months: ["January", "Feburary", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
                                            indicator: false,
                                            placeholder: "<span>No Sessions Held</span>"
                                        });
                                var newData1 = [];
                                $.each(data, function (i, v) {
                                    var date = v.date.split(' ')[0];
                                    var tmp = '{"' + date.split('-')[0] + '":{"' + date.split('-')[1] + '":{"' + date.split('-')[2] + '":[{"startTime":"' + v.patStart_time + '","endTime":"' + v.patEnd_time + '","text":"Session"}]}}}';
                                    var tmp1 = JSON.parse(tmp);
                                    newData1.push(tmp1);
                                })
                                var newData = {
                                    2019: {
                                        12: {
                                            25: [
                                                {
                                                    startTime: "12:00",
                                                    endTime: "15:00",
                                                    text: "Session 1"
                                                },
                                                {
                                                    startTime: "16:00",
                                                    endTime: "20:00",
                                                    text: "Session "
                                                }
                                            ]
                                        },
                                        08: {
                                            31: [
                                                {
                                                    startTime: "12:00",
                                                    endTime: "15:00",
                                                    text: "Dialysis Session 1"
                                                },
                                                {
                                                    startTime: "16:00",
                                                    endTime: "20:00",
                                                    text: "Dialysis Day Session 2"
                                                }
                                            ]
                                        }
                                    }
                                };
                                $('#chart2').empty();
                                $('#chart1').css('display', 'none');
                                $('#chart2').css('display', 'none');
                                $('#calender_container').css('display', 'block');

                                var organizer = new Organizer("organizerContainer", calendar, newData1[0]);

                            },
                            error: function (e) {
                                console.log(e.responseText);
                            }
                        });
                    } else {
                        $.alert({
                            title: 'Error',
                            content: "Kindly Enter the patient Id",
                            type: 'red',
                            typeAnimated: true
                        });
                    }
                });



//////////////////////////           Charts 2                            ////////////////////////////////////







                /*
                 // this function will generate output in this format
                 // data = [
                 [timestamp, 23],
                 [timestamp, 33],
                 [timestamp, 12]
                 ...
                 ]
                 */



//////////////////////////           Charts 2                            ////////////////////////////////////
//



//                var chart2 = new ApexCharts(
//                        document.querySelector("#chart2"),
//                        options
//                        );

//                chart2.render();

                $(document).on("click", "#graph_patient_graph2", function (e) {
                    e.preventDefault();
                    var patId = $('#graph_patient_id').val();
                    $.ajax({
                        url: '/VIDUR/Doctor/getGraphData?caseFor=2&patId=' + patId,
                        type: "GET",
                        dataType: "JSON",
                        success: function (data) {
                            console.log(data);
                            var BPhigh = $.grep(data, function (a) {
                                if (a.condn.includes('BP High')) {
                                    a.condnName = 'BP High';
                                    return a;
                                }
                            });
                            var BPhighCondn = [], BPhighCondnDate = [];
                            $.each(BPhigh, function (i, v) {
                                BPhighCondn.push(v.condnName);
                                BPhighCondnDate.push(v.date);
                            });
                            var BPhighGraph = {
                                x: BPhighCondnDate,
                                y: BPhighCondn,
                                mode: 'markers',
                                type: 'scatter',
                                name: 'BP High',
                                marker: {size: 8}
                            };
                            var BPlow = $.grep(data, function (a) {
                                if (a.condn.includes('BP Low')) {
                                    a.condnName = 'BP Low';
                                    return a;
                                }
                            });
                            var BPlowCondn = [], BPlowCondnDate = [];
                            $.each(BPlow, function (i, v) {
                                BPlowCondn.push(v.condnName);
                                BPlowCondnDate.push(v.date);
                            });
                            var BPlowGraph = {
                                x: BPlowCondnDate,
                                y: BPlowCondn,
                                mode: 'markers',
                                type: 'scatter',
                                name: 'BP Low',
                                marker: {size: 8}
                            };
                            var Nausea = $.grep(data, function (a) {
                                if (a.condn.includes('Nausea')) {
                                    a.condnName = 'Nausea';
                                    return a;
                                }
                            });
                            var NauseaCondn = [], NauseaCondnDate = [];
                            $.each(Nausea, function (i, v) {
                                NauseaCondn.push(v.condnName);
                                NauseaCondnDate.push(v.date);
                            });
                            var NauseaGraph = {
                                x: NauseaCondnDate,
                                y: NauseaCondn,
                                mode: 'markers',
                                type: 'scatter',
                                name: 'Nausea',
                                marker: {size: 8}
                            };
                            var Vomiting = $.grep(data, function (a) {
                                if (a.condn.includes('Vomiting')) {
                                    a.condnName = 'Vomiting';
                                    return a;
                                }
                            });
                            var VomitingCondn = [], VomitingCondnDate = [];
                            $.each(Vomiting, function (i, v) {
                                VomitingCondn.push(v.condnName);
                                VomitingCondnDate.push(v.date);
                            });
                            var VomitingGraph = {
                                x: VomitingCondnDate,
                                y: VomitingCondn,
                                mode: 'markers',
                                type: 'scatter',
                                name: 'Vomiting',
                                marker: {size: 8}
                            };
                            var Short_Breath = $.grep(data, function (a) {
                                if (a.condn.includes('Short Breath')) {
                                    a.condnName = 'Short Breath';
                                    return a;
                                }
                            });
                            var Short_BreathCondn = [], Short_BreathCondnDate = [];
                            $.each(Short_Breath, function (i, v) {
                                Short_BreathCondn.push(v.condnName);
                                Short_BreathCondnDate.push(v.date);
                            });
                            var Short_BreathGraph = {
                                x: Short_BreathCondnDate,
                                y: Short_BreathCondn,
                                mode: 'markers',
                                type: 'scatter',
                                name: 'Short Breath',
                                marker: {size: 8}
                            };
                            var Bleeding = $.grep(data, function (a) {
                                if (a.condn.includes('Bleeding')) {
                                    a.condnName = 'Bleeding';
                                    return a;
                                }
                            });
                            var BleedingCondn = [], BleedingCondnDate = [];
                            $.each(Bleeding, function (i, v) {
                                BleedingCondn.push(v.condnName);
                                BleedingCondnDate.push(v.date);
                            });
                            var BleedingGraph = {
                                x: BleedingCondnDate,
                                y: BleedingCondn,
                                mode: 'markers',
                                type: 'scatter',
                                name: 'Bleeding',
                                marker: {size: 8}
                            };
                            var Edema = $.grep(data, function (a) {
                                if (a.condn.includes('Edema')) {
                                    a.condnName = 'Edema';
                                    return a;
                                }
                            });
                            var EdemaCondn = [], EdemaCondnDate = [];
                            $.each(Edema, function (i, v) {
                                EdemaCondn.push(v.condnName);
                                EdemaCondnDate.push(v.date);
                            });
                            var EdemaGraph = {
                                x: EdemaCondnDate,
                                y: EdemaCondn,
                                mode: 'markers',
                                type: 'scatter',
                                name: 'Edema',
                                marker: {size: 8}
                            };
                            var Hypoglycemia = $.grep(data, function (a) {
                                if (a.condn.includes('Hypoglycemia')) {
                                    a.condnName = 'Hypoglycemia';
                                    return a;
                                }
                            });
                            var HypoglycemiaCondn = [], HypoglycemiaCondnDate = [];
                            $.each(Hypoglycemia, function (i, v) {
                                HypoglycemiaCondn.push(v.condnName);
                                HypoglycemiaCondnDate.push(v.date);
                            });
                            var HypoglycemiaGraph = {
                                x: HypoglycemiaCondnDate,
                                y: HypoglycemiaCondn,
                                mode: 'markers',
                                type: 'scatter',
                                name: 'Hypoglycemia',
                                marker: {size: 8}
                            };
                            var Diarrhea = $.grep(data, function (a) {
                                if (a.condn.includes('Diarrhea')) {
                                    a.condnName = 'Diarrhea';
                                    return a;
                                }
                            });
                            var DiarrheaCondn = [], DiarrheaCondnDate = [];
                            $.each(Diarrhea, function (i, v) {
                                DiarrheaCondn.push(v.condnName);
                                DiarrheaCondnDate.push(v.date);
                            });
                            var DiarrheaGraph = {
                                x: DiarrheaCondnDate,
                                y: DiarrheaCondn,
                                mode: 'markers',
                                type: 'scatter',
                                name: 'Diarrhea',
                                marker: {size: 8}
                            };
                            var Orthostatic_Hypotension = $.grep(data, function (a) {
                                if (a.condn.includes('Orthostatic Hypotension')) {
                                    a.condnName = 'Orthostatic Hypotension';
                                    return a;
                                }
                            });
                            var Ortho_HypCondn = [], Ortho_HypCondnDate = [];
                            $.each(Orthostatic_Hypotension, function (i, v) {
                                Ortho_HypCondn.push(v.condnName);
                                Ortho_HypCondnDate.push(v.date);
                            });
                            var Orthostatic_HypotensionGraph = {
                                x: Ortho_HypCondnDate,
                                y: Ortho_HypCondn,
                                mode: 'markers',
                                type: 'scatter',
                                name: 'Orthostatic Hypotension',
                                marker: {size: 8}
                            };
                            var Dizziness = $.grep(data, function (a) {
                                if (a.condn.includes('Dizziness')) {
                                    a.condnName = 'Dizziness';
                                    return a;
                                }
                            });
                            var DizzinessCondn = [], DizzinessCondnDate = [];
                            $.each(Dizziness, function (i, v) {
                                DizzinessCondn.push(v.condnName);
                                DizzinessCondnDate.push(v.date);
                            });
                            var DizzinessGraph = {
                                x: DizzinessCondnDate,
                                y: DizzinessCondn,
                                mode: 'markers',
                                type: 'scatter',
                                name: 'Dizziness',
                                marker: {size: 8}
                            };

                            var dataList = [BPhighGraph, BPlowGraph, NauseaGraph, VomitingGraph,
                                Short_BreathGraph, BleedingGraph, EdemaGraph, HypoglycemiaGraph,
                                DiarrheaGraph, Orthostatic_HypotensionGraph, DizzinessGraph];

                            $('#chart2').empty();
                            $('#chart1').css('display', 'none');
                            $('#calender_container').css('display', 'none');
                            $('#chart2').css('display', 'block');
                            Plotly.newPlot('chart2', dataList, {title:"Patient Condition"}, {showSendToCloud: true});
                        },
                        error: function (e) {
                            console.log(e.responseText);
                        }
                    });
                });


//////////////////////////           Charts 1(Latest Plot.ly)                            ////////////////////////////////////


                $(document).on("click", "#graph_patient_graph1", function (e) {
                    e.preventDefault();
                    $('#param_table').css('display', 'none');
                    var patId = $('#graph_patient_id').val();
                    if (patId) {
                        var HbData = [];
                        var HbDateData = [];
                        $.ajax({
                            async: true,
                            url: '/VIDUR/Doctor/getGraphData?caseFor=1&subCase=1&patId=' + patId,
                            type: "GET",
                            dataType: "json",
                            success: function (data) {
                                console.log(data);
                                $.each(data, function (i, v) {
                                    HbData.push(v.pathHB);
                                    HbDateData.push(v.date);
                                });

                            },
                            error: function (e) {
                                console.log(e.responseText);
                            }
                        });


                        $.ajax({
                            async: true,
                            url: '/VIDUR/Doctor/getGraphData?caseFor=1&subCase=2&patId=' + patId,
                            type: "GET",
                            dataType: "JSON",
                            success: function (data) {
                                console.log(data);
                                var drugsIS = [], drugRangeIS = [];
                                var drugsEPO = [], drugRangeEPO = [];
                                var drugsDex = [], drugRangeDex = [];
                                $.each(data, function (i, v) {
                                    if (v.drugs_given.toLowerCase() == 'iron sucrose') {
                                        drugsIS.push(v.date);
                                        drugRangeIS.push(1);
                                    }
                                    if (v.drugs_given.toUpperCase() == 'EPO') {
                                        drugsEPO.push(v.date);
                                        drugRangeEPO.push(2);
                                    }
                                    if (v.drugs_given.toLowerCase() == 'dextrose') {
                                        drugsDex.push(v.date);
                                        drugRangeDex.push(3);
                                    }
                                });

//                                    x: ['2019-10-04 22:23:00', '2019-10-20 22:23:00', '2019-12-28 22:23:00'],
//                                    y: [11, 5, 17],
                                var HB = {
                                    x: HbDateData,
                                    y: HbData,
                                    mode: 'lines+markers',
                                    type: 'scatter',
                                    name: 'HB data',
                                    marker: {size: 8}
                                };

                                var IS = {
                                    x: drugsIS,
                                    y: drugRangeIS,
                                    mode: 'markers',
                                    type: 'scatter',
                                    name: 'Iron Sucrose',
                                    marker: {size: 8}
                                };

                                var EPO = {
                                    x: drugsEPO,
                                    y: drugRangeEPO,
                                    mode: 'markers',
                                    type: 'scatter',
                                    name: 'EPO',
                                    marker: {size: 8}
                                };

                                var Dex = {
                                    x: drugsDex,
                                    y: drugRangeDex,
                                    mode: 'markers',
                                    type: 'scatter',
                                    name: 'Dextrose',
                                    marker: {size: 8}
                                };

                                var data = [HB, IS, EPO, Dex];

                                $('#chart1').empty();
                                $('#calender_container').css('display', 'none');
                                $('#chart2').css('display', 'none');
                                $('#chart1').css('display', 'block');
                                Plotly.newPlot('chart1', data, {title:"Hemoglobin Graph"}, {showSendToCloud: true});
                            },
                            error: function (e) {
                                console.log(e.responseText);
                            }
                        });
                    } else {
                        $.alert({
                            title: 'Error',
                            content: "Kindly Enter the patient Id",
                            type: 'red',
                            typeAnimated: true
                        });
                    }
                });

            });

//            var trace1 = {
//                x: ['2013-10-04 22:23:00', '2013-11-04 22:23:00', '2013-12-04 22:23:00'],
//                y: [11, 13, 17],
//                mode: 'lines+markers',
//                type: 'scatter',
//                name: 'HB data'
//            };
//
//            var trace2 = {
//                x: ['2013-10-04 22:23:00', '2013-12-02 22:23:00'],
//                y: [10, 16],
//                mode: 'markers',
//                type: 'scatter',
//                name: 'drug taken',
//                marker: {size: 8}
//            };
//
//                var trace3 = {
//                    x: ['2013-10-04 22:23:00', '2013-11-04 22:23:00', '2013-12-04 22:23:00'],
//                    y: [12, 9, 15],
//                    mode: 'lines+markers',
//                    type: 'scatter'
//                };

//            var data = [trace1, trace2];//, trace3];


////////////////////////////////////////////////////////////////////////////////////////////////////
        </script>
    </body>
</html>