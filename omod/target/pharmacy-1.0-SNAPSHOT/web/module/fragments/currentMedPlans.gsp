<%
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "dataTables.js")
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
                        <td>${ patientPlanOrder.key }</td>
                        <td>
                            <% patientPlanOrder.value.each { patientPlan -> %>
                                <div>
                                    <span id="order_label">${ patientPlanOrdersExtn.get(patientPlan.orderId).drugname.getDisplayString() }</span>
                                    <span id="order_value">${ patientPlanOrdersExtn.get(patientPlan.orderId).startdate }</span>
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
        "bFilter": false

    });
</script>