<%
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "dataTables.js")
%>

<form method="post" id="medPlanGroupForm">
    
    <input type="hidden" id="planPatient" name="planPatient" />
    <input type="hidden" id="planName" name="planName" />
        
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
                    <tr class="groupRow" onclick="selectedMedPlanGroup('${patientPlanOrder.key}','${order.key.toUpperCase()}')">
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
</form>

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