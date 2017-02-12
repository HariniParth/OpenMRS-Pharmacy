<%
    ui.includeCss("pharmacy", "pharmacy.css")
    ui.includeJavascript("pharmacy", "pharmacy.js")
%>

<div id="mailWindow" class="dialog">
    <form method="post">
        <div class="dialog-header">
            <h3 id="dialog-heading">${ ui.message("Mail To Orderer") }</h3>
        </div>

        <input class="confirm right" id="sendButton" type="submit" name="action" value="Send" />
        <input class="cancel left" id="sendButton" type="button" value="Cancel" />

        <table border="0">
            <tr>
                <td>From:</td>
                <td><input type="text" id="sender"  name="sender" value="" /></td>
            </tr>
            <tr>
                <td>To:</td>
                <td><input type="text" id="recipient" name="recipient" value="" /></td>
            </tr>
            <tr>
                <td>Subject:</td>
                <td><input type="text" id="subject" name="subject" value="" /></td>
            </tr>
            <tr>
                <td>Message:</td>
                <td><textarea rows="10" id="message" name="message"></textarea></td>
            </tr>
        </table>
    </form>
</div>
