function submit_AC_Form(patientName) {
    var patientDetails = new Object();
    patientDetails.patientId = patientName.toUpperCase();
    patientDetails.patientName = $('#inputName').val();
    patientDetails.AccessPoint = $('#inputAP').val();
    patientDetails.Location = $('#inputCentre').val();
    patientDetails.Gender = $('#inputGender').val();
    patientDetails.Birthdate = $('#inputDate').val();
    patientDetails.PINCODE = $('#inputPincode').val();
    patientDetails.patient_rotations = $('#inputSessIntr').val();
    patientDetails.Address = $('#inputAddress').val();
    var contacts = new Array();
    $(".tableContact .tableConRow").each(function (i, v) {
        var contact = new Object();
        contact.contact_type = $(this).find('.inputTypeContacts').val();
        contact.contactNumber = $(this).find('.inputEmergContacts').val();
        contacts.push(contact);
    });
    patientDetails.contacts = contacts;
    patientDetails.Blood_Group = $('#inputBloodgrp').val();
    patientDetails.Referring_Nephrologist = $('#inputReferNephro').val();
    patientDetails.Blood_Group = $('#inputBloodgrp').val();
    patientDetails.Fisrt_Session = $('#dateSess').val();
    patientDetails.No_of_Dialysis = $('#noofdialysis').val();
    patientDetails.Awaiting_Transplant = $('#awaiTrans').val();
    patientDetails.CKD_5D = $('#ureCalc').val();
    patientDetails.SU_Decision = $('#stabDec').val();
    patientDetails.Heart_Fun = $('#heartFun').val();
    patientDetails.Injection_Frac = $('#injFrac').val();
    patientDetails.BP_Stable = $('#bpStable').val();
    patientDetails.Past_Habits = $('#pastHab').val();
    patientDetails.Liver_Fun = $('#lvrFunTest').val();
    patientDetails.ECG_Arr = $('#ecgArr').val();
    patientDetails.Type_of_Diet = $('#typeOfDiet').val();
    patientDetails.Ini_Ano = $('#iniSymAno').val();
    patientDetails.Ini_Vom = $('#iniSymVom').val();
    patientDetails.Ini_Nau = $('#iniSymNau').val();
    patientDetails.Ini_Dia = $('#iniSymDia').val();

    var contactArr = new Array();
    contactArr.push(patientDetails);
    if (contactArr.length > 0) {
        $.ajax({
            type: "POST",
            url: '/VIDUR/AC/PatientServlet',
            data: {data: JSON.stringify(contactArr)},
            dataType: "JSON",
            success: function (data) {
                $.alert({
                    title: 'Successful',
                    content: data,
                    type: 'green',
                    typeAnimated: true,
                });
            },
            error: function (e) {
                console.log(e.responseText);
            }
        });
    }

}
$(document).ready(function () {

    var now = new Date().getFullYear() + '-' + (parseInt(new Date().getMonth()) + 1) + '-' + new Date().getDate();
    $('#inputDate').attr('max', now);
    $('#dateSess').attr('max', now);
    ///Function Validation
    $(document).on('change', '.form-control', function (e) {
        var se = $(this);
        if (se[0].checkValidity()) {
            se.addClass('is-valid');
            se.removeClass('is-invalid');
        } else {
            se.addClass('is-invalid');
            se.removeClass('is-valid');
        }
    });


    $(document).on('click', '#ACSubmit', function (e) {
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

        if (flag) {
            var strArr1 = $('#inputName').val().split(" ");
            var patientName = frmtZero(new Date().getUTCFullYear()).slice(2, 4) + frmtZero(new Date().getMonth() + 1) + frmtZero(new Date().getDate()) + strArr1[0][0] + strArr1[strArr1.length - 1][0] + "1";
            submit_AC_Form(patientName);

        } else {
            $.alert({
                title: 'Encountered an error!',
                content: 'Kindly fill the red box to proceed further',
                type: 'red',
                typeAnimated: true, });
        }
    });

    $(document).on('click', '.removeTR', function () {
        $(this).parents('.tableConRow').remove();
    });

    $(document).on('click', '.contactBar', function () {
        //"<input type='number' class='form-control' id='inputPrimContacts' placeholder='For Primary' minlength='8' maxlength='14'>" +
        $('.tableContact').append("<div class='row tableConRow'>" +
                "<div class='col-3'>" +
                "<div class='form-group'>" +
                "<select class='form-control inputTypeContacts' id='inputTypeContacts'>" +
                "<option>Select..</option>" +
                "<option>Primary</option>" +
                "<option>Emergency</option>" +
                "<option>Others</option>" +
                "</select>" +
                "</div>" +
                "</div>" +
                "<div class='col-7'>" +
                "<div class='form-group'>" +
                "<input type='number' id='inputEmergContacts' class='form-control inputEmergContacts' placeholder='Additional numbers' minlength='8' maxlength='12'>" +
                "</div>" +
                "</div>" +
                "<div class='col-2'>" +
                "<div class='form-group text-danger text-center' title='Click to delete respective Record'>" +
                "<i class='fas fa-trash cursorOnHover removeTR'></i>" +
                "</div>" +
                "</div>" +
                "</div>");
    });

});