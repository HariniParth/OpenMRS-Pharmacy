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


<div class="col-lg-12"></div>
<div class="info-body">
    
    <h3>${ ui.message("ACTIVE DRUG ORDERS") }</h3>
    <p>${ ui.message("Click on an order item to record action") } - 
    Selected: <label id="order_id_display" value="order_id_display" name="order_id_display"></label>
    </p> 
    <br/>
    <% currentDrugOrders.each { currentDrugOrder -> %>
        <p>
            <a href="#" id="pharmacyView" onclick="viewPharmaOrderView('${ currentDrugOrder.orderId }')">
                ${ currentDrugOrder.drugname }          
                Start Date: 
                ${ currentDrugOrder.startdate }
            </a>
        </p>
        
    <% } %>
    
    
    ${ ui.includeFragment("pharmacy", "pharmaOrderView") }
    
    ${ ui.includeFragment("pharmacy", "pharmaActionWindow") }
    
</div>

<script type="text/javascript">
    jq(function() {
        emr.updateBreadcrumbs();
    });
</script>