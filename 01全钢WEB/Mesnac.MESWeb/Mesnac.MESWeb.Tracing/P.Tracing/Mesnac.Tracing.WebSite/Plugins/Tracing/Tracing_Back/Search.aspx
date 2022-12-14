<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Search.aspx.cs" Inherits="Tracing_Back_Search" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="head" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>条码追溯</title>
    <!--通用-->
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script src="<%= Page.ResolveUrl("./") %>Search.js?_dc=<%= DateTime.Now.ToString("yyyyMMddHHmmss") %>"></script>
    <script type="text/javascript">
        var gridPanelRefresh = function () {
            App.store.currentPage = 1;
            App.refreshHidden.setValue("1");
            App.store.reload();
            return false;
        }
    </script>
   <%-- <script type="text/javascript">
        var basicInfoLoad = function (barcode) {
            App.direct.BasicInfoLoad(barcode, {
                success: function (result) {
                },
                failure: function (errorMsg) {
                    Ext.Msg.alert('提示', errorMsg);
                }
            });
        }
    </script>--%>
</head>
<body>
    <form id="form" runat="server">
        <ext:ResourceManager ID="resourceManager" runat="server" />
        <ext:Viewport ID="viewport" runat="server" Layout="BorderLayout">
            <Items>
                <ext:Panel ID="northPanel" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="northToolbar">
                            <Items>
                                <ext:ToolbarSeparator ID="toolbarSeparator_begin" />
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="点击进行查询" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="gridPanelRefresh"></Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" />
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:Panel ID="panelNorthQuery" runat="server" Layout="AnchorLayout" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container1" runat="server" Layout="AnchorLayout" AutoHeight="true" Padding="5">
                                    <Items>
                                        <ext:Container ID="container4" runat="server" Layout="HBoxLayout" Padding="5">
                                            <Items>
                                                <ext:DateField ID="txtBeginTime" runat="server" FieldLabel="开始时间" LabelAlign="Right" Format="yyyy-MM-dd">
                                                </ext:DateField>
                                                <ext:DateField ID="txtEndTime" runat="server" FieldLabel="结束时间" LabelAlign="Right" Format="yyyy-MM-dd">
                                                </ext:DateField>
                                                <ext:ComboBox ID="cbxShift" runat="server" SelectOnTab="true" Editable="false" LabelAlign="Right" Width="200" FieldLabel="班次信息">
                                                </ext:ComboBox>
                                                <ext:TriggerField ID="txtMaterialName" runat="server" FieldLabel="物料名称" Width="300" LabelAlign="Right" Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Fn="QueryMaterialInfo" />
                                                    </Listeners>
                                                </ext:TriggerField>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container3" runat="server" Layout="HBoxLayout" Padding="5">
                                            <Items>
                                                <ext:ComboBox ID="cbxBarcodeType" runat="server" FieldLabel="条码类型" LabelAlign="Right">
                                                    <Items>
                                                      <%--  <ext:ListItem Index="1" Text="原材料条码" Value="1" />--%>
                                                        <ext:ListItem Index="2" Text="架子条码" Value="2" />
                                                        <ext:ListItem Index="3" Text="半制品条码" Value="3" />
                                                        <ext:ListItem Index="4" Text="成型号" Value="4" />
                                                        <ext:ListItem Index="5" Text="硫化号" Value="5" />
                                                  <%--      <ext:ListItem Index="6" Text="出库单号" Value="6" />--%>
                                                    </Items>
                                                    <Listeners>
                                                        <Change Fn="cbxBarcodeType_Change" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:TextField ID="txtBarcode" runat="server" FieldLabel="条码号" Width="275" LabelAlign="Right" />
                                                <ext:ComboBox ID="cbxClass" runat="server" SelectOnTab="true" Editable="false" LabelAlign="Right" Width="200" FieldLabel="班组信息">
                                                </ext:ComboBox>
                                                <ext:TriggerField ID="txtEquipName" runat="server" FieldLabel="机台名称" Width="300" LabelAlign="Right" Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Fn="QueryEquipInfo" />
                                                    </Listeners>
                                                </ext:TriggerField>
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:Container>
                                <ext:Hidden ID="hiddenMaterialMajorType" runat="server"></ext:Hidden>
                                <ext:Hidden ID="hiddenEquipMajorType" runat="server"></ext:Hidden>
                                <ext:Hidden ID="hiddenMaterialId" runat="server"></ext:Hidden>
                                <ext:Hidden ID="hiddenSearchTimes" runat="server" Text="0"></ext:Hidden>
                                <ext:Hidden ID="hiddenEquipId" runat="server"></ext:Hidden>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="Panel1" runat="server" Region="Center" AutoHeight="true" Layout="BorderLayout">
                    <Items>
                        <ext:GridPanel ID="gridPanelCenter" runat="server" Region="Center">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="30">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server">
                                            <Fields>
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="columnModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="30" />
                                    <%--    <ext:Column ID="ShelfBarCode" DataIndex="ShelfBarcode" runat="server" Text="架子条码" Width="120" />
                                    <ext:Column ID="Barcode" DataIndex="Barcode" runat="server" Text="车条码" Width="120" />
                                    <ext:Column ID="EquipName" DataIndex="EquipName" runat="server" Text="机台" Width="100" />
                                    <ext:Column ID="ShiftID" DataIndex="ShiftName" runat="server" Text="班次" Width="35" />
                                    <ext:Column ID="ClassID" DataIndex="ClassName" runat="server" Text="班组" Width="35" />
                                    <ext:Column ID="MaterName" DataIndex="MaterName" runat="server" Text="物料名称" Width="100" />
                                    <ext:Column ID="PlanID" DataIndex="PlanID" runat="server" Text="计划编号" Width="100" />
                                    <ext:Column ID="SerialID" DataIndex="SerialID" runat="server" Text="车次号" Width="45" />
                                    <ext:Column ID="StartDatetime" DataIndex="StartDatetime" runat="server" Text="开始生产时间" Width="120" />
                                    <ext:Column ID="SetWeight" DataIndex="SetWeight" runat="server" Text="设重" Width="50" />
                                    <ext:Column ID="RealWeight" DataIndex="RealWeight" runat="server" Text="实重" Width="50" />
                                    <ext:Column ID="TestResult" DataIndex="TestResultName" runat="server" Text="质检结果" Width="60" />
                                    <ext:Column ID="SerialBatchID" DataIndex="SerialBatchID" runat="server" Text="累计车次" Width="60" />
                                    <ext:Column ID="MixStatus" DataIndex="MixStatusName" runat="server" Text="生产状态" Width="60" />
                                    <ext:Column ID="ZJSID" DataIndex="ZJSID" runat="server" Text="主机手编号" Width="60" />--%>
                                   
                                </Columns>
                            </ColumnModel>
                            <SelectionModel>
                                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" Mode="Single">
                                </ext:RowSelectionModel>
                            </SelectionModel>
                            <BottomBar>
                                <ext:PagingToolbar ID="pageToolbar" runat="server">
                                    <Plugins>
                                        <ext:ProgressBarPager ID="progressBarPager" runat="server" />
                                    </Plugins>
                                </ext:PagingToolbar>
                            </BottomBar>
                            <Listeners>
                             <%--   <SelectionChange Handler="basicInfoLoad(App.gridPanelCenter.getRowsValues({selectedOnly:true}));" />--%>
                                <CellDblClick Fn="gridPanelCellDblClick" />
                            </Listeners>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
                <ext:Hidden runat="server" ID="refreshHidden" />

            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
