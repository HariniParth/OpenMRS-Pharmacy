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
        { label: "Pharmacy Orders"}
    ];
</script>

<div class="info-body">
    <h3>${ ui.message("ACTIVE DRUG ORDERS") }</h3>
    <p>${ ui.message("Click on an order item to record action") }</p>
    <br/>
    <% currentDrugOrders.each { currentDrugOrder -> %>
        <p>
            <a href="#" id="pharmacyView">Patient ID: 
                <% patientFullNameList.each { patient -> %>
                    <% if(currentDrugOrder.patientid == patient.person) { %>
                        ${ patient.givenName } ${ patient.middleName } ${ patient.familyName }
                    <% } %>
                <% } %>

                ${ currentDrugOrder.drugname }    
                ${ currentDrugOrder.startdate }
            </a>
        </p>
        
    <% } %>
    
</div>

<script type="text/javascript">
    jq(function() {
        emr.updateBreadcrumbs();
    });
</script>