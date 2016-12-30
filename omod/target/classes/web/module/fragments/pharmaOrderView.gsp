<%
    ui.includeCss("pharmacy", "pharmacy.css")
    def last_dispatch_date = "";
%>

<% if(!singleID.equals("") || !assocID.equals("") || !otherID.equals("")) { %>
    <div id="pharmaOrderView" class="dialog">

        <form method="post">

            <div class="dialog-header">
                <h3 id="dialog-heading">${ ui.message("Record Action") }</h3>
            </div><br/>
            
            <input type="hidden" id="pharmaOrderID" name="pharmaOrderID" value="${ orderExtn.orderId }" />

            <div id="singleOrder">
                <div class="fields" id="view_order_detail">
                    <div id="order_label"><label>Order(s)</label></div>
                    <div id="order_value"><input type="text" id="pharma_order_details" name="pharma_order_details" value="${ orderExtn.drugname.getDisplayString() } ${ orderMain.route.getDisplayString() } ${ orderMain.dose } ${ orderMain.doseUnits.getDisplayString() } ${ orderMain.duration } ${ orderMain.durationUnits.getDisplayString() } ${ orderMain.quantity } ${ orderMain.quantityUnits.getDisplayString() } ${ orderMain.frequency }" readonly /></div>
                </div> 

                <br/><br/>

                <div class="fields" id="view_order_detail">
                    <div id="order_label"><label>Start Date</label></div>
                    <div id="order_value"><input type="text" id="pharma_start_date" name="pharma_start_date" value="${ orderExtn.startdate.format('yyyy-MM-dd') }" readonly /></div>
                </div>   

                <br/><br/>

                <div class="fields" id="view_order_detail">
                    <div id="order_label"><label>Patient Instructions</label></div>
                    <div id="order_value"><input type="text" id="pharma_patient_instructions" name="pharma_patient_instructions" value="${ orderExtn.patientinstructions }" readonly /></div>
                </div>     

                <br/><br/><br/>
                
                <span class="printLabel"><span class="fields">Click Confirm to print label</span><br/><br/>
                    <div class="labelBorder"></div><br/>
                </span>

                <div class="fields" id="view_order_detail">
                    <div id="order_label"><label>Pharmacist Instructions</label></div>
                    <div id="order_value"><input type="text" id="pharma_pharmacist_instructions" name="pharma_pharmacist_instructions" value="${ orderExtn.pharmacistinstructions }" readonly /></div>
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
                        <div id="order_value"><input type="text" id="pharma_order_diagnosis" name="pharma_order_diagnosis" value="${ orderExtn.associateddiagnosis.getDisplayString() }" readonly /></div>
                    </div>

                    <br/><br/>

                    <div class="fields" id="view_order_detail">
                        <div id="order_label"><label>Allergy Note</label></div>
                        <div id="order_value"><input type="text" id="pharma_order_allergic" name="pharma_order_allergic" value="${ orderExtn.isallergicorderreasons }" readonly /></div>
                    </div>
                    <br/><br/>

                    <div class="fields" id="view_order_detail">
                        <div id="order_label"><label>Refills</label></div>
                        <div id="order_value"><input type="text" id="pharma_order_refill" name="pharma_order_refill" value="${ orderExtn.refill }" readonly /></div>
                    </div> 

                    <br/><br/>

                    <% if(orderExtn.lastdispatchdate != null) { %>
                        <% last_dispatch_date = orderExtn.lastdispatchdate.format('yyyy-MM-dd'); %>
                    <% } else { %>
                        <% last_dispatch_date = orderExtn.lastdispatchdate; %>
                    <% } %>

                    <div class="fields" id="view_order_detail">
                        <div id="order_label"><label>Last Given</label></div>
                        <div id="order_value"><input type="text" id="pharma_last_dispatch_date" name="pharma_last_dispatch_date" value="${ last_dispatch_date }" readonly /></div>
                    </div>
                    
                    <br/><br/>
                    
                    <div class="fields" id="view_order_detail">
                        <div id="order_label"><label>Interval (days)</label></div>
                        <div id="order_value"><input type="text" id="pharma_order_refillInterval" name="pharma_order_refillInterval" value="${ orderExtn.refillinterval }" readonly /></div>
                    </div>
                        
                    <br/><br/>

                </div><br/>
            </div><br/>
            
            <div class="additionalInfo" id="view_order_detail">
                <div id="order_label"><label>Provider</label></div>
                <div id="order_value"><input type="text" id="order_provider" name="order_provider" value="${ provider }" readonly /></div>
            </div>

            <br/><br/>

            <div class="additionalInfo" id="view_order_detail">
                <div id="order_label"><label>Associated Order (if any)</label></div>
                <div id="order_value"><input type="text" id="associatedOrders" name="associatedOrders" value="${ associatedOrders }" readonly /></div>
            </div>
                
            <br/><br/>
            
            <label class="fields" id="statusLabel"><br/>Order Status: <span id="selectedAction"></span></label><br/>

            <span id="pharmaGroupButtons">
                <div class="fields"><input class="confirm right" id="btn-place" value="Dispatch" type="button" onclick="showPharmaConfirmationSection('Dispatch')" /></div><br/><br/>

                <div class="fields"><input class="confirm right" id="btn-place" value="On Hold" type="button" onclick="showPharmaConfirmationSection('On Hold')" /></div><br/><br/>

                <div class="fields"><input class="confirm right" id="btn-place" value="Discard" type="button" onclick="showPharmaConfirmationSection('Discard')" />

                <input class="cancel" id="btn-place" value="Cancel" type="submit" /></div>
            </span>
            
            <span id="pharmaGroupActionButtons">
                <input type="hidden" id="pharmaSingleAction" name="pharmaSingleAction" />
                
                <div class="fields">
                    <label>Comments (Optional)</label>
                </div>

                <div class="fields">
                    <input type="textarea" maxlength="100" id="comments" name="comments" placeholder="Enter Comments on the Order"/>
                </div><br/>

                <div class="fields" id="view_order_detail">
                    <input type="checkbox" name="commentCheckbox" value="1" />Forward message to ordering physician<br/>
                </div><br/>

                <div class="fields" id="view_order_detail">
                    <input type="checkbox" name="messageCheckbox" value="1" />Another message to ordering physician<br/>
                </div><br/>

                <div class="fields">
                    <input type="textarea" maxlength="100" id="additionalMessage" name="additionalMessage" placeholder="Enter Additional Message for Orderer"/>
                </div><br/>

                <div class="fields">
                    <input class="confirm right" id="btn-place" type="submit" name="action" value="Confirm" />
                </div>

                <div class="fields">
                    <input class="cancel" id="btn-place" value="Back" type="button" onclick="showPharmaOrderViewSection()" />
                </div>
            </span>
            
        </form>
    </div>
<% } %>

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