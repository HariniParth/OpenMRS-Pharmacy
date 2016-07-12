<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<div id="pharmaOrderView">
    <form method="post">
        <h4 id="header">${ ui.message("Record Action") }</h4>
        
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
            <div class="fields"><label>Start Date</label></div>
            <div id="order_value"><label id="start_date" value="start_date"></label></div>
        </div>   
            
        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Order/s</label></div>
            <br/><br/>
            <div id="order_value"><label id="order_details" value="order_details"></label></div>
        </div> 
        
        <br/>
        
        <div class="fields" id="view_order_detail"><label>Physician instructions for</label></div>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Patient</label></div>
            <div id="order_value"><label id="patient_instructions" value="patient_instructions"></label></div>
        </div>     
            
        <br/>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Pharmacist</label></div>
            <div id="order_value"><label id="pharmacist_instructions" value="pharmacist_instructions"></label></div>
        </div>    
        
        <br/>
        
        <div class="fields"><button class="confirm right" id="btn-dispatch" name="dispatchOrder" type="submit" onclick="showPharmaActionWindow()">${ ui.message("Dispatch") }</button></div>
        <br/><br/>
        <div class="fields"><button class="confirm right" id="btn-hold" name="holdOrder" type="submit" onclick="showPharmaActionWindow()">${ ui.message("Hold") }</button></div>
        <br/><br/>
        <div class="fields"><button class="confirm right" id="btn-drop" name="dropOrder" type="submit" onclick="showPharmaActionWindow()">${ ui.message("Drop") }</button>
        <button class="cancel" id="btn-place" onclick="hidePharmaOrderView()">${ ui.message("Cancel") }</button></div>
    </form>
</div>