<div id="pharmaOrderView">
    <h4>${ ui.message("Record Action") }</h4>
    <div><label>Order ID </label><text id="order_id_display" /></div>
    <div><label>Patient ID</label></div>
    <div><label>Patient Name</label></div>
    <div><label>Start Date</label></div>
    <div><label>Order/s</label></div>
    <br/>
    <div><label>Physician instructions for</label></div>
    <div><label>Patient</label></div>
    <div><label>Pharmacist</label></div>
    <br/>
    <div><button class="confirm right" id="btn-dispatch" name="dispatchOrder" type="submit" onclick="showPharmaActionWindow()">${ ui.message("Dispatch") }</button></div>
    <div><button class="confirm right" id="btn-hold" name="holdOrder" type="submit" onclick="showPharmaActionWindow()">${ ui.message("Hold") }</button></div>
    <button class="confirm right" id="btn-drop" name="dropOrder" type="submit" onclick="showPharmaActionWindow()">${ ui.message("Drop") }</button>
    <button class="cancel" id="btn-place" onclick="hidePharmaOrderView()">${ ui.message("Cancel") }</button>
        
</div>