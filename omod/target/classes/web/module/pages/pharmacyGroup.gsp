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
        { label: "${ ui.message("Pharmacy") }"}
    ];
</script>

${ ui.includeFragment("pharmacy", "searchBarByPatient") } <br/>

<div>
    <h3>
        <i class="icon-medicine"></i>
        <strong>${ ui.message("ACTIVE DRUG ORDERS") } <label id="selectedGroupPatient"></label>
            <span class="pageLinks pull-right" onclick="location.href='${ui.pageLink("pharmacy", "pharmacySingle")}';">Display By Order >></span>
        </strong>
    </h3>
    Click on an order to view allowed <strong>Refills</strong> and <strong>Last-Dispatch-Date</strong>
</div><br/>

<div class="info-body">

    <div id="currentDrugOrdersWindow">
        
        <p class="fields">${ ui.includeFragment("pharmacy", "searchGroupView") }</p>
        
        <div id="currentOrdersWindow">
            <p class="fields"><strong>GROUP DRUG ORDERS</strong></p><br/>
            ${ ui.includeFragment("pharmacy", "currentGroupOrders") } <br/>

            <p class="fields"><strong>GROUP PLAN ORDERS</strong></p><br/>
            ${ ui.includeFragment("pharmacy", "currentPlanGroupOrders") } <br/>
        </div>
        
    </div>
    
    <div id="pharmaGroupViewWindow">
        ${ ui.includeFragment("pharmacy", "pharmaGroupView") }
    </div>

</div>

<script type="text/javascript">
    jq(function() {
        emr.updateBreadcrumbs();
    });
</script>