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
            <span class="pageLinks pull-right" onclick="location.href='${ui.pageLink("pharmacy", "pharmacyGroup", [patientId: patient.patientId])}';">Display By Group >></span>
        </strong>
    </h3>
</div><br/>

<div class="info-body">

    <div id="currentDrugOrdersWindow">
        <p class="fields">${ ui.includeFragment("pharmacy", "associatedOrderView") }</p>
                
        <div id="currentOrdersWindow">

            <br/> ${ ui.includeFragment("pharmacy", "currentDrugOrders") } <br/>

            <br/> ${ ui.includeFragment("pharmacy", "currentMedPlans") } <br/>
            
        </div>
        
    </div>
    
    <div id="pharmaOrderViewWindow">
        ${ ui.includeFragment("pharmacy", "pharmaOrderView") }
    </div>

</div>