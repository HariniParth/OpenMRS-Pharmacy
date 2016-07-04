<div id="pharmaActionView">
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
        <div class="fields"><label>Enter Comments</label></div>
        <div class="fields"><input type="textarea" maxlength="50" id="comments" name="comments"/></div>
        
        <div class="fields"><input type="checkbox" name="commentCheckbox" > Forward message to ordering physician<br></div>
        <div class="fields"><input type="checkbox" name="messageCheckbox" > Send another message to ordering physician<br></div>
        <div class="fields">
            <input type="textarea" maxlength="50" id="patientInstructions" name="patientInstructions"/>
        </div>
        <br/>
        <div class="fields"><button class="confirm right" id="btn-drop" name="dropOrder" type="submit" onclick="showPharmaActionWindow()">${ ui.message("OK") }</button></div>
        <div class="fields"><button class="cancel" id="btn-place" onclick="hidePharmaActionWindow()">${ ui.message("Back") }</button></div>
    </form>
</div>