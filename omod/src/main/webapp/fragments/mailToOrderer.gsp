<%
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "pharmacy.js")
%>

<% if(groupAction == "On Hold" || groupAction == "Discard") { %>
    <div id="mailWindow" class="dialog">
        <form method="post">
            <div class="dialog-header">
                <h3 id="dialog-heading">${ ui.message("Mail To Orderer") }</h3>
            </div>

            <table border="0">
                <tr>
                    <td>From:</td>
                    <td><input type="text" id="sender"  name="sender" value="" readonly="true" /></td>
                </tr>
                <tr>
                    <td>To:</td>
                    <td><input type="text" id="recipient" name="recipient" value="" readonly="true" /></td>
                </tr>
                <tr>
                    <td>Subject:</td>
                    <td><input type="text" id="subject" name="subject" value="" readonly="true" /></td>
                </tr>
                <tr>
                    <td>Message:</td>
                    <td><textarea rows="10" id="message" name="message"></textarea></td>
                </tr>
            </table><br/>
            
            <div class="fields">
                <input class="confirm right" id="btn-place" type="submit" name="action" value="Send" />
                <input class="cancel left" id="btn-place" type="button" value="Cancel" onclick="closeMailWindow()" />
            </div>
        </form>
    </div>
<% } %>