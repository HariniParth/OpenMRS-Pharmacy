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
                    <th>Plan Name/Group</th>
                    <th>Drug(s)</th>
                    <th>Start Date</th>
                    <th>Refills</th>
                    <th>Last Dispatch</th>
                </tr>
            </thead>
            <tbody>
                <% patientOrders.each { order -> %>

                    <tr class="orderRow" onclick="selectedOrder('${ order.orderId }')">
                        <td></td>
                        <td>${ order.drugname.getDisplayString() }</td>
                        <td>${ order.startdate.format('yyyy-MM-dd') }</td>
                        <td>${ order.refill }</td>
                        
                        <% if(order.lastdispatchdate != null) { %>
                            <% last_dispatch_date = order.lastdispatchdate.format('yyyy-MM-dd'); %>
                        <% } else { %>
                            <% last_dispatch_date = order.lastdispatchdate; %>
                        <% } %>
                                    
                        <td>${ last_dispatch_date }</td>
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
        "bInfo": false,
        "bFilter": false

    });
</script>

<script type="text/javascript">    
    jq(".orderRow").click(function(){
        jq(this).css({"background": "#75b2f0","color": "white"});
    });
</script>