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

            <% groupOrderMain.each { groupOrder -> %>
                <% list_of_orders = list_of_orders + groupOrder.key + "," %>
                
                <div class="groups">
                    <div class="fields" id="view_order_detail">
                        <div id="order_label"><label>Order</label></div>
                        <div id="order_value"><input type="text" class="group_order_order_details" name="group_order_order_details" value="${ groupOrderExtn.get(groupOrder.key).drugname.getDisplayString() }, ${ groupOrder.value.route.getDisplayString() } ${ groupOrder.value.dose } ${ groupOrder.value.doseUnits.getDisplayString() } ${ groupOrder.value.duration } ${ groupOrder.value.durationUnits.getDisplayString() } ${ groupOrder.value.quantity } ${ groupOrder.value.quantityUnits.getDisplayString() } ${ groupOrder.value.frequency }" readonly /></div>
                    </div>

                    <br/><br/>

                    <div class="fields" id="view_order_detail">
                        <div id="order_label"><label>Start Date</label></div>
                        <div id="order_value"><input type="text" class="group_order_start_date" name="group_order_start_date" value="${ groupOrderExtn.get(groupOrder.key).startdate.format('yyyy-MM-dd') }" readonly /></div>
                    </div>   

                    <br/><br/>
                    
                    <div class="fields" id="view_order_detail">
                        <div id="order_label"><label>Patient Instructions</label></div>
                        <div id="order_value"><input type="text" class="group_order_patient_instructions" name="group_order_patient_instructions" value="${ groupOrderExtn.get(groupOrder.key).patientinstructions }" readonly /></div>
                    </div>     

                    <br/><br/><br/>
                    
                    <div class="fields" id="view_order_detail">
                        <div id="order_label"><label>Pharmacist Instructions</label></div>
                        <div id="order_value"><input type="text" class="group_order_pharmacist_instructions" name="group_order_pharmacist_instructions" value="${ groupOrderExtn.get(groupOrder.key).pharmacistinstructions }" readonly /></div>
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
                            <div id="order_label"><label>Last Given</label></div>
                            <div id="order_value"><input type="text" id="group_order_last_dispatch_date" name="group_order_last_dispatch_date" value="${ last_dispatch_date }" readonly /></div>
                        </div>   

                        <br/><br/>
                        
                        <div class="fields" id="view_order_detail">
                            <div id="order_label"><label>Interval (days)</label></div>
                            <div id="order_value"><input type="text" class="group_order_order_refillInterval" name="group_order_order_refillInterval" value="${ groupOrderExtn.get(groupOrder.key).refillinterval }" readonly /></div>
                        </div>  

                        <br/><br/>
                        
                    </div><br/>
                </div><br/>
                <% provider_name = provider.get(groupOrder.key) %>
            <% } %>

            <input type="hidden" id="group_order_ID" name="group_order_ID" value="${ list_of_orders }" readonly />
            
            <div class="additionalInfo" id="view_order_detail">
                <div id="order_label"><label>Orderer</label></div>
                <div id="order_value"><input type="text" id="group_order_order_provider" name="group_order_order_provider" value="${ provider_name }" readonly /></div>
            </div>

            <br/><br/>
            
            <div class="additionalInfo" id="contactLabel">
                <label>Contact Orderer 
                    <i class="icon-plus-sign edit-action" title="${ ui.message("Show") }"></i>
                    <i class="icon-minus-sign edit-action" title="${ ui.message("Hide") }"></i>
                </label>
            </div>
            
            <div class="additionalInfo" id="ordererContact">
                <div class="fields" id="view_order_detail">
                    <div id="order_label"><label>Phone</label></div>
                    <div id="order_value"><input type="text" id="orderer_phone" name="orderer_phone" value="" readonly /></div>
                </div>
                <br/><br/>
                <div class="fields" id="view_order_detail">
                    <div id="order_label"><label>Email</label></div>
                    <div id="order_value"><input type="text" id="orderer_email" name="orderer_email" value="" readonly /></div>
                </div>
                <br/><br/>
            </div>
            
            <label class="fields" id="statusLabel"><br/>Order Status: <span id="selectedAction"></span></label><br/>
            <label class="fields" id="printLabel">Click <a href="#" onclick="submitDispatch()">here</a> to Print Label<br/><br/></label>
            
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
                    <label>Comments (Optional)</label>
                </div>
                <div class="fields">
                    <input type="textarea" maxlength="100" id="groupComments" name="groupComments" placeholder="Enter Comments on the Order"/>
                </div><br/>
                <div class="fields" id="view_order_detail">
                    <input type="checkbox" name="commentbox" value="1" />Forward message to ordering physician<br/>
                </div><br/>
                <div class="fields" id="view_order_detail">
                    <input type="checkbox" name="messagebox" value="1" />Another message to ordering physician<br/>
                </div><br/>
                <div class="fields">
                    <input type="textarea" maxlength="100" id="groupMessage" name="groupMessage" placeholder="Enter Additional Message for Orderer"/>
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
        jq(this).parent().parent().next("#additionalInformation").show();
        jq(this).hide();
        jq(this).next(".icon-minus-sign").show();
    });
    
    jq(".icon-minus-sign").click(function(){
        jq(this).parent().parent().next("#additionalInformation").hide();
        jq(this).hide();
        jq(this).prev(".icon-plus-sign").show();
    });
</script>

<script type="text/javascript">    
    jq(".icon-plus-sign").click(function(){
        jq(this).parent().parent().next("#ordererContact").show();
        jq(this).hide();
        jq(this).next(".icon-minus-sign").show();
    });
    
    jq(".icon-minus-sign").click(function(){
        jq(this).parent().parent().next("#ordererContact").hide();
        jq(this).hide();
        jq(this).prev(".icon-plus-sign").show();
    });
</script>