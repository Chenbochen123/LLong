<%@ page language="C#" autoeventwireup="true" inherits="Plugins_Semis_Reports_Zero, Mesnac.Semis.WebSite" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell {
            background-color: #B0FFBA !important;
        }
    </style>
    <script type="text/javascript">

        var startTrack = function () {
            this.checkboxes = [];
            var cb;

            Ext.select(".x-form-item", false).each(function (checkEl) {
                cb = Ext.getCmp(checkEl.dom.id.selected);
                cb.setValue(false);
                this.rowselect.push(cb);
            }, this);
        };
        var pnlListFresh = function () {
            App.pnlList.store.reload();
            return false;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmFcheckInfo" runat="server" />
        <ext:Viewport ID="vpFcheckInfo" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnFcheckInfo" runat="server" Region="North" Height="90">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbFcheckInfo">
                            <Items>
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <Listeners>
                                        <Click Fn="pnlListFresh" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="tsMid" />
                                <ext:Button runat="server" Icon="PageExcel" Text="导出Excel" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="tsEnd" />
                                <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                                <ext:ToolbarFill ID="tfEnd" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".2"
                                    Padding="5">
                                    <Items>
                                        <ext:DateField ID="txtBeginDate" FieldLabel="生产日期" runat="server" LabelAlign="Right" Flex="1" Editable="false" />

                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".2"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox runat="server" ID="cmbEquip" Visible="false" Editable="false" FieldLabel="工序" LabelAlign="Right"></ext:ComboBox>
                                    </Items>
                                </ext:Container>
                            </Items>
                            <Listeners>
                                <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="pnlDetail" runat="server" Region="Center" Title="零度计划报表" Height="250" Icon="Basket" Layout="Fit" Collapsible="true"
                    Split="true" MarginsSummary="0 5 5 5" AutoScroll="true">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server" MarginsSummary="0 5 5 5">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="10">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="BANCHAN" />
                                                <ext:ModelField Name="REQUIREMENTS" />
                                                <ext:ModelField Name="SAFE_STOCKS" />
                                                <ext:ModelField Name="SHIFT_STOCKS" />
                                                <ext:ModelField Name="CIRCULATION_COEFFCIENT" />
                                                <ext:ModelField Name="ZHONG_PLAN_AMOUNT" />
                                                <ext:ModelField Name="ZHONG_REAL_AMOUNT" />
                                                <ext:ModelField Name="ZHONG_ORDER" />
                                                <ext:ModelField Name="ZHONG_RATE" />
                                                <ext:ModelField Name="YE_PLAN_AMOUNT" />
                                                <ext:ModelField Name="YE_REAL_AMOUNT" />
                                                <ext:ModelField Name="YE_ORDER" />
                                                <ext:ModelField Name="YE_RATE" />
                                                <ext:ModelField Name="ZAO_PLAN_AMOUNT" />
                                                <ext:ModelField Name="ZAO_REAL_AMOUNT" />
                                                <ext:ModelField Name="ZAO_ORDER" />
                                                <ext:ModelField Name="ZAO_RATE" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="materialName" runat="server" Text="规格" DataIndex="MATERIAL_NAME" Width="180" />
                                    <ext:Column ID="banChan" runat="server" Text="成型班计划" DataIndex="BANCHAN" Width="60" />
                                    <ext:Column ID="requirements" runat="server" Text="成型班用量" DataIndex="REQUIREMENTS" Width="100" />
                                    <ext:Column ID="safeStocks" runat="server" Text="安全库存" DataIndex="SAFE_STOCKS" Width="60" />
                                    <ext:Column ID="shiftStocks" runat="server" Text="库存" DataIndex="SHIFT_STOCKS" Width="60" />
                                    <ext:Column ID="coeffcient" runat="server" Text="循环系数" DataIndex="CIRCULATION_COEFFCIENT" Width="60" />
                                    <ext:Column ID="zhong" runat="server" Text="中班（16：00-24:00）">
                                        <Columns>
                                            <ext:Column ID="ZHONG_PLAN_AMOUNT" runat="server" Text="计划" DataIndex="ZHONG_PLAN_AMOUNT" Width="60">
                                            </ext:Column>
                                            <ext:Column ID="ZHONG_REAL_AMOUNT" runat="server" Text="完成" DataIndex="ZHONG_REAL_AMOUNT" Width="60">
                                            </ext:Column>
                                             <ext:Column ID="ZHONG_RATE" runat="server" Text="完成率" DataIndex="ZHONG_REASON" Width="60">
                                            </ext:Column>
                                            <ext:Column ID="ZHONG_ORDER" runat="server" Text="顺序" DataIndex="ZHONG_ORDER" Width="60">
                                            </ext:Column>
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column ID="ye" runat="server" Text="夜班（00：00-08:00）">
                                        <Columns>
                                            <ext:Column ID="YE_PLAN_AMOUNT" runat="server" Text="计划" DataIndex="YE_PLAN_AMOUNT" Width="60">
                                            </ext:Column>
                                            <ext:Column ID="YE_REAL_AMOUNT" runat="server" Text="完成" DataIndex="YE_REAL_AMOUNT" Width="60">
                                            </ext:Column>
                                             <ext:Column ID="YE_RATE" runat="server" Text="完成率" DataIndex="YE_REASON" Width="60">
                                            </ext:Column>
                                            <ext:Column ID="YE_ORDER" runat="server" Text="顺序" DataIndex="YE_ORDER" Width="60">
                                            </ext:Column>
                                        </Columns>
                                    </ext:Column>
                                    <ext:Column ID="Column6" runat="server" Text="白班（08：00-16:00）">
                                        <Columns>
                                            <ext:Column ID="ZAO_PLAN_AMOUNT" runat="server" Text="计划" DataIndex="ZAO_PLAN_AMOUNT" Width="60">
                                            </ext:Column>
                                            <ext:Column ID="ZAO_REAL_AMOUNT" runat="server" Text="完成" DataIndex="ZAO_REAL_AMOUNT" Width="60">
                                            </ext:Column>
                                             <ext:Column ID="ZAO_RATE" runat="server" Text="完成率" DataIndex="ZAO_REASON" Width="60">
                                            </ext:Column>
                                            <ext:Column ID="ZAO_ORDER" runat="server" Text="顺序" DataIndex="ZAO_ORDER" Width="60">
                                            </ext:Column>
                                        </Columns>
                                    </ext:Column>
                                </Columns>
                            </ColumnModel>
                            <SelectionModel>
                                <ext:RowSelectionModel ID="rowSelectMuti" runat="server" Mode="Single">
                                </ext:RowSelectionModel>
                            </SelectionModel>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
