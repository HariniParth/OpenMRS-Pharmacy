<%
    ui.decorateWith("appui", "standardEmrPage");
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "pharmacy.js")
    ui.includeJavascript("pharmacy", "dataTables.js")
%>

<script type="text/javascript">
    var breadcrumbs = [
        { icon: "icon-home", link: '/' + OPENMRS_CONTEXT_PATH + '/index.htm' },
        { label: "${ ui.message("Pharmacy") }"},
    ];
</script>

${ ui.includeFragment("pharmacy", "searchBarByPatient") } <br/>

<div id="patientTableWrapper">
    <table id="patientTable">
        <thead>
            <tr>
                <th>Name</th>
                <th>Birth Date</th>
                <th>Age</th>
                <th>Gender</th>
                <th>Address</th>
            </tr>
        </thead>
        
        <tbody>
            <% allPatients.each { patient -> %>
                <tr class="patientRow" onclick="location.href='${ ui.pageLink("pharmacy", "pharmacyGroup", [patientId: patient.patientId]) }';">
                    
                    <td>${ patient.givenName } ${ patient.familyName }</td>
                    <td>${ patient.birthdate.format('yyyy-MM-dd') }</td>
                    <td>${ patient.age }</td>
                    <td>${ patient.gender }</td>
                    <td>${ patient.addresses.address1[0] } ${ patient.addresses.cityVillage[0] } ${ patient.addresses.stateProvince[0] } - ${ patient.addresses.postalCode[0] } ${ patient.addresses.country[0] }</td>
                </tr>
            <% } %>
        </tbody>
    </table>
</div>

<br/><br/>

<div id="nonActiveTableWrapper">
    <table id="nonActiveTable">
        <thead>
            <tr>
                <th>Patient Name</th>
                <th>Drug(s)</th>
                <th>Start Date</th>
                <th>Comments</th>
                <th>Provider</th>
                <th>Notify Status</th>
            </tr>
        </thead>
        <tbody>
            <% patientPlans.each { order -> %>
                <% def patientName = "" %>
                <tr>
                    <td colspan="5">
                        <% order.value.each { o -> %>                        
                            <div class="groupHome">
                                <div class="d1">
                                    <div class="c1">
                                        <% if(patientName == "") { %>
                                            <% patientName = o.patientid %>
                                            ${ patientName }
                                        <% } %>
                                    </div>
                                    <div class="c2">
                                        <div class="b1">
                                            ${ o.drugname.getDisplayString() }
                                        </div>
                                        <div class="b2">
                                            ${ o.startdate.format('yyyy-MM-dd') }
                                        </div>
                                    </div>
                                </div>
                                <div class="d2">
                                    <div class="c3">
                                        ${ o.comments }
                                    </div>
                                    <div class="c4">
                                        ${ ordererName.get(o.orderId) }
                                    </div>
                                </div>
                            </div>
                        <% } %>
                    </td>
                    <td style="display: none;"></td>
                    <td style="display: none;"></td>
                    <td style="display: none;"></td>
                    <td style="display: none;"></td>
                    <td></td>
                </tr>
            <% } %>
            
            <% patientGroups.each { order -> %>
                <% def patientName = "" %>
                <tr>
                    <td colspan="5">
                        <% order.value.each { o -> %>                            
                            <div class="groupHome">
                                <div class="d1">
                                    <div class="c1">
                                        <% if(patientName == "") { %>
                                            <% patientName = o.patientid %>
                                            ${ patientName }
                                        <% } %>
                                    </div>
                                    <div class="c2">
                                        <div class="b1">
                                            ${ o.drugname.getDisplayString() }
                                        </div>
                                        <div class="b2">
                                            ${ o.startdate.format('yyyy-MM-dd') }
                                        </div>
                                    </div>
                                </div>
                                <div class="d2">
                                    <div class="c3">
                                        ${ o.comments }
                                    </div>
                                    <div class="c4">
                                        ${ ordererName.get(o.orderId) }
                                    </div>
                                </div>
                            </div>
                        <% } %>
                    </td>
                    <td style="display: none;"></td>
                    <td style="display: none;"></td>
                    <td style="display: none;"></td>
                    <td style="display: none;"></td>
                    <td></td>
                </tr>
            <% } %>
            
            <% patientSingles.each { order -> %>
                <tr>
                    <td>${ order.patientid }</td>
                    <td>${ order.drugname.getDisplayString() }</td>
                    <td>${ order.startdate.format('yyyy-MM-dd') }</td>
                    <td>${ order.comments }</td>
                    <td>${ ordererName.get(order.orderId) }</td>
                    <td></td>
                </tr>
            <% } %>
            
        </tbody>
    </table>
</div>

<script>
    jq('#patientTable').dataTable({
        "sPaginationType": "full_numbers",
        "bPaginate": true,
        "bAutoWidth": false,
        "bLengthChange": true,
        "bSort": true,
        "bJQueryUI": true,
        "bInfo": true,
        "bFilter": false

    });
</script>

<script>
    jq('#nonActiveTable').dataTable({
        "sPaginationType": "full_numbers",
        "bPaginate": true,
        "bAutoWidth": false,
        "bLengthChange": true,
        "bSort": true,
        "bJQueryUI": true,
        "bInfo": true,
        "bFilter": false

    });
</script>