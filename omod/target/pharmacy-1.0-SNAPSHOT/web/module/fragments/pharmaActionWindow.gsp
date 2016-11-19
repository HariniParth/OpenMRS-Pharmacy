<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<div id="pharmaActionView" class="dialog">
    
    <div class="dialog-header">
        <h3 id="dialog-heading">${ ui.message("Confirm Action") }</h3>
    </div><br/>
    
    <form method="post">
        
        <input type="hidden" id="pharma_action_order_id" value="${pharma_order_id}" name="pharma_action_order_id" readonly />
        
        <div class="fields" id="view_order_detail">
            <div id="order_label">
                <label>Order Status </label>
            </div>
            <div id="order_value">
                <input type="text" id="pharma_order_status" value="${order_status}" name="pharma_order_status" readonly />
            </div>
        </div>
        
        <br/><br/>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label">
                <label>Patient Name</label>
            </div>
            <div id="order_value">
                <input type="text" id="pharma_action_patient_name" value="${pharma_patient_name}" name="pharma_action_patient_name" readonly />
            </div>
        </div>
        
        <br/><br/>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label">
                <label>Patient DOB</label>
            </div>
            <div id="order_value">
                <input type="text" id="pharma_action_patient_DOB" value="${pharma_patient_DOB}" name="pharma_action_patient_DOB" readonly />
            </div>
        </div>
        
        <br/><br/>
        
        <div class="hidden" id="view_order_detail">
            <div id="order_label">
                <label>Patient ID</label>
            </div>
            <div id="order_value">
                <input type="text" id="pharma_action_patient_id" value="${pharma_patient_id}" name="pharma_action_patient_id" readonly />
            </div>
        </div>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label">
                <label>Address</label>
            </div>
            <div id="order_value">
                <input type="text" id="pharma_action_patient_address" value="${pharma_patient_address}" name="pharma_action_patient_address" readonly />
            </div>
        </div>
        
        <br/><br/>

        <div class="fields" id="view_order_detail">
            <div id="order_label">
                <label>Start Date</label>
            </div>
            <div id="order_value">
                <input type="text" id="pharma_action_start_date" value="${pharma_start_date}" readonly />
            </div>
        </div>  
        
        <br/><br/>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label">
                <label>Order/s</label>
            </div>
            <div id="order_value">
                <input type="text" id="pharma_action_order_details" value="${pharma_order_details}" readonly />
            </div>
        </div> 

        <br/><br/>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label">
                <label>Refills</label>
            </div>
            <div id="order_value">
                <input type="text" id="pharma_action_order_refill" value="${pharma_order_refill}" readonly />
            </div>
        </div> 

        <br/><br/>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label">
                <label>Last Dispatch</label>
            </div>
            <div id="order_value">
                <input type="text" id="pharma_action_last_dispatch_date" value="${pharma_last_dispatch_date}" readonly />
            </div>
        </div>  
        
        <br/><br/>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label">
                <label>Interval</label>
            </div>
            <div id="order_value">
                <input type="text" id="pharma_action_order_refillInterval" value="${pharma_order_refillInterval}" readonly />
            </div>
        </div> 

        <br/><br/>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label">
                <label>Provider</label>
            </div>
            <div id="order_value">
                <input type="text" id="pharma_order_provider" value="${order_provider}" name="pharma_order_provider" readonly />
            </div>
        </div> 

        <br/><br/>

        <div class="fields" id="view_order_detail">
            <label>Instructions for</label>
        </div>

        <div class="fields" id="view_order_detail">
            <div id="order_label">
                <label>Patient</label>
            </div>
            <div id="order_value">
                <input type="text" id="pharma_action_patient_instructions" value="${pharma_patient_instructions}" readonly />
            </div>
        </div>     

        <br/><br/>

        <div class="fields" id="view_order_detail">
            <div id="order_label">
                <label>Pharmacist</label>
            </div>
            <div id="order_value">
                <input type="text" id="pharma_action_pharmacist_instructions" value="${pharma_pharmacist_instructions}" readonly />
            </div>
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
                <div id="order_value"><input type="text" id="pharma_action_order_diagnosis" value="${pharma_order_diagnosis}" readonly /></div>
            </div>
            
            <br/><br/>
            
            <div class="fields" id="view_order_detail">
                <div id="order_label"><label>Allergy Note</label></div>
                <div id="order_value"><input type="text" id="pharma_action_order_allergic" value="${pharma_order_allergic}" readonly /></div>
            </div>
            <br/><br/>
        </div>
        
        <div class="fields" id="view_order_detail">
            <label>Associated Orders (if any)</label>
            <input type="text" id="associatedOrders" name="associatedOrders" value="${associatedOrders}" readonly />
        </div><br/>
        
        <div class="fields">
            <label>Enter Comments</label>
        </div>
        
        <div class="fields">
            <input type="textarea" maxlength="100" id="comments" name="comments"/>
        </div><br/>
        
        <div class="fields" id="view_order_detail">
            <input type="checkbox" name="commentCheckbox" value="1" />Forward message to ordering physician<br/>
        </div><br/>
        
        <div class="fields" id="view_order_detail">
            <input type="checkbox" name="messageCheckbox" value="1" />Another message to ordering physician<br/>
        </div><br/>
        
        <div class="fields">
            <input type="textarea" maxlength="100" id="additionalMessage" name="additionalMessage"/>
        </div><br/>
        
        <div class="fields">
            <input class="confirm right" id="btn-place" type="submit" name="action" value="OK" onclick="showPharmaActionWindow()" />
        </div>
        
        <div class="fields">
            <input class="cancel" id="btn-place" value="Back" type="button" onclick="hidePharmaActionWindow('${pharma_order_id}','${pharma_patient_id}','${pharma_patient_name}','${pharma_patient_DOB}','${pharma_patient_address}','${pharma_start_date}','${pharma_order_details}','${pharma_order_refill}','${pharma_last_dispatch_date}','${pharma_order_refillInterval}','${order_provider}','${pharma_patient_instructions}','${pharma_pharmacist_instructions}','${pharma_order_diagnosis}','${pharma_order_allergic}','${associatedOrders}')" />
        </div>

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