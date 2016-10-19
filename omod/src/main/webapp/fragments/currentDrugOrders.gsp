<%
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "dataTables.js")
%>

<div id="activeOrdersWindow">
    <table id="currentDrugOrdersTable">
        <thead>
            <tr>
                <th id="patientSort">Patient Name</th>
                <th id="drugSort">Drug Name</th>
                <th id="dateSort">Start Date</th>
                <th id="prioritySort">Priority</th>
            </tr>
        </thead>
        <tbody>
            <% currentDrugOrdersExtension.each { currentDrugOrderExtension -> %>
                <% def otherOrdersInGroup = "Nil" %>
                <% if(currentDrugOrderExtension.orderstatus == "Active-Group") { %>
                    <% otherOrdersInGroup = otherOrders.get(currentDrugOrderExtension.orderId) %>
                <% } %>
                
                <tr id="orderRow" onclick="viewPharmaOrderView('${ currentDrugOrdersMain.get(currentDrugOrderExtension.orderId).orderId }','${patientIdentifiers.get(currentDrugOrderExtension.patientid.toInteger())}','${patientNames.get(currentDrugOrderExtension.patientid.toInteger())}','${patientDOB.get(currentDrugOrderExtension.patientid.toInteger())}','${patientAddress.get(currentDrugOrderExtension.patientid.toInteger())}','${ currentDrugOrderExtension.startdate }','${ currentDrugOrderExtension.drugname.getDisplayString() }','${ currentDrugOrdersMain.get(currentDrugOrderExtension.orderId).route.getDisplayString() }','${ currentDrugOrdersMain.get(currentDrugOrderExtension.orderId).dose }','${ currentDrugOrdersMain.get(currentDrugOrderExtension.orderId).doseUnits.getDisplayString() }','${ currentDrugOrdersMain.get(currentDrugOrderExtension.orderId).duration }','${ currentDrugOrdersMain.get(currentDrugOrderExtension.orderId).durationUnits.getDisplayString() }','${ currentDrugOrdersMain.get(currentDrugOrderExtension.orderId).quantity }','${ currentDrugOrdersMain.get(currentDrugOrderExtension.orderId).quantityUnits.getDisplayString() }','${ currentDrugOrdersMain.get(currentDrugOrderExtension.orderId).frequency }','${ currentDrugOrderExtension.refill }','${ currentDrugOrderExtension.lastdispatchdate }','${ currentDrugOrderExtension.refillinterval }','${providerIdentifiers.get(currentDrugOrdersMain.get(currentDrugOrderExtension.orderId).orderId)}','${ currentDrugOrderExtension.patientinstructions }','${ currentDrugOrderExtension.pharmacistinstructions }','${ otherOrdersInGroup }')">
                    <td>
                        ${ patientNames.get(currentDrugOrderExtension.patientid.toInteger()) }
                    </td>
                    <td>
                        ${ currentDrugOrderExtension.drugname.getDisplayString().toUpperCase().capitalize() }
                    </td>
                    <td>
                        ${ currentDrugOrderExtension.startdate }
                    </td>
                    <td>
                        ${ currentDrugOrderExtension.priority.getDisplayString() }
                    </td>
                </tr>
            <% } %>
        </tbody>
    </table>
</div>

<script>
    jq('#currentDrugOrdersTable').dataTable({
        "sPaginationType": "full_numbers",
        "bPaginate": true,
        "bAutoWidth": false,
        "bLengthChange": true,
        "bSort": true,
        "bJQueryUI": true,
        "bFilter": false

    });
</script>