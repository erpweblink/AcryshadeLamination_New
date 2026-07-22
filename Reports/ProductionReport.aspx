<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProductionReport.aspx.cs" Inherits="Reports_ProductionReport" MasterPageFile="~/MasterPage.master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .completionList {
            scroll-behavior: smooth;
            border: solid 1px Gray;
            border-radius: 0 0 6px 6px;
            margin: 0px;
            padding: 3px;
            height: 200px;
            overflow: auto;
            width: 500px;
            background-color: #FFFFFF;
            font-size: 16px;
        }

        .listItem {
            color: #191919;
        }

        .itemHighlighted {
            background-color: #5b78b1;
            font-weight: 900;
        }

        .completionList {
            scroll-behavior: smooth;
            border: solid 1px Gray;
            border-radius: 0 0 6px 6px;
            margin: 0px;
            padding: 3px;
            height: 200px;
            overflow: auto;
            width: 500px;
            background-color: #FFFFFF;
            font-size: 16px;
        }

        .listItem {
            color: #191919;
        }

        .itemHighlighted {
            background-color: #5b78b1;
            font-weight: 900;
        }

        .error-border {
            border: 2px solid red !important;
        }

        .error-msg {
            min-height: 14px;
            margin-top: 2px;
        }
    </style>
</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server"></asp:ToolkitScriptManager>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="card">
                <div class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
                    <h3 class="m-0 font-weight-bold"><b>Production Report</b></h3>
                    <asp:Button ID="btnExportExcel" runat="server" Text="Export To Excel"
                        CssClass="btn btn-outline-success" OnClick="btnExportExcel_Click" />
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <div class="row">
                            <div class="col-md-2">
                                <label>Product</label>
                                <asp:TextBox ID="txtproduct" runat="server"
                                    CssClass="form-control"
                                    AutoPostBack="true" OnTextChanged="txtproduct_TextChanged">
                                </asp:TextBox>
                                <asp:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" CompletionListCssClass="completionList"
                                    CompletionListHighlightedItemCssClass="itemHighlighted" CompletionListItemCssClass="listItem"
                                    CompletionInterval="10" MinimumPrefixLength="1" ServiceMethod="GetproductList"
                                    TargetControlID="txtproduct" Enabled="true">
                                </asp:AutoCompleteExtender>
                            </div>
                            <div class="col-md-2">
                                <label>Machine</label>
                                <asp:DropDownList ID="ddlMachine" runat="server"
                                    CssClass="form-control"
                                    AutoPostBack="true" OnSelectedIndexChanged="ddlMachine_SelectedIndexChanged">
                                </asp:DropDownList>


                            </div>
                            <div class="col-md-2">
                                <label>Delivery Status</label>
                                <asp:DropDownList ID="ddlDeliveryStatus" runat="server"
                                    CssClass="form-control"
                                    AutoPostBack="true" OnSelectedIndexChanged="ddlDeliveryStatus_SelectedIndexChanged">
                                    <asp:ListItem Value="">All</asp:ListItem>
                                    <asp:ListItem Value="Overdue">Overdue</asp:ListItem>
                                    <asp:ListItem Value="Not Overdue">Not Overdue</asp:ListItem>
                                </asp:DropDownList>
                            </div>

                            <div class="col-md-3">
                                <label>Dealer</label>
                                <asp:TextBox ID="txtDealer" CssClass="form-control" runat="server" Width="100%" autocomplete="off" OnTextChanged="txtDealer_TextChanged" AutoPostBack="true"></asp:TextBox>
                                <asp:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" CompletionListCssClass="completionList"
                                    CompletionListHighlightedItemCssClass="itemHighlighted" CompletionListItemCssClass="listItem"
                                    CompletionInterval="10" MinimumPrefixLength="1" ServiceMethod="GetCompanyList"
                                    TargetControlID="txtDealer" Enabled="true">
                                </asp:AutoCompleteExtender>
                            </div>
                            <div class="col-md-2">
    <label>Status</label>
    <asp:DropDownList ID="ddlstatus" runat="server"
        CssClass="form-control"
        AutoPostBack="true" OnSelectedIndexChanged="ddlstatus_SelectedIndexChanged" >
        <asp:ListItem Value="">All</asp:ListItem>
        <asp:ListItem Value="Pending">Pending</asp:ListItem>
        <asp:ListItem Value="Dispatched">Dispatched</asp:ListItem>
    </asp:DropDownList>

</div>
                        </div>

                        
                        <br />
                        <asp:GridView ID="GvProduction" runat="server"
                            AutoGenerateColumns="False"
                            EmptyDataText="Record Not Found"
                            CssClass="table table-bordered">

                            <Columns>

                                <asp:BoundField DataField="Dealer" HeaderText="Dealer" />
                                <asp:BoundField DataField="TallyRefNo" HeaderText="Work Order No." />
                                <asp:BoundField DataField="ProductName" HeaderText="Product Name" />
                                <asp:BoundField DataField="TotalQty" HeaderText="Total Qty" />
                                <asp:BoundField DataField="TotalSqFeet" HeaderText="Total SqFeet" />
                                <asp:BoundField DataField="ProductionStatus" HeaderText="Production Status" />
                                <asp:BoundField DataField="DispatchStatus" HeaderText="Dispatch Status" />
                                <asp:BoundField DataField="DeliveryStatus" HeaderText="Delivery Status" />
                            </Columns>

                        </asp:GridView>
                    </div>
                </div>
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnExportExcel" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
