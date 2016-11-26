<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<div id="patient-search-bar">
    <form method="post" id="searchByPatient">
        <p class="fields"><strong>FIND ORDERS BY PATIENT</strong>
            <input id="patient_full_name" type="text" name="patient_full_name" placeholder="Enter Patient Name" oninput="autoCompletePatientName('${allPatientNames}')" />
        </p>
    </form>
</div>