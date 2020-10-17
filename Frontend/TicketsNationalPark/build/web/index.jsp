<%-- 
    PROJECT: TICKETS NATIONAL PARK.
    LUIS J. BRAVO ZÚÑIGA.
    INDEX PAGE (MAIN PAGE).
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Yosemite National Park</title>
        <link href="boostrap/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="tools/css/index/styles.css" rel="stylesheet" type="text/css"/>
    </head>

    <body>
        <div class="container-fluid">
            <div class="row" style="background-color:#ffffff;">
                <div class="col align-self-center" style="background-color:#ffffff;">

                    <p class="text-center header-main"><a href="login.jsp"><span>Login</span></a></p>
                </div>
                <div class="col align-self-center" style="background-color:#ffffff;">
                    <p class="text-center header-main">About us</p>
                </div>
                <div class="col align-self-center" style="background-color:#ffffff;">
                    <p class="text-center header-main">KUNG FLU!</p>
                </div>
                <div class="col align-self-center" style="background-color:#ffffff;">
                    <p class="text-center header-main"><a href="interfaces/purchase.jsp"><span>Get your tickets!</span></a></p>
                </div>
            </div>
        </div>
        <div class="container-fluid center-main">
            <p class="text-center d-inline-block over-text center" style="font-size:4vw;color:rgb(255,255,255);font-weight:lighter">
                YOSEMITE NATIONAL PARK</br>
                Find your next trip!
            </p>

        </div>
        <footer>
            <div class="container-fluid">
                <div class="row">
                    <div class="col-auto" style="background-color:#103572;"><img class="img-fluid" src="tools/css/images/LogoNationalParkService.png" style="width:100px;"></div>
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
        <script src="tools/js/index/jquery.min.js" type="text/javascript"></script>
        <script src="boostrap/bootstrap.min.js" type="text/javascript"></script>
    </body>
</html>