<%
    ui.decorateWith("appui", "standardEmrPage");
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

<script type="text/javascript">
    jq(function() {
        emr.updateBreadcrumbs();
    });
</script>