/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* global jq */

$(document).ready( function() {
    jq("#pharmaOrderView").hide();
});

function viewPharmaOrderView(orderId){
    $("#order_id_display").val(orderId);
    //$("#start_date_display").text(startdate);
    jq("#pharmaOrderView").show();
}

function hidePharmaOrderView(){
    jq("#pharmaOrderView").hide();
}

function showPharmaActionWindow(){
    jq("#pharmaOrderView").hide();
    jq("#pharmaActionView").show();
}

function hidePharmaActionWindow(){
    jq("#pharmaActionView").hide();
}