<%
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "dataTables.js")
    def last_dispatch_date = "";
%>

<form method="post" id="groupOrdersForm">
    
    <input type="hidden" id="orderID" name="orderID" />
    <input type="hidden" id="groupID" name="groupID" />
    
    <div id="activeOrdersWindow">
        <table id="currentGroupOrdersTable">
            <thead>
                <tr>
                    <th>Plan Name/Group</th>
                    <th>Drug(s)</th>
                    <th>Start Date</th>
                    <th>Refills</th>
                    <th>Last Dispatch</th>
                </tr>
            </thead>
            <tbody>
                <% patientGroupOrders.each { patientGroupOrder -> %>
                    <tr class="groupRow" onclick="selectedGroupOrder('${ patientGroupOrder.key }')">
                        <td></td>
                        <td colspan="4">
                            <% patientGroupOrder.value.each { order -> %>
                                
                                <div>
                                    <span class="groupDrug">${ order.drugname.getDisplayString() }</span>
                                    <span class="groupSDate">${ order.startdate.format('yyyy-MM-dd') }</span>
                                    <span class="groupRefill">${ order.refill }</span>

                                    <% if(order.lastdispatchdate != null) { %>
                                        <% last_dispatch_date = order.lastdispatchdate.format('yyyy-MM-dd'); %>
                                    <% } else { %>
                                        <% last_dispatch_date = order.lastdispatchdate; %>
                                    <% } %>

                                    <span class="groupDDate">${ last_dispatch_date }</span>
                                </div>
                            
                            <% } %>
                        </td>
                    </tr>
                <% } %>

                <% patientSingleOrders.each { patientSingleOrder -> %>
                    <tr class="groupRow" onclick="selectedSingleOrder('${ patientSingleOrder.orderId }')">
                        
                        <td></td>
                        <td>${ patientSingleOrder.drugname.getDisplayString() }</td>
                        <td>${ patientSingleOrder.startdate.format('yyyy-MM-dd') }</td>
                        <td>${ patientSingleOrder.refill }</td>
                        
                        <% if(patientSingleOrder.lastdispatchdate != null) { %>
                            <% last_dispatch_date = patientSingleOrder.lastdispatchdate.format('yyyy-MM-dd'); %>
                        <% } else { %>
                            <% last_dispatch_date = patientSingleOrder.lastdispatchdate; %>
                        <% } %>
                            
                        <td>${ last_dispatch_date }</td>
                        
                    </tr> 
                <% } %>

            </tbody>
        </table>
    </div>
</form>

<script>
    jq('#currentGroupOrdersTable').dataTable({
        "sPaginationType": "full_numbers",
        "bPaginate": true,
        "bAutoWidth": false,
        "bLengthChange": true,
        "bSort": true,
        "bJQueryUI": true,
        "bInfo": false,
        "bFilter": false

    });
</script>