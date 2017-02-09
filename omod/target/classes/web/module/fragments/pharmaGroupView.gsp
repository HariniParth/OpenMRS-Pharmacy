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
            </div>

            <h4 id="heading"><strong>Selected Group Order(s)</strong></h4><br/>
            
            <div class="group">
                <% groupOrderMain.each { groupOrder -> %>
                    <% list_of_orders = list_of_orders + groupOrder.key + "," %>

                    <div class="groupItem">
                                
                        <div id="view_order_detail">
                            <span id="drug_name">
                                <h5><input type="checkbox" name="orderCheckBox" value="${ groupOrder.key }" ng-model="orderCheckBox" /></span>
                                    <i class="icon-plus-sign edit-action" title="${ ui.message("Show") }"></i>
                                    <i class="icon-minus-sign edit-action" title="${ ui.message("Hide") }"></i>
                                    <strong>${ groupOrderExtn.get(groupOrder.key).drugName.getDisplayString() }</strong>
                                </h5>
                            </span>
                        </div>

                        <div class="expiryDateField">
                            <div class="fields" id="view_order_detail">
                                <div id="order_label">
                                    <label>Expiry<span id="asterisk">*</span></label>
                                </div>
                                <div id="order_value">
                                    <input type="date" class="drugExpiryDate" value="${ groupOrderExtn.get(groupOrder.key).drugExpiryDate }" name="drugExpiryDate">
                                </div>
                            </div> 
                            <br/><br/>
                        </div>

                        <div class="additionalInformation">
                            <div class="fields" id="view_order_detail">
                                <div id="order_label"><label>Order</label></div>
                                <div id="order_value"><input type="text" class="group_order_order_details" name="group_order_order_details" value="${ groupOrderExtn.get(groupOrder.key).drugName.getDisplayString() }, ${ groupOrder.value.route.getDisplayString() }, ${ groupOrder.value.dose } ${ groupOrder.value.doseUnits.getDisplayString() }, ${ groupOrder.value.duration } ${ groupOrder.value.durationUnits.getDisplayString() }, ${ groupOrder.value.quantity } ${ groupOrder.value.quantityUnits.getDisplayString() }, ${ groupOrder.value.frequency }" readonly /></div>
                            </div>     

                            <br/><br/>
                            
                            <div class="fields" id="view_order_detail">
                                <div id="order_label"><label>Allergy</label></div>
                                <div id="order_value"><input type="text" class="group_order_order_allergic" name="group_order_order_allergic" value="${ groupOrderExtn.get(groupOrder.key).isAllergicOrderReasons }" readonly /></div>
                            </div>
                            
                            <br/><br/>
                            
                            <div class="fields" id="view_order_detail">
                                <div id="order_label"><label>Diagnosis</label></div>
                                <div id="order_value"><input type="text" class="group_order_order_diagnosis" name="group_order_order_diagnosis" value="${ groupOrderExtn.get(groupOrder.key).associatedDiagnosis.getDisplayString() }" readonly /></div>
                            </div>

                            <br/><br/>
                            
                            <div class="fields" id="view_order_detail">
                                <div id="order_label"><label>Refills</label></div>
                                <div id="order_value"><input type="text" class="group_order_order_refill" name="group_order_order_refill" value="${ groupOrderExtn.get(groupOrder.key).refill }" readonly /></div>
                            </div> 

                            <br/><br/>
                            
                            <% if(groupOrderExtn.get(groupOrder.key).lastDispatchDate != null) { %>
                                <% last_dispatch_date = groupOrderExtn.get(groupOrder.key).lastDispatchDate.format('yyyy-MM-dd'); %>
                            <% } else { %>
                                <% last_dispatch_date = groupOrderExtn.get(groupOrder.key).lastDispatchDate; %>
                            <% } %>

                            <div class="fields" id="view_order_detail">
                                <div id="order_label"><label>Last Refill</label></div>
                                <div id="order_value"><input type="text" id="group_order_last_dispatch_date" name="group_order_last_dispatch_date" value="${ last_dispatch_date }" readonly /></div>
                            </div>   

                            <br/><br/>

                            <div class="fields" id="view_order_detail">
                                <div id="order_label"><label>Interval</label></div>
                                <div id="order_value"><input type="text" class="group_order_order_refillInterval" name="group_order_order_refillInterval" value="${ groupOrderExtn.get(groupOrder.key).refillInterval }" readonly /></div>
                            </div>  

                            <br/><br/>
                            
                            <div class="fields" id="view_order_detail">
                                <p>Instructions from Physician for</p>
                            </div>

                            <div class="fields" id="view_order_detail">
                                <div id="order_label"><label>Patient</label></div>
                                <div id="order_value"><input type="text" class="group_order_patient_instructions" name="group_order_patient_instructions" value="${ groupOrderExtn.get(groupOrder.key).patientInstructions }" readonly /></div>
                            </div>     

                            <br/><br/>

                            <div class="fields" id="view_order_detail">
                                <div id="order_label"><label>Pharmacy</label></div>
                                <div id="order_value"><input type="text" class="group_order_pharmacist_instructions" name="group_order_pharmacist_instructions" value="${ groupOrderExtn.get(groupOrder.key).pharmacistInstructions }" readonly /></div>
                            </div>    

                            <br/><br/>
                        </div><br/>
                    </div>
                    <% provider_name = provider.get(groupOrder.key) %>
                <% } %>
            </div>

            <input type="hidden" id="group_order_ID" name="group_order_ID" value="${ list_of_orders }" readonly />
            <input type="hidden" id="orderer_email" name="orderer_email" value="" readonly />
            
            <label class="fields" id="statusLabel"><br/>Order Status: <span id="selectedAction"></span></label>
            
            <div class="fields" id="printLabel">
                <div><label>Comments</label></div>
                <div><input type="textarea" maxlength="100" id="patientNotes" name="patientNotes" placeholder="Enter Notes for the Patient"/></div><br/>
                Click <a href="#" onclick="submitDispatch()">here</a> to Print Label<br/><br/>
            </div>
            
            <span id="pharmaGroupButtons"><br/>
                <div class="fields"><input class="confirm right" id="btn-place" value="Dispatch" type="button" onclick="showPharmaConfirmationSection('Dispatch')" /></div><br/><br/>
                <div class="fields"><input class="confirm right" id="btn-place" value="On Hold" type="button" onclick="showPharmaConfirmationSection('On Hold')" /></div><br/><br/>
                <div class="fields"><input class="confirm right" id="btn-place" value="Discard" type="button" onclick="showPharmaConfirmationSection('Discard')" />
                <input class="cancel" id="btn-place" value="Cancel" type="submit" /></div>
            </span>
            
            <input type="hidden" id="pharmaGroupAction" name="pharmaGroupAction" />
            
            <div id="confirmButtons">
                <div class="fields">
                    <input class="confirm right" id="btn-place" type="submit" name="action" value="Confirm" />
                </div>
                <div class="fields">
                    <input class="cancel left" id="btn-place" type="button" value="Back" onclick="showPharmaOrderViewSection()" />
                </div>
            </div>
                    
            <span id="pharmaGroupActionButtons">
                <div class="fields">
                    <label>Comments</label>
                </div>
                <div class="fields">
                    <input type="textarea" maxlength="100" id="groupComments" name="groupComments" placeholder="Enter Comments for the Orderer"/>
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
        jq(this).parent().parent().parent().nextAll(".additionalInformation").first().show();
        jq(this).hide();
        jq(this).next(".icon-minus-sign").show();
    });
    
    jq(".icon-minus-sign").click(function(){
        jq(this).parent().parent().parent().nextAll(".additionalInformation").first().hide();
        jq(this).hide();
        jq(this).prev(".icon-plus-sign").show();
    });
</script>