<%
    ui.decorateWith("appui", "standardEmrPage");
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "pharmacy.js")
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

${ ui.includeFragment("pharmacy", "searchBar") }

<div class="col-lg-12"></div>
<div class="info-body">
    
    <h3>${ ui.message("ACTIVE DRUG ORDERS") }</h3>
    <p>${ ui.message("Click on an order item to record action") }</p>
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