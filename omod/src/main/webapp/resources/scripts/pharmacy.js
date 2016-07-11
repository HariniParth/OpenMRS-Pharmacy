/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* global jq */

$(document).ready( function() {
    jq("#pharmaOrderViewWindow").hide();
    jq("#pharmaOrderActionWindow").hide();
});

function viewPharmaOrderView(orderId){
    $("#order_id_display").text(orderId);
    jq("#pharmaOrderViewWindow").show();
}

function hidePharmaOrderView(){
    jq("#pharmaOrderViewWindow").hide();
}

function showPharmaActionWindow(){
    jq("#pharmaOrderViewWindow").hide();
    jq("#pharmaOrderActionWindow").show();
}

function hidePharmaActionWindow(){
    jq("#pharmaOrderActionWindow").hide();
    jq("#pharmaOrderViewWindow").show();
}

function searchPharmaOrderByOrderID(){
    var orderId = $("#search_order_id").val();
    $("#order_id_display").val(orderId);
    jq("#pharmaOrderViewWindow").show();
}