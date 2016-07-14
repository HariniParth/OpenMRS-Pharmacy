<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<div id="order-search-bar">
    <form method="post">
        <div id="orderSearchField">FIND BY ORDER ID: <input type="text" id="search_order_id" name="search_order_id"/></div>
        <div id="orderSearchButton"><input class="confirm right" id="btn-place" name="searchPharmaOrderByOrderID" type="submit"></input></div>
    </form>
</div>