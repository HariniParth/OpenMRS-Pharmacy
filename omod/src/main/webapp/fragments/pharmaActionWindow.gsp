<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<div id="pharmaActionView">
    <form method="post">
        <h4 class="heading">${ ui.message("Record Action") }</h4>
        <label class="heading" id="status"></label>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Order ID </label></div>
            <div id="order_value"><label id="order_id" value="order_id"></label></div>
        </div>

        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Patient ID</label></div>
            <div id="order_value"><label id="patient_id" value="patient_id"></label></div>
        </div>

        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Patient Name</label></div>
            <div id="order_value"><label id="patient_name" value="patient_name"></label></div>
        </div>

        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Start Date</label></div>
            <div id="order_value"><label id="start_date" value="start_date"></label></div>
        </div>  
        
        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Order/s</label></div>
            <br/><br/><br/>
            <div id="order_value"><label id="order_details" value="order_details"></label></div>
        </div> 

        <br/><br/>

        <div class="fields" id="view_order_detail"><label>Physician instructions for</label></div>

        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Patient</label></div>
            <div id="order_value"><label id="patient_instructions" value="patient_instructions"></label></div>
        </div>     

        <br/><br/>

        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Pharmacist</label></div>
            <div id="order_value"><label id="pharmacist_instructions" value="pharmacist_instructions"></label></div>
        </div>    

        <br/><br/>
        
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