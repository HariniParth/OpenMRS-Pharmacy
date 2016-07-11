<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<div id="pharmaOrderView">
    <form method="post">
        <h4>${ ui.message("Record Action") }</h4>
        <div class="fields"><label>Order ID </label></div>
        <div class="fields"><label>Patient ID</label></div>
        <div class="fields"><label>Patient Name</label></div>
        <div class="fields"><label>Start Date</label></div>
        <div class="fields"><label>Order/s</label></div>
        <br/>
        <div class="fields"><label>Physician instructions for</label></div>
        <div class="fields"><label>Patient</label></div>
        <div class="fields"><label>Pharmacist</label></div>
        <br/>
        <div class="fields"><button class="confirm right" id="btn-dispatch" name="dispatchOrder" type="submit" onclick="showPharmaActionWindow()">${ ui.message("Dispatch") }</button></div>
        <br/><br/>
        <div class="fields"><button class="confirm right" id="btn-hold" name="holdOrder" type="submit" onclick="showPharmaActionWindow()">${ ui.message("Hold") }</button></div>
        <br/><br/>
        <div class="fields"><button class="confirm right" id="btn-drop" name="dropOrder" type="submit" onclick="showPharmaActionWindow()">${ ui.message("Drop") }</button>
        <button class="cancel" id="btn-place" onclick="hidePharmaOrderView()">${ ui.message("Cancel") }</button></div>
    </form>
</div>