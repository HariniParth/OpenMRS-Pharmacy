<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<div id="patient-search-bar">
    <form method="post" id="searchByPatient">
        <h3 class="fields">FIND ORDERS BY PATIENT
            <input id="patient_full_name" type="text" name="patient_full_name" placeholder="Enter Patient Name" oninput="autoCompletePatientName('${allPatientNames}')" />
        </h3>
    </form>
</div>