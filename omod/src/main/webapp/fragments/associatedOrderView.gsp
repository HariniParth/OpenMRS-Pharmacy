<%
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "dataTables.js")
    def last_dispatch_date = "";
%>

<% if(associatedOrderExtn.size() > 0) { %>

    <div id="associatedOrdersTableWrapper">
        <strong>ASSOCIATED ORDERS - ${ patientName }</strong>
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

                            <% if(orderExtn.lastdispatchdate != null) { %>
                                <% last_dispatch_date = orderExtn.lastdispatchdate.format('yyyy-MM-dd'); %>
                            <% } else { %>
                                <% last_dispatch_date = orderExtn.lastdispatchdate; %>
                            <% } %>
                                
                            <tr class="orderRow" onclick="viewPharmaOrderView('${ orderExtn.orderId }','${ patientID }','${ patientName }','${ patientDOB }','${ patientAddress }','${ orderExtn.startdate.format('yyyy-MM-dd') }','${ orderExtn.drugname.getDisplayString() }','${ associatedOrderMain.get(orderExtn.orderId).route.getDisplayString() }','${ associatedOrderMain.get(orderExtn.orderId).dose }','${ associatedOrderMain.get(orderExtn.orderId).doseUnits.getDisplayString() }','${ associatedOrderMain.get(orderExtn.orderId).duration }','${ associatedOrderMain.get(orderExtn.orderId).durationUnits.getDisplayString() }','${ associatedOrderMain.get(orderExtn.orderId).quantity }','${ associatedOrderMain.get(orderExtn.orderId).quantityUnits.getDisplayString() }','${ associatedOrderMain.get(orderExtn.orderId).frequency }','${ orderExtn.refill }','${ last_dispatch_date }','${ orderExtn.refillinterval }','${ provider }','${ orderExtn.patientinstructions }','${ orderExtn.pharmacistinstructions }','${ orderExtn.associateddiagnosis.getDisplayString() }','${ orderExtn.isallergicorderreasons }','${ otherOrders.get(orderExtn.orderId) }')">
                                <td>${ patientName }</td>
                                <td>${ orderExtn.drugname.getDisplayString() }</td>
                                <td>${ orderExtn.startdate.format('yyyy-MM-dd') }</td>
                                <td>${ orderExtn.priority.getDisplayString() }</td>
                            </tr>

                        <% } %>
                    <% } %>
                <% } %>
            </tbody>
        </table><br/><br/>
        
        <% if(allOrdersExtn.size() > 0) { %>
            <strong>OTHER DRUG ORDERS - ${ patientName }</strong><br/><br/>

            <table id="allOrdersTable">
                <thead>
                    <tr>
                        <th id="patientSort">Patient Name</th>
                        <th id="drugSort">Drug Name</th>
                        <th id="dateSort">Start Date</th>
                        <th id="prioritySort">Priority</th>
                    </tr>
                </thead>
                <tbody>
                    <% allOrdersExtn.each { extn -> %>

                        <% if(extn.value.lastdispatchdate != null) { %>
                            <% last_dispatch_date = extn.value.lastdispatchdate.format('yyyy-MM-dd'); %>
                        <% } else { %>
                            <% last_dispatch_date = extn.value.lastdispatchdate; %>
                        <% } %>

                        <tr class="orderRow" onclick="viewPharmaOrderView('${ extn.key }','${ patientID }','${ patientName }','${ patientDOB }','${ patientAddress }','${ extn.value.startdate.format('yyyy-MM-dd') }','${ extn.value.drugname.getDisplayString() }','${ allOrdersMain.get(extn.value.orderId).route.getDisplayString() }','${ allOrdersMain.get(extn.value.orderId).dose }','${ allOrdersMain.get(extn.value.orderId).doseUnits.getDisplayString() }','${ allOrdersMain.get(extn.value.orderId).duration }','${ allOrdersMain.get(extn.value.orderId).durationUnits.getDisplayString() }','${ allOrdersMain.get(extn.value.orderId).quantity }','${ allOrdersMain.get(extn.value.orderId).quantityUnits.getDisplayString() }','${ allOrdersMain.get(extn.value.orderId).frequency }','${ extn.value.refill }','${ last_dispatch_date }','${ extn.value.refillinterval }','${ provider }','${ extn.value.patientinstructions }','${ extn.value.pharmacistinstructions }','${ extn.value.associateddiagnosis.getDisplayString() }','${ extn.value.isallergicorderreasons }','${ otherOrders.get(extn.key) }')">
                            <td>${ patientName }</td>
                            <td>${ extn.value.drugname.getDisplayString() }</td>
                            <td>${ extn.value.startdate.format('yyyy-MM-dd') }</td>
                            <td>${ extn.value.priority.getDisplayString() }</td>
                        </tr>

                    <% } %>
                </tbody>
            </table><br/><br/>
            
        <% } %>
        <div id="line-break"></div><br/><br/>
        
    </div>
<% } %>

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