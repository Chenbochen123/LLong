<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EquipStorage.aspx.cs" Inherits="Plugins_Molding_Storage_EquipStorage" %>

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
        <script language="javascript" type="text/javascript">
            var Barcode_Renderer = function (value, metadata, record, rowIndex, colIndex, store, view) {
                if (record.data.YA_TIME < new Date().getTime() && record.data.FXBZ != 1) {
                    metadata.style = "color: Red;";
                }

                var hour = document.getElementById('txtHour-inputEl').value;
                if (parseInt(record.data.YA_TIME.getTime() - new Date().getTime()) / 1000 / 60 / 60 <= hour && parseInt(record.data.YA_TIME.getTime() - new Date().getTime()) / 1000 / 60 / 60 > 0)
                    metadata.style = "color: blue;";

                return value;
            };
    </script>
    <script type="text/javascript">

        var pnlListFresh = function () {

            App.storeDetail.currentPage = 1;
            App.pageToolBar.DoRefresh();
            return false;
        }

        var prepareToolbar = function (grid, toolbar, rowIndex, record) {
            if (record.get("FiledFlag") == "1") {
                toolbar.items.getAt(0).hide();
                toolbar.items.getAt(1).hide();
            }
            else if (record.get("LockedFlag") == "1") {
                toolbar.items.getAt(0).hide();
                toolbar.items.getAt(1).hide();
            }
        };

        var commandcolumn_click = function (command, record) {
            commandcolumn_direct_showpic(record);
            return false;
        };

        var commandcolumn_click = function (command, record) {
            commandcolumn_click_confirm(command, record);
            return false;
        };
        var commandcolumn_click_confirm = function (command, record) {
            if (command.toLowerCase() == "delete") {
                Ext.Msg.confirm("提示", '您确定需要清空吗？', function (btn) { commandcolumn_direct_Delete(btn, record) });
            }
            return false;
        };
        var commandcolumn_direct_Delete = function (btn, record) {

            if (btn != 'yes') {
                return;
            }

            var StorePlaceId = record.data.STORE_PLACE_ID;
            var DUMMY2 = record.data.DUMMY2;
            debugger;
            App.direct.commandcolumn_direct_Delete(StorePlaceId, DUMMY2, {
                success: function (result) {
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
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

                                        <ext:TextField ID="txtMaterialName" runat="server" FieldLabel="规格" LabelAlign="Right" Editable="false"></ext:TextField>
                                        <ext:TextField ID="txtCardNo" runat="server" FieldLabel="卡片号" LabelAlign="Right" Editable="false"></ext:TextField>
                                        <ext:TextField ID="txtHour" runat="server" FieldLabel="超期预警" LabelAlign="Right" Editable="false" Text="8"></ext:TextField>
                                    </Items>
                                </ext:Container>

                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxStore" runat="server" FieldLabel="仓库" LabelAlign="Right" Editable="false">
                                            <Listeners>
                                                <Select Handler="#{cbxStorePlace}.clearValue(); #{PlaceStore}.reload();" />
                                            </Listeners>
                                        </ext:ComboBox>

                                        <ext:ComboBox ID="cbxStorePlace" runat="server" DisplayField="STORE_PLACE_NAME"
                                            ValueField="OBJID" FieldLabel="库位" LabelAlign="Right" Editable="false">
                                            <Store>
                                                <ext:Store
                                                    runat="server"
                                                    ID="PlaceStore"
                                                    AutoLoad="false"
                                                    OnReadData="StorePlaceRefresh">
                                                    <Model>
                                                        <ext:Model runat="server" IDProperty="OBJID">
                                                            <Fields>
                                                                <ext:ModelField Name="OBJID" Type="String" Mapping="OBJID" />
                                                                <ext:ModelField Name="STORE_PLACE_NAME" Type="String" Mapping="STORE_PLACE_NAME" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                    <Listeners>
                                                        <Load Handler="#{cbxStorePlace}.setValue(#{cbxStorePlace}.store.getAt(0).get('OBJID'));" />
                                                    </Listeners>
                                                </ext:Store>
                                            </Store>
                                        </ext:ComboBox>
                                    </Items>
                                </ext:Container>

                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtToolingBarcode" runat="server" FieldLabel="工装号" LabelAlign="Right" Editable="false">
                                        </ext:TextField>
                                        <ext:ComboBox ID="cbxSelectCondition" runat="server" FieldLabel="统计方式" LabelAlign="Right" Editable="false">
                                            <Items>
                                                <ext:ListItem Text="按库位和规格" Value="1" />
                                                <ext:ListItem Text="按规格" Value="2" />

                                            </Items>
                                        </ext:ComboBox>
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
                                <%-- ^^^^^^^^^^^^^^^^^^ --%>
                                <ext:Store ID="store" runat="server" PageSize="90">
                                    <Model>
                                        <ext:Model ID="model" runat="server">
                                            <Fields>
                                                <ext:ModelField Name="STORE_PLACE_ID" />
                                                <ext:ModelField Name="STORE_PLACE_NAME" />
                                                <ext:ModelField Name="DUMMY2" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="SAP_CODE" />
                                                <ext:ModelField Name="TOTAL_COUNT" />
                                                <ext:ModelField Name="QTY" />
                                                <ext:ModelField Name="UNIT_NAME" />
                                                <ext:ModelField Name="UNIT_ID" />
                                                <ext:ModelField Name="YJNUM" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModel1" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="RowNumbererColumn1" runat="server" Width="35" />
                                    <ext:Column ID="STOREPLACE" runat="server" Text="库位" DataIndex="STORE_PLACE_NAME" Width="250" Hidden="true" />
                                    <ext:Column ID="MATERIALNAME" runat="server" Text="规格" DataIndex="MATERIAL_NAME" Width="250" />
                                     <ext:Column ID="SAP_CODE" runat="server" Text="SAP号" DataIndex="SAP_CODE" Width="250" />
                                    <ext:Column ID="TOTAL_COUNT" runat="server" Text="工装数量" DataIndex="TOTAL_COUNT" Width="120" />
                                    <ext:Column ID="QTY" runat="server" Text="数量" DataIndex="QTY" Width="120" />
                                    <ext:Column ID="UNIT_NAME" runat="server" Text="单位" DataIndex="UNIT_NAME" Width="120" />
                                    <ext:Column ID="Column2" runat="server" Text="预警数量" DataIndex="YJNUM" Width="120" />
                                    <ext:Column ID="UNIT_ID" runat="server" Text="单位ID" DataIndex="UNIT_ID" Hidden="true" />
                                    <ext:CommandColumn ID="Col" runat="server" Text="操作" Align="Center" Hidden="true">
                                        <Commands>
                                            <ext:GridCommand Icon="TableEdit" CommandName="Delete" Text="清空">
                                            </ext:GridCommand>
                                        </Commands>
                                        <Listeners>
                                            <Command Handler="return commandcolumn_click(command, record);" />
                                        </Listeners>
                                    </ext:CommandColumn>

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
                                                <ext:ModelField Name="CARD_NO" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="SAP_CODE" />
                                                <ext:ModelField Name="STORE_NAME" />
                                                <ext:ModelField Name="STORE_PLACE_NAME" />
                                                <ext:ModelField Name="STORE_PLACE_SUB_NAME" />
                                                <ext:ModelField Name="SHELF_NO" />
                                                <ext:ModelField Name="QTY" />
                                                <ext:ModelField Name="DATA_TIME"  />
                                                <ext:ModelField Name="SHIFT_NAME" />
                                                <ext:ModelField Name="INTO_TIME"  />
                                                <ext:ModelField Name="YA_TIME" Type="Date" />
                                                <ext:ModelField Name="FXBZ" />
                                                <ext:ModelField Name="USER_NAME" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                    <Parameters>
                                        <ext:StoreParameter Name="DUMMY2" Mode="Raw" Value="#{pnlList}.getSelectionModel().hasSelection() ? #{pnlList}.getSelectionModel().getSelection()[0].data.DUMMY2 : -1" />
                                        <ext:StoreParameter Name="STORE_PLACE_ID" Mode="Raw" Value="#{pnlList}.getSelectionModel().hasSelection() ? #{pnlList}.getSelectionModel().getSelection()[0].data.STORE_PLACE_ID : -1" />
                                        <ext:StoreParameter Name="UNIT_ID" Mode="Raw" Value="#{pnlList}.getSelectionModel().hasSelection() ? #{pnlList}.getSelectionModel().getSelection()[0].data.UNIT_ID : -1" />
                                    </Parameters>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModelDetail" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="CARD_NO" runat="server" Text="卡片号" DataIndex="CARD_NO" Flex="1" >
                                    <Renderer Fn="Barcode_Renderer" />
                                    </ext:Column>
                                    <ext:Column ID="MATERIAL_NAME" runat="server" Text="规格" DataIndex="MATERIAL_NAME" Width="250" >
                                    <Renderer Fn="Barcode_Renderer" />
                                    </ext:Column>
                                    <ext:Column ID="Column1" runat="server" Text="SAP号" DataIndex="SAP_CODE" Flex="1" >
                                     <Renderer Fn="Barcode_Renderer" />
                                    </ext:Column>
                                    <ext:Column ID="STORENAME" runat="server" Text="仓库" DataIndex="STORE_NAME" Flex="1" >
                                    <Renderer Fn="Barcode_Renderer" />
                                    </ext:Column>
                                    <ext:Column ID="STORE_PLACE_NAME" runat="server" Text="库位" DataIndex="STORE_PLACE_NAME" Flex="1" >
                                    <Renderer Fn="Barcode_Renderer" />
                                    </ext:Column>
                                    <ext:Column ID="STORE_PLACE_SUB_NAME" runat="server" Text="子库位" DataIndex="STORE_PLACE_SUB_NAME" Flex="1" >
                                    <Renderer Fn="Barcode_Renderer" />
                                    </ext:Column>
                                    <ext:Column ID="SHELF_NO" runat="server" Text="工装号" DataIndex="SHELF_NO" Flex="1" >
                                    <Renderer Fn="Barcode_Renderer" />
                                    </ext:Column>
                                    <ext:DateColumn ID="DATA_TIME" runat="server" Text="生产日期" DataIndex="DATA_TIME" Flex="1" Format="yyyy-MM-dd" >
                                    <Renderer Fn="Barcode_Renderer" />
                                    </ext:DateColumn>
                                    <ext:Column ID="LEFT_QTY" runat="server" Text="数量" DataIndex="QTY" Flex="1" >
                                    <Renderer Fn="Barcode_Renderer" />
                                    </ext:Column>
                                    <ext:Column ID="SHIFT_NAME" runat="server" Text="生产班次" DataIndex="SHIFT_NAME" Flex="1" >
                                    <Renderer Fn="Barcode_Renderer" />
                                    </ext:Column>
                                    <ext:DateColumn ID="INTO_TIME" runat="server" Text="入库时间" DataIndex="INTO_TIME" Flex="1" Format="yyyy-MM-dd" >
                                     <Renderer Fn="Barcode_Renderer" />
                                    </ext:DateColumn>
                                    <ext:DateColumn ID="YA_TIME" runat="server" Text="有效期" DataIndex="YA_TIME" Flex="1"  Format="yyyy-MM-dd HH24:mi:ss" Hidden="true"  >
                                    <Renderer Fn="Barcode_Renderer" />
                                    </ext:DateColumn>
                                    <ext:Column ID="USER_NAME" runat="server" Text="入库人" DataIndex="USER_NAME" Flex="1" >
                                    <Renderer Fn="Barcode_Renderer" />
                                    </ext:Column>
                                </Columns>
                            </ColumnModel>
                            <%--  <SelectionModel>
                                <ext:RowSelectionModel ID="rowSelectMutiDetail" runat="server" Mode="Single" />
                            </SelectionModel>--%>
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
