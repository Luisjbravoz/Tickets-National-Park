<%-- 
    PROJECT: TICKETS NATIONAL PARK.
    LUIS J. BRAVO ZÚÑIGA.
    CHANGE PASSWORD PAGE.
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>YNP Change Password</title>
        <link href="../tools/css/modal/style.css" rel="stylesheet" type="text/css"/>
        <link href="../boostrap/bootstrap.min.css" rel="stylesheet" type="text/css"/>
        <link href="../tools/css/changePassword/styles.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <% String username = (String) session.getAttribute("username");
           if(username == null) {response.sendRedirect("http://localhost:8084/TicketsNationalPark/login.jsp");}
        %>
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
                        <li class="nav-item nav-link" style="background-color:#103572; color:#ffffff;">Change password</li>
                        <li class="nav-item"><a class="nav-link" href="showPurchase.jsp">Go back</a></li>
                    </ul>
                </div>
            </div>
        </div>
        <div style="background-image:url('../tools/css/changePassword/images/YosemiteNP18.jpg'); height: 1000px; width: 100%;  ">
            <div class="container-fluid justify-content-center align-items-center align-content-center">
                <form  action="javascript:updateUser()" method="POST">
                    <div class="form-row" style="margin:0px;">
                        <div class="col d-flex justify-content-center align-items-center align-content-center align-self-center" style="margin:15px;padding:0px;">
                            <input class="form-control align-content-center align-self-center" type="text" id="username" name="username" disabled="" autocomplete="off" value = '<%=username%>' style="width:315px;"></div>
                    </div>
                    <div class="form-row" style="margin:0px;">
                        <div class="col d-flex justify-content-center align-items-center align-content-center align-self-center" style="padding:0px 5px;">
                            <input class="form-control" type="password" id="password" name="password" required="" placeholder="New password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" style="width:315px;"></div>
                    </div>
                    <div class="form-row" style="margin:15px;">
                        <div class="col d-flex justify-content-center align-items-center align-content-center align-self-center">
                            <input class="form-control" type="password" id="password2" name="password2" required="" placeholder="Repeat new password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" style="width:315px;"></div>
                    </div>
                    <div class="form-row" style="margin:0px;">
                        <div class="col d-flex justify-content-center align-items-center align-content-center" style="margin:15px;"><button class="btn btn-primary btn-block" type="submit" style="background-color:#103572;color:rgb(255,255,255);width:315px;">Submit</button></div>
                    </div>
                </form>
            </div>            
        </div>
        <script src="../tools/js/index/jquery.min.js" type="text/javascript"></script>
        <script src="../boostrap/bootstrap.min.js" type="text/javascript"></script>
        <script src="../tools/js/changePassword/admin_change_password.js" type="text/javascript"></script>
    </body>

</html>