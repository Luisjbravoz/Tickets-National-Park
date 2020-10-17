/*
 * PROJECT: TICKETS NATIONAL PARK.
 * LUIS J. BRAVO ZÚÑIGA.
 * ADMIN_CHANGE_PASSWORD JS.
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
 * FOR CHANGE PASSWORD (UPDATE USER).
 */

function updateUser() {
    $.ajax({
        type: "PUT",
        url: "http://localhost:8084/TicketsNationalPark/api/user/{0}/{1}/{2};charset=UTF-8".format($('#username').val(), $('#password').val(), $('#password2').val())
    })
            .done(function (data) {
                correct(data);
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                showInfo("Error has occurred, please check your info and try again!");
            });
}

function correct(data) {
    if (data === "false") {
        showInfo("Please make sure the passwords are equals!");
    } else {
        showInfo("Success!");
    }
}

/******************************************************************************************
 * OTHERS.
 */

function showInfo(message) {
    var modal = $("#myModal"),
            close = $(".close").eq(0),
            writeHere = $("#text");
    writeHere.html(message);
    modal.css("display", "block");

    close.click(function () {
        modal.css("display", "none");
    });
}

