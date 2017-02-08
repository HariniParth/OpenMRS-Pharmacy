<%
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "dataTables.js")
    def last_dispatch_date = "";
%>

<form method="post" id="individualOrderForm">
    
    <input type="hidden" id="singleID" name="singleID" />
    
    <div id="activeOrdersWindow">
        <table id="currentDrugOrdersTable">
            <thead>
                <tr>
                    <th>Plan Name</th>
                    <th>Drug(s)</th>
                    <th>Start Date</th>
                    <th>Refills</th>
                    <th>Last Dispatch</th>
                    <th>Orderer</th>
                </tr>
            </thead>
            <tbody>
                <% patientOrders.each { order -> %>

                    <tr class="orderRow <% if(order.forDiscard == 1) { %> discontinued <% } %> <% if(order.onHold == 1) { %> onHold <% } %>" onclick="selectedOrder('${ order.orderId }')" title="${ ui.message(order.commentForOrderer) }" >
                        
                        <td><% if(order.orderStatus == "Active-Plan") { %> ${ order.associatedDiagnosis.getDisplayString().toUpperCase() } <% } %></td>
                        <td>${ order.drugName.getDisplayString().toUpperCase() }</td>
                        <td>${ order.startDate.format('yyyy-MM-dd') }</td>
                        <td>${ order.refill }</td>
                        
                        <% if(order.lastDispatchDate != null) { %>
                            <% last_dispatch_date = order.lastDispatchDate.format('yyyy-MM-dd'); %>
                        <% } else { %>
                            <% last_dispatch_date = order.lastDispatchDate; %>
                        <% } %>
                                    
                        <td>${ last_dispatch_date }</td>
                        <td>${ OrdererName.get(order.orderId) }</td>
                    </tr>
                    
                <% } %>
            </tbody>
        </table>
    </div>
</form>

<script>
    jq('#currentDrugOrdersTable').dataTable({
        "sPaginationType": "full_numbers",
        "bPaginate": true,
        "bAutoWidth": false,
        "bLengthChange": true,
        "bSort": true,
        "bJQueryUI": true,
        "bInfo": true,
        "bFilter": true,
        "columns": [
            { "width": "15%" },
            { "width": "25%" },
            { "width": "15%" },
            { "width": "10%" },
            { "width": "15%" },
            { "width": "20%" }
        ],
        fixedColumns: true

    });
</script>