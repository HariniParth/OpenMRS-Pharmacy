<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<div id="pharmaOrderView">
    <form method="post">
        <h4 class="heading">${ ui.message("Record Action") }</h4>

        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Order ID </label></div>
            <div id="order_value"><input type="text" id="pharma_order_id" name="pharma_order_id" readonly /></div>
        </div>

        <br/><br/>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Patient ID</label></div>
            <div id="order_value"><input type="text" id="pharma_patient_id" name="pharma_patient_id" readonly /></div>
        </div>

        <br/><br/>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label"><label>Patient Name</label></div>
            <div id="order_value"><input type="text" id="pharma_patient_name" name="pharma_patient_name" readonly /></div>
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

        <div class="fields" id="view_order_detail"><label>Physician instructions for</label></div>

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

        <div class="fields"><button class="confirm right" id="btn-dispatch" name="dispatchOrder" type="submit" onclick="showPharmaActionWindow('Dispatch')">${ ui.message("Dispatch") }</button></div>
        <br/><br/>
        <div class="fields"><button class="confirm right" id="btn-hold" name="holdOrder" type="submit" onclick="showPharmaActionWindow('Hold')">${ ui.message("Hold") }</button></div>
        <br/><br/>
        <div class="fields"><button class="confirm right" id="btn-drop" name="dropOrder" type="submit" onclick="showPharmaActionWindow('Cancelled')">${ ui.message("Drop") }</button>
        <button class="cancel" id="btn-place" onclick="hidePharmaOrderView()">${ ui.message("Cancel") }</button></div>
    </form>
</div>