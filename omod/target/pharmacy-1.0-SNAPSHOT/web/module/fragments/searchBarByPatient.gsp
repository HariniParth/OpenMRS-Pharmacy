<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<div id="patient-search-bar">
    <form method="post">
        FIND ORDER BY
        <div id="patientSearchField">PATIENT ID: <input id="search_patient_id" type="text" value="search_patient_id" name="search_patient_id"/>
        <input class="confirm right" id="btn-place" name="searchPharmaOrderByPatientID" type="submit" onclick="viewPharmaOrderByPatient()"></input</div>
    </form>
</div>