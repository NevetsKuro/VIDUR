function AddSecsToTime(addedTime, prev) {//31, 1.30 pm
    var updateMins, timeMins, timeHrs, hrs;

    updateMins = (parseInt(prev.split(":")[1]) + addedTime) % 60; // 1
    timeMins = (updateMins.toString().length > 1 ?
            updateMins
            : "0" + updateMins);//31

    var chck = (parseInt(prev.split(":")[1]) + addedTime); //61
    if (chck > 59) {//true
        hrs = parseInt(chck / 60);//1
        timeHrs = parseInt(prev.split(":")[0]) + hrs;//1 + 1 = 2
        timeHrs = (timeHrs.toString().length > 1 ? timeHrs : "0" + timeHrs);
    } else {
        timeHrs = parseInt(prev.split(":")[0]);//-
    }

    var newTime = (prev == " " ? " " : (timeHrs + ":" + timeMins + " " + prev.split(" ")[1]));
    return newTime;
}

function submit_Tech_form(patientName) {
    var patientSession = new Object();
    patientSession.patientId = patientName.toUpperCase();
    patientSession.patient = {
        "patientName": $('#inputName').val()
    };
    patientSession.access_point = $('#techAccessPoint').val();
    patientSession.patStart_time = $('#techStartTime').val();
    patientSession.patEnd_time = $('#techEndTime').val();
    patientSession.sch_emrg = $('#emerData').val();
    patientSession.paid = $('#techPUData').val();
    patientSession.billno = $('#PharmTable > tbody > tr').find('td:nth-child(3)').find('.tabPharmBillNo').val();
    patientSession.diag_id = $('#techDiagID').val();
    patientSession.diag_condn = $('#inputCondition').val();
    patientSession.mach_id = $('#techMachID').val();
    patientSession.open_tech = $('#techOpenID').val();
    patientSession.close_tech = $('#techCloseID').val();
    //pre dialysis
    patientSession.pre_site_condn = $('#techAccsSiteCondn').val();
    patientSession.pre_condn_no_expl = $('#tectSiteCondnNO').val();
    patientSession.pre_patientWeight = $('#inputprediagWeight').val();
    patientSession.pre_notes = $('#techPreNote').val();
    var patCondns = new Array();
    $('.preDialChk').each(function () {
        if ($(this).prop('checked')) {
            patCondns.push($(this).siblings().text().trim());
        }
    });
    patientSession.pre_patient_condns = patCondns;//array
    //dur dial
    var durArr = new Array();
    $('#makeEditable > tbody > tr').each(function () {
        var durDial = new Object();
        durDial.time = $(this).find('td:nth-child(1)').text();
        durDial.BP = $(this).find('td:nth-child(2)').text();
        durDial.pulse = $(this).find('td:nth-child(3)').text();
        durDial.uf_rate = $(this).find('td:nth-child(4)').text();
        durDial.uf_volume = $(this).find('td:nth-child(5)').text();
        durDial.bf_rate = $(this).find('td:nth-child(6)').text();
        durDial.ap = $(this).find('td:nth-child(7)').text();
        durDial.vp = $(this).find('td:nth-child(8)').text();
        durDial.tmp = $(this).find('td:nth-child(9)').text();
        durDial.ktv = $(this).find('td:nth-child(10)').text();
        durDial.cbv = $(this).find('td:nth-child(11)').text();
        durArr.push(durDial);
    });
    patientSession.arrDurDial = durArr;//array
    patientSession.drugs_given = $('#inputDrugs').val();
    patientSession.drugs_issues = $('#techDurDiagIssues').val();
    patientSession.hepari = $('#techDurDiagHepar').val();
    patientSession.UF = $('#techDurDiagUF').val();
    //post dialysis
    var patCondns2 = new Array();
    $('.postDialChk').each(function () {
        if ($(this).prop('checked')) {
            patCondns2.push($(this).siblings().text().trim());
        }
    });
    patientSession.post_site_condn = $('#techAccsSiteCondnPost').val();
    patientSession.post_condn_no_expl = $('#tectSiteCondnNOPost').val();
    patientSession.post_patientWeight = $('#techPostDiagWeight').val();
    patientSession.post_notes = $('#techPostNote').val();
    patientSession.post_patient_condns = patCondns2;//array
    patientSession.discharge = $('#techDischarge').val();
    patientSession.earlyDis = $('#techEarlyDis').val();
    patientSession.diet_notes = $('#techDietNote').val();
    patientSession.tech_reg = $('#regFee').val();
    patientSession.tech_thera = $('#therFee').val();
    patientSession.tech_dial = $('#dialFee').val();
    patientSession.tech_othserv = $('#othServ').val();
    patientSession.tech_othservamt = $('#othServFee').val();
    patientSession.centreNo = $('#techCentre').val();
    patientSession.billingNo = $('#billingNo').val();
//    patientSession.tech_signature = $('#').val();
    //pharmacy

    var pharmArr = new Array();
    $('#PharmTable > tbody > tr').each(function () {
        var pharm = new Object();
        pharm.itemName = $(this).find('td:nth-child(1)').find('.tabPharmItem').val();
        pharm.qty = $(this).find('td:nth-child(2)').find('.tabPharmNumber').val();
        pharm.bill_no = $(this).find('td:nth-child(3)').find('.tabPharmBillNo').val();
        pharm.cut = 0;//$(this).find('td:nth-child(3)').text();
        pharm.price = 0;
        pharm.sgst = 0;
        pharm.cgst = 0;
        pharm.total = 0;
        pharm.finalTots = 0;
        if (pharm.bill_no != 0 && pharm.bill_no != null && pharm.itemName != 'none') {
            pharmArr.push(pharm);
        }
    });
    patientSession.tech_pharm = pharmArr;
    //consumables
    var consArr = new Array();
    var consObj = new Object();
    consObj.category = $('#tectConsumCat').val();
    consObj.IV_SET = $('#tectConsumIVSet').val();
    consObj.heparin_amp = $('#tectConsumHA').val();
    consObj.heparin_ml = $('#tectConsumHepMl').val();
    consObj.tubing = $('#tectConsumTubing').val();
    consObj.NS_500 = $('#tectConsumNS500').val();
    consObj.NS_1K = $('#tectConsumNS1k').val();
    consObj.onoff_kit = $('#tectConsumKit').val();
    consObj.syringe_10ml = $('#tectConsumSyringe10ml').val();
    consObj.F6 = $('#tectConsumF6').val();
    consObj.TP = $('#tectConsumTP').val();
    consObj.F8 = $('#tectConsumF8').val();
    consObj.syringe_20ml = $('#tectConsumSyringe20ML').val();
    consObj.g_needle16 = $('#tectConsum16GNeedle').val();
    consObj.g_needle17 = $('#tectConsum17GNeedle').val();
    consObj.a_part = $('#tectConsumAPart').val();
    consObj.b_part = $('#tectConsumBPart').val();
    consObj.d25 = $('#tectConsumD25per').val();
    consObj.bedsheet = $('#tectConsumBsheet').val();
    consArr.push(consObj);
    patientSession.tech_consumables = consArr;
    //investigation
    patientSession.tech_doc_notes = $('#techInsNote').val();
    var patArr = new Array();
    patArr.push(patientSession);
    var sTime = parseInt(patientSession.patStart_time.split(':')[0]);
    var eTime = parseInt(patientSession.patEnd_time.split(':')[0]);

    if ((sTime + eTime) <= 8) {
        if (durArr.length > 0) {
            $.ajax({
                url: '/VIDUR/Tech/addSessionSerlvet',
                type: "POST",
                data: {data: JSON.stringify(patArr)},
                dataType: "json",
                success: function (data) {
//                console.log(data);
                    var str = data;
                    if (str.indexOf('first') && str.indexOf('second') && str.indexOf('third') && str.indexOf('fourth')) {
                        $.alert({
                            title: 'Successful',
//                content: data,
                            content: 'Session added against patient id ' + patientName.toUpperCase(),
                            type: 'green',
                            typeAnimated: true
                        });
                    } else {
                        $.alert({
                            title: 'Error!',
                            content: 'Something went wrong!!',
                            type: 'red',
                            typeAnimated: true
                        });
                    }
                },
                error: function (e) {
                    console.log(e.responseText);
                }
            });
        } else {
            $.alert({
                title: 'Error!',
                content: "Kindly add patient parameter of the patient",
                type: 'red',
                typeAnimated: true
            });
        }
    } else {
        $.alert({
            title: 'Error!',
            content: 'Duration of the Session cannot be more than 8 hours',
            type: 'red',
            typeAnimated: true,
        });
    }
}

function frmtZero(n) {
    return n > 9 ? "" + n : "0" + n;
}
function frmtTimeRev(n) {
    var timeFmt = n.split(" ");
    var time = timeFmt[0].split(":")
    if (timeFmt[1] == "PM") {
        return parseInt(frmtZero(time[0])) + 12 + ":" + time[1];
    } else {
        return timeFmt[0];
    }
}
function frmtTime(n) {
    var time = n.split(":");
    return (parseInt(time[0]) > 12 ? parseInt(time[0]) % 12 + ":" + time[1] + " PM" : n + " AM");
}

$(document).ready(function () {
    var timeAdded = 60;
    $(document).on('click', '#patientParaAdd', function () {
        var lastRow = $('#makeEditable > tbody > tr:last-child');
        var prev = lastRow.find('td:nth-child(1)').text();
//            var addedtime = (parseInt(prev.split(":")[1]) > 29 ? 1 : 0);
//            var timeHrs = (parseInt(prev.split(":")[0]) > 9 ?
//                    parseInt(prev.split(":")[0])
//                    : "0" + (parseInt(prev.split(":")[0]) + addedtime));
//            var timeMins = ((parseInt(prev.split(":")[1]) + 60) % 60);
//            if (timeMins < 9) {
//                timeMins = "0" + timeMins;
//            }
//            var newTime = (prev == " " ? " " : (timeHrs + ":" + timeMins + " " + prev.split(" ")[1]));
        if ($('#techPatRotations').val() != "") {
            timeAdded = $('#techPatRotations').val();
        } else {
            timeAdded = 60;
        }
        var newTime = AddSecsToTime(parseInt(timeAdded), prev);
        if ($('#techStartTime').val() != "") {
            var row = '<tr><td>' + newTime + '</td><td>' + lastRow.find('td:nth-child(2)').text() + '</td><td>0</td>' +
                    '<td>0</td><td>0</td><td>' + lastRow.find('td:nth-child(6)').text() + '</td><td>' + lastRow.find('td:nth-child(7)').text() + '</td>' +
                    '<td>' + lastRow.find('td:nth-child(8)').text() + '</td><td>' + lastRow.find('td:nth-child(9)').text() + '</td><td>' + lastRow.find('td:nth-child(10)').text() + '</td><td>' + lastRow.find('td:nth-child(11)').text() + '</td><td name="buttons"><div class="btn-group pull-right">' +
                    '<button id="bEdit" type="button" class="btn btn-sm btn-default" onclick="rowEdit(this);" style=""><i class="fas fa-pencil-alt"></i></button><button id="bElim" type="button" class="btn btn-sm btn-default" onclick="rowElim(this);" style=""><i class="fas fa-trash" aria-hidden="true"></i></button><button id="bAcep" type="button" class="btn btn-sm btn-default" style="display: none;" onclick="rowAcep(this);"><i class="fas fa-check"></i></button><button id="bCanc" type="button" class="btn btn-sm btn-default" style="display: none;" onclick="rowCancel(this);"><i class="fas fa-times" aria-hidden="true"></i></button></div></td></tr>';
            $('#makeEditable > tbody').append(row);
        } else {
            $('#techStartTime').focus();
            $.alert({
                title: 'Warning',
                content: "Note: Firstly add 'Start Time' data in the above section",
                type: 'red',
                typeAnimated: true
            });
        }
    });

    $(document).on('click', '#TechSubmit', function (e) {
        e.preventDefault();
        var flag = true;
        $('.form-control').each(function (i, v) {
            var se = $(this);
            if (v.checkValidity()) {
                se.addClass('is-valid');
                se.removeClass('is-invalid');
            } else {
                se.addClass('is-invalid');
                se.removeClass('is-valid');
                flag = false;
            }
        });
        if ($('#techStartTime').val() > $('#techEndTime').val()) {
            flag = false;
        }
        if (flag) {
            var patientId = $('#hidnPatientId').val();
            if (patientId) {
                submit_Tech_form(patientId);
            }
        } else {
            $.alert({
                title: 'Error',
                content: "Kindly fill all the red marked inputs",
                type: 'red',
                typeAnimated: true,
            });
        }
    });

    $('#makeEditable').SetEditable({
//        $addButton: $('#patientParaAdd')
    });

    $('#makeEditable2').SetEditable({
        $addButton: $('#patientBillAdd')
    });

    $('.preventDefault').click(function (e) {
        e.preventDefault();
    });
    $('#makeEditable').find('th:nth-child(12)').empty();
    $('#makeEditable2').find('th:nth-child(7)').empty();
    $('#makeEditable').find('th:nth-child(12)').html("Action");
    $('#makeEditable2').find('th:nth-child(7)').html("Action");


//    $(document).on('click', '.removeParaTr', function () {
//        $.confirm({
//            title: 'Confirm',
//            content: 'Are you sure you want to remove this record?',
//            type: 'red',
//            typeAnimated: true,
//            buttons: {
//                Delete: {
//                    btnClass: 'btn-success',
//                    action: function () {
//                        $(this).parents('tr').remove();
//                    }
//                },
//                Cancel: {
//                    btnClass: 'btn-danger'
//                }
//            }
//        });
//    });
//    $(document).on('click', '.editParaTr', function () {
//        $('#rowId').val($(this).parents('tr').data('id'));
//        var _this = $(this);
//        if (_this.parents('tr').find('td:nth-child(1)').text().split(" ")[1] == "PM") {
//            $('#techDurDiagTime').val(frmtTimeRev(_this.parents('tr').find('td:nth-child(1)').text()));
//        } else {
//            $('#techDurDiagTime').val(_this.parents('tr').find('td:nth-child(1)').text().split(" ")[0]);
//        }
//        $('#techDurDiagBP').val($(this).parents('tr').find('td:nth-child(2)').text());
//        $('#techDurDiagPulse').val($(this).parents('tr').find('td:nth-child(3)').text());
//        $('#techDurDiagUFR').val($(this).parents('tr').find('td:nth-child(4)').text());
//        $('#techDurDiagUFV').val($(this).parents('tr').find('td:nth-child(5)').text());
//        $('#techDurDiagBFR').val($(this).parents('tr').find('td:nth-child(6)').text());
//        $('#techDurDiagAP').val($(this).parents('tr').find('td:nth-child(7)').text());
//        $('#techDurDiagVF').val($(this).parents('tr').find('td:nth-child(8)').text());
//        $('#techDurDiagTMP').val($(this).parents('tr').find('td:nth-child(9)').text());
//        $('#techDurDiagKTV').val($(this).parents('tr').find('td:nth-child(10)').text());
//        $('#techDurDiagIssues').val($(this).parents('tr').find('td:nth-child(11)').attr('title'));
//    });
//    $(document).on('click', '.removePharmTr', function () {
//        $.confirm({
//            title: 'Confirm',
//            content: 'Are you sure you want to remove this record?',
//            type: 'red',
//            typeAnimated: true,
//            buttons: {
//                Delete: {
//                    btnClass: 'btn-danger',
//                    action: function () {
//                        $(this).parents('tr').remove();
//                    }
//                },
//                Cancel: {
//                    btnClass: 'btn-success'
//                }
//            }
//        });
//    });
    $('#techStartTime').focusout(function () {
        var startTime = $('#techStartTime').val();
        if (startTime) {
            $('#makeEditable > tbody').append('<tr><td>' + frmtTime($('#techStartTime').val()) +
                    '</td><td>n/n</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td><td>0</td>' +
                    '<td>0</td><td>0</td><td name="buttons"><div class="btn-group pull-right">' +
                    '<button id="bEdit" type="button" class="btn btn-sm btn-default" onclick="rowEdit(this);" style=""><i class="fas fa-pencil-alt"></i></button><button id="bElim" type="button" class="btn btn-sm btn-default" onclick="rowElim(this);" style=""><i class="fas fa-trash" aria-hidden="true"></i></button><button id="bAcep" type="button" class="btn btn-sm btn-default" style="display: none;" onclick="rowAcep(this);"><i class="fas fa-check"></i></button><button id="bCanc" type="button" class="btn btn-sm btn-default" style="display: none;" onclick="rowCancel(this);"><i class="fas fa-times" aria-hidden="true"></i></button></div></td></tr>');
        }
    });

    $(document).on('change', '#techPatientId', function () {
        var flag = false;
        if ($(this).val() && $('#techCentre').val()) {
            $.ajax({
                url: '/VIDUR/Tech/addSessionSerlvet?patId=' + $(this).val(),
                type: "GET",
                dataType: "JSON",
                success: function (data) {
                    flag = true;
                    if (data.patientId != null) {
                        if (data.patientId) {
                            $('.patientSessionRecords').fadeIn(2000);
                        }
                        $('#hidnPatientId').val(data.patientId);
                        $('#techPatName').val(data.patientName);
                        $('#techAccessPoint').val(data.AccessPoint == "C" ? "Cannula" : "Fistula");
                        $('#tectConsumCat').val(data.AccessPoint == "C" ? "Cannula" : "Fistula");
                        $('#techPatRotations').val(data.patient_rotations);
                    } else {
                        flag = false;
                    }
                },
                error: function (e) {
                    console.log(e.responseText);
                    $.alert({
                        title: 'Search Result',
                        content: "No Records found with patient Id " + $(this).val(),
                        type: 'red',
                        typeAnimated: true
                    });
                    flag = false;
                }
            });
        }
        if ($('#hidnPatientId').val() != " " && flag) {
            $('.patientSessionRecords').css('display', 'block');
        } else {
            $('.patientSessionRecords').css('display', 'none');
        }
    });
    $(document).on("change", "#techCentre", function (e) {
        $('#techPatientId').trigger('change');
    });
    $(document).on("change", "#techCentre", function (e) {
        e.preventDefault();
        if ($(this).val() == 0) {
            $('#therFee').val(1250);
        } else if ($(this).val() == 1) {
            $('#therFee').val(1100);
        }
    });

    $(document).on('change', '#techStartTime', function () {
        $('#techDurDiagTime').attr('min', $(this).val());
        $('#techDurDiagTime').val($(this).val());
    });
    $(document).on('change', '#techEndTime', function () {
        $('#techDurDiagTime').attr('max', $(this).val());
    });

    $(document).on("change", "#tectConsumBPart", function (e) {
        e.preventDefault();
        var tmp = $(this).val();
        $('#tectConsumAPart').val(tmp / 2);
    });

    $(document).on("click", "#addPharmTab", function (e) {
        e.preventDefault();
        var pharmRow = `
            <tr>
                <td>
                    <select class="tabPharmItem form-control">
                        <option>Iron sucrose</option>
                        <option>Antibotic</option>
                        <option>Multivitamin</option>
                        <option>EPO 4000</option>
                        <option>EPO Renocel 10000</option>
                    </select>
                </td>
                <td><input type="number" class="tabPharmNumber form-control"></td>
                <td><input type="text" class="tabPharmBillNo form-control" maxlength="15"></td>
                <td>
                    <div class='col-2'>
                        <div class='form-group text-danger text-center' title='Click to delete respective Record'>
                            <i class='fas fa-trash cursorOnHover removeTabPharm'></i>
                        </div>
                    </div>
                </td>
            </tr>`;
        $("#PharmTable > tbody").append(pharmRow);
    });

    $(document).on("click", ".removeTabPharm", function (e) {
        e.preventDefault();
        $(this).parents("tr").remove();
    });

    $(document).on("change", "#techPUData", function (e) {
        e.preventDefault();
        if ($(this).val() == "paid") {
            $('.billingsShow').css('display', 'block');
        } else {
            $('.billingsShow').css('display', 'none');
        }
    });
});


