<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<% if((!(planPatient).equals("") && !(planName).equals("")) || !groupID.equals("") || !orderID.equals("")) { %>
    <div id="pharmaGroupView">

        <form method="post">

            <div class="dialog-header">
                <h3 id="dialog-heading">${ ui.message("Record Action") }</h3>
            </div><br/>

            <div class="fields" id="view_order_detail">
                <div id="order_label"><label>Patient Name</label></div>
                <div id="order_value"><input type="text" id="group_order_patient_name" name="group_order_patient_name" value="${ patientName }" readonly /></div>
            </div>

            <br/><br/>

            <div class="fields" id="view_order_detail">
                <div id="order_label"><label>Patient DOB</label></div>
                <div id="order_value"><input type="text" id="group_order_patient_dob" name="group_order_patient_dob" value="${ patientDOB.format('yyyy-MM-dd') }" readonly /></div>
            </div>

            <br/><br/>

            <div class="hidden" id="view_order_detail">
                <div id="order_label"><label>Patient ID</label></div>
                <div id="order_value"><input type="text" id="group_order_patient_id" name="group_order_patient_id" readonly /></div>
            </div>

            <div class="fields" id="view_order_detail">
                <div id="order_label"><label>Address</label></div>
                <div id="order_value"><input type="text" id="group_order_patient_address" name="group_order_patient_address" value="${ patientAddress }" readonly /></div>
            </div>

            <br/><br/><br/>

            <% groupOrderMain.each { groupOrder -> %>

                <div class="groups"><br/>
                    <div class="fields" id="view_order_detail">
                        <div id="order_label"><label>Order</label></div>
                        <div id="order_value"><input type="text" id="group_order_order_details" name="group_order_order_details" value="${ groupOrderExtn.get(groupOrder.key).drugname.getDisplayString() } ${ groupOrder.value.route.getDisplayString() } ${ groupOrder.value.dose } ${ groupOrder.value.doseUnits.getDisplayString() } ${ groupOrder.value.duration } ${ groupOrder.value.durationUnits.getDisplayString() } ${ groupOrder.value.quantity } ${ groupOrder.value.quantityUnits.getDisplayString() } ${ groupOrder.value.frequency }" readonly /></div>
                    </div>

                    <br/><br/>

                    <div class="fields" id="view_order_detail">
                        <div id="order_label"><label>Start Date</label></div>
                        <div id="order_value"><input type="text" id="group_order_start_date" name="group_order_start_date" value="${ groupOrderExtn.get(groupOrder.key).startdate.format('yyyy-MM-dd') }" readonly /></div>
                    </div>   

                    <br/><br/>

                    <div class="fields" id="view_order_detail"><label>Instructions</label></div>

                    <div class="fields" id="view_order_detail">
                        <div id="order_label"><label>Patient</label></div>
                        <div id="order_value"><input type="text" id="group_order_patient_instructions" name="group_order_patient_instructions" value="${ groupOrderExtn.get(groupOrder.key).patientinstructions }" readonly /></div>
                    </div>     

                    <br/><br/>

                    <div class="fields" id="view_order_detail">
                        <div id="order_label"><label>Pharmacist</label></div>
                        <div id="order_value"><input type="text" id="group_order_pharmacist_instructions" name="group_order_pharmacist_instructions" value="${ groupOrderExtn.get(groupOrder.key).pharmacistinstructions }" readonly /></div>
                    </div>    

                    <br/><br/>

                    <div class="fields" id="view_order_detail">
                        <label>Additional Information 
                            <i class="icon-plus-sign edit-action" title="${ ui.message("Show") }"></i>
                            <i class="icon-minus-sign edit-action" title="${ ui.message("Hide") }"></i>
                        </label>
                    </div>

                    <div id="additionalInformation">
                        <div class="fields" id="view_order_detail">
                            <div id="order_label"><label>Diagnosis</label></div>
                            <div id="order_value"><input type="text" id="group_order_order_diagnosis" name="group_order_order_diagnosis" value="${ groupOrderExtn.get(groupOrder.key).associateddiagnosis.getDisplayString() }" readonly /></div>
                        </div>

                        <br/><br/>

                        <div class="fields" id="view_order_detail">
                            <div id="order_label"><label>Allergy Note</label></div>
                            <div id="order_value"><input type="text" id="group_order_order_allergic" name="group_order_order_allergic" value="${ groupOrderExtn.get(groupOrder.key).isallergicorderreasons }" readonly /></div>
                        </div>
                        <br/><br/>

                        <div class="fields" id="view_order_detail">
                            <div id="order_label"><label>Refills</label></div>
                            <div id="order_value"><input type="text" id="group_order_order_refill" name="group_order_order_refill" value="${ groupOrderExtn.get(groupOrder.key).refill }" readonly /></div>
                        </div> 

                        <br/><br/>

                        <div class="fields" id="view_order_detail">
                            <div id="order_label"><label>Interval (days)</label></div>
                            <div id="order_value"><input type="text" id="group_order_order_refillInterval" name="group_order_order_refillInterval" value="${ groupOrderExtn.get(groupOrder.key).refillinterval }" readonly /></div>
                        </div>  

                    </div><br/>
                </div><br/>

            <% } %>

            <div class="fields" id="view_order_detail">
                <div id="order_label"><label>Last Dispatch</label></div>
                <div id="order_value"><input type="text" id="group_order_last_dispatch_date" name="group_order_last_dispatch_date" readonly /></div>
            </div>   

            <br/><br/>

            <div class="fields" id="view_order_detail">
                <div id="order_label"><label>Provider</label></div>
                <div id="order_value"><input type="text" id="group_order_order_provider" name="group_order_order_provider" readonly /></div>
            </div>

            <br/><br/><br/>         

            <div class="fields"><input class="confirm right" id="btn-place" value="Dispatch" type="button" onclick="showPharmaConfirmationSection()" /></div><br/><br/>

            <div class="fields"><input class="confirm right" id="btn-place" value="On Hold" type="button" onclick="showPharmaConfirmationSection()" /></div><br/><br/>

            <div class="fields"><input class="confirm right" id="btn-place" value="Discard" type="button" onclick="showPharmaConfirmationSection()" />

            <input class="cancel" id="btn-place" value="Cancel" type="button" onclick="closePharmaGroupViewWindow()" /></div>

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