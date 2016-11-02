<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<div id="pharmaOrderView" class="dialog">
    
    <form method="post">
        
        <div class="dialog-header">
            <h3 id="dialog-heading">${ ui.message("Record Action") }</h3>
        </div><br/>

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
        
        <div class="hidden" id="view_order_detail">
            <div id="order_label"><label>Patient ID</label></div>
            <div id="order_value"><input type="text" id="pharma_patient_id" name="pharma_patient_id" readonly /></div>
        </div>
        
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
            <div id="order_label"><label>Last Dispatch</label></div>
            <div id="order_value"><input type="text" id="pharma_last_dispatch_date" name="pharma_last_dispatch_date" readonly /></div>
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

        <br/><br/><br/>
        
        <div class="fields" id="view_order_detail">
            <label>Additional Information 
                <i class="icon-plus-sign edit-action" title="${ ui.message("Show") }"></i>
                <i class="icon-minus-sign edit-action" title="${ ui.message("Hide") }"></i>
            </label>
        </div>
        
        <div id="additionalInformation">
            <div class="fields" id="view_order_detail">
                <div id="order_label"><label>Diagnosis</label></div>
                <div id="order_value"><input type="text" id="pharma_order_diagnosis" name="pharma_order_diagnosis" readonly /></div>
            </div>
            
            <br/><br/>
            
            <div class="fields" id="view_order_detail">
                <div id="order_label"><label>Allergy Note</label></div>
                <div id="order_value"><input type="text" id="pharma_order_allergic" name="pharma_order_allergic" readonly /></div>
            </div>
            <br/><br/>
        </div>
        
        <div class="fields" id="view_order_detail">
            <label>Associated Orders (if any)</label>
            <input type="text" id="associatedOrders" name="associatedOrders" readonly />
        </div>    

        <br/><br/>

        <div class="fields"><input class="confirm right" id="btn-dispatch" name="action" value="Dispatch" type="submit" onclick="showPharmaActionWindow()" /></div><br/><br/>
        
        <div class="fields"><input class="confirm right" id="btn-hold" name="action" value="Hold" type="submit" onclick="showPharmaActionWindow()" /></div><br/><br/>
        
        <div class="fields"><input class="confirm right" id="btn-drop" name="action" value="Drop" type="submit" onclick="showPharmaActionWindow()" />
        
        <input class="cancel" id="btn-place" value="Close" type="submit" /></div>
    
    </form>
</div>

<script type="text/javascript">    
    jq(".icon-plus-sign").click(function(){
        jq(this).parent().parent().next("#additionalInformation").show();
        jq(this).hide();
        jq(this).next(".icon-minus-sign").show();
    });
</script>

<script type="text/javascript">
    jq(".icon-minus-sign").click(function(){
        jq(this).parent().parent().next("#additionalInformation").hide();
        jq(this).hide();
        jq(this).prev(".icon-plus-sign").show();
    });
</script>