<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<% currentDrugOrdersExtension.each { currentDrugOrderExtension -> %>
    <% currentDrugOrdersMain.each { currentDrugOrderMain -> %>
        <% if(currentDrugOrderMain.orderId.equals(currentDrugOrderExtension.orderId) && ((currentDrugOrderExtension.orderstatus).equals("Active") || (currentDrugOrderExtension.orderstatus).equals("Hold") || (currentDrugOrderExtension.orderstatus).equals("Active-Plan") || (currentDrugOrderExtension.orderstatus).equals("Active-Group"))) { %>
        
             <p> 
                <a href="#" id="pharmacyView" onclick="viewPharmaOrderView('${ currentDrugOrderMain.orderId }','${patientIdentifiers.get(currentDrugOrderExtension.patientid.toInteger())}','${patientNames.get(currentDrugOrderExtension.patientid.toInteger())}','${patientDOB.get(currentDrugOrderExtension.patientid.toInteger())}','${ currentDrugOrderExtension.startdate }','${ currentDrugOrderExtension.drugname.getDisplayString() }','${ currentDrugOrderMain.route.getDisplayString() }','${ currentDrugOrderMain.dose }','${ currentDrugOrderMain.doseUnits.getDisplayString() }','${ currentDrugOrderMain.duration }','${ currentDrugOrderMain.durationUnits.getDisplayString() }','${ currentDrugOrderMain.quantity }','${ currentDrugOrderMain.quantityUnits.getDisplayString() }','${ currentDrugOrderMain.frequency }','${ currentDrugOrderExtension.patientinstructions }','${ currentDrugOrderExtension.pharmacistinstructions }')">
                    ${patientNames.get(currentDrugOrderExtension.patientid.toInteger())}
                    ${ currentDrugOrderExtension.drugname.getDisplayString() } 
                    Start Date: 
                    ${ currentDrugOrderExtension.startdate }
                </a>
            </p>
        
        <% } %>
    <% } %>
<% } %>
