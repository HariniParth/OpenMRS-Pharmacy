<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<div id="order-search-bar">
    <form method="post">
        <div>FIND BY ORDER ID:</div>
        <div>
            <span id="orderSearchField">
                <input type="text" id="search_order_id" name="search_order_id"/>
            </span>
            <span id="orderSearchButton">
                <input class="confirm" id="btn-place" name="searchPharmaOrderByOrderID" type="submit"/>
            </span>
        </div>
        <input type="hidden" name="action" value="searchByOrder"/>
    </form>
</div>