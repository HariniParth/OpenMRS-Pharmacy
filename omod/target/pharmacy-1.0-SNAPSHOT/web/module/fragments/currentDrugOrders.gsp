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
                <% currentDrugOrdersMain.each { currentDrugOrderMain -> %>
                    <% if(currentDrugOrderMain.orderId.equals(currentDrugOrderExtension.orderId) && ((currentDrugOrderExtension.orderstatus).equals("Active") || (currentDrugOrderExtension.orderstatus).equals("Hold") || (currentDrugOrderExtension.orderstatus).equals("Active-Plan") || (currentDrugOrderExtension.orderstatus).equals("Active-Group"))) { %>

                        <tr id="orderRow" onclick="viewPharmaOrderView('${ currentDrugOrderMain.orderId }','${patientIdentifiers.get(currentDrugOrderExtension.patientid.toInteger())}','${patientNames.get(currentDrugOrderExtension.patientid.toInteger())}','${patientDOB.get(currentDrugOrderExtension.patientid.toInteger())}','${patientAddress.get(currentDrugOrderExtension.patientid.toInteger())}','${ currentDrugOrderExtension.startdate }','${ currentDrugOrderExtension.drugname.getDisplayString() }','${ currentDrugOrderMain.route.getDisplayString() }','${ currentDrugOrderMain.dose }','${ currentDrugOrderMain.doseUnits.getDisplayString() }','${ currentDrugOrderMain.duration }','${ currentDrugOrderMain.durationUnits.getDisplayString() }','${ currentDrugOrderMain.quantity }','${ currentDrugOrderMain.quantityUnits.getDisplayString() }','${ currentDrugOrderMain.frequency }','${ currentDrugOrderExtension.patientinstructions }','${ currentDrugOrderExtension.pharmacistinstructions }')">
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
                <% } %>
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