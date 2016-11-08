/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* global jq */

$(document).ready( function() {
    jq("#pharmaOrderViewWindow").hide();
    
    var selectedPatient = $("#pharma_action_patient_name").val();
    
    if(selectedPatient !== undefined){
        $("#selectedPatient").text("- "+selectedPatient);
        var selectedDrug = $("#pharma_action_order_details").val().replace(/(\w+).*/,"$1").toUpperCase();
            
        var $rowsNo = $('#currentDrugOrdersTable tbody tr').filter(function () {
            if($.trim($(this).find('td').eq(0).text()) === selectedPatient && $.trim($(this).find('td').eq(1).text()) === selectedDrug){
                $(this).css({"background": "#75b2f0","color": "white"});
            }
            return $.trim($(this).find('td').eq(0).text()) !== selectedPatient;
        }).hide();
    
        var $rowsNo = $('#currentMedPlansTable tbody tr').filter(function () {
            var $rowsPlan = $('.medRow').filter(function () {
                if($(this).find('#planDrugName').text() === selectedDrug){
                    $(this).children("span").css({"background": "#75b2f0","color": "white"});
                }
            });
        
            return $.trim($(this).find('td').eq(0).text()) !== selectedPatient;
        }).hide();
    }
    
    if($("#searchOrders").val() !== undefined){
        jq("#currentOrdersWindow").hide();
    }
});

function viewPharmaOrderView(orderId,patientId,patientName,patientDOB,patientAddress,startDate,drugName,route,dose,doseUnits,duration,durationUnits,quantity,quantityUnits,frequency,numRefills,lastDispatchDate,refillInterval,providerInfo,patientinstructions,pharmacistinstructions,diagnosis,isAllergic,associatedOrders){
    
    jq(this).on('click', function () {
        var $rowsNo = $('#currentDrugOrdersTable tbody tr').filter(function () {
            return $.trim($(this).find('td').eq(0).text()) !== patientName;
        }).hide();
    
        var $rowsNo = $('#currentMedPlansTable tbody tr').filter(function () {
            return $.trim($(this).find('td').eq(0).text()) !== patientName;
        }).hide();
    });
    
    $("#selectedPatient").text("- "+patientName);
    $("#pharma_order_id").val(orderId);
    $("#pharma_patient_id").val(patientId);
    $("#pharma_patient_name").val(patientName);
    $("#pharma_patient_dob").val(patientDOB);
    $("#pharma_patient_address").val(patientAddress);
    $("#pharma_start_date").val(startDate);
    $("#pharma_order_details").val(drugName +" "+dose+" "+doseUnits+" "+route+" "+duration+" "+durationUnits+" "+quantity+" "+quantityUnits+" "+frequency);
    $("#pharma_order_refill").val(numRefills);
    $("#pharma_last_dispatch_date").val(lastDispatchDate);
    $("#pharma_order_refillInterval").val(refillInterval);
    $("#order_provider").val(providerInfo);
    $("#pharma_patient_instructions").val(patientinstructions);
    $("#pharma_pharmacist_instructions").val(pharmacistinstructions);
    $("#pharma_order_diagnosis").val(diagnosis);
    if(isAllergic !== "null")
        $("#pharma_order_allergic").val(isAllergic);
    else
        $("#pharma_order_allergic").val("Nil");
    
    var associatedOrderList = associatedOrders.replace("[","").replace("]","").split(',');
    var orderList = "";
    $.each(associatedOrderList,function(index,value){
        if(!value.includes(drugName)){
            orderList = orderList + value;
        }
    });
    $("#associatedOrders").val(orderList);
    
    document.getElementById("pharmaOrderViewWindow").style.display = 'block';
    jq("#pharmaOrderViewWindow").show();
}

function showPharmaActionWindow(){
    jq("#pharmaOrderViewWindow").hide();
}

function hidePharmaActionWindow(orderID,patientID,patientName,patientDOB,patientAddress,startDate,orderDetails,numRefill,lastDispatchDate,refillInterval,providerInfo,patientInst,pharmaInst,diagnosis,isAllergic,orderList){
    jq("#pharmaOrderActionWindow").hide();
    $("#pharma_order_id").val(orderID);
    $("#pharma_patient_id").val(patientID);
    $("#pharma_patient_name").val(patientName);
    $("#pharma_patient_dob").val(patientDOB);
    $("#pharma_patient_address").val(patientAddress);
    $("#pharma_start_date").val(startDate);
    $("#pharma_order_details").val(orderDetails);
    $("#pharma_order_refill").val(numRefill);
    $("#pharma_last_dispatch_date").val(lastDispatchDate);
    $("#pharma_order_refillInterval").val(refillInterval);
    $("#order_provider").val(providerInfo);
    $("#pharma_patient_instructions").val(patientInst);
    $("#pharma_pharmacist_instructions").val(pharmaInst);
    $("#pharma_order_diagnosis").val(diagnosis);
    if(isAllergic !== "Nil")
        $("#pharma_order_allergic").val(isAllergic);
    else
        $("#pharma_order_allergic").val("Nil");
    $("#associatedOrders").val(orderList);
    jq("#pharmaOrderViewWindow").show();
}

function closeSearchResultsWindow(){
    jq("#searchResultsWindow").hide();
    jq("#currentOrdersWindow").show();
}

function closeAllOrdersWindow(){
    jq("#allOrdersTableWrapper").hide();
}

function autoCompletePatientName(patientNameList){
    var list = patientNameList.replace("[","").replace("]","").split(',');
    console.log(list);
    $("#patient_full_name").autocomplete({
       source : list,
       select : function( event , ui ) {
           $("#patient_full_name").val(ui.item.label);
           $("#searchByPatient").submit();
       }
    });
}