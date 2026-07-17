<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" EnableEventValidation="false" AutoEventWireup="true" Async="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <style type="text/css">
        .dashboard {
            padding: 25px;
            background: #f5f7fb;
        }

        .dashboard-card {
            background: #fff;
            border-radius: 18px;
            padding: 22px;
            box-shadow: inset 7px 0px 3px 0px rgb(27 70 157);
            margin-bottom: 27px;
            transition: .3s;
            border: 1px solid #0a287c;
        }

            .dashboard-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 30px rgba(0,0,0,.12);
            }

        .card-top {
            display: flex;
            align-items: flex-start;
        }

        .icon-box {
            width: 58px;
            height: 58px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
            font-size: 26px;
            margin-right: 18px;
        }

        .blue {
            background: #2F6BFF;
        }

        .green {
            background: #18B663;
        }

        .purple {
            background: #B43AD7;
        }

        .red {
            background: #F5515F;
        }

        .orange {
            background: #FFA329;
        }

        .sky {
            background: #15B5E9;
        }

        .card-content {
            flex: 1;
        }

        .card-title {
            font-size: 22px;
            font-weight: 700;
            color: #f75d00;
        }

        .list-item {
            font-size: 16px;
            color: #000000;
            margin: 8px 0;
            font-weight: 500;
        }

        .value {
            font-size: 26px;
            font-weight: 700;
            color: #20243d;
        }

        .progress {
            height: 8px;
            border-radius: 30px;
            background: #eceff6;
            margin-top: 10px;
        }

        .progress-bar {
            background: #3d73ff;
        }

        .percent {
            float: right;
            color: #2F6BFF;
            font-weight: 600;
            margin-top: 5px;
        }

        .chart-card {
            background: #fff;
            border-radius: 18px;
            padding: 20px;
            box-shadow: 0 2px 15px rgba(0,0,0,.08);
        }

        .section-title {
            font-size: 22px;
            font-weight: 700;
            margin-bottom: 20px;
            color: #23304f;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="container-fluid dashboard">
                <div class="row">
                    <!-- LEFT SIDE -->
                    <div class="col-lg-8">
                        <div class="row">
                            <!-- Stage 1 -->
                            <div class="col-md-6">

                                <div class="dashboard-card">

                                    <div class="card-top">

                                        <div class="icon-box blue">
                                            <i class="bi bi-gear"></i>
                                        </div>

                                        <div class="card-content">

                                            <div class="card-title">
                                                Stage 1 %
                                            </div>

                                            <asp:Repeater ID="rptMachines" runat="server">
                                                <ItemTemplate>

                                                    <div class="list-item">
                                                        <%# Eval("DisplayText") %>
                                                    </div>

                                                </ItemTemplate>
                                            </asp:Repeater>

                                            <div class="progress mt-2">
                                                <div class="progress-bar bg-primary" style="width: 27%"></div>
                                            </div>

                                            <div class="text-end mt-1 text-primary fw-bold">
                                                27.50%
                                            </div>

                                        </div>

                                    </div>

                                </div>

                            </div>

                            <!-- Stage 2 -->
                            <div class="col-md-6">

                                <div class="dashboard-card">

                                    <div class="card-top">

                                        <div class="icon-box blue">
                                            <i class="bi bi-gear"></i>
                                        </div>

                                        <div class="card-content">

                                            <div class="card-title">
                                                Stage 2 %
                                            </div>

                                            <asp:Repeater ID="rptStage2Machines" runat="server">
                                                <ItemTemplate>

                                                    <div class="list-item">
                                                        <%# Eval("DisplayText") %>
                                                    </div>

                                                </ItemTemplate>
                                            </asp:Repeater>

                                            <div class="progress mt-2">
                                                <div class="progress-bar bg-success" style="width: 38%"></div>
                                            </div>

                                            <div class="text-end mt-1 text-success fw-bold">
                                                37.50%
                                            </div>

                                        </div>

                                    </div>

                                </div>

                            </div>
                        </div>

                        <!-- Packaging / Rejected -->

                        <div class="row">

                            <div class="col-md-6">

                                <div class="dashboard-card">

                                    <div class="card-top">

                                        <div class="icon-box purple">
                                            <i class="bi bi-box-seam"></i>
                                        </div>

                                        <div class="card-content">

                                            <div class="card-title">
                                                Packaging %
                                            </div>

                                            <div class="value">
                                                <asp:Label ID="lblPackaging" runat="server"></asp:Label>
                                            </div>

                                        </div>

                                    </div>

                                </div>

                            </div>

                            <div class="col-md-6">

                                <div class="dashboard-card">

                                    <div class="card-top">

                                        <div class="icon-box red">
                                            <i class="bi bi-x-octagon"></i>
                                        </div>

                                        <div class="card-content">

                                            <div class="card-title">
                                                Rejected Count
                                            </div>

                                            <div class="value">
                                                <asp:Label ID="lblRejectedCount" runat="server"></asp:Label>
                                            </div>

                                        </div>

                                    </div>

                                </div>

                            </div>

                        </div>

                        <!-- Dispatch / Production -->

                        <div class="row">

                            <div class="col-md-6">

                                <div class="dashboard-card">

                                    <div class="card-top">

                                        <div class="icon-box sky">
                                            <i class="bi bi-clipboard-check"></i>
                                        </div>

                                        <div class="card-content">

                                            <div class="card-title">
                                                Work Order Dispatch
                                            </div>

                                            <div class="value">
                                                <asp:Label ID="lblDispatchCount" runat="server"></asp:Label>
                                            </div>

                                        </div>

                                    </div>

                                </div>

                            </div>

                            <div class="col-md-6">

                                <div class="dashboard-card">

                                    <div class="card-top">

                                        <div class="icon-box purple">
                                            <i class="bi bi-building"></i>
                                        </div>

                                        <div class="card-content">

                                            <div class="card-title">
                                                Monthly Production
                                            </div>

                                            <div class="value">
                                                <asp:Label ID="lblMonthlyProduction" runat="server"></asp:Label>
                                            </div>

                                        </div>

                                    </div>

                                </div>

                            </div>

                        </div>

                        <!-- Dispatch Days / Dealers -->

                        <div class="row">

                            <div class="col-md-6">

                                <div class="dashboard-card">

                                    <div class="card-top">

                                        <div class="icon-box orange">
                                            <i class="bi bi-calendar-event"></i>
                                        </div>

                                        <div class="card-content">

                                            <div class="card-title">
                                                Average Dispatch Days
                                            </div>

                                            <div class="value">
                                                -
                                            </div>

                                        </div>

                                    </div>

                                </div>

                            </div>

                            <div class="col-md-6">

                                <div class="dashboard-card">

                                    <div class="card-top">

                                        <div class="icon-box blue">
                                            <i class="bi bi-people"></i>
                                        </div>

                                        <div class="card-content">

                                            <div class="card-title">
                                                No. Of Dealers
                                            </div>

                                            <div class="value">
                                                <asp:Label ID="lblDealerCount" runat="server"></asp:Label>
                                            </div>

                                        </div>

                                    </div>

                                </div>

                            </div>

                        </div>

                    </div>


                    <!-- RIGHT SIDE -->

                    <div class="col-lg-4">

                        <!-- Down Time -->

                        <div class="dashboard-card">

                            <div class="card-top">

                                <div class="icon-box orange">
                                    <i class="bi bi-clock-history"></i>
                                </div>

                                <div class="card-content">

                                    <div class="card-title">
                                        Down Time
                                    </div>

                                    <asp:Repeater ID="rptDownTime" runat="server">
                                        <ItemTemplate>

                                            <div class="list-item">
                                                <%# Eval("MachineName") %> -
                                                <%# Eval("TotalDownTime") %> hr
                                            </div>

                                        </ItemTemplate>
                                    </asp:Repeater>

                                </div>

                            </div>

                        </div>

                        <!-- Productivity -->

                        <div class="dashboard-card">
                            <div class="card-top">
                                <div class="icon-box sky">
                                    <i class="bi bi-bar-chart"></i>
                                </div>
                                <div class="card-content">
                                    <div class="card-title">
                                        Productivity
                                    </div>
                                    <asp:Repeater ID="rptProductivity" runat="server">
                                        <ItemTemplate>
                                            <div class="list-item">
                                                <%# Eval("DisplayText") %>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                        <!-- Orders -->

                        <div class="dashboard-card">

                            <div class="card-top">

                                <div class="icon-box green">
                                    <i class="bi bi-card-checklist"></i>
                                </div>

                                <div class="card-content">

                                    <div class="card-title">
                                        Orders
                                    </div>

                                    <div class="list-item">
                                        New Orders -
                                        <asp:Label ID="lblNewOrders" runat="server" Text="0"></asp:Label>
                                    </div>

                                    <div class="list-item">
                                        Pending Orders -
                                        <asp:Label ID="lblPendingOrders" runat="server" Text="0"></asp:Label>
                                    </div>

                                    <div class="list-item">
                                        Over Due Orders -
                                        <asp:Label ID="lblOverDueOrders" runat="server" Text="0"></asp:Label>
                                    </div>

                                </div>

                            </div>

                        </div>

                    </div>

                </div>

                <!-- Charts -->
                <div class="row mt-3 d-none">

                    <div class="col-md-6">

                        <div class="dashboard-card">

                            <div class="card-title mb-3">
                                Monthly Production (Sq.ft)
                            </div>

                            <canvas id="productionChart" height="120"></canvas>

                        </div>

                    </div>

                    <div class="col-md-6">

                        <div class="dashboard-card">

                            <div class="card-title mb-3">
                                Work Order Dispatch Trend
                            </div>

                            <canvas id="dispatchChart" height="120"></canvas>

                        </div>

                    </div>

                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
