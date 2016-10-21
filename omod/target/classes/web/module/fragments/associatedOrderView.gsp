<%
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "dataTables.js")
%>

<% if(associatedOrderExtn.size() > 0) { %>

    <div id="associatedOrdersTableWrapper">
        <strong>Associated Drug Orders</strong>
        <i class="icon-remove-sign edit-action pull-right" onclick="closeAssociatedOrdersWindow()" title="${ ui.message("Close") }"></i></span><br/><br/>
        
        <table id="associatedOrdersTable">
            <thead>
                <tr>
                    <th id="patientSort">Patient Name</th>
                    <th id="drugSort">Drug Name</th>
                    <th id="dateSort">Start Date</th>
                    <th id="prioritySort">Priority</th>
                </tr>
            </thead>
            <tbody>
                <% associatedOrderExtn.each { associatedExtn -> %>
                    <% associatedExtn.value.each { orderExtn -> %>
                        <% if(orderExtn.orderstatus == "Active-Group" || orderExtn.orderstatus == "Active-Plan") { %>

                            <tr id="orderRow" onclick="viewPharmaOrderView('${ orderExtn.orderId }','${ patientID }','${ patientName }','${ patientDOB }','${ patientAddress }','${ orderExtn.startdate }','${ orderExtn.drugname.getDisplayString() }','${ associatedOrderMain.get(orderExtn.orderId).route.getDisplayString() }','${ associatedOrderMain.get(orderExtn.orderId).dose }','${ associatedOrderMain.get(orderExtn.orderId).doseUnits.getDisplayString() }','${ associatedOrderMain.get(orderExtn.orderId).duration }','${ associatedOrderMain.get(orderExtn.orderId).durationUnits.getDisplayString() }','${ associatedOrderMain.get(orderExtn.orderId).quantity }','${ associatedOrderMain.get(orderExtn.orderId).quantityUnits.getDisplayString() }','${ associatedOrderMain.get(orderExtn.orderId).frequency }','${ orderExtn.refill }','${ orderExtn.lastdispatchdate }','${ orderExtn.refillinterval }','${ provider }','${ orderExtn.patientinstructions }','${ orderExtn.pharmacistinstructions }','${ associatedOrders }')">
                                <td>${ patientName }</td>
                                <td>${ orderExtn.drugname.getDisplayString() }</td>
                                <td>${ orderExtn.startdate }</td>
                                <td>${ orderExtn.priority.getDisplayString() }</td>
                            </tr>

                        <% } %>
                    <% } %>
                <% } %>
            </tbody>
        </table>
    </div><br/>
<% } %>


<script>
    jq('#associatedOrdersTable').dataTable({
        "sPaginationType": "full_numbers",
        "bPaginate": true,
        "bAutoWidth": false,
        "bLengthChange": true,
        "bSort": true,
        "bJQueryUI": true,
        "bFilter": false

    });
</script>