<%-- 
    PROJECT: TICKETS NATIONAL PARK.
    LUIS J. BRAVO ZÚÑIGA.
    SHOW PURCHASE PAGE.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>YNP Show Purchase</title>
        <link href="../boostrap/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../tools/css/showPurchase/Navigation-with-Button.css" rel="stylesheet" type="text/css"/>
        <link href="../tools/css/showPurchase/Navigation-with-Search.css" rel="stylesheet" type="text/css"/>
        <link href="../tools/css/showPurchase/styles.css" rel="stylesheet" type="text/css"/>
        <link href="../tools/css/modal/style.css" rel="stylesheet" type="text/css"/>
    </head>

    <body onLoad="javascript:loadData()">
        <% String username = (String) session.getAttribute("username");
            if (username == null) {
                response.sendRedirect("http://localhost:8084/TicketsNationalPark/login.jsp");
            }
        %>
        <!-- The Modal -->
        <div id="myModal" class="modal">
            <div class="modal-content" style=" width: 50%;">
                <span class="close">&times;</span>
                <p class="info-error" id = "modalMessage"></p>
            </div>
        </div>
        <div class="container-fluid">
            <p class="text-center" style="font-size:40PX;">YOSEMITE NATIONAL PARK</p>
        </div>
        <div class="container-fluid">
            <ul class="nav nav-tabs">
                <li class="nav-item nav-link active" style="background-color:rgb(16,53,114);color:rgb(255,255,255);">Show purchase</li>
                <li class="nav-item"><a class="nav-link" href="../login.jsp">Logout</a></li>
                <li class="nav-item"><a class="nav-link" href="../interfaces/changePassword.jsp">Change password</a></li>
            </ul>
        </div>
        <div class="container">
            <div class="row">
                <div class="col d-flex justify-content-center align-items-center align-content-center" style="margin:10px;padding:10px;">
                    <div class="form-group">
                        <p class="d-inline">Write the ID purchase for search: &nbsp; &nbsp;</p>
                        <input class="d-inline" type="number" id="search" name="search" min="1" step="1" oninput="javascript:filter();" style="width:129px;height:35px;"></div>
                </div>
            </div>
        </div>
        <div class="container-fluid d-flex align-items-center">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>ID purchaser</th>
                            <th>Full name</th>
                            <th>Email Address</th>
                            <th>Tickets</th>
                            <th>Reservation date</th>
                            <th>Check</th>
                        </tr>
                    </thead>
                    <tbody id="tableBody">
                    </tbody>
                </table>
            </div>
        </div>
        <script src="../tools/js/index/jquery.min.js" type="text/javascript"></script>
        <script src="../boostrap/bootstrap.min.js" type="text/javascript"></script>
        <script src="../tools/js/showPurchase/admin_show_purchase.js" type="text/javascript"></script>
    </body>
</html>
