<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BpmWeightInfoA.aspx.cs" Inherits="Plugins_Molding_Quality_BpmWeightInfoA" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>胎胚称重区间分析</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell {
            background-color: #B0FFBA !important;
        }
    </style>
    <script type="text/javascript">

        var pnlListFresh = function () {
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            setTimeout: 300000;
            return false;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmQCRepair" runat="server" />
        <ext:Viewport ID="vpQCRepair" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnMQCRepair" runat="server" Region="North" Height="90">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbQCRepair">
                            <Items>

                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <Listeners>
                                        <Click Fn="pnlListFresh" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" Icon="PageExcel" Text="导出Excel" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="tsBegin" />
                                <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                                <ext:ToolbarFill ID="tfEnd" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        
                                        <ext:ComBoBox ID="cbxequip" runat="server" FieldLabel="成型机台" LabelAlign="Right" Flex="1">
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" Qtip="清空">
                                                </ext:FieldTrigger>
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Handler="this.setValue('');" />
                                            </Listeners>
                                        </ext:ComBoBox>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txtMater" runat="server" FieldLabel="物料规格" LabelAlign="Right" Flex="1">
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                    Padding="5">
                                    <Items>
                                        <ext:ComBoBox ID="cbxshift" runat="server" FieldLabel="班次" LabelAlign="Right" Flex="1">
                                            <Items>
                                                <ext:ListItem Text="白" Value="1">
                                                </ext:ListItem>
                                                <ext:ListItem Text="中" Value="2">
                                                </ext:ListItem>
                                                <ext:ListItem Text="夜" Value="3">
                                                </ext:ListItem>
                                            </Items>
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" Qtip="清空">
                                                </ext:FieldTrigger>
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Handler="this.setValue('');" />
                                            </Listeners>
                                        </ext:ComBoBox>
                                    </Items>
                                </ext:Container>
                            </Items>
                            <Listeners>
                                <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>

                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5" Title="">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="100">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server">
                                            <Fields>
                                                <ext:ModelField Name="DATE1" Type="Date" />
                                                <ext:ModelField Name="SHIFTNAME" />
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="负二" />
                                                <ext:ModelField Name="负2负点" />
                                                <ext:ModelField Name="负点零" />
                                                <ext:ModelField Name="零点五" />
                                                <ext:ModelField Name="点二" />
                                                <ext:ModelField Name="二点五" />
                                                <ext:ModelField Name="NUM" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                                    <ext:DateColumn ID="GREEN_TYRE_NO" runat="server" Text="日期" DataIndex="DATE1" Width="100" Format="yyyy-MM-dd" />
                                    <ext:Column ID="Column9" runat="server" Text="班次" DataIndex="SHIFTNAME" Width="80" />
                                    <ext:Column ID="Column10" runat="server" Text="机台" DataIndex="EQUIP_NAME" Width="80" />
                                    <ext:Column ID="Column11" runat="server" Text="物料规格" DataIndex="MATERIAL_NAME" Width="180" />
                                    <ext:Column ID="Column8" runat="server" Text="检测数量" DataIndex="NUM" Width="100" />
                                    <ext:Column ID="GREEN_MATER_NAME" runat="server" Text="-2.5%以上" DataIndex="负二" Width="100" />
                                    <ext:Column ID="Column1" runat="server" Text="-2.5%~-0.5%" DataIndex="负2负点" Width="100" />
                                    <ext:Column ID="Column2" runat="server" Text="-0.5%~0" DataIndex="负点零" Width="100" />
                                    <ext:Column ID="Column3" runat="server" Text="0~0.5%" DataIndex="零点五" Width="100" />
                                    <ext:Column ID="Column4" runat="server" Text="0.5%~2.5%" DataIndex="点二" Width="100" />
                                    <ext:Column ID="Column5" runat="server" Text="2.5%以上" DataIndex="二点五" Width="100" />
                                </Columns>
                            </ColumnModel>
                            <Plugins>
                                <ext:CellEditing ID="cellEditing1" runat="server" ClicksToEdit="1">
                                </ext:CellEditing>
                            </Plugins>
                            <BottomBar>
                                <ext:PagingToolbar ID="pageToolBar" runat="server">
                                    <Items>
                                        <ext:ToolbarSpacer ID="ToolbarSpacer1" runat="server" Width="10" />
                                        <ext:ComboBox ID="ComboBox1" runat="server" Width="80" Hidden="true">
                                            <Items>
                                                <ext:ListItem Text="10" />
                                                <ext:ListItem Text="50" />
                                                <ext:ListItem Text="100" />
                                                <ext:ListItem Text="200" />
                                            </Items>
                                            <SelectedItems>
                                                <ext:ListItem Value="10" />
                                            </SelectedItems>
                                            <Listeners>
                                                <Select Handler="#{pnlDetailList}.storeData.pageSize = parseInt(this.getValue(), 10); #{pageToolBar}.doRefresh(); return false;" />
                                            </Listeners>
                                        </ext:ComboBox>
                                    </Items>
                                    <Plugins>
                                        <ext:ProgressBarPager ID="ProgressBarPager" runat="server" />
                                    </Plugins>
                                </ext:PagingToolbar>
                            </BottomBar>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
