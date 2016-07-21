<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<div id="order-search-bar">
    <form method="post">
        <div id="orderSearchField">FIND BY ORDER ID: 
            <input type="text" id="search_order_id" name="search_order_id"/>
        </div>
        <div id="orderSearchButton">
            <input class="confirm" id="btn-place" name="searchPharmaOrderByOrderID" type="submit"/>
        </div>
        <input type="hidden" name="action" value="searchByOrder"/>
    </form>
</div>