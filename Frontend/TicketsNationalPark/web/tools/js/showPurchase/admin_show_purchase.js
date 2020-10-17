/*
 * PROJECT: TICKETS NATIONAL PARK.
 * LUIS J. BRAVO ZÚÑIGA.
 * ADMIN_SHOW_PURCHASE JS.
 */

//GLOBAL
var listPurchase = null, table = null,
        checkFormat = "<img class='image' src='../tools/css/showPurchase/images/Check.png' onclick='showInfo(\"This purchase was already checked in.\");'>",
        noCheckFormat = "<img class='image' src='../tools/css/showPurchase/images/NotCheck.png' onclick='checkIn(\"{0}\");'>",
        noMatchesFormat = "<td colspan=\"7\" style=\"text-align:center;font-weight: bold;font-size:30px;\"> No matches. No data for show!</td>",
        rowFormat = "<td> {0} </td>"
            + "<td> {1} </td>"
            + "<td> {2} </td>"
            + "<td> {3} </td>"
            + "<td> {4} </td>"
            + "<td> {5} </td>"
            + "<td> {6} </td>"
            + "<td id={7}>{8}</td>";

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

/*******************************************************************************************
 * LOAD PURCHASES.
 */

function loadData() {
    $.ajax({
        type: "GET",
        url: "http://localhost:8084/TicketsNationalPark/api/purchase;charset=UTF-8"
    })
            .done(function (data) {
                listPurchase = data;
                correct(listPurchase);
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                showInfo("Error has ocurred, please try again!");
            });
}

function correct(data) {
    table = $("#tableBody");
    table.html("");
    for (var item in data) {
        row(table, data[item]);
    }
}

function row(table, item) {
    var tr = $("<tr/>");
    tr.html(rowFormat.format(item.id, item.idPurchaser, item.firstName, item.lastName, item.email, item.quantityTickets, (item.reservationDate.toString()).substring(0, 10), item.id, getCheck(item)));
    table.append(tr);
}

function getCheck(item) {
    return item.checkOut === true? checkFormat : noCheckFormat.format(item.id);
}

/*******************************************************************************************
 * DELETE PURCHASE.
 */

function checkIn(id) {
    $.ajax({
        type: "DELETE",
        url: "http://localhost:8084/TicketsNationalPark/api/purchase/{0};charset=UTF-8".format(id)
    })
            .done(function (data) {
                if (data === false) {
                    showInfo("Error has ocurred, please try again!");
                } else {
                    update(id);
                }
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                showInfo("Error has ocurred, please try again!");
            });
}

function update(id) {
    listPurchase[id - 1].checkOut = true;
    $("#" + id).html(checkFormat);
}

/*******************************************************************************************
 * FILTER.
 */

function filter() {
    var fil = $("#search").val();
    console.log(fil);
    if (fil === "") {
        setTable(listPurchase);
    } else {
        var auxListPurchase = new Array();
        for (var item in listPurchase) {
            if (listPurchase[item].id.toString().includes(fil)) {
                auxListPurchase.push(listPurchase[item]);
            }
        }
        if (auxListPurchase.length === 0) {
            noMatches();
        } else {
            setTable(auxListPurchase);
        }
    }
}

function noMatches() {
    table.html("");
    var tr = $("<tr/>");
    tr.html(noMatchesFormat);
    table.append(tr);
}

function setTable(list) {
    var table = $("#tableBody");
    table.html("");
    for (var item in list) {
        row(table, list[item]);
    }
}


/*******************************************************************************************
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