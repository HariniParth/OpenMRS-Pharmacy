<%
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "dataTables.js")
%>

<% if(!(patient_name).equals("")) { %>
    <div id="searchResultsWindow">
        
        <% if(PatientFound) { %>
            <span class="searchResults"><strong>SEARCH RESULTS <span id="searchOrders">- ${ patient_name }</span></strong>
            <i class="icon-remove-sign edit-action pull-right" onclick="closeSearchResultsWindow()" title="${ ui.message("Close") }"></i></span><br/><br/>

            <table id="searchGroupOrdersTable">
                <thead>
                    <tr>
                        <th id="patientSort">Patient Name</th>
                        <th id="patientSort">Patient DOB</th>
                        <th id="detailsSort">Drug Name <span class="pull-right">Start Date</span></th>
                    </tr>
                </thead>
                <tbody>
                    <% PlanOrders.each { PlanOrder -> %>
                        <tr class="groupRow">
                            <td>${ patient_name }</td>
                            <td>${ patient_DOB.format('yyyy-MM-dd') }</td>
                            <td>
                                <% PlanOrder.value.each { order -> %>
                                    <div>
                                        <span>${ order.drugname.getDisplayString().toUpperCase() }</span>
                                        <span class="pull-right">${ order.startdate.format('yyyy-MM-dd') }</span>
                                    </div>
                                <% } %>
                            </td>
                        </tr> 
                    <% } %> 

                    <% GroupOrders.each { GroupOrder -> %>
                        <tr class="groupRow">
                            <td>${ patient_name }</td>
                            <td>${ patient_DOB.format('yyyy-MM-dd') }</td>
                            <td>
                                <% GroupOrder.value.each { order -> %>
                                    <div>
                                        <span>${ order.drugname.getDisplayString().toUpperCase() }</span>
                                        <span class="pull-right">${ order.startdate.format('yyyy-MM-dd') }</span>
                                    </div>
                                <% } %>
                            </td>
                        </tr> 
                    <% } %> 

                    <% SingleOrders.each { order -> %>
                        <tr class="groupRow">
                            <td>${ patient_name }</td>

                            <td>${ patient_DOB.format('yyyy-MM-dd') }</td>

                            <td>
                                <div>
                                    <span>${ order.value.drugname.getDisplayString().toUpperCase() }</span>
                                    <span class="pull-right">${ order.value.startdate.format('yyyy-MM-dd') }</span>
                                </div>
                            </td>
                        </tr> 
                    <% } %>       
                </tbody>
            </table>
        
        <% } else { %>
            <span class="searchResults"><strong>Search Results</strong>
            <i class="icon-remove-sign edit-action pull-right" onclick="closeSearchResultsWindow()" title="${ ui.message("Clear") }"></i></span><br/><br/>
            <span class="fields">No Orders Found</span>
        <% } %>
        
    </div><br/>
<% } %>

<script>
    jq('#searchGroupOrdersTable').dataTable({
        "sPaginationType": "full_numbers",
        "bPaginate": true,
        "bAutoWidth": false,
        "bLengthChange": true,
        "bSort": true,
        "bJQueryUI": true,
        "bInfo": false,
        "bFilter": false

    });
</script>

<script type="text/javascript">    
    jq(".groupRow").click(function(){
        jq(this).css({"background": "#75b2f0","color": "white"});
    });
</script>