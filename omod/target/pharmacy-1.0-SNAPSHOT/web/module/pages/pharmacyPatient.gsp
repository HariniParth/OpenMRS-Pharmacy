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
            <% if(patient != "") { %>
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

<br/><br/> ${ ui.includeFragment("pharmacy", "removeFromHold") } <br/><br/>

<p><strong>ORDERS Hold/Discard</strong></p><br/>

<div id="nonActiveTableWrapper">
    <table id="nonActiveTable">
        <thead>
            <tr>
                <th>Patient</th>
                <th>Drug(s)</th>
                <th>Start Date</th>
                <th>Status</th>
                <th>Provider</th>
                <th>Notify</th>
            </tr>
        </thead>
        <tbody>
            <% patientPlans.each { order -> %>
                <% def name = "" %>
                <tr class="setHome">
                    <td colspan="5">
                        <% order.value.each { o -> %>                        
                            <div class="groupHome <% if(o.forDiscard == 1) { %> forDiscard <% } %> <% if(o.onHold == 1) { %> onHold <% } %>">
                                <div class="l11">
                                    <div class="l21">
                                        <% if(name == "") { %>
                                            <% name = patientName.get(o.patientId.toInteger()) %>
                                            ${ name }
                                        <% } %>
                                    </div>
                                    <div class="l22">
                                        <div class="l31">
                                            ${ o.drugName.getDisplayString().toUpperCase() }
                                        </div>
                                        <div class="l32">
                                            ${ o.startDate.format('yyyy-MM-dd') }
                                        </div>
                                    </div>
                                </div>
                                <div class="l12">
                                    <div class="l23">
                                        <% if(o.onHold == 1) { %>
                                            <span class="comments" title="${ o.commentForOrderer }"> ON HOLD</span>
                                        <% } else if(o.forDiscard == 1) { %>
                                            <span class="comments" title="${ o.commentForOrderer }"> DISCARD</span>
                                        <% } else { %>
                                            <span class="comments"> ACTIVE</span>
                                        <% } %>
                                    </div>
                                    <div class="l24">
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
                    <td class="notifyGroupIcon"><i class="icon-ok-circle" title="Mark Order(s) Available" onclick="showRemoveOrderHoldWindow()"></i></td>
                </tr>
            <% } %>
            
            <% patientGroups.each { order -> %>
                <% def name = "" %>
                <tr class="setHome">
                    <td colspan="5">
                        <% order.value.each { o -> %>                            
                            <div class="groupHome <% if(o.forDiscard == 1) { %> forDiscard <% } %> <% if(o.onHold == 1) { %> onHold <% } %>">
                                <div class="l11">
                                    <div class="l21">
                                        <% if(name == "") { %>
                                            <% name = patientName.get(o.patientId.toInteger()) %>
                                            ${ name }
                                        <% } %>
                                    </div>
                                    <div class="l22">
                                        <div class="l31">
                                            ${ o.drugName.getDisplayString().toUpperCase() }
                                        </div>
                                        <div class="l32">
                                            ${ o.startDate.format('yyyy-MM-dd') }
                                        </div>
                                    </div>
                                </div>
                                <div class="l12">
                                    <div class="l23">
                                        <% if(o.onHold == 1) { %>
                                            <span class="comments" title="${ o.commentForOrderer }"> ON HOLD</span>
                                        <% } else if(o.forDiscard == 1) { %>
                                            <span class="comments" title="${ o.commentForOrderer }"> DISCARD</span>
                                        <% } else { %>
                                            <span class="comments"> ACTIVE</span>
                                        <% } %>
                                    </div>
                                    <div class="l24">
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
                    <td class="notifyGroupIcon"><i class="icon-ok-circle" title="Mark Order(s) Available" onclick="showRemoveOrderHoldWindow()"></i></td>
                </tr>
            <% } %>
            
            <% patientSingles.each { order -> %>
                <tr class="singleHome <% if(order.forDiscard == 1) { %> forDiscard <% } %> <% if(order.onHold == 1) { %> onHold <% } %>">
                    <td>${ patientName.get(order.patientId.toInteger()) }</td>
                    <td>${ order.drugName.getDisplayString().toUpperCase()}</td>
                    <td>${ order.startDate.format('yyyy-MM-dd') }</td>
                    <td>
                        <% if(order.onHold == 1) { %>
                            <span class="comments" title="${ order.commentForOrderer }"> ON HOLD</span>
                        <% } else if(order.forDiscard == 1) { %>
                            <span class="comments" title="${ order.commentForOrderer }"> DISCARD</span>
                        <% } else { %>
                            <span class="comments"> ACTIVE</span>
                        <% } %>
                    </td>
                    <td>${ ordererName.get(order.orderId) }</td>
                    <td class="notifySingleIcon"><i class="icon-ok-circle" title="Mark Order(s) Available" onclick="showRemoveOrderHoldWindow()"></i></td>
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
        "bFilter": false,
        "columns": [
            { "width": "20%" },
            { "width": "15%" },
            { "width": "5%"  },
            { "width": "10%" },
            { "width": "50%" }
        ],
        fixedColumns: true

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
        "bFilter": false,
        "columns": [
            { "width": "20%" },
            { "width": "33%" },
            { "width": "12%" },
            { "width": "10%" },
            { "width": "20%" },
            { "width": "5%"  }
        ],
        fixedColumns: true

    });
</script>

<script type="text/javascript">    
    jq(".notifyGroupIcon > i").click(function(){
        jq(this).parent().parent().children('td').slice(0, 1).css({"background": "#75b2f0","color": "white"});
    });
</script>

<script type="text/javascript">    
    jq(".notifySingleIcon > i").click(function(){
        jq(this).parent().parent().children('td').slice(0, 5).css({"background": "#75b2f0","color": "white"});
    });
</script>