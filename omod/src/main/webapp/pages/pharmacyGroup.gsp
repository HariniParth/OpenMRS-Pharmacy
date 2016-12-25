<%
    ui.decorateWith("appui", "standardEmrPage");
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "pharmacy.js")
%>

<script type="text/javascript">
    var breadcrumbs = [
        { icon: "icon-home", link: '/' + OPENMRS_CONTEXT_PATH + '/index.htm' },
        { label: "${ ui.message("Pharmacy") }" , link: '${ui.pageLink("pharmacy", "pharmacyPatient")}'},
        { label: "${ ui.format(patient.familyName) }, ${ ui.format(patient.givenName) }"}
    ];
     
    var patient = { id: ${ patient.id } };

</script>
 
${ ui.includeFragment("coreapps", "patientHeader", [ patient: patient ]) } <br/>

<div>
    <h3>
        <i class="icon-medicine"></i>
        <strong>${ ui.message("ACTIVE DRUG ORDERS") }
            <span class="pageLinks pull-right" onclick="location.href='${ui.pageLink("pharmacy", "pharmacySingle", [patientId: patient.patientId])}';">Display By Order >></span>
        </strong>
    </h3>
</div><br/>

<div class="info-body">

    <div id="currentDrugOrdersWindow">
                
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