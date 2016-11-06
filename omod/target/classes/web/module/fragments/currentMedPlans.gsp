<%
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "dataTables.js")
    def last_dispatch_date = "";
%>

<div id="activeOrdersWindow">
    <table id="currentMedPlansTable">
        <thead>
            <tr>
                <th id="patientSort">Patient Name</th>
                <th id="planSort">Plan Name</th>
                <th id="detailsSort">Details</th>
            </tr>
        </thead>
        <tbody>
            <% patientPlanOrdersMain.each { patientPlanOrderMain -> %>
                <% patientPlanOrderMain.value.each { patientPlanOrder -> %>
                    <tr>
                        <td>${ patientPlanOrderMain.key }</td>
                        <td>${ patientPlanOrder.key.toUpperCase() }</td>
                        <td>
                            <% patientPlanOrder.value.each { patientPlan -> %>
                            
                                <% if(patientPlanOrdersExtn.get(patientPlan.orderId).lastdispatchdate != null) { %>
                                    <% last_dispatch_date = patientPlanOrdersExtn.get(patientPlan.orderId).lastdispatchdate.format('yyyy-MM-dd'); %>
                                <% } else { %>
                                    <% last_dispatch_date = patientPlanOrdersExtn.get(patientPlan.orderId).lastdispatchdate; %>
                                <% } %>
                
                                <div class="medRow" onclick="viewPharmaOrderView('${ patientPlan.orderId }','${patientIdentifiers.get(patientPlanOrdersExtn.get(patientPlan.orderId).patientid.toInteger())}','${patientPlanOrderMain.key}','${patientDOB.get(patientPlanOrdersExtn.get(patientPlan.orderId).patientid.toInteger()).format('yyyy-MM-dd')}','${patientAddress.get(patientPlanOrdersExtn.get(patientPlan.orderId).patientid.toInteger())}','${ patientPlanOrdersExtn.get(patientPlan.orderId).startdate.format('yyyy-MM-dd') }','${ patientPlanOrdersExtn.get(patientPlan.orderId).drugname.getDisplayString() }','${ patientPlan.route.getDisplayString() }','${ patientPlan.dose }','${ patientPlan.doseUnits.getDisplayString() }','${ patientPlan.duration }','${ patientPlan.durationUnits.getDisplayString() }','${ patientPlan.quantity }','${ patientPlan.quantityUnits.getDisplayString() }','${ patientPlan.frequency }','${ patientPlanOrdersExtn.get(patientPlan.orderId).refill }','${ last_dispatch_date }','${ patientPlanOrdersExtn.get(patientPlan.orderId).refillinterval }','${providerIdentifiers.get(patientPlan.orderId)}','${ patientPlanOrdersExtn.get(patientPlan.orderId).patientinstructions }','${ patientPlanOrdersExtn.get(patientPlan.orderId).pharmacistinstructions }','${ patientPlanOrdersExtn.get(patientPlan.orderId).associateddiagnosis.getDisplayString() }','${ patientPlanOrdersExtn.get(patientPlan.orderId).isallergicorderreasons }','${ otherOrdersByPatients.get(patientPlanOrdersExtn.get(patientPlan.orderId).patientid.toInteger()).get(patientPlanOrder.key) }')">
                                    <span id="order_label">${ patientPlanOrdersExtn.get(patientPlan.orderId).drugname.getDisplayString().toUpperCase() }</span>
                                    <span id="order_value">${ patientPlanOrdersExtn.get(patientPlan.orderId).startdate.format('yyyy-MM-dd') }</span>
                                </div>
                            <% } %>
                        </td>
                    </tr>   
                <% } %>
            <% } %>
        </tbody>
    </table>
</div>

<script>
    jq('#currentMedPlansTable').dataTable({
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
    jq(".medRow").click(function(){
        jq(this).children("span").css({"background": "#75b2f0","color": "white"});
    });
</script>