<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<% if(!(search_order_id).equals("")) { %>
    <% if(dorder_main != null) { %>
        <% if((dorder_extension.orderstatus).equals("Active") || (dorder_extension.orderstatus).equals("Hold")) { %>
            <a href="#" id="pharmacyView" onclick="viewPharmaOrderView('${ dorder_main.orderId }','${ dorder_extension.patientid }','${ pharma_patient_name }','${ dorder_extension.startdate }','${ dorder_extension.drugname }','${ dorder_main.route.getDisplayString() }','${ dorder_main.dose }','${ dorder_main.doseUnits.getDisplayString() }','${ dorder_main.duration }','${ dorder_main.durationUnits.getDisplayString() }','${ dorder_main.quantity }','${ dorder_main.quantityUnits.getDisplayString() }','${ dorder_main.frequency }','${ dorder_extension.patientinstructions }','${ dorder_extension.pharmacistinstructions }')">
                ${ pharma_patient_name } ${ dorder_extension.drugname } Start Date: ${ dorder_extension.startdate }
            </a>
        <% } else { %>
            <p>Order Not Found</p>
        <% } %>
    <% } else { %>
        <p>Order Not Found</p>
    <% } %>      
    <br/><br/><br/>
<% } %>
        

<% if(!(search_patient_id).equals("")) { %>
    <% if(patient_found) { %>
        <% dorders_main.each { dorder_main -> %>
            <% dorders_extension.each { dorder_extension -> %>
                <% if(dorder_main.orderId.equals(dorder_extension.orderId)) { %>
                    <% if((dorder_extension.orderstatus).equals("Active") || (dorder_extension.orderstatus).equals("Hold")) { %>
                        <% patient_records_found = true; %>
                        <a href="#" id="pharmacyView" onclick="viewPharmaOrderView('${ dorder_main.orderId }','${ dorder_extension.patientid }','${ pharma_patient_name }','${ dorder_extension.startdate }','${ dorder_extension.drugname }','${ dorder_main.route.getDisplayString() }','${ dorder_main.dose }','${ dorder_main.doseUnits.getDisplayString() }','${ dorder_main.duration }','${ dorder_main.durationUnits.getDisplayString() }','${ dorder_main.quantity }','${ dorder_main.quantityUnits.getDisplayString() }','${ dorder_main.frequency }','${ dorder_extension.patientinstructions }','${ dorder_extension.pharmacistinstructions }')">
                            ${ pharma_patient_name } ${ dorder_extension.drugname } Start Date: ${ dorder_extension.startdate }
                        </a>
                        <br/><br/>
                    <% } %>
                <% } %>
            <% } %>
        <% } %>
    <% } else { %>
        <p>Patient ID Invalid</p>
    <% } %> 
    <br/><br/><br/>
<% } %>