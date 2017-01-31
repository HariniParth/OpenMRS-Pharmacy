<%
    ui.includeCss("pharmacy", "pharmacy.css")
    def list_of_orders = "";
    def provider_name = "";
    def last_dispatch_date = "";
%>

<% if(!planID.equals("") || !groupID.equals("") || !orderID.equals("")) { %>
    <div id="pharmaGroupView" class="dialog">

        <form method="post" id="groupActionForm">

            <div class="dialog-header">
                <h3 id="dialog-heading">${ ui.message("Record Action") }</h3>
            </div><br/>

            <div class="group">
                <% groupOrderMain.each { groupOrder -> %>
                    <% list_of_orders = list_of_orders + groupOrder.key + "," %>

                    <div class="groupItem">
                                
                        <div class="fields" id="view_order_detail">
                            <div id="order_label">
                                <input type="checkbox" name="orderCheckBox" value="${ groupOrder.key }" ng-model="orderCheckBox" /></span>
                                <i class="icon-plus-sign edit-action" title="${ ui.message("Show") }"></i>
                                <i class="icon-minus-sign edit-action" title="${ ui.message("Hide") }"></i>
                            </div>
                            
                            <div id="order_value">
                                <span id="drug_name"><strong>${ groupOrderExtn.get(groupOrder.key).drugname.getDisplayString() }</strong></span>
                            </div>
                        </div>

                        <br/><br/>

                        <span class="expiryDateField">
                            <div class="fields" id="view_order_detail">
                                <div id="order_label">
                                    <label>Expiry Date<span id="asterisk">*</span></label>
                                </div>
                                <div id="order_value">
                                    <input type="date" class="drugExpiryDate" value="${ groupOrderExtn.get(groupOrder.key).drugexpirydate }" name="drugExpiryDate">
                                </div>
                            </div> 
                            <br/><br/>
                        </span>

                        <div id="additionalInformation">
                            <div class="fields" id="view_order_detail">
                                <div id="order_label"><label>Order</label></div>
                                <div id="order_value"><input type="text" class="group_order_order_details" name="group_order_order_details" value="${ groupOrderExtn.get(groupOrder.key).drugname.getDisplayString() }, ${ groupOrder.value.route.getDisplayString() }, ${ groupOrder.value.dose } ${ groupOrder.value.doseUnits.getDisplayString() }, ${ groupOrder.value.duration } ${ groupOrder.value.durationUnits.getDisplayString() }, ${ groupOrder.value.quantity } ${ groupOrder.value.quantityUnits.getDisplayString() }, ${ groupOrder.value.frequency }" readonly /></div>
                            </div>     

                            <br/><br/><br/>
                            
                            <div class="fields" id="view_order_detail">
                                <p>Instructions from Physician for</p>
                            </div>

                            <div class="fields" id="view_order_detail">
                                <div id="order_label"><label>Patient</label></div>
                                <div id="order_value"><input type="text" class="group_order_patient_instructions" name="group_order_patient_instructions" value="${ groupOrderExtn.get(groupOrder.key).patientinstructions }" readonly /></div>
                            </div>     

                            <br/><br/>

                            <div class="fields" id="view_order_detail">
                                <div id="order_label"><label>Pharmacist</label></div>
                                <div id="order_value"><input type="text" class="group_order_pharmacist_instructions" name="group_order_pharmacist_instructions" value="${ groupOrderExtn.get(groupOrder.key).pharmacistinstructions }" readonly /></div>
                            </div>    

                            <br/><br/>
                        
                            <div class="fields" id="view_order_detail">
                                <div id="order_label"><label>Diagnosis</label></div>
                                <div id="order_value"><input type="text" class="group_order_order_diagnosis" name="group_order_order_diagnosis" value="${ groupOrderExtn.get(groupOrder.key).associateddiagnosis.getDisplayString() }" readonly /></div>
                            </div>

                            <br/><br/>

                            <div class="fields" id="view_order_detail">
                                <div id="order_label"><label>Allergy Note</label></div>
                                <div id="order_value"><input type="text" class="group_order_order_allergic" name="group_order_order_allergic" value="${ groupOrderExtn.get(groupOrder.key).isallergicorderreasons }" readonly /></div>
                            </div>
                            <br/><br/>

                            <div class="fields" id="view_order_detail">
                                <div id="order_label"><label>Refills</label></div>
                                <div id="order_value"><input type="text" class="group_order_order_refill" name="group_order_order_refill" value="${ groupOrderExtn.get(groupOrder.key).refill }" readonly /></div>
                            </div> 

                            <br/><br/>

                            <% if(groupOrderExtn.get(groupOrder.key).lastdispatchdate != null) { %>
                                <% last_dispatch_date = groupOrderExtn.get(groupOrder.key).lastdispatchdate.format('yyyy-MM-dd'); %>
                            <% } else { %>
                                <% last_dispatch_date = groupOrderExtn.get(groupOrder.key).lastdispatchdate; %>
                            <% } %>

                            <div class="fields" id="view_order_detail">
                                <div id="order_label"><label>Last Refill</label></div>
                                <div id="order_value"><input type="text" id="group_order_last_dispatch_date" name="group_order_last_dispatch_date" value="${ last_dispatch_date }" readonly /></div>
                            </div>   

                            <br/><br/>

                            <div class="fields" id="view_order_detail">
                                <div id="order_label"><label>Refill Interval</label></div>
                                <div id="order_value"><input type="text" class="group_order_order_refillInterval" name="group_order_order_refillInterval" value="${ groupOrderExtn.get(groupOrder.key).refillinterval }" readonly /></div>
                            </div>  

                            <br/><br/>

                        </div><br/>
                    </div><br/>
                    <% provider_name = provider.get(groupOrder.key) %>
                <% } %>
            </div>

            <input type="hidden" id="group_order_ID" name="group_order_ID" value="${ list_of_orders }" readonly />
            <input type="hidden" id="orderer_email" name="orderer_email" value="" readonly />
            
            <label class="fields" id="statusLabel"><br/>Order Status: <span id="selectedAction"></span></label><br/>
            
            <div class="fields" id="printLabel">
                <div class="fields"><label>Comments</label></div>
                <div class="fields"><input type="textarea" maxlength="100" id="patientNotes" name="patientNotes" placeholder="Enter Notes for the Patient"/></div>
                Click <a href="#" onclick="submitDispatch()">here</a> to Print Label<br/><br/>
            </div>
            
            <span id="pharmaGroupButtons">
                <div class="fields"><input class="confirm right" id="btn-place" value="Dispatch" type="button" onclick="showPharmaConfirmationSection('Dispatch')" /></div><br/><br/>
                <div class="fields"><input class="confirm right" id="btn-place" value="On Hold" type="button" onclick="showPharmaConfirmationSection('On Hold')" /></div><br/><br/>
                <div class="fields"><input class="confirm right" id="btn-place" value="Discard" type="button" onclick="showPharmaConfirmationSection('Discard')" />
                <input class="cancel" id="btn-place" value="Cancel" type="submit" /></div>
            </span>
            
            <div id="cancelButtons">
                <div class="fields">
                    <input class="confirm right" id="btn-place" type="button" value="Cancel" onclick="closePharmaGroupView()" />
                </div>
                <div class="fields">
                    <input class="cancel left" id="btn-place" type="button" value="Back" onclick="showPharmaOrderViewSection()" />
                </div>
            </div>
                    
            <span id="pharmaGroupActionButtons">
                
                <input type="hidden" id="pharmaGroupAction" name="pharmaGroupAction" />
                <div class="fields">
                    <label>Comments</label>
                </div>
                <div class="fields">
                    <input type="textarea" maxlength="100" id="groupComments" name="groupComments" placeholder="Enter Comments for the Orderer"/>
                </div><br/>
                <div class="fields">
                    <input class="confirm right" id="btn-place" type="submit" name="action" value="Record" />
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
        jq(this).parent().parent().nextAll("#additionalInformation").show();
        jq(this).hide();
        jq(this).next(".icon-minus-sign").show();
    });
    
    jq(".icon-minus-sign").click(function(){
        jq(this).parent().parent().nextAll("#additionalInformation").hide();
        jq(this).hide();
        jq(this).prev(".icon-plus-sign").show();
    });
</script>