<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<% if(!(patient_first_name).equals("") && !(patient_last_name).equals("")) { %>
    <div id="searchResultsWindow">
        
        <% if(PatientFound) { %>
            <span class="searchResults">Search Results
            <i class="icon-remove-sign edit-action pull-right" onclick="closeSearchResultsWindow()" title="${ ui.message("Clear") }"></i></span><br/><br/>

            <% drugOrdersMain.each { dorder_main -> %>
                <% drugOrdersExtension.each { dorder_extension -> %>
                    <% if(dorder_main.orderId.equals(dorder_extension.orderId)) { %>
                        <% if((dorder_extension.orderstatus).equals("Active") || (dorder_extension.orderstatus).equals("Active-Plan") || (dorder_extension.orderstatus).equals("Active-Group") || (dorder_extension.orderstatus).equals("Hold")) { %>

                            <% patient_records_found = true; %>
                            <a href="#" id="pharmacyView" onclick="viewPharmaOrderView('${ dorder_main.orderId }','${ dorder_extension.patientid }','${ patient_first_name }','${ patient_last_name }','${ dorder_extension.startdate }','${ dorder_extension.drugname.getDisplayString() }','${ dorder_main.route.getDisplayString() }','${ dorder_main.dose }','${ dorder_main.doseUnits.getDisplayString() }','${ dorder_main.duration }','${ dorder_main.durationUnits.getDisplayString() }','${ dorder_main.quantity }','${ dorder_main.quantityUnits.getDisplayString() }','${ dorder_main.frequency }','${ dorder_extension.patientinstructions }','${ dorder_extension.pharmacistinstructions }')">
                                ${ patient_first_name } ${ patient_last_name } ${ dorder_extension.drugname.getDisplayString() } Start Date: ${ dorder_extension.startdate }
                            </a> <br/><br/>

                        <% } %>
                    <% } %>
                <% } %>
            <% } %> 

        <% } else { %>
            <p>No Orders Found</p>
        <% } %>
        
    </div><br/>
    
<% } %>