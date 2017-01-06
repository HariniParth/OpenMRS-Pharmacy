<%
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "dataTables.js")
    def last_dispatch_date = "";
%>

<form method="post" id="groupOrdersForm">
    
    <input type="hidden" id="planID" name="planID" />
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
                <% patientPlanOrders.each { patientPlanOrder -> %>
                    <tr class="groupRow" onclick="selectedPlanOrder('${ patientPlanOrder.key }')">
                        
                        <td>${ planName.get(patientPlanOrder.key).getDisplayString() }</td>
                        <td colspan="4">
                            <% patientPlanOrder.value.each { order -> %>
                                
                                <div class="groupElement <% if(order.discontinued == 1) { %> discontinued <% } %> <% if(order.onHold == 1) { %> onhold <% } %>" title="${ ui.message(order.comments) }">
                                    
                                    <div class="d1">
                                        <div class="g1">${ order.drugname.getDisplayString().toUpperCase() }</div>
                                        <div class="g2">&nbsp; ${ order.startdate.format('yyyy-MM-dd') }</div>
                                    </div>
                                    
                                    <div class="d2">
                                        <div class="g3">${ order.refill }</div>

                                        <% if(order.lastdispatchdate != null) { %>
                                            <% last_dispatch_date = order.lastdispatchdate.format('yyyy-MM-dd'); %>
                                        <% } else { %>
                                            <% last_dispatch_date = order.lastdispatchdate; %>
                                        <% } %>

                                        <div class="g4">${ last_dispatch_date }</div>
                                    </div>
                                </div>
                            
                            <% } %>
                        </td>
                        <td style="display: none;"></td>
                        <td style="display: none;"></td>
                        <td style="display: none;"></td>
                    </tr>
                <% } %>
                
                <% patientGroupOrders.each { patientGroupOrder -> %>
                    <tr class="groupRow" onclick="selectedGroupOrder('${ patientGroupOrder.key }')">
                        <td></td>
                        <td colspan="4">
                            <% patientGroupOrder.value.each { order -> %>
                                
                                <div class="groupElement <% if(order.discontinued == 1) { %> discontinued <% } %> <% if(order.onHold == 1) { %> onhold <% } %>" title="${ ui.message(order.comments) }">
                                    
                                    <div class="d1">
                                        <div class="g1">${ order.drugname.getDisplayString().toUpperCase() }</div>
                                        <div class="g2">&nbsp; ${ order.startdate.format('yyyy-MM-dd') }</div>
                                    </div>
                                    
                                    <div class="d2">
                                        <div class="g3">${ order.refill }</div>

                                        <% if(order.lastdispatchdate != null) { %>
                                            <% last_dispatch_date = order.lastdispatchdate.format('yyyy-MM-dd'); %>
                                        <% } else { %>
                                            <% last_dispatch_date = order.lastdispatchdate; %>
                                        <% } %>

                                        <div class="g4">${ last_dispatch_date }</div>
                                    </div>
                                </div>
                            
                            <% } %>
                        </td>
                        <td style="display: none;"></td>
                        <td style="display: none;"></td>
                        <td style="display: none;"></td>
                    </tr>
                <% } %>

                <% patientSingleOrders.each { patientSingleOrder -> %>
                    <tr class="singleRow <% if(patientSingleOrder.discontinued == 1) { %> discontinued <% } %> <% if(patientSingleOrder.onHold == 1) { %> onhold <% } %>" onclick="selectedSingleOrder('${ patientSingleOrder.orderId }')" title="${ ui.message(patientSingleOrder.comments) }">
                        
                        <td></td>
                        <td>${ patientSingleOrder.drugname.getDisplayString().toUpperCase() }</td>
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
        "bInfo": true,
        "bFilter": true

    });
</script>