/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

function getUserMaster() {
    $.ajax({
        url: '/VIDUR/userMasterServlet',
        type: "GET",
        dataType: "json",
        success: function (data) {
            $("#userTable > tbody").empty();
            if (data.length > 0) {
                $.each(data, function (i, v) {
                    if (v.urole != 'ADMIN') {
                        $("#userTable > tbody").append(`
                        <tr data-id="${v.uid}">
                            <td>${i + 1}</td>
                            <td>${v.uname}</td>
                            <td>${v.upassword}</td>
                            <td>${v.urole}</td>
                            <td>${v.location}</td>
                            <td>${v.updatedDate}</td>
                            <td class="text-center">
                                <span class="openUserModal"><i class="fa fa-pencil-alt text-success cursorOnHover"></i></span>
                                    |
                                <span class="userDelete"><i class="fa fa-user-minus text-danger cursorOnHover"></i></span>
                            </td>
                        </tr>
                        `);
                    } else {
                        $("#userTable > tbody").append(`
                        <tr data-id="${v.uid}">
                            <td>${i + 1}</td>
                            <td>${v.uname}</td>
                            <td>${v.upassword}</td>
                            <td>${v.urole}</td>
                            <td>${v.location}</td>
                            <td>${v.updatedDate}</td>
                            <td class="text-center">
                                ---
                            </td>
                        </tr>
                        `);
                    }
                });
            }
        },
        error: function (e) {
            console.log(e.responseText);
        }
    });
}

$(document).ready(function () {

    getUserMaster();

    //add users
    $(document).on("click", "#userAdd", function (e) {
        e.preventDefault();
        var name = $('#userName').val();
        var pwd = $('#userPwd').val();
        var role = $('#userRole').val();
        var locs = $('#userCentre').val();
        if (name && pwd && role && locs) {
            $.ajax({
                url: "/VIDUR/userMasterServlet?action=Add&userName=" + name + "&userPwd=" + pwd + "&userRole=" + role+ "&userLoc=" + locs,
                type: "POST",
                dataType: "json",
                success: function (data) {
                    if (data.includes("Successfully")) {
                        $.alert({
                            title: 'Successful',
                            content: data,
                            type: 'green',
                            typeAnimated: true
                        });
                        getUserMaster();
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
        } else {
            $.alert({
                title: 'Warning',
                content: 'Kindly fill all the fields!!',
                type: 'red',
                typeAnimated: true
            });
        }
    });
    //

    $(document).on("click", ".userDelete", function (e) {
        e.preventDefault();
        var userId = $(this).parents("tr").data("id");
        if (userId) {
            $.ajax({
                url: "/VIDUR/userMasterServlet?action=Delete&userId=" + userId,
                type: "POST",
                dataType: "json",
                success: function (data) {
                    if (data.includes("Successfully")) {
                        $.alert({
                            title: 'Successful',
                            content: data,
                            type: 'green',
                            typeAnimated: true
                        });
                        getUserMaster();
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
        } else {
            $.alert({
                title: 'Error',
                content: 'Something is missing!!',
                type: 'red',
                typeAnimated: true
            });
        }
    });

    //open Modal
    $(document).on("click", ".openUserModal", function (e) {
        e.preventDefault();
        $('#modaluId').val($(this).parents("tr").data("id"));
        $('#modaluName').val($(this).parents("tr").find("td:nth-child(2)").text());
        $('#modaluPassword').val($(this).parents("tr").find("td:nth-child(3)").text());
        $('#modaluRole').val($(this).parents("tr").find("td:nth-child(4)").text().trim());
        $('#modaluCentre').val($(this).parents("tr").find("td:nth-child(5)").text().trim());
        $('#userModal').modal('show');
    });

    $(document).on("click", "#userUpdate", function (e) {
        e.preventDefault();
        var userId = $('#modaluId').val();
        var name = $('#modaluName').val();
        var pwd = $('#modaluPassword').val();
        var role = $('#modaluRole').val();
        var locs = $('#modaluCentre').val();
        if (name && pwd && role && locs) {
            $('#userModal').modal('hide');
            $.ajax({
                url: "/VIDUR/userMasterServlet?action=Update&uid=" + userId + "&userName=" + name + "&userPwd=" + pwd + "&userRole=" + role+ "&userLoc=" + locs,
                type: "POST",
                dataType: "JSON",
                success: function (data) {
                    if (data.includes("Successfully")) {
                        $.alert({
                            title: 'Successful',
                            content: data,
                            type: 'green',
                            typeAnimated: true
                        });
                        getUserMaster();
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
        } else {
            $.alert({
                title: 'Warning',
                content: 'Kindly fill all field to update record!!',
                type: 'red',
                typeAnimated: true
            });
        }
    });
});
