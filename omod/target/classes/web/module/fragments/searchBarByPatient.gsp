<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<div id="patient-search-bar">
    <form method="post">
        <div id="orderSearchField">FIND BY PATIENT ID: 
            <input id="search_patient_id" type="text" name="search_patient_id"/>
        </div>
        <div id="orderSearchButton">
            <input class="confirm" id="btn-place" name="searchPharmaOrderByPatientID" type="submit" />
        </div>
        <input type="hidden" name="action" value="searchByPatient"/>
    </form>
</div>