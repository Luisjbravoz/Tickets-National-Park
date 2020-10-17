/*
 * PROJECT: TICKETS NATIONAL PARK.
 * LUIS J. BRAVO ZÚÑIGA.
 * ADMIN_PRESULT_PURCHASE JS.
 */

//GLOBAL
var id = null, textMonths = ["January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"],
    output = "<b>PURCHASE INFORMATION </br>" +
            "ID PAYMENT RECEIPT: {0} </b> </br> </br>" +
            "<b>PURCHASER INFORMATION</b> </br>" +
            "ID: {1} </br>" +
            "Full name: {2} {3} </br>" +
            "Email: {4} </br>" +
            "Telephone: {5} </br> </br>" +
            "<b>RESERVATION INFORMATION</b> </br>" +
            "Quantity of tickets: {6} </br>" +
            "Date of reservation: {7} </br>" +
            "Total: ${8} </br>" +
            "Check out: no </br> </br>"

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
 * FOR GET PURCHASE'S INFO.
 * ID OF LAST PURCHASE IS IN LOCAL STORAGE.
 */

function loadData() {
    id = localStorage.getItem("index");
    findData();
}

function findData() {
    $.ajax({
        type: "GET",
        url: "http://localhost:8084/TicketsNationalPark/api/purchase/{0};charset=UTF-8".format(id)
    })
            .done(function (data) {
                correct(data);
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                 showInfo("Error was ocurred, please call (209) 372-0200 for verify.");
            });
}

function correct(data) {
    if (data === undefined) {
        noCorrect();
    } else {
        var write = document.getElementById("showData");
        write.innerHTML = formatData(data);
    }
}

function formatData(data) {
    return output.format(data.id, data.idPurchaser, data.firstName, data.lastName, 
                        data.email, data.telephone, data.quantityTickets, 
                        (data.reservationDate.toString()).substring(0, 10), data.total);
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

function getTextMonth(month) {
    return textMonths[parseInt(month.charAt(1)) - 1];
}

