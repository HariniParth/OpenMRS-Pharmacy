<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<% currentDrugOrdersExtension.each { currentDrugOrderExtension -> %>
    <% currentDrugOrdersMain.each { currentDrugOrderMain -> %>
        <% if(currentDrugOrderMain.orderId.equals(currentDrugOrderExtension.orderId) && ((currentDrugOrderExtension.orderstatus).equals("Active") || (currentDrugOrderExtension.orderstatus).equals("Hold") || (currentDrugOrderExtension.orderstatus).equals("Active-Plan") || (currentDrugOrderExtension.orderstatus).equals("Active-Group"))) { %>
            <% patientNames.each { patientName -> %>
                <% if(patientName.key.toInteger() == currentDrugOrderExtension.patientid.toInteger()) { %>
                    <% patientIdentifiers.each { patientIdentifier -> %>
                        <% if(patientIdentifier.key.toInteger() == currentDrugOrderExtension.patientid.toInteger()) { %>
                            <p> 
                                <a href="#" id="pharmacyView" onclick="viewPharmaOrderView('${ currentDrugOrderMain.orderId }','${ patientIdentifier.value }','${ patientName.value }','${ currentDrugOrderExtension.startdate }','${ currentDrugOrderExtension.drugname.getDisplayString() }','${ currentDrugOrderMain.route.getDisplayString() }','${ currentDrugOrderMain.dose }','${ currentDrugOrderMain.doseUnits.getDisplayString() }','${ currentDrugOrderMain.duration }','${ currentDrugOrderMain.durationUnits.getDisplayString() }','${ currentDrugOrderMain.quantity }','${ currentDrugOrderMain.quantityUnits.getDisplayString() }','${ currentDrugOrderMain.frequency }','${ currentDrugOrderExtension.patientinstructions }','${ currentDrugOrderExtension.pharmacistinstructions }')">
                                    ${ patientName.value } 
                                    ${ currentDrugOrderExtension.drugname.getDisplayString() } 
                                    Start Date: 
                                    ${ currentDrugOrderExtension.startdate }
                                </a>
                            </p>
                            <br/>
                        <% } %>
                    <% } %>
                <% } %>
            <% } %>
        <% } %>
    <% } %>
<% } %>
