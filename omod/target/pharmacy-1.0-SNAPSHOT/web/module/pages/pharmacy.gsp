<%
    ui.decorateWith("appui", "standardEmrPage");
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "pharmacy.js")
    def isSelected = 0;
%>

<script type="text/javascript">
    //var OPENMRS_CONTEXT_PATH = 'openmrs';
    window.sessionContext = window.sessionContext || {
        locale: "en_GB"
    };
    window.translations = window.translations || {};
</script>

<script type="text/javascript">
    var breadcrumbs = [
        { icon: "icon-home", link: '/' + OPENMRS_CONTEXT_PATH + '/index.htm' },
        { label: "Pharmacy Orders"}
    ];
</script>

<div class="col-lg-12">
    <div class="col-lg-6">
        ${ ui.includeFragment("pharmacy", "searchBarByOrder") }
    </div>
    <div class="col-lg-6">
        ${ ui.includeFragment("pharmacy", "searchBarByPatient") }
    </div>
</div>

<br/><br/><br/><br/>

<div class="info-body">
    
    <h3>${ ui.message("ACTIVE DRUG ORDERS") }</h3>
    <p>${ ui.message("Click on an order item to record action") } - 
        Selected: <label id="order_id_display" name="order_id_display"></label></p>

    <br/>
    
    <div id="currentDrugOrdersWindow">
        <% if(!(search_order_id).equals("")) { %>
            <a href="#" id="pharmacyView" onclick="viewPharmaOrderView('${ dorder_main.orderId }','${ dorder_extension.patientid }','${ pharma_patient_name }','${ dorder_extension.startdate }','${ dorder_extension.drugname }','${ dorder_main.route.getDisplayString() }','${ dorder_main.dose }','${ dorder_main.doseUnits.getDisplayString() }','${ dorder_main.duration }','${ dorder_main.durationUnits.getDisplayString() }','${ dorder_main.quantity }','${ dorder_main.quantityUnits.getDisplayString() }','${ dorder_main.frequency }','${ dorder_extension.patientinstructions }','${ dorder_extension.pharmacistinstructions }')">
                ${ pharma_patient_name } ${ dorder_extension.drugname } ${ dorder_extension.startdate }
            </a>
            
            <br/><br/><br/>
        <% } %>
        
        
        
        ${ ui.includeFragment("pharmacy", "currentDrugOrders") }
    </div>
    
    <div id="pharmaOrderViewWindow">
        ${ ui.includeFragment("pharmacy", "pharmaOrderView") }
    </div>

    <div id="pharmaOrderActionWindow">
        <% if(!(pharma_order_id).equals("")) { %>
            ${ ui.includeFragment("pharmacy", "pharmaActionWindow") }
        <% } %>
    </div>
</div>

<script type="text/javascript">
    jq(function() {
        emr.updateBreadcrumbs();
    });
</script>