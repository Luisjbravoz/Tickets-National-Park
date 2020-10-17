<%-- 
    PROJECT: TICKETS NATIONAL PARK.
    LUIS J. BRAVO ZÚÑIGA.
    EXIT PURCHASE PAGE.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>YNP Payment receipt</title>
        <link href="../boostrap/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../tools/css/resultPurchase/styles.css" rel="stylesheet" type="text/css"/>
        <link href="../tools/css/modal/style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body onLoad="javascript:loadData()">
        <!-- The Modal -->
        <div id="myModal" class="modal">
            <div class="modal-content" style=" width: 50%;">
                <span class="close">&times;</span>
                <p class="info-error" id = "modalMessage"></p>
            </div>
        </div>
        <div class="container-fluid">
            <div class="row">
                <div class="col">
                    <p class="text-center" style="font-size:40px;">Yosemite National Park</p>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <ul class="nav nav-tabs" style="margin:0px;padding:10px;">
                        <li class="nav-item nav-link" style="background-color:#103572; color:#ffffff;">Payment receipt</li>
                        <li class="nav-item nav-link">Please print this page, is requiered for check in.</li>
                        <li class="nav-item"><a class="nav-link" href="http://localhost:8084/TicketsNationalPark/index.jsp">Go back</a></li>
                    </ul>
                </div>
            </div>
            <div class="row">
                <div class="col">
                    <p style="font-size:20px;" id="showData"></p>
                </div>
            </div>
        </div>
        <footer>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-auto" style="background-color:#103572;"><img class="img-fluid" src="../tools/css/images/LogoNationalParkService.png" style="width:100px;"></div>
                    <div class="col" style="background-color:#103572;">
                        <p class="text-center d-block footer-main-gen-inf">Yosemite National Park</p>
                        <p class="text-center d-block footer-main-gen-inf">National Park Service</p>
                        <p class="text-center d-block footer-main-gen-inf">U.S. Departament of The Interior</p>
                    </div>
                    <div class="col" style="background-color:#103572;">
                        <p class="text-center d-block footer-main-gen-inf">Telephone: (209) 372-0200</p>
                        <p class="text-center d-block footer-main-gen-inf">Open from Tuesday to Sunday,</p>
                        <p class="text-center d-block footer-main-gen-inf">info@yosemite.com</p>
                    </div>
                </div>
            </div>
        </footer>
        <script src="../tools/js/index/jquery.min.js" type="text/javascript"></script>
        <script src="../boostrap/bootstrap.min.js" type="text/javascript"></script>
        <script src="../tools/js/resultPurchase/admin_result_purchase.js" type="text/javascript"></script>
    </body>
</html>