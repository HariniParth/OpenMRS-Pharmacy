<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<div id="search-bar">
    <form method="post">
        FIND ORDER BY
        <div id="searchField">ORDER ID: <input id="search_order_id" type="text" name="search_order_id"/>
        <input class="confirm right" id="btn-place" name="searchPharmaOrderByOrderID" type="submit" onclick="searchPharmaOrderByOrderID()"></input></div>
        <div id="searchField">PATIENT ID: <input id="search_patient_id" type="text" name="search_patient_id"/>
        <input class="confirm right" id="btn-place" name="searchPharmaOrderByPatientID" type="submit" onclick="searchPharmaOrderVYPatientID()"></input</div>
    </form>
</div>