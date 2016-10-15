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
        { label: "${ ui.message("Pharmacy") }" }
    ];
</script>

${ ui.includeFragment("pharmacy", "searchBarByPatient") } <br/>

<h3 id="header">${ ui.message("ACTIVE DRUG ORDERS") }</h3>
<p>${ ui.message("Click on an order item to record action") }</p><br/>

<div class="info-body">

    <div id="currentDrugOrdersWindow">
        ${ ui.includeFragment("pharmacy", "searchOrderView") }
        
        <p class="fields"><strong>Individual Drug Orders</strong></p><br/>
        ${ ui.includeFragment("pharmacy", "currentDrugOrders") }
        
        <p class="fields"><strong>Medication Plan Orders</strong></p><br/>
        ${ ui.includeFragment("pharmacy", "currentMedPlans") }
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