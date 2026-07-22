<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" EnableEventValidation="false" AutoEventWireup="true" Async="true" CodeFile="OrderHistory.aspx.cs" Inherits="OrderHistory" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/sweetalert2@11.6.9/dist/sweetalert2.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.6.9/dist/sweetalert2.min.js"></script>
    <style type="text/css">
        .order-headerss {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }

            /* remove default margin issues */
            .order-headerss h2 {
                margin: 0;
                white-space: nowrap;
            }

        .order-subrow {
            display: flex;
            align-items: center;
            gap: 15px;
        }

            .order-subrow select {
                max-width: 220px;
            }

        /* optional styling for link h2 */
        .product-link a {
            text-decoration: none;
            font-size: 16px;
        }

        /* Mobile responsiveness */
        @media (max-width: 600px) {
            .order-headerss {
                flex-direction: column;
                align-items: stretch; /* was flex-start */
                gap: 12px;
            }

                .order-headerss h2 {
                    white-space: normal;
                }

            .order-subrow {
                width: 100%;
                justify-content: space-between;
                gap: 10px;
            }

                .order-subrow select {
                    max-width: 60%;
                    flex: 1;
                }

                .order-subrow h2 {
                    margin: 0;
                }
        }

        .order-container {
            width: min(1200px,95%);
            margin: auto;
            padding: 20px;
        }

        .order-card {
            background: #fff;
            border-radius: 14px;
            margin-bottom: 20px;
            padding: 18px;
            box-shadow: 0 8px 20px rgba(0,0,0,.08);
            transition: .25s;
        }

            .order-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 15px 35px rgba(0,0,0,.12);
            }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 20px;
            flex-wrap: wrap;
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
            cursor: pointer;
        }

            .order-header:hover {
                background: #fafafa;
            }

            .order-header > div:nth-child(2) {
                flex: 1;
            }

        .order-right {
            display: flex;
            align-items: center;
            gap: 15px;
            flex-wrap: wrap;
        }

        .order-status {
            color: #fff;
            font-size: 14px;
            font-weight: 600;
            padding: 8px 15px;
            border-radius: 40px;
            white-space: nowrap;
        }


        .status-outfordelivery {
            cursor: pointer;
            transition: .2s;
        }

            .status-outfordelivery:hover {
                transform: scale(1.05);
                box-shadow: 0 0 8px rgba(34,197,94,.4);
            }

        .status-placed {
            background: #F59E0B;
            color: #fff;
        }

        .status-hold {
            background: #6B7280;
            color: #fff;
        }

        .status-approved {
            background: #2563EB;
            color: #fff;
        }

        .status-design {
            background: #8B5CF6;
            color: #fff;
        }

        .status-production {
            background: #F97316;
            color: #fff;
        }

        .status-packed {
            background: #06B6D4;
            color: #fff;
        }

        .status-dispatched {
            background: #14B8A6;
            color: #fff;
        }

        .status-outfordelivery {
            background: #22C55E;
            color: #fff;
        }

        .status-rejected {
            background: #DC2626;
            color: #fff;
        }

        .pdf-link {
            width: 42px;
            height: 42px;
            display: flex;
            justify-content: center;
            align-items: center;
            border-radius: 50%;
            background: #f4f6f9;
            transition: .2s;
            text-decoration: none;
        }

            .pdf-link:hover {
                background: #dbe9ff;
                transform: scale(1.08);
            }

            .pdf-link i {
                font-size: 24px;
            }

        .progress-ring {
            position: relative;
            width: 46px;
            height: 46px;
        }

            .progress-ring svg {
                width: 46px;
                height: 46px;
                transform: rotate(-90deg);
            }

        .progress-bg {
            stroke: #ddd;
            stroke-width: 4;
            fill: none;
        }

        .progress-fill {
            stroke-width: 4;
            fill: none;
            stroke-linecap: round;
        }

        .progress-text {
            position: absolute;
            inset: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 10px;
            font-weight: bold;
        }

        .products-container {
            margin-top: 18px;
            display: grid;
            grid-template-columns: repeat(auto-fit,minmax(320px,1fr));
            gap: 18px;
        }

        .product-row {
            display: flex;
            gap: 15px;
            padding: 12px;
            border-radius: 10px;
            border: 1px solid #eee;
            transition: .25s;
            background: #fff;
        }

            .product-row:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 18px rgba(0,0,0,.08);
                border-color: #0d6efd;
            }

            .product-row img {
                width: 80px;
                height: 80px;
                object-fit: cover;
                border-radius: 8px;
                cursor: pointer;
            }

        .product-info {
            flex: 1;
        }

        .product-name {
            font-weight: 600;
            font-size: 16px;
            margin-bottom: 6px;
        }

        .product-meta {
            color: #666;
            font-size: 13px;
            margin-top: 3px;
        }

        .product-note {
            margin-top: 8px;
            background: #f7f9fc;
            padding: 8px;
            border-radius: 8px;
            font-size: 12px;
        }

        .order-details {
            display: none;
            margin-top: 18px;
        }

        .img-modal {
            display: none;
            position: fixed;
            inset: 0;
            background: rgba(0,0,0,.85);
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

            .img-modal img {
                max-width: 90%;
                max-height: 90%;
                border-radius: 12px;
            }

        @media(max-width:768px) {

            .order-container {
                padding: 10px;
            }

            .order-header {
                flex-direction: column;
                align-items: flex-start;
            }

            .order-right {
                width: 100%;
                justify-content: space-between;
            }

            .products-container {
                grid-template-columns: 1fr;
            }

            .product-row {
                align-items: flex-start;
            }

                .product-row img {
                    width: 70px;
                    height: 70px;
                }

            .order-status {
                font-size: 13px;
            }

            .pdf-link {
                width: 38px;
                height: 38px;
            }
        }

        @media(max-width:480px) {

            .order-right {
                flex-wrap: wrap;
                gap: 10px;
            }

            .order-status {
                width: 100%;
                text-align: center;
            }

            .progress-ring {
                margin-left: auto;
            }

            .pdf-link {
                margin-left: auto;
            }
        }
    </style>
    <script type="text/javascript">
        let allOrdersData = [];
        $(document).ready(function () {
            loadOrders();
        });

        function toggleOrder(orderId) {
            $("#details_" + orderId).slideToggle();

            let icon = $("#icon_" + orderId);

            if (icon.text() === "▼")
                icon.text("▲");
            else
                icon.text("▼");

        }

        function loadOrders() {
            $.ajax({
                type: "POST",
                url: "OrderHistory.aspx/GetOrders",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (response) {
                    let orders = response.d;

                    allOrdersData = orders || [];

                    if (allOrdersData.length > 0) {
                        $("#ddlStatusFilter").show();
                        applyStatusColor($("#ddlStatusFilter").val());
                    } else {
                        $("#ddlStatusFilter").hide();
                        $("#ddlStatusFilter").val(""); // reset filter if list becomes empty
                    }

                    renderOrders(allOrdersData);
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }

        const statusColorMap = {
            "": { bg: "#fff", text: "#333" },
            "Order Placed": { bg: "#F59E0B", text: "#F59E0B" },
            "Order Hold": { bg: "#6B7280", text: "#6B7280" },
            "Order Approved": { bg: "#2563EB", text: "#2563EB" },
            "Design Approved": { bg: "#8B5CF6", text: "#8B5CF6" },
            "Production Started": { bg: "#F97316", text: "#F97316" },
            "Order Packed": { bg: "#06B6D4", text: "#06B6D4" },
            "Order Dispatched": { bg: "#14B8A6", text: "#14B8A6" },
            "Out for Delivery": { bg: "#22C55E", text: "#22C55E" },
            "Delivered": { bg: "#22C55E", text: "#22C55E" },
            "Order Rejected": { bg: "#DC2626", text: "#DC2626" },
            "Order Canceled": { bg: "#DC2626", text: "#DC2626" }
        };

        function applyStatusColor(status) {
            let colors = statusColorMap[status] || statusColorMap[""];
            $("#ddlStatusFilter").css({
                "color": colors.text,
                "border-color": colors.bg
            });
        }

        function onStatusFilterChange() {
            let selectedStatus = $("#ddlStatusFilter").val();

            applyStatusColor(selectedStatus);

            if (selectedStatus === "") {
                renderOrders(allOrdersData);
            } else {
                let filtered = allOrdersData.filter(o => o.OrderStatus === selectedStatus);
                renderOrders(filtered);
            }
        }

        function renderOrders(orders) {

            let html = "";

            if (!orders || orders.length === 0) {

                let isFiltered = $("#ddlStatusFilter").val() !== "";

                html = isFiltered ? `
                    <div class="text-center py-5">
                        <i class="bi bi-filter-circle" style="font-size:70px;color:#c0c0c0;"></i>
                        <h4 class="mt-3 text-secondary">No Orders Found</h4>
                        <p class="text-muted">No orders match this status.</p>
                    </div>
                ` : `
                    <div class="text-center py-5">
                        <i class="bi bi-bag-x-fill" style="font-size:70px;color:#c0c0c0;"></i>
                        <h4 class="mt-3 text-secondary">No Orders Yet</h4>
                        <p class="text-muted">You haven't placed any orders yet.</p>
                        <a href="/Admin/PlaceOrder.aspx" class="btn btn-primary mt-2">Place Your First Order</a>
                    </div>
                `;

                $("#orderList").html(html);
                return;
            }

            orders.forEach(o => {
                let statusClass = "";
                let progress = 0;
                let progressColor = "";

                if (o.OrderStatus === "Order Placed") {
                    statusClass = "status-placed";
                    progress = 0;
                    progressColor = "#F59E0B";      // Orange
                }
                else if (o.OrderStatus === "Order Hold") {
                    statusClass = "status-hold";
                    progress = 0;
                    progressColor = "#6B7280";      // Gray
                }
                else if (o.OrderStatus === "Order Approved") {
                    statusClass = "status-approved";
                    progress = 20;
                    progressColor = "#2563EB";      // Blue
                }
                else if (o.OrderStatus === "Design Approved") {
                    statusClass = "status-design";
                    progress = 40;
                    progressColor = "#8B5CF6";      // Purple
                }
                else if (o.OrderStatus === "Production Started") {
                    statusClass = "status-production";
                    progress = 60;
                    progressColor = "#F97316";      // Orange-Red
                }
                else if (o.OrderStatus === "Order Packed") {
                    statusClass = "status-packed";
                    progress = 80;
                    progressColor = "#06B6D4";      // Cyan
                }
                else if (o.OrderStatus === "Order Dispatched") {
                    statusClass = "status-dispatched";
                    progress = 90;
                    progressColor = "#14B8A6";      // Teal
                }
                else if (o.OrderStatus === "Out for Delivery" || o.OrderStatus === "Delivered") {
                    statusClass = "status-outfordelivery";
                    progress = 100;
                    progressColor = "#22C55E";      // Green
                }
                else if (o.OrderStatus === "Order Rejected" || o.OrderStatus === "Order Canceled") {
                    statusClass = "status-rejected";
                    progress = 100;
                    progressColor = "#DC2626";      // Red
                }

                let tallyRefHtml = "";

                if (o.TallyRefNo && o.TallyRefNo.trim() !== "") {
                    tallyRefHtml = `
                        <span style="color:red;background: #f9fd0ad1;font-size:17px;">
                            <b>Work Order: ${o.TallyRefNo}</b>
                        </span>
                        <br/>
                    `;
                }
                html += `
                    <div class="order-card" style="position:relative;">
                     ${o.OrderStatus === "Order Placed" || o.OrderStatus === "Order Approved"
                        || o.OrderStatus === "Design Approved" ? `
                     <div class="position-absolute d-flex gap-2"
                             style="top:10px; right:10px; z-index:10;">

                                    <button class="btn btn-primary btn-sm" title="Hold Order"
                                            onclick="event.stopPropagation(); holdOrder('${o.ID}' ,'${o.WoID}')">
                                        <i class="bi bi-pause-circle"></i>
                                    </button>

                                    <button class="btn btn-danger btn-sm" title="Cancel Order"
                                            onclick="event.stopPropagation(); cancelOrder('${o.ID}' ,'${o.WoID}')">
                                        <i class="bi bi-x-circle"></i>
                                    </button>                       
                        </div>
                         ` : ""}
                        <br/>
                        <div class="order-header" onclick="toggleOrder('${o.ID}')">

                            <span id="icon_${o.ID}">▼</span>

                            <div>
                                ${tallyRefHtml}
                                <b>Order ID: </b> ${o.OrderID}<br/>
                                <small>Placed on: ${o.CreatedDate}</small>
                            </div>

                            
                            <div class="order-right">
         
                               <div class="order-status ${statusClass}"
                                    title="${o.OrderStatus !== 'Order Rejected' && o.OrderStatus !== 'Order Canceled'
                        ? 'Click when you receive the order'
                        : ''}"
                                    ${o.OrderStatus === "Out for Delivery"
                        ? `style="cursor:pointer;"
                                                       onclick="event.stopPropagation(); confirmDelivery('${o.ID}','${o.WoID}')"`
                        : ""}>
                                    ${o.OrderStatus}
                                </div>

                               <a href="${o.AttachedPath ? '/Content/' + o.AttachedPath.replace('~/', '') : 'javascript:void(0)'}"
                                   ${o.AttachedPath ? 'target="_blank"' : ''}
                                   onclick="${o.AttachedPath ? 'event.stopPropagation();' : 'return false;'}"
                                   title="${o.AttachedPath ? 'Attached Order' : 'No Order Available'}"
                                   class="pdf-link"
                                   style="${!o.AttachedPath ? 'pointer-events:none;cursor:not-allowed;opacity:.7;' : ''}">
                                    <i class="bi bi-file-earmark-pdf-fill"
                                       style="color:${o.AttachedPath ? '#0d6efd' : '#dc3545'}">
                                    </i>
                                </a>

                                ${(o.TallyRefNo && o.TallyRefNo.trim() !== "") ? `

                                <a href="${o.Invoicepath ? '/Content/' + o.Invoicepath.replace('~/', '') : 'javascript:void(0)'}"
                                   ${o.Invoicepath ? 'target="_blank"' : ''}
                                   onclick="${o.Invoicepath ? 'event.stopPropagation();' : 'return false;'}"
                                   title="${o.Invoicepath ? 'Invoice' : 'No Invoice Available'}"
                                   class="pdf-link"
                                   style="${!o.Invoicepath ? 'pointer-events:none;cursor:not-allowed;opacity:.7;' : ''}">
                                    <i class="bi bi-receipt"
                                       style="color:${o.Invoicepath ? '#0d6efd' : '#dc3545'}"></i>
                                </a>

                                <a href="${o.Lrpath ? '/Content/' + o.Lrpath.replace('~/', '') : 'javascript:void(0)'}"
                                   ${o.Lrpath ? 'target="_blank"' : ''}
                                   onclick="${o.Lrpath ? 'event.stopPropagation();' : 'return false;'}"
                                   title="${o.Lrpath ? 'LR Copy' : 'No LR Copy Available'}"
                                   class="pdf-link"
                                   style="${!o.Lrpath ? 'pointer-events:none;cursor:not-allowed;opacity:.7;' : ''}">
                                    <i class="bi bi-truck"
                                       style="color:${o.Lrpath ? '#198754' : '#dc3545'}"></i>
                                </a>

                                ` : ""
                    }

                               <div class="progress-ring">

                                <svg viewBox="0 0 40 40">

                                    <circle
                                        class="progress-bg"
                                        cx="20"
                                        cy="20"
                                        r="16">
                                    </circle>

                                    <circle
                                        class="progress-fill"
                                        cx="20"
                                        cy="20"
                                        r="16"
                                        stroke="${progressColor}"
                                        stroke-dasharray="100"
                                        stroke-dashoffset="${100 - progress}">
                                    </circle>

                                </svg>

                                <div class="progress-text"
                                     style="color:${progressColor}">
                                     ${progress}%
                                </div>

                            </div>

                        </div>

                        </div>

                        <div id="details_${o.ID}" class="order-details">

                            <div>
                                <b>Estimated Delivery:</b>
                                ${o.EstimatedDeliveryDate ?? 'Not Updated'}
                            </div>

                            <div class="products-container">
                    `;

                o.Products.forEach(p => {
                    var Image = '/Content/' + p.ImagePathName.replace('~/', '');

                    html += `
                        <div class="product-row">

                            <img src="${Image}" onclick="openModal('${Image}')" />

                            <div class="product-info">
                                <div class="product-name">${p.ProductName}</div>
                        `;

                    if (p.ProductNote && p.ProductNote.trim() !== "") {
                        html += `
                            <div class="product-note">
                                ${p.ProductNote}
                            </div>
                        `;
                    }

                    html += `
                            <div class="product-meta">
                                Type: ${p.ProductType} | Size: ${p.Size}
                            </div>

                            <div class="product-meta">
                                Qty: ${p.Qty}
                            </div>
                        </div>
                    </div>
                    `;
                });

                html += `
                        </div>
                    </div>
                    </div>
                    `;
            });

            $("#orderList").html(html);
        }

        function confirmDelivery(orderId, woId) {

            Swal.fire({
                title: "Confirm Delivery",
                text: "Has this order been delivered to you?",
                icon: "question",
                showCancelButton: true,
                confirmButtonText: "Yes, Delivered",
                cancelButtonText: "No"
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        type: "POST",
                        url: "OrderHistory.aspx/ConfirmDelivery", // Change to your method
                        contentType: "application/json; charset=utf-8",
                        data: JSON.stringify({
                            orderId: orderId,
                            WorkOId: woId
                        }),
                        dataType: "json",
                        success: function (res) {

                            alert("Thank you for confirming delivery.");

                            // Reload orders
                            loadOrders(); // Your existing function
                        },
                        error: function () {
                            alert("Something went wrong. Please try again.");
                        }
                    });
                }
            });
        }

        function holdOrder(orderId, WorkOId) {

            if (!confirm("Hold this order?"))
                return;

            $.ajax({
                type: "POST",
                url: "OrderHistory.aspx/holdOrder",
                data: JSON.stringify({ orderId: orderId, WorkOId: WorkOId }),
                contentType: "application/json; charset=utf-8",
                success: function () {
                    window.location.href = window.location.href;
                }
            });
        }

        function cancelOrder(orderId, WorkOId) {

            if (!confirm("Cancel this order?"))
                return;

            $.ajax({
                type: "POST",
                url: "OrderHistory.aspx/CancelOrder",
                data: JSON.stringify({ orderId: orderId, WorkOId: WorkOId }),
                contentType: "application/json; charset=utf-8",
                success: function () {
                    window.location.href = window.location.href;
                }
            });
        }

        function openModal(src) {

            document.getElementById("imgModal")
                .style.display = "flex";

            document.getElementById("modalImg")
                .src = src;
        }

        function closeModal() {

            document.getElementById("imgModal")
                .style.display = "none";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="order-container">
                <div class="order-headerss">
                    <h2 class="fw-bold">My Orders</h2>

                    <div class="order-subrow">
                        <select id="ddlStatusFilter"
                            class="form-select"
                            style="display: none;"
                            onchange="onStatusFilterChange()">
                            <option value="" style="color: #333;">All Orders</option>
                            <option value="Order Placed" style="color: #F59E0B;">Order Placed</option>
                            <option value="Order Hold" style="color: #6B7280;">Order Hold</option>
                            <option value="Order Approved" style="color: #2563EB;">Order Approved</option>
                            <option value="Design Approved" style="color: #8B5CF6;">Design Approved</option>
                            <option value="Production Started" style="color: #F97316;">Production Started</option>
                            <option value="Order Packed" style="color: #06B6D4;">Order Packed</option>
                            <option value="Order Dispatched" style="color: #14B8A6;">Order Dispatched</option>
                            <option value="Out for Delivery" style="color: #22C55E;">Out for Delivery</option>
                            <option value="Delivered" style="color: #22C55E;">Delivered</option>
                            <option value="Order Rejected" style="color: #DC2626;">Order Rejected</option>
                            <option value="Order Canceled" style="color: #DC2626;">Order Canceled</option>
                        </select>

                        <h2 class="product-link">
                            <a href="/Admin/PlaceOrder.aspx"><i>Product List</i></a>
                        </h2>
                    </div>
                </div>
                <br />
                <br />
                <div id="orderList"></div>
            </div>

            <div id="imgModal"
                class="img-modal"
                onclick="closeModal()">

                <img id="modalImg">
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
