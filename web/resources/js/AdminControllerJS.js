$(document).ready(function () {

    $(document).on("click", ".roleChange", function (e) {
        e.preventDefault();
        $.ajax({
            url: "/VIDUR/userMasterServlet?action=switchUser&toRole=" + $(this).data('role'),
            type: "POST",
            dataType: "json",
            success: function (data) {
                if (data.includes("Changed")) {
                    window.open("/VIDUR/sessionCreateServlet","_blank");
                } else {
                    $.alert({
                        title: 'Warning',
                        content: data,
                        type: 'red',
                        typeAnimated: true
                    });
                }
            },
            error: function (e) {
                console.log(e.responseText);
            }
        });
    });

    $(document).on("click", ".updateAdminPriceRecords", function (e) {
        e.preventDefault();
        var tmp = $(this).data('id');
        var flag = true;
        var price = "", SGST = "", CGST = "";
        switch (tmp) {
            case "Iron":
                price = $('#priceIS').val();
                SGST = $('#priceISsgst').val();
                CGST = $('#priceIScgst').val();
                break;
            case "Multivitamin":
                price = $('#priceMulti').val();
                SGST = $('#priceMultisgst').val();
                CGST = $('#priceMulticgst').val();
                break;
            case "EPO1":
                price = $('#priceEPO1000').val();
                SGST = $('#priceEPO1000sgst').val();
                CGST = $('#priceEPO1000cgst').val();
                break;
            case "EPO4":
                price = $('#priceEPO4000').val();
                SGST = $('#priceEPO4000sgst').val();
                CGST = $('#priceEPO4000cgst').val();
                break;
            case "Anitbotic":
                price = $('#priceAnti').val();
                SGST = $('#priceAntisgst').val();
                CGST = $('#priceAnticgst').val();
                break;
            default :
                flag = false;
        }
        var fileOf = "updatePrice";
        var Item = {
            "Item": $(this).data("item"),
            "Price": price,
            "SGST": SGST,
            "CGST": CGST
        };
        if (flag && price != "") {
            $.ajax({
                url: '/VIDUR/Admin/AdminFilesServlet?fileFor=' + fileOf,
                type: "POST",
                data: Item,
                dataType: "json",
                success: function (data) {
                    console.log(data);
                    $.alert({
                        title: 'Success',
                        content: 'Succesfully updated ' + Item.Item,
                        type: 'green',
                        typeAnimated: true,
                    });
                },
                error: function (e) {
                    console.log(e.responseText);
                }
            });
        }
    });

    $(document).on("click", "#updateAdminRecords", function (e) {
        e.preventDefault();
        var tech = $("#adminTech").val();
        var drugs = $("#adminDrugs").val();
        var mach = $("#adminMach").val();
        var fileOf = "updateCommon";
        var data = {
            "tech": tech,
            "drugs": drugs,
            "mach": mach
        };
        $.ajax({
            url: '/VIDUR/Admin/AdminFilesServlet?fileFor=' + fileOf + '',
            type: "POST",
            data: data,
            dataType: "JSON",
            success: function (data) {
                console.log(data);
                $.alert({
                    title: 'Successful',
                    content: 'Updated all records',
                    type: 'green',
                    typeAnimated: true,
                });
            },
            error: function (e) {
                console.log(e.responseText);
            }
        });
    });

    $(document).on("click", "#searchByDateAdminC1", function (e) {
        e.preventDefault();
        var fromDate = $('#fromDateAdminC').val();
        var toDate = $('#toDateAdminC').val();
        var data = {
            "IVSet": $('#toIVSet').val(),
            "Hep": $('#toHep').val(),
            "Tubing": $('#toTubing').val(),
            "NS500": $('#tons500').val(),
            "NS1k": $('#tons1k').val(),
            "KIT": $('#toKit').val(),
            "S10ML": $('#tosyringe10ml').val(),
            "TP": $('#toTP').val(),
            "S20ML": $('#tosyringe20ml').val(),
            "N16": $('#to16needle').val(),
            "N17": $('#to17needle').val(),
            "BPart": $('#toABPart').val(),
            "D25": $('#toD25').val(),
            "Bedsheet": $('#toBedsheet').val(),
        }
        var fileOf = 'Consumables';
        if (fromDate && toDate) {
            $.ajax({
                url: '/VIDUR/Admin/AdminFilesServlet?fileFor=' + fileOf + '&fromDate=' + fromDate + '&toDate=' + toDate,
                type: "POST",
                data: data,
                dataType: "json",
                success: function (data) {
                    console.log(data);
                },
                error: function (e) {
                    console.log(e.responseText);
                }
            });
        } else {
            $.alert({
                title: 'Warning!!',
                content: 'Kindly Enter Start and End dates for the report',
                type: 'red',
                typeAnimated: true,
            });
        }
    });
});