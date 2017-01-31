<%
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "dataTables.js")
    def last_dispatch_date = "";
%>

<div id="allOrdersTableWrapper">
    
    <% if(associatedOrderExtn.size() > 0 || allOrdersExtn.size() > 0) { %>
        
        <i class="icon-remove-sign edit-action pull-right" onclick="closeAllOrdersWindow()" title="${ ui.message("Close") }"></i></span><br/><br/>
        
        <% if(associatedOrderExtn.size() > 0) { %>

            <form method="post" id="associatedOrderForm">
    
                <input type="hidden" id="assocID" name="assocID" />
                
                <div id="associatedOrdersTableWrapper">
                    <strong>ASSOCIATED ORDERS</strong><br/><br/>

                    <table id="associatedOrdersTable">
                        <thead>
                            <tr>
                                <th>Plan Name/Group</th>
                                <th>Drug(s)</th>
                                <th>Start Date</th>
                                <th>Refills</th>
                                <th>Last Dispatch</th>
                                <th>Orderer</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% associatedOrderExtn.each { associatedExtn -> %>
                                <% associatedExtn.value.each { orderExtn -> %>
                                    <% if(orderExtn.orderstatus == "Active-Group" || orderExtn.orderstatus == "Active-Plan") { %>

                                        <% if(orderExtn.lastdispatchdate != null) { %>
                                            <% last_dispatch_date = orderExtn.lastdispatchdate.format('yyyy-MM-dd'); %>
                                        <% } else { %>
                                            <% last_dispatch_date = orderExtn.lastdispatchdate; %>
                                        <% } %>

                                        <tr class="orderRow <% if(orderExtn.fordiscard == 1) { %> discontinued <% } %> <% if(orderExtn.onhold == 1) { %> onhold <% } %>" onclick="associatedOrder('${ orderExtn.orderId }')" title="${ ui.message(orderExtn.comments) }">
                                            <td></td>
                                            <td>${ orderExtn.drugname.getDisplayString() }</td>
                                            <td>${ orderExtn.startdate.format('yyyy-MM-dd') }</td>
                                            <td>${ orderExtn.refill }</td>
                                            <td>${ last_dispatch_date }</td>
                                            <td>${ assocOrdererName.get(orderExtn.orderId) }</td>
                                        </tr>

                                    <% } %>
                                <% } %>
                            <% } %>
                        </tbody>
                    </table><br/>
                </div>
            </form>
        <% } %>

        <% if(allOrdersExtn.size() > 0) { %>
        
            <form method="post" id="otherOrderForm">
    
                <input type="hidden" id="otherID" name="otherID" />
                
                <div id="otherOrdersTableWrapper">
                    <strong>OTHER DRUG ORDERS</strong><br/><br/>

                    <table id="allOrdersTable">
                        <thead>
                            <tr>
                                <th>Plan Name/Group</th>
                                <th>Drug(s)</th>
                                <th>Start Date</th>
                                <th>Refills</th>
                                <th>Last Dispatch</th>
                                <th>Orderer</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% allOrdersExtn.each { extn -> %>
                                <% if(extn.value.orderstatus == "Active" || extn.value.orderstatus == "Active-Group" || extn.value.orderstatus == "Active-Plan") { %>

                                    <% if(extn.value.lastdispatchdate != null) { %>
                                        <% last_dispatch_date = extn.value.lastdispatchdate.format('yyyy-MM-dd'); %>
                                    <% } else { %>
                                        <% last_dispatch_date = extn.value.lastdispatchdate; %>
                                    <% } %>

                                    <tr class="orderRow <% if(orderExtn.fordiscard == 1) { %> discontinued <% } %> <% if(orderExtn.onhold == 1) { %> onhold <% } %>" onclick="otherOrder('${ extn.value.orderId }')">
                                        <td></td>
                                        <td>${ extn.value.drugname.getDisplayString() }</td>
                                        <td>${ extn.value.startdate.format('yyyy-MM-dd') }</td>
                                        <td>${ extn.value.refill }</td>
                                        <td>${ last_dispatch_date }</td>
                                        <td>${ assocOrdererName.get(extn.value.orderId) }</td>
                                    </tr>

                                <% } %>
                            <% } %>
                        </tbody>
                    </table><br/>
                </div>
            </form>
        <% } %> <br/>
    <% } %>
</div>

<script>
    jq('#associatedOrdersTable').dataTable({
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

<script>
    jq('#allOrdersTable').dataTable({
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

<script type="text/javascript">    
    jq(".orderRow").click(function(){
        jq(this).css({"background": "#75b2f0","color": "white"});
    });
</script>