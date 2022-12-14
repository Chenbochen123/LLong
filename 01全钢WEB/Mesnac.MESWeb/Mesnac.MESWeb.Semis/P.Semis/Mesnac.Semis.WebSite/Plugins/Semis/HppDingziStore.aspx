<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HppDingziStore.aspx.cs" Inherits="Plugins_Semis_HppDingziStore" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>锭子房数据展示</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell {
            background-color: #B0FFBA !important;
        }
    </style>
        <script language="javascript" type="text/javascript">
            var Barcode_Renderer = function (value, metadata, record, rowIndex, colIndex, store, view) {
                
                return value;
            };
    </script>
    <script type="text/javascript">

        var pnlListFresh = function () {
            App.storeDetail.currentPage = 1;
            App.pageToolBar.DoRefresh();
            return false;
        }


        var pnDaping = function () {
            window.open("HppDingziStoreScroll.aspx?", "_blank");

        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmMoldingStorage" runat="server" />
        <ext:Viewport ID="vpMoldingStorage" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnMoldingStorage" runat="server" Region="North" Height="120">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbMoldingStorage">
                            <Items>
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <DirectEvents>
                                        <Click OnEvent="btnQuary_Click" Timeout="300000" >
                                             <EventMask ShowMask="true" Msg="查询中..." />
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                        <ext:Button runat="server" Icon="Find" Text="查看大屏" ID="Button1">
                            <Listeners>
                                <Click Fn="pnDaping" />
                            </Listeners>
                        </ext:Button>
                                <ext:Button runat="server" Icon="PageExcel" Text="导出Excel" ID="btnExport" >
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:Hidden runat="server" ID="hiddenMaterialName" Text=" "></ext:Hidden>
                                <ext:ToolbarSeparator ID="tsEnd" />
                                <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                                <ext:ToolbarFill ID="tfEnd" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtsubstore" runat="server" FieldLabel="锭子库位" LabelAlign="Right" Editable="true"></ext:TextField>
                                    </Items>
                                </ext:Container>

                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtbarcode" runat="server" FieldLabel="钢丝条码" LabelAlign="Right" Editable="true"></ext:TextField>
                                    </Items>
                                </ext:Container>
                            </Items>
                            <Listeners>
                                <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>

                <ext:Panel ID="Panel" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="90">
                                    <Model>
                                        <ext:Model ID="model" runat="server" >
                                            <Fields>
                                                <ext:ModelField Name="SUB_PLACESTORE" />
                                                <ext:ModelField Name="AMOUNT" />
                                                <ext:ModelField Name="RONGL" />
                                                <ext:ModelField Name="SAP_CODE" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModel1" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="RowNumbererColumn1" runat="server" Width="35" />
                                    <ext:Column ID="STOREPLACE" runat="server" Text="锭子库位" DataIndex="SUB_PLACESTORE" Width="200"/>
                                    <ext:Column ID="Column4" runat="server" Text="SAP编码" DataIndex="SAP_CODE" Width="200" />
                                    <ext:Column ID="MATERIALNAME" runat="server" Text="数量" DataIndex="AMOUNT" Width="200" />
                                     <ext:Column ID="SAP_CODE" runat="server" Text="容量" DataIndex="RONGL" Width="200" />
                                </Columns>
                            </ColumnModel>

                            <SelectionModel>
                                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" Mode="Single">
                                    <Listeners>
                                        <Select Handler="#{storeDetail}.reload();" Buffer="250" />
                                    </Listeners>
                                </ext:RowSelectionModel>
                            </SelectionModel>

                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="pnlDetail" runat="server" Region="South" Title="库存明细数据" Height="300" Icon="Basket" Layout="Fit" Collapsible="true"
                    Split="true" MarginsSummary="0 5 5 5">
                    <Items>
                        <ext:GridPanel ID="pnlDetailList" runat="server" MarginsSummary="0 5 5 5">
                            <Store>
                                <ext:Store ID="storeDetail" runat="server" PageSize="10" OnReadData="storeDetail_ReadData">
                                    <Model>
                                        <ext:Model ID="modelDetail" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="SUB_PLACESTORE" />
                                                <ext:ModelField Name="RECORD_TIME" />
                                                <ext:ModelField Name="USER_NAME" />
                                                <ext:ModelField Name="BARCODE" />
                                                <ext:ModelField Name="CLASS_NAME" />
                                                <ext:ModelField Name="DAY2" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                    <Parameters>
                                        <ext:StoreParameter Name="SUB_PLACESTORE" Mode="Raw" Value="#{pnlList}.getSelectionModel().hasSelection() ? #{pnlList}.getSelectionModel().getSelection()[0].data.SUB_PLACESTORE : -1" />
                                    </Parameters>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModelDetail" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="CARD_NO" runat="server" Text="条码" DataIndex="BARCODE" Flex="1" >
                                    <Renderer Fn="Barcode_Renderer" />
                                    </ext:Column>
                                    <ext:Column ID="MATERIAL_NAME" runat="server" Text="班组" DataIndex="CLASS_NAME" Width="250" >
                                    <Renderer Fn="Barcode_Renderer" />
                                    </ext:Column>
                                    <ext:Column ID="Column1" runat="server" Text="锭子库位" DataIndex="SUB_PLACESTORE" Flex="1" >
                                     <Renderer Fn="Barcode_Renderer" />
                                    </ext:Column>
                                    <ext:Column ID="Column2" runat="server" Text="操作人" DataIndex="USER_NAME" Flex="1" >
                                     <Renderer Fn="Barcode_Renderer" />
                                    </ext:Column>
                                    <ext:DateColumn ID="STORENAME" runat="server" Text="记录时间" DataIndex="RECORD_TIME" Flex="1"  Format="yyyy-MM-dd HH:mm:ss" >
                                    <Renderer Fn="Barcode_Renderer" />
                                    </ext:DateColumn>
                                    <ext:Column ID="Column3" runat="server" Text="已入库天数" DataIndex="DAY2" Flex="1" >
                                     <Renderer Fn="Barcode_Renderer" />
                                    </ext:Column>
                                </Columns>
                            </ColumnModel>
                            <BottomBar>
                                <ext:PagingToolbar ID="pageToolBar" runat="server">
                                    <Items>
                                        <ext:Label ID="Label1" runat="server" Text="每页条数:" Hidden="true" />
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
                                                <Select Handler="#{pnlDetailList}.storeDetail.pageSize = parseInt(this.getValue(), 10); #{pageToolBar}.DoRefresh(); return false;" />
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

