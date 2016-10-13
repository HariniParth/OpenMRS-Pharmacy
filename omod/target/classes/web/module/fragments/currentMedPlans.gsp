<%
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "dataTables.js")
%>

<div id="activeOrdersWindow">
    <table id="currentMedPlansTable">
        <thead>
            <tr>
                <th id="patientSort">Patient Name</th>
                <th id="planSort">Plan Name</th>
                <th id="detailsSort">Details</th>
            </tr>
        </thead>
        <tbody>
            
        </tbody>
    </table>
</div>

<script>
    jq('#currentMedPlansTable').dataTable({
        "sPaginationType": "full_numbers",
        "bPaginate": true,
        "bAutoWidth": false,
        "bLengthChange": true,
        "bSort": true,
        "bJQueryUI": true,
        "bFilter": false

    });
</script>