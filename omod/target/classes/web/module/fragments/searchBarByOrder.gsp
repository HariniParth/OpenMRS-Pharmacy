<%
    ui.includeCss("pharmacy", "pharmacy.css")
%>

<div id="order-search-bar">
    <form method="post">
        FIND ORDER BY
        <div id="orderSearchField">ORDER ID: <input id="search_order_id" type="text" name="search_order_id"/>
        <input class="confirm right" id="btn-place" name="searchPharmaOrderByOrderID" type="submit" onclick="searchPharmaOrderByOrderID()"></input></div>
    </form>
</div>