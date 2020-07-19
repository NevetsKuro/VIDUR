
$(document).ready(function () {
    var now = new Date().getFullYear() + '-' + (parseInt(new Date().getMonth())+1) + '-' + new Date().getDate() ;
    $('#pathDate').attr('max',now);

    $(document).on("change", "#pathDate", function (e) {
        e.preventDefault();
        var date = $(this).val();
        var isFuture = (new Date(date).getTime() - new Date().getTime());
        if (isFuture > 0) {
            $.alert({
                title: 'Error',
                content: 'Future dates cannot be selected',
                type: 'red',
                typeAnimated: true,
            });
        }

    });
});