<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<div id="pharmaOrderView">
    <form method="post">
        <h4 class="heading">${ ui.message("Record Action") }</h4>

        <input type="hidden" id="pharma_order_id" name="pharma_order_id" readonly />
        
        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Patient Name</label></div>
            <div id="order_value"><input type="text" id="pharma_patient_name" name="pharma_patient_name" readonly /></div>
        </div>

        <br/><br/>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Patient DOB</label></div>
            <div id="order_value"><input type="text" id="pharma_patient_dob" name="pharma_patient_dob" readonly /></div>
        </div>

        <br/><br/>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Patient ID</label></div>
            <div id="order_value"><input type="text" id="pharma_patient_id" name="pharma_patient_id" readonly /></div>
        </div>

        <br/><br/>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Address</label></div>
            <div id="order_value"><input type="text" id="pharma_patient_address" name="pharma_patient_address" readonly /></div>
        </div>

        <br/><br/>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Start Date</label></div>
            <div id="order_value"><input type="text" id="pharma_start_date" name="pharma_start_date" readonly /></div>
        </div>   

        <br/><br/>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Order/s</label></div>
            <div id="order_value"><input type="text" id="pharma_order_details" name="pharma_order_details" readonly /></div>
        </div> 
        
        <br/><br/>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Refills</label></div>
            <div id="order_value"><input type="text" id="pharma_order_refill" name="pharma_order_refill" readonly /></div>
        </div> 

        <br/><br/>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Interval (days)</label></div>
            <div id="order_value"><input type="text" id="pharma_order_refillInterval" name="pharma_order_refillInterval" readonly /></div>
        </div> 

        <br/><br/>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Provider</label></div>
            <div id="order_value"><input type="text" id="order_provider" name="order_provider" readonly /></div>
        </div>
        
        <br/><br/><br/>

        <div class="fields" id="view_order_detail"><label>Instructions for</label></div>

        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Patient</label></div>
            <div id="order_value"><input type="text" id="pharma_patient_instructions" name="pharma_patient_instructions" readonly /></div>
        </div>     

        <br/><br/>

        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Pharmacist</label></div>
            <div id="order_value"><input type="text" id="pharma_pharmacist_instructions" name="pharma_pharmacist_instructions" readonly /></div>
        </div>    

        <br/><br/>

        <div class="fields"><input class="confirm right" id="btn-dispatch" name="action" value="Dispatch" type="submit" onclick="showPharmaActionWindow()" /></div>
        <br/><br/>
        <div class="fields"><input class="confirm right" id="btn-hold" name="action" value="Hold" type="submit" onclick="showPharmaActionWindow()" /></div>
        <br/><br/>
        <div class="fields"><input class="confirm right" id="btn-drop" name="action" value="Drop" type="submit" onclick="showPharmaActionWindow()" />
        <input class="cancel" type="button" id="btn-place" value="Close" onclick="hidePharmaOrderView()" /></div>
    </form>
</div>