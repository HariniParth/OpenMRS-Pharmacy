<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<% currentDrugOrdersExtension.each { currentDrugOrderExtension -> %>
    <% currentDrugOrdersMain.each { currentDrugOrderMain -> %>
        <% if(currentDrugOrderMain.orderId.equals(currentDrugOrderExtension.orderId)) { %>
            <p> 
                <a href="#" id="pharmacyView" onclick="viewPharmaOrderView('${ currentDrugOrderMain.orderId }')">
                    ${ currentDrugOrderExtension.patientid } 
                    ${ currentDrugOrderExtension.drugname } 
                    Start Date: 
                    ${ currentDrugOrderExtension.startdate }
                </a>
            </p>
        <% } %>
    <% } %>
    <br/><br/>
<% } %>