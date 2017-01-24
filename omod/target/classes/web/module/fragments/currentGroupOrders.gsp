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
                    <th>Plan Name</th>
                    <th>Drug(s)</th>
                    <th>Start Date</th>
                    <th>Refills</th>
                    <th>Last Dispatch</th>
                    <th>Orderer</th>
                </tr>
            </thead>
            <tbody>
                <% patientPlanOrders.each { patientPlanOrder -> %>
                    <tr class="groupRow" onclick="selectedPlanOrder('${ patientPlanOrder.key }')">
                        
                        <td>${ planName.get(patientPlanOrder.key).getDisplayString() }</td>
                        <td colspan="5">
                            <% patientPlanOrder.value.each { order -> %>
                                
                                <div class="groupElement <% if(order.forDiscard == 1) { %> discontinued <% } %> <% if(order.onHold == 1) { %> onhold <% } %>" title="${ ui.message(order.comments) }">
                                    
                                    <div class="d1">
                                        <div class="g1">
                                            <div class="c1">${ order.drugname.getDisplayString().toUpperCase() }</div>
                                            <div class="c2"></div>
                                        </div>
                                        <div class="g2">
                                            <div class="c3">${ order.startdate.format('yyyy-MM-dd') }</div>
                                            <div class="c4"></div>
                                        </div>
                                    </div>
                                    
                                    <div class="d2">
                                        <div class="d3">
                                            <div class="g3">${ order.refill }</div>
                                        </div>
                                        
                                        <div class="d4">
                                            <% if(order.lastdispatchdate != null) { %>
                                                <% last_dispatch_date = order.lastdispatchdate.format('yyyy-MM-dd'); %>
                                            <% } else { %>
                                                <% last_dispatch_date = order.lastdispatchdate; %>
                                            <% } %>

                                            <div class="g4">${ last_dispatch_date }</div>
                                            <div class="g5">${ OrdererName.get(order.orderId) }</div>
                                        </div>
                                    </div><br/><br/>
                                </div>
                            
                            <% } %>
                        </td>
                        <td style="display: none;"></td>
                        <td style="display: none;"></td>
                        <td style="display: none;"></td>
                        <td style="display: none;"></td>
                    </tr>
                <% } %>
                
                <% patientGroupOrders.each { patientGroupOrder -> %>
                    <tr class="groupRow" onclick="selectedGroupOrder('${ patientGroupOrder.key }')">
                        <td></td>
                        <td colspan="5">
                            <% patientGroupOrder.value.each { order -> %>
                                
                                <div class="groupElement <% if(order.forDiscard == 1) { %> discontinued <% } %> <% if(order.onHold == 1) { %> onhold <% } %>" title="${ ui.message(order.comments) }">
                                    
                                    <div class="d1">
                                        <div class="g1">
                                            <div class="c1">${ order.drugname.getDisplayString().toUpperCase() }</div>
                                            <div class="c2"></div>
                                        </div>
                                        <div class="g2">
                                            <div class="c3">${ order.startdate.format('yyyy-MM-dd') }</div>
                                            <div class="c4"></div>
                                        </div>
                                    </div>
                                    
                                    <div class="d2">
                                        <div class="d3">
                                            <div class="g3">${ order.refill }</div>
                                        </div>
                                        
                                        <div class="d4">
                                            <% if(order.lastdispatchdate != null) { %>
                                                <% last_dispatch_date = order.lastdispatchdate.format('yyyy-MM-dd'); %>
                                            <% } else { %>
                                                <% last_dispatch_date = order.lastdispatchdate; %>
                                            <% } %>

                                            <div class="g4">${ last_dispatch_date }</div>
                                            <div class="g5">${ OrdererName.get(order.orderId) }</div>
                                        </div>
                                    </div><br/><br/>
                                </div>
                            
                            <% } %>
                        </td>
                        <td style="display: none;"></td>
                        <td style="display: none;"></td>
                        <td style="display: none;"></td>
                        <td style="display: none;"></td>
                    </tr>
                <% } %>

                <% patientSingleOrders.each { patientSingleOrder -> %>
                    <tr class="singleRow <% if(patientSingleOrder.forDiscard == 1) { %> discontinued <% } %> <% if(patientSingleOrder.onHold == 1) { %> onhold <% } %>" onclick="selectedSingleOrder('${ patientSingleOrder.orderId }')" title="${ ui.message(patientSingleOrder.comments) }">
                        
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
                        <td>${ OrdererName.get(patientSingleOrder.orderId) }</td>
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