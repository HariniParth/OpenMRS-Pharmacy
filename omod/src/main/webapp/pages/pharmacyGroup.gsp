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
        <strong>${ ui.message("ACTIVE DRUG ORDERS") }
            <span class="pageLinks pull-right" onclick="location.href='${ui.pageLink("pharmacy", "pharmacy")}';">Display By Order >></span>
        </strong>
    </h3>
    ${ ui.message("Click on an order item to record action") }
</div><br/>

<script type="text/javascript">
    jq(function() {
        emr.updateBreadcrumbs();
    });
</script>