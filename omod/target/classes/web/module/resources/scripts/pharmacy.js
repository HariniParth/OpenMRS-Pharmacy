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

function associatedOrder(orderID){
    $("#assocID").val(orderID);
    $("#associatedOrderForm").submit();
}

function otherOrder(orderID){
    $("#otherID").val(orderID);
    $("#otherOrderForm").submit();
}

function showPharmaConfirmationSection(action){
    $("#pharmaGroupAction").val(action);
    $("#pharmaSingleAction").val(action);
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