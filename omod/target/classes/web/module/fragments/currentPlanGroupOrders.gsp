<%
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "dataTables.js")
%>

<div id="activeOrdersWindow">
    <table id="currentPlanGroupTable">
        <thead>
            <tr>
                <th id="patientSort">Patient Name</th>
                <th id="patientSort">Patient DOB</th>
                <th id="planSort">Plan Name</th>
                <th id="detailsSort">Drug Name <span id="planDrugDate">Start Date</span></th>
            </tr>
        </thead>
        <tbody>
            <% patientPlanOrders.each { patientPlanOrder -> %>
                <% patientPlanOrder.value.each { order -> %>
                    <tr>
                        <td>${ patientName.get(patientPlanOrder.key) }</td>
                        
                        <td>${ patientDOB.get(patientPlanOrder.key).format('yyyy-MM-dd') }</td>
                        
                        <td>${ order.key.toUpperCase() }</td>
                        
                        <td>
                            <% order.value.each { o -> %>
                          
                                <div>
                                    <span id="planDrugName">${ o.drugname.getDisplayString().toUpperCase() }</span>
                                    <span id="planDrugDate">${ o.startdate.format('yyyy-MM-dd') }</span>
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
    jq('#currentPlanGroupTable').dataTable({
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
