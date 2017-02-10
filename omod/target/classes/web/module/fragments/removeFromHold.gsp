<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<form method="post">
    <div id="removeHold" class="dialog">
        <div class="dialog-header">
            <h3 id="dialog-heading">${ ui.message("Remove Order Hold") }</h3>
        </div>
        
        <h4 id="heading"><strong>Remove hold on selected Orders?</strong></h4><br/>

        <div class="fields">
            <button class="confirm right" id="btn-place" type="submit">Confirm</button>
            <button class="cancel left" id="btn-place" type="button" onclick="closeRemoveOrderHoldWindow()">Cancel</button>
        </div>
    </div>
</form>
