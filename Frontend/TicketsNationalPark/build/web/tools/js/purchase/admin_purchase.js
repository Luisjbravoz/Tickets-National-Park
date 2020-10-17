/*
 * PROJECT: TICKETS NATIONAL PARK.
 * LUIS J. BRAVO ZÚÑIGA.
 * ADMIN_PURCHASE JS.
 */

//GLOBAL
var textMonths = ["January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"],
        purchase = null, initNull = "NULL";

/******************************************************************************************
 * FOR GET RESERVATION DATES.
 */

function load() {
    listReservation();
}

function listReservation() {
    $.ajax({
        type: "GET",
        url: "http://localhost:8084/TicketsNationalPark/api/reservation;charset=UTF-8"
    })
            .done(function (data) {
                loadReservationDates(data);
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                location.reload();
            });
}

function loadReservationDates(data) {
    var quantity_days = data.length,
            quantity_months = Math.trunc(quantity_days / 30, 417),
            quantity_years = Math.trunc(quantity_months / 12),
            item = null,
            day = new Array(data.length),
            month = new Array(quantity_months),
            year = new Array(quantity_years),
            index_year = 0,
            index_month = 0;
    for (var i = 0; i < quantity_days; i++) {
        item = (data[i].id).substring(0, 10);
        if (year[index_year] === null || year[index_year - 1] !== item.substring(0, 4)) {
            year[index_year++] = item.substring(0, 4);
        }
        if (month[index_month] === null || month[index_month - 1] !== item.substring(5, 7)) {
            month[index_month++] = item.substring(5, 7);
        }
        if (verifyDay(day, item.substring(8, 10))) {
            day[i] = item.substring(8, 10);
        }
    }
    loadDataForm(day, month, year);
}

function loadDataForm(day, month, year) {
    var formDay = document.getElementsByName("day")[0],
            formMonth = document.getElementsByName("month")[0],
            formYear = document.getElementsByName("year")[0];
    var item = null, opt = null;
    for (item in day) {
        opt = document.createElement("option");
        opt.text = day[item];
        formDay.add(opt);
    }
    for (item in month) {
        opt = document.createElement("option");
        opt.text = getTextMonth(month[item]);
        formMonth.add(opt);
    }
    for (item in year) {
        opt = document.createElement("option");
        opt.text = year[item];
        formYear.add(opt);
    }
}

function verifyDay(array, day) {
    var index = 0;
    while (index < array.length) {
        if (array[index] === day) {
            return false;
        }
        index++;
    }
    return true;
}

function getTextMonth(month) {
    return textMonths[parseInt(month.charAt(1)) - 1];
}

function getNumberMonth(month) {
    var index = 0;
    while (index < 12) {
        if (month === textMonths[index]) {
            return (index);
        }
        index++;
    }
}


/*******************************************************************************************
 * FOR INSERT PURCHASE.
 */

function insert() {
    purchase = {
        id: -1,
        idPurchaser: $("#id-purchaser").val(),
        firstName: $("#first-name").val(),
        lastName: $("#last-name").val(),
        email: $("#email").val(),
        telephone: $("#phone").val(),
        quantityTickets: $("#tickets").val(),
        reservationDate: new Date(parseInt($("#year").val()), getNumberMonth($("#month").val()), parseInt($("#day").val())),
        total: 0.0,
        checkOut: false
    };
    $.ajax({
        type: "POST",
        url: "http://localhost:8084/TicketsNationalPark/api/purchase;charset=UTF-8",
        data: JSON.stringify(purchase),
        contentType: "application/json"
    })
            .done(function (data) {
                correct(data);
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                showInfo("An error occurred while processing the purchase transaction. Please try again.");
            });
}

function correct(data) {
    if (data === "-1") {
        showInfo("An error occurred while processing the purchase transaction. Please try again.");
    } else {
        localStorage.setItem("index", data);
        console.log(data);
        location.href = "resultPurchase.jsp";
    }
}

/*******************************************************************************************
 * FOR GET QUANTITY OF TICKETS.
 */

function stateInput() {
    var status = [initNull, false, initNull, false, initNull, false],
            year = document.getElementById("year"),
            month = document.getElementById("month"),
            day = document.getElementById("day");
    status[0] = day.value;
    if (status[0] !== initNull) {
        status[1] = true;
    } else {
        status[1] = false;
    }

    status[2] = month.value;
    if (status[2] !== initNull) {
        status[3] = true;
    } else {
        status[3] = false;
    }

    status[4] = year.value;
    if (status[4] !== initNull) {
        status[5] = true;
    } else {
        status[5] = false;
    }
    updateStateInput(status);

}

function updateStateInput(status) {
    if (status[1] === true && status[3] === true && status[5] === true) {
        document.getElementById("tickets").disabled = false;
        getquantityTickets(status[0], getNumberMonth(status[2]), status[4]);
    }
}

function getquantityTickets(day, month, year) {
    $.ajax({
        type: "GET",
        url: "http://localhost:8084/TicketsNationalPark/api/reservation/{0}/{1}/{2};charset=UTF-8".format(day, month, year)
    })
            .done(function (data) {
                showInfo("The quantity of tickets available for selected date: {0}".format(data));
            })
            .fail(function (jqXHR, textStatus, errorThrown) {
                showInfo("Please, choose another date for reservation!");
            });
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


