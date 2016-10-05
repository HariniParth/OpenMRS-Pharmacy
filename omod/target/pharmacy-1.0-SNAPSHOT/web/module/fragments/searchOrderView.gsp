<%
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "dataTables.js")
%>

<% if(!(patient_first_name).equals("") && !(patient_last_name).equals("")) { %>
    <div id="searchResultsWindow">
        
        <% if(PatientFound) { %>
            <span class="searchResults"><strong>Search Results</strong>
            <i class="icon-remove-sign edit-action pull-right" onclick="closeSearchResultsWindow()" title="${ ui.message("Close") }"></i></span><br/><br/>

            <table id="searchResultsTable">
                <thead>
                    <tr>
                        <th id="patientSort">Patient Name</th>
                        <th id="drugSort">Drug Name</th>
                        <th id="dateSort">Start Date</th>
                        <th id="prioritySort">Priority</th>
                    </tr>
                </thead>
                <tbody>
                    <% drugOrdersMain.each { dorder_main -> %>
                        <% drugOrdersExtension.each { dorder_extension -> %>
                            <% if((dorder_main.orderId.equals(dorder_extension.orderId)) && ((dorder_extension.orderstatus).equals("Active") || (dorder_extension.orderstatus).equals("Active-Plan") || (dorder_extension.orderstatus).equals("Active-Group") || (dorder_extension.orderstatus).equals("Hold"))) { %>

                                <tr id="orderRow" onclick="viewPharmaOrderView('${ dorder_main.orderId }','${ patient_identifier }','${ patient_first_name } ${ patient_last_name }','${ patient_DOB }','${ patient_address }','${ dorder_extension.startdate }','${ dorder_extension.drugname.getDisplayString() }','${ dorder_main.route.getDisplayString() }','${ dorder_main.dose }','${ dorder_main.doseUnits.getDisplayString() }','${ dorder_main.duration }','${ dorder_main.durationUnits.getDisplayString() }','${ dorder_main.quantity }','${ dorder_main.quantityUnits.getDisplayString() }','${ dorder_main.frequency }','${ dorder_main.numRefills }','${ providerIdentifiers.get(dorder_main.orderId) }','${ dorder_extension.patientinstructions }','${ dorder_extension.pharmacistinstructions }')">
                                    <td>${ patient_first_name } ${ patient_last_name }</td>
                                    <td>${ dorder_extension.drugname.getDisplayString() }</td>
                                    <td>${ dorder_extension.startdate }</td>
                                    <td>${ dorder_extension.priority.getDisplayString() }</td>
                                </tr>
                            <% } %>
                        <% } %>
                    <% } %>
                </tbody>
            </table>

        <% } else { %>
            <span class="searchResults"><strong>Search Results</strong>
            <i class="icon-remove-sign edit-action pull-right" onclick="closeSearchResultsWindow()" title="${ ui.message("Clear") }"></i></span><br/><br/>
            <span class="fields">No Orders Found</span>
        <% } %>
        
    </div><br/>
    
<% } %>

<script>
    jq('#searchResultsTable').dataTable({
        "sPaginationType": "full_numbers",
        "bPaginate": true,
        "bAutoWidth": false,
        "bLengthChange": true,
        "bSort": true,
        "bJQueryUI": true,
        "bFilter": false

    });
</script>