<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<div id="patient-search-bar">
    <form method="post">
        <div>FIND BY PATIENT ID:</div>
        <div>
            <span id="orderSearchField">
                <input id="search_patient_id" type="text" name="search_patient_id"/>
            </span>
            <span id="orderSearchButton">
                <input class="confirm" id="btn-place" name="searchPharmaOrderByPatientID" type="submit" />
            </span>
        </div>
        <input type="hidden" name="action" value="searchByPatient"/>
    </form>
</div>