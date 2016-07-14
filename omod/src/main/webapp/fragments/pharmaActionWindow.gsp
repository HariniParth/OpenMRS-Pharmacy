<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<div id="pharmaActionView">
    <form method="post">
        <h4 class="heading">${ ui.message("Record Action") }</h4>
        <label class="heading" id="status"></label>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Order ID </label></div>
            <div id="order_value"><input type="text" id="pharma_action_order_id" value="${pharma_order_id}" readonly /></div>
        </div>

        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Patient ID</label></div>
            <div id="order_value"><input type="text" id="pharma_action_patient_id" value="${pharma_patient_id}" readonly /></div>
        </div>

        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Patient Name</label></div>
            <div id="order_value"><input type="text" id="pharma_action_patient_name" value="${pharma_patient_name}" readonly /></div>
        </div>

        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Start Date</label></div>
            <div id="order_value"><input type="text" id="pharma_action_start_date" value="${pharma_start_date}" readonly /></div>
        </div>  
        
        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Order/s</label></div>
            <br/><br/><br/>
            <div id="order_value"><input type="text" id="pharma_action_order_details" value="${pharma_order_details}" readonly /></div>
        </div> 

        <br/><br/>

        <div class="fields" id="view_order_detail"><label>Physician instructions for</label></div>

        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Patient</label></div>
            <div id="order_value"><input type="text" id="pharma_action_patient_instructions" value="${pharma_patient_instructions}" readonly /></div>
        </div>     

        <br/><br/>

        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Pharmacist</label></div>
            <div id="order_value"><input type="text" id="pharma_action_pharmacist_instructions" value="${pharma_pharmacist_instructions}" readonly /></div>
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