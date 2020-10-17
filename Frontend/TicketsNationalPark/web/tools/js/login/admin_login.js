/*
 * PROJECT: TICKETS NATIONAL PARK.
 * LUIS J. BRAVO ZUÑIGA.
 * LOGIN JS.
 */

/****
 * Format a String
 * var username = "admin", password = "abC1";
 * e.g. : "api/login/{0}/{1}".format(username, password);
 * output: api/login/admin/abC1
 */

String.prototype.format = String.prototype.f = function () {
    var data = this, i = arguments.length;
    while (i--) {
        data = data.replace(new RegExp('\\{' + i + '\\}', 'gm'), arguments[i]);
    }
    return data;
};
 
 /******************************************************************************************
 * FOR LOGIN.
 */

function login() {
    $.ajax({
        type: "GET",
        url: "api/login/{}/{};charset=UTF-8".format($('#username').val(), $('#password').val())
    })
            .done(function (data) {
                correct(data);
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                no_correct();
            });
}

function correct(data) {
    if (data === undefined) {
        open_modal();
    } else {
        location.href = "interfaces/showPurchase.jsp";
    }
}

function no_correct() {
    open_modal();
}

function go_back() {
    location.href="index.jsp";
}

function open_modal() {
    var modal = $("#myModal"),
            close = $(".close").eq(0);
    modal.css("display", "block");

    close.click(function () {
        modal.css("display", "none");
    });
}