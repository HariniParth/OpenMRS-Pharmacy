/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* global jq */

$(document).ready( function() {
    
    $(document).mouseup(function (e){
        var objects = $('.dialog');
        $(objects).each(function(){
            if (!$(this).is(e.target) && $(this).has(e.target).length === 0){
                $(this).hide();
                clearHighlights();
            }
        });        
    });
    
    var selectedPatient = $("#pharma_action_patient_name").val();
    
    if(selectedPatient !== undefined){
        $("#selectedPatient").text("- "+selectedPatient);
        var selectedDrug = $("#pharma_action_order_details").val().replace(/(\w+).*/,"$1").toUpperCase();
            
        var $rowsNo = $('#currentDrugOrdersTable tbody tr').filter(function () {
            if($.trim($(this).find('td').eq(0).text()) === selectedPatient && $.trim($(this).find('td').eq(2).text()) === selectedDrug){
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
    
    var selectedGroupPatient = $("#group_order_patient_name").val();
    
    if(selectedGroupPatient !== undefined){
        $("#selectedGroupPatient").text("- "+selectedGroupPatient);
        
        var $rowsNo = $('#currentGroupOrdersTable tbody tr').filter(function () {
            
            var givenDrug = $.trim($(this).find('td').eq(2).find('div').find('span').first().text());
            var matching = false;
            
            $(".group_order_order_details").each(function(){
                var selectedDrug = $(this).val().split(",")[0].toUpperCase();
                
                if(selectedDrug === givenDrug)
                    matching = true;
            });
            
            if(matching){
                $(this).css({"background": "#75b2f0","color": "white"});
            }
            return $.trim($(this).find('td').eq(0).text()) !== selectedGroupPatient;
        }).hide();
        
        var selectedDiagnosis = $(".group_order_order_diagnosis").val().toUpperCase();
        
        var $rowsNo = $('#currentPlanGroupTable tbody tr').filter(function () {
            
            if($(this).find('td').eq(2).text() === selectedDiagnosis){
                $(this).css({"background": "#75b2f0","color": "white"});
            }
            return $.trim($(this).find('td').eq(0).text()) !== selectedGroupPatient;
        }).hide();
    }
    
    if($("#searchOrders").val() !== undefined){
        jq("#currentOrdersWindow").hide();
    }
});

function clearHighlights(){
    
    jq(".groupRow").each(function(){
        jq(this).css({'background-color':'','color':''});
    });
    jq(".orderRow").each(function(){
        jq(this).css({'background-color':'','color':''});
    });
    jq(".medRow").each(function(){
        jq(this).children("span").css({'background-color':'','color':''});
    });
}

function viewPharmaOrderView(orderId,patientId,patientName,patientDOB,patientAddress,startDate,drugName,route,dose,doseUnits,duration,durationUnits,quantity,quantityUnits,frequency,numRefills,lastDispatchDate,refillInterval,providerInfo,patientinstructions,pharmacistinstructions,diagnosis,isAllergic,associatedOrders){
    
    jq(this).on('click', function () {
        var $rowsNo = $('#currentDrugOrdersTable tbody tr').filter(function () {
            return $.trim($(this).find('td').eq(0).text()) !== patientName;
        }).hide();
    
        var $rowsNo = $('#currentMedPlansTable tbody tr').filter(function () {
            return $.trim($(this).find('td').eq(0).text()) !== patientName;
        }).hide();
    });
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

function selectedMedPlanGroup(planPatient, planName){
    $("#planPatient").val(planPatient);
    $("#planName").val(planName);
    $("#medPlanGroupForm").submit();
    $("#searchGroupForm").submit();
}

function selectedGroupOrder(groupID){
    $("#groupID").val(groupID);
    $("#groupOrdersForm").submit();
}

function selectedSingleOrder(orderID){
    $("#orderID").val(orderID);
    $("#groupOrdersForm").submit();
}

function selectedOrder(orderID){
    $("#singleID").val(orderID);
    $("#individualOrderForm").submit();
}

function showPharmaConfirmationSection(action){
    $("#pharmaGroupAction").val(action);
    jq("#pharmaGroupButtons").hide();
    jq("#pharmaGroupActionButtons").show();
    document.getElementById("pharmaGroupActionButtons").style.display = 'block';
}

function showPharmaOrderViewSection(){
    jq("#pharmaGroupActionButtons").hide();
    jq("#pharmaGroupButtons").show();
    document.getElementById("#pharmaGroupButtons").style.display = 'block';
}

function clearPatientTableFIlters(){
    $("#patient_full_name").val("");
    $("#searchByPatient").submit();
}