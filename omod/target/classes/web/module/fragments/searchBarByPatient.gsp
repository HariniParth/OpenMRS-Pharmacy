<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<div id="patient-search-bar">
    <form method="post">
        <h4 id="header" class="fields">FIND ORDERS BY PATIENT</h4>
        <div class="fields">
            <span id="orderSearchField">
                <input id="patient_first_name" type="text" name="patient_first_name" placeholder="Enter First Name"/>
            </span>
            <span id="orderSearchField">
                <input class="fields" id="patient_last_name" type="text" name="patient_last_name" placeholder="Enter Last Name"/>
            </span>
            <span id="orderSearchButton">
                <button id="btn-place" type="submit">Search</button>
            </span><br/><br/>
        </div>
        <input type="hidden" name="action" value="searchByPatient"/>
    </form>
</div>