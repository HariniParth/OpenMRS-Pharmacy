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

<br/><br/>

<div class="info-body">
    
    <h3>${ ui.message("ACTIVE DRUG ORDERS") }</h3>
    <p>${ ui.message("Click on an order item to record action") } - 
        Selected: <label id="order_id_display" name="order_id_display"></label></p>
    
    <br/>
    
    <div id="currentDrugOrdersWindow">
        ${ ui.includeFragment("pharmacy", "currentDrugOrders") }
    </div>
    
    <div id="pharmaOrderViewWindow">
        ${ ui.includeFragment("pharmacy", "pharmaOrderView") }
    </div>

    <div id="pharmaOrderActionWindow">
        ${ ui.includeFragment("pharmacy", "pharmaActionWindow") }
    </div>

</div>

<script type="text/javascript">
    jq(function() {
        emr.updateBreadcrumbs();
    });
</script>