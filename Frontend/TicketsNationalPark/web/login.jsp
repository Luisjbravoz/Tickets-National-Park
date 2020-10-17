<%-- 
    PROJECT: TICKETS NATIONAL PARK.
    LUIS J. BRAVO ZÚÑIGA.
    LOGIN PAGE.
--%>
<%@page import="model.Model"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>YNP Login</title>
        <link href="tools/css/login/styles.css" rel="stylesheet" type="text/css"/>
        <link href="tools/css/modal/style.css" rel="stylesheet" type="text/css"/>
        <link href="boostrap/bootstrap.min.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <% if (session.getAttribute("username") != null) {
                session.setAttribute("username", null);
        }%> 
        <!-- The Modal -->
        <div id="myModal" class="modal">
            <div class="modal-content" style=" width: 50%;">
                <span class="close">&times;</span>
                <p><h4 class="info-error">Your username or password are incorrect.</h4></p>
                <p class="info-error">Check your info and try again, please!</p>
            </div>

        </div>
        <div class="container-fluid align-items-center">
            <div class="row">
                <div class="col picture-login"></div>
                <div class="col-5">
                    <form action="javascript:login()" method="POST" style="margin:25px;padding:25px;">
                        <h2 class="sr-only">Login Form</h2>
                        <div class="illustration">
                            <p class="lead text-center align-content-center" style="font-size:35px;">Login for continue</p>
                        </div>
                        <div class="form-group"><input class="form-control" type="email" name="username" id="username" placeholder="Username"></div>
                        <div class="form-group"><input class="form-control" type="password" name="password" id="password" placeholder="Password"></div>
                        <div class="form-group"><button class="btn btn-primary btn-block" type="submit">login</button>
                                <p class="text-center"><br>This page is only for Yosemite National Park's employees.<br></p>
                            </div>
                           <div class="form-group"><button class="btn btn-primary btn-block" onclick="javascript:go_back()">Go back</button>
                    </form>
                </div>
            </div>
        </div>
    </body>
    <script src="tools/js/index/jquery.min.js" type="text/javascript"></script>
    <script src="boostrap/bootstrap.min.js" type="text/javascript"></script>
    <script src="tools/js/login/admin_login.js" type="text/javascript"></script>
</html>