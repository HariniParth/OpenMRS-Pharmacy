<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<div id="pharmaActionView">
    <h4 class="heading">${ ui.message("Confirm Action") }</h4>
    
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
                <input type="text" id="pharma_action_patient_name" value="${pharma_patient_name}" readonly />
            </div>
        </div>
        
        <br/><br/>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label">
                <label>Patient DOB</label>
            </div>
            <div id="order_value">
                <input type="text" id="pharma_action_patient_DOB" value="${pharma_patient_DOB}" readonly />
            </div>
        </div>
        
        <br/><br/>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label">
                <label>Patient ID</label>
            </div>
            <div id="order_value">
                <input type="text" id="pharma_action_patient_id" value="${pharma_patient_id}" readonly />
            </div>
        </div>
        
        <br/><br/>
        
        <div class="fields" id="view_order_detail">
            <div id="order_label">
                <label>Address</label>
            </div>
            <div id="order_value">
                <input type="text" id="pharma_action_patient_address" value="${pharma_patient_address}" readonly />
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
                <label>Provider</label>
            </div>
            <div id="order_value">
                <input type="text" id="pharma_order_provider" value="${order_provider}" readonly />
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

        <br/><br/>
        
        <div class="fields">
            <label>Enter Comments</label>
        </div>
        
        <div class="fields">
            <input type="textarea" maxlength="50" id="comments" name="comments"/>
        </div>
        
        <div class="fields">
            <input type="checkbox" name="commentCheckbox" value="1" />Forward message to ordering physician<br/>
        </div>
        
        <div class="fields">
            <input type="checkbox" name="messageCheckbox" value="1" />Send another message to ordering physician<br/>
        </div>
        
        <div class="fields">
            <input type="textarea" maxlength="50" id="additionalMessage" name="additionalMessage"/>
        </div>
        
        <br/>
        <div class="fields">
            <input class="confirm right" id="btn-confirm" type="submit" name="action" value="OK" onclick="showPharmaActionWindow()" />
        </div>
        
        <div class="fields">
            <button class="cancel" id="btn-place" type="button" onclick="hidePharmaActionWindow('${pharma_order_id}','${pharma_patient_id}','${pharma_patient_name}','${pharma_patient_DOB}','${pharma_patient_address}','${pharma_start_date}','${pharma_order_details}','${pharma_order_refill}','${order_provider}','${pharma_patient_instructions}','${pharma_pharmacist_instructions}')">${ ui.message("Back") }</button>
        </div>

    </form>
</div>