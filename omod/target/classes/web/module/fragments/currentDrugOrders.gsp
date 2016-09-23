<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<table id="currentDrugOrdersTable">
    <thead>
        <tr>
            <th>Patient Name</th>
            <th>Drug Name</th>
            <th>Start Date</th>
        </tr>
    </thead>
    <tbody>
        <% currentDrugOrdersExtension.each { currentDrugOrderExtension -> %>
            <% currentDrugOrdersMain.each { currentDrugOrderMain -> %>
                <% if(currentDrugOrderMain.orderId.equals(currentDrugOrderExtension.orderId) && ((currentDrugOrderExtension.orderstatus).equals("Active") || (currentDrugOrderExtension.orderstatus).equals("Hold") || (currentDrugOrderExtension.orderstatus).equals("Active-Plan") || (currentDrugOrderExtension.orderstatus).equals("Active-Group"))) { %>
                    
                    <tr onclick="viewPharmaOrderView('${ currentDrugOrderMain.orderId }','${patientIdentifiers.get(currentDrugOrderExtension.patientid.toInteger())}','${patientNames.get(currentDrugOrderExtension.patientid.toInteger())}','${patientDOB.get(currentDrugOrderExtension.patientid.toInteger())}','${ currentDrugOrderExtension.startdate }','${ currentDrugOrderExtension.drugname.getDisplayString() }','${ currentDrugOrderMain.route.getDisplayString() }','${ currentDrugOrderMain.dose }','${ currentDrugOrderMain.doseUnits.getDisplayString() }','${ currentDrugOrderMain.duration }','${ currentDrugOrderMain.durationUnits.getDisplayString() }','${ currentDrugOrderMain.quantity }','${ currentDrugOrderMain.quantityUnits.getDisplayString() }','${ currentDrugOrderMain.frequency }','${ currentDrugOrderExtension.patientinstructions }','${ currentDrugOrderExtension.pharmacistinstructions }')">
                        <td>
                            <a href="#">${ patientNames.get(currentDrugOrderExtension.patientid.toInteger()) }</a>
                        </td>
                        <td>
                            <a href="#">${ currentDrugOrderExtension.drugname.getDisplayString().toUpperCase().capitalize() }</a>
                        </td>
                        <td>
                            <a href="#">${ currentDrugOrderExtension.startdate }</a>
                        </td>
                    </tr>
                <% } %>
            <% } %>
        <% } %>
    </tbody>
</table>

<script>
    jq('#currentDrugOrdersTable').dataTable({
        "sPaginationType": "full_numbers",
        "bPaginate": true,
        "bAutoWidth": false,
        "bLengthChange": true,
        "bSort": true,
        "bJQueryUI": true
    });
</script>