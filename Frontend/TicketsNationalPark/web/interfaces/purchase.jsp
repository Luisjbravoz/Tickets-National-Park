<%-- 
    PROJECT: TICKETS NATIONAL PARK.
    LUIS J. BRAVO ZÚÑIGA.
    PURCHASE PAGE.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>YNP Purchase</title>
        <!-- Mobile Specific Metas -->
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <link href="../tools/css/modal/style.css" rel="stylesheet" type="text/css"/>
        <link href="../tools/fonts/material-design-iconic-font/css/material-design-iconic-font.min.css" rel="stylesheet" type="text/css"/>
        <link href="../tools/css/purchase/style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body onLoad="javascript:load()">
        <!-- The Modal -->
        <div id="myModal" class="modal">
            <div class="modal-content" style=" width: 50%;">
                <span class="close">&times;</span>
                <p class="info-error" id = "modalMessage"></p>
            </div>
        </div>
        <div class="page-content">
            <div class="form-v1-content">
                <div class="wizard-form">
                    <form class="form-register" action="javascript:insert()" id="formAdd" method="POST">
                        <div id="form-total">
                            <!-- SECTION 1 -->
                            <h2>
                                <p class="step-icon"><span>01</span></p>
                                <span class="step-text">Purchase Information</span>
                            </h2>
                            <section>
                                <div class="inner">
                                    <div class="wizard-header">
                                        <h3 class="heading">Purchase Information</h3>
                                        <p id="modalMessage"></p>
                                    </div>
                                    <div class="form-row">
                                        <div  class="form-holder">
                                            <fieldset>
                                                <legend>ID</legend>
                                                <input type="text" class="form-control" id="id-purchaser" name="id-purchaser" placeholder="ID" autocomplete="off" required>
                                            </fieldset>
                                        </div>
                                        <div class="form-holder">
                                            <fieldset>
                                                <legend>First Name</legend>
                                                <input type="text" class="form-control" id="first-name" name="first-name" placeholder="First Name" autocomplete="off" required>
                                            </fieldset>
                                        </div>
                                        <div class="form-holder">
                                            <fieldset>
                                                <legend>Last Name</legend>
                                                <input type="text" class="form-control" id="last-name" name="last-name" placeholder="Last Name" autocomplete="off" required>
                                            </fieldset>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-holder form-holder-2">
                                            <fieldset>
                                                <legend>Email address</legend>
                                                <input type="text" name="email" id="email" class="form-control" pattern="[^@]+@[^@]+.[a-zA-Z]{2,6}" placeholder="example@email.com" autocomplete="off" required>
                                            </fieldset>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-holder form-holder-2">
                                            <fieldset>
                                                <legend>Phone Number</legend>
                                                <input type="text" class="form-control" id="phone" name="phone" placeholder="+1 888-999-7777">
                                            </fieldset>
                                        </div>
                                    </div>
                                    <div class="form-row form-row-date">
                                        <div class="form-holder form-holder-2">
                                            <label class="special-label">Choose a reservation date:</label>
                                            <select name="day" id="day" onchange="javascript:stateInput()">
                                                <option value="null" disabled selected>Day</option>
                                            </select>
                                            <select name="month" id="month" onchage="javascript:stateInput()">
                                                <option value="null" disabled selected>Month</option>
                                            </select>
                                            <select name="year" id="year" onchage="javascript:stateInput()">
                                                <option value="null" disabled selected>Year</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-holder form-holder-2">
                                            <label class="special-label">How many tickets? Max 9 tickets per purchase!</label>
                                            <input type="number" class="form-control input-border" id="tickets" name="tickets" min="1" max ="120" disabled="true" autocomplete="off" required>
                                        </div>
                                    </div>
                                </div>
                            </section>
                            <!-- SECTION 2 -->
                            <h2>
                                <p class="step-icon"><span>02</span></p>
                                <span class="step-text">Payment details</span>
                            </h2>
                            <section>
                                <div class="inner">
                                    <div class="wizard-header">
                                        <h3 class="heading">Payment details</h3>
                                        <p>Please complete the information required</p>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-holder form-holder-2">
                                            <select id="card" name="card">
                                                <option value="" disabled selected>Select a card type</option>
                                                <option value="credit">Credit</option>
                                                <option value="debit">Debit</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-holder form-holder-2">
                                            <fieldset>
                                                <legend>Card number</legend>
                                                <input type="text" class="form-control" id="card-number" name="card-number" placeholder="Card number" autocomplete="off" required>
                                            </fieldset>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-holder form-holder-2">
                                            <fieldset>
                                                <legend>Security code</legend>
                                                <input type="password" class="form-control" id="security-code" name="security-code" placeholder="Security code" autocomplete="off" required>
                                            </fieldset>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-holder form-holder-2">
                                            <fieldset>
                                                <legend>Expiry date</legend>
                                                <input type="date" class="form-control" id="expiry-date" name="expiry-date" autocomplete="off" required>
                                            </fieldset>
                                        </div>
                                    </div>
                                </div>
                            </section>			
                            <!-- SECTION 3 -->
                            <h2>
                                <p class="step-icon"><span>03</span></p>
                                <span class="step-text">Confirmation</span>
                            </h2>
                            <section>
                                <div class="inner">
                                    <div class="wizard-header">
                                        <h3 class="heading">Purchase confirmation!</h3>
                                        <p>Please, read the following instructions</p>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-holder form-holder-2">
                                            <p style="color: #000000; font-weight: lighter;"> 1. Check all fields are complete.</br></p>
                                            <p style="color: #000000; font-weight: lighter;"> 2. Make sure the reservation information and purchase data is the correct.</br></p>
                                            <p style="color: #000000; font-weight: lighter;"> 3. Finally, click the next button for make the transaction. </br></p>
                                        </div>
                                    </div>
                                    <div class="form-row">
                                        <div class="form-holder form-holder-2" style="align-content: center;">
                                            <button class="boton" type="submit">
                                                <img src="../tools/css/purchase/images/Check.png" alt=""/>
                                            </button>
                                        </div>
                                    </div>
                            </section>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="../tools/js/purchase/jquery-3.3.1.min.js" type="text/javascript"></script>
        <script src="../tools/js/purchase/jquery.steps.js" type="text/javascript"></script>
        <script src="../tools/js/purchase/main.js" type="text/javascript"></script>
        <script src="../tools/js/purchase/admin_purchase.js" type="text/javascript"></script>
    </body>
</html>