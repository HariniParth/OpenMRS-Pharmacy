/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* global jq */

$(document).ready( function() {
    jq("#pharmaOrderViewWindow").hide();
});

function viewPharmaOrderView(orderId,patientId,patientName,startDate,drugName,route,dose,doseUnits,duration,durationUnits,quantity,quantityUnits,frequency,patientinstructions,pharmacistinstructions){
    $("#pharma_order_id").val(orderId);
    $("#pharma_patient_id").val(patientId);
    $("#pharma_patient_name").val(patientName);
    $("#pharma_start_date").val(startDate);
    $("#pharma_order_details").val(drugName +" "+dose+" "+doseUnits+" "+route+" "+duration+" "+durationUnits+" "+quantity+" "+quantityUnits+" "+frequency);
    $("#pharma_patient_instructions").val(patientinstructions);
    $("#pharma_pharmacist_instructions").val(pharmacistinstructions);
    jq("#pharmaOrderViewWindow").show();
}

function hidePharmaOrderView(){
    jq("#pharmaOrderViewWindow").hide();
}

function showPharmaActionWindow(status){
    jq("#pharmaOrderViewWindow").hide();
    $("#status").text(status);
    jq("#pharmaOrderActionWindow").show();
}

function hidePharmaActionWindow(){
    jq("#pharmaOrderActionWindow").hide();
    jq("#pharmaOrderViewWindow").show();
}

function searchPharmaOrderByOrderID(){
    jq("#pharmaOrderViewWindow").show();
}