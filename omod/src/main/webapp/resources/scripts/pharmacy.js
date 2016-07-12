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

function viewPharmaOrderView(orderId,patientId,startDate,drugName,route,dose,doseUnits,duration,durationUnits,quantity,quantityUnits,frequency,patientinstructions,pharmacistinstructions){
    $("#order_id").text(orderId);
    $("#patient_id").text(patientId);
    $("#start_date").text(startDate);
    $("#order_details").text(drugName +" "+dose+" "+doseUnits+" "+route+" "+duration+" "+durationUnits+" "+quantity+" "+quantityUnits+" "+frequency);
    $("#patient_instructions").text(patientinstructions);
    $("#pharmacist_instructions").text(pharmacistinstructions);
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