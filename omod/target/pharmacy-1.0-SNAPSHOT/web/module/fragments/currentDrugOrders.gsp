<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<% currentDrugOrdersExtension.each { currentDrugOrderExtension -> %>
    <% currentDrugOrdersMain.each { currentDrugOrderMain -> %>
        <% if(currentDrugOrderMain.orderId.equals(currentDrugOrderExtension.orderId)) { %>
            <% patientNames.each { patientName -> %>
                <% if(patientName.key.equals(currentDrugOrderExtension.patientid)) { %>
                    One ${ patientName.value }
                <% } %>
                <% if(${ patientName.key } == currentDrugOrderExtension.patientid) { %>
                    Two ${ patientName.value }
                <% } %>
            <% } %>
            <p> 
                <a href="#" id="pharmacyView" onclick="viewPharmaOrderView('${ currentDrugOrderMain.orderId }','${ currentDrugOrderExtension.patientid }','${ currentDrugOrderExtension.startdate }','${ currentDrugOrderExtension.drugname }','${ currentDrugOrderMain.dose }','${ currentDrugOrderMain.doseUnits.getDisplayString() }','${ currentDrugOrderMain.duration }','${ currentDrugOrderMain.durationUnits.getDisplayString() }','${ currentDrugOrderMain.quantity }','${ currentDrugOrderMain.quantityUnits.getDisplayString() }','${ currentDrugOrderMain.frequency }','${ currentDrugOrderExtension.patientinstructions }','${ currentDrugOrderExtension.pharmacistinstructions }')">
                    ${ currentDrugOrderExtension.patientid } 
                    ${ currentDrugOrderExtension.drugname } 
                    Start Date: 
                    ${ currentDrugOrderExtension.startdate }
                </a>
            </p>
        <% } %>
    <% } %>
    <br/>
<% } %>

