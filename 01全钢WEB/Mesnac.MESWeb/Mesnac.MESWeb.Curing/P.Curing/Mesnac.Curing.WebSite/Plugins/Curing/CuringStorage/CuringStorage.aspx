<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CuringStorage.aspx.cs" Inherits="Plugins_Curing_CuringStorage_CuringStorage" %>

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
        //分页
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
            var MaterialId = record.data.MATERIAL_ID;
            debugger;
            App.direct.commandcolumn_direct_Delete(StorePlaceId, MaterialId, {
                success: function (result) {
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        var Barcode_Renderer = function (value, metadata, record, rowIndex, colIndex, store, view) {
            if (record.data.YA_TIME < new Date().getTime() && record.data.SEQ_INDEX == 1) {
                metadata.style = "color: Red;";
            }
            var hour = document.getElementById('txtHour-inputEl').value;
            if (parseInt(record.data.YA_TIME.getTime() - new Date().getTime()) / 1000 / 60 / 60 <= hour && parseInt(record.data.YA_TIME.getTime() - new Date().getTime()) / 1000 / 60 / 60 > 0)
                metadata.style = "color: blue;";
            return value;
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmMoldingStorage" runat="server" />

        <ext:Viewport ID="vpMoldingStorage" runat="server" Layout="border">
            <Items>

                <ext:Panel ID="pnMoldingStorage" runat="server" Region="North" Height="90">
                    <%-- 菜单 --%>
                    <TopBar>

                        <ext:Toolbar runat="server" ID="tbMoldingStorage">
                            <Items>
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <DirectEvents>
                                        <Click OnEvent="btnQuary_Click" />
                                    </DirectEvents>
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
                                <%--导出--%>

                                <ext:Hidden runat="server" ID="hiddenMaterialName" Text=" "></ext:Hidden>

                                <ext:ToolbarSeparator ID="tsEnd" />

                                <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />

                                <ext:ToolbarFill ID="tfEnd" />

                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <%--end 菜单  --%>

                    <%-- 条件查询 --%>
                    <Items>
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtHour" runat="server" FieldLabel="超期预警" LabelAlign="Right" Editable="false" Text="8"></ext:TextField>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtMaterialName" runat="server" FieldLabel="规格" LabelAlign="Right" Editable="false"></ext:TextField>
                                        <ext:TextField ID="txtGreenTyreNo" runat="server" FieldLabel="胎胚号" LabelAlign="Right" Editable="false"></ext:TextField>
                                    </Items>
                                </ext:Container>

                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".25"
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

                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtToolingBarcode" runat="server" FieldLabel="胎胚车号" LabelAlign="Right" Editable="false">
                                        </ext:TextField>
                                        <ext:ComboBox ID="cbxSelect" runat="server" FieldLabel="统计方式" LabelAlign="Right" Editable="false">
                                            <items>
                                                <ext:ListItem Text="按库位和规格" Value="1" />
                                                <ext:ListItem Text="按规格" Value="2" />

                                            </items>
                                        </ext:ComboBox>
                                   </Items>
                                </ext:Container>
                            </Items>
                            <Listeners>
                                <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                    </Items>
                    <%-- end 条件查询 --%>
                </ext:Panel>
                <%-- 第一个文本框 --%>
                <ext:Panel ID="Panel" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="90">
                                    <Model>
                                        <ext:Model ID="model" runat="server"  >
                                            <Fields>
                                                <%--begin  --%>
                                                <ext:ModelField Name="STORE_PLACE_NAME" />
                                                <ext:ModelField Name="STORE_PLACE_ID" />
                                                <%-- end --%>
                                                <ext:ModelField Name="MATERIAL_ID" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="TOTAL_COUNT" />
                                                <ext:ModelField Name="YJ_NUM" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <%-- 表头 --%>
                            <ColumnModel ID="ColumnModel1" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="RowNumbererColumn1" runat="server" Width="35" />
                                    <%--begion  --%>
                                    <ext:Column ID="STOREPLACE" runat="server" Text="库位" DataIndex="STORE_PLACE_NAME" Width="250" />
                                    <%--end  --%>
                                    <ext:Column ID="MATERIALNAME" runat="server" Text="规格" DataIndex="MATERIAL_NAME" Width="250" />
                                    <ext:Column ID="TOTAL_COUNT" runat="server" Text="当前库存" DataIndex="TOTAL_COUNT" Width="120" />
                                    <ext:Column ID="YJ_NUM" runat="server" Text="预警数量" DataIndex="YJ_NUM" Width="120" />
                                      <%--begion  --%>
                                     <ext:CommandColumn ID="Col" runat="server" Text="操作" Align="Center">
                                        <Commands>
                                            <ext:GridCommand Icon="TableEdit" CommandName="Delete" Text="清空" >
                                            </ext:GridCommand>
                                        </Commands>
                                        <Listeners>
                                            <Command Handler="return commandcolumn_click(command, record);" />
                                        </Listeners>
                                    </ext:CommandColumn>
                                    <%--end  --%>
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
                                   <%-- 后 --%>
                                     <Model>
                                        <ext:Model ID="modelDetail" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="GREEN_TYRE_NO" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="STORE_NAME" />
                                                <ext:ModelField Name="STORE_PLACE_NAME" />
                                                <ext:ModelField Name="TOOLING_BARCODE" />
                                                <%--<ext:ModelField Name="BEGIN_TIME" Type="Date" />
                                                <ext:ModelField Name="SHIFT_NAME" />--%>
                                                <ext:ModelField Name="BACKUP_TIME" Type="Date" />
                                                <ext:ModelField Name="USER_NAME" />
                                                <ext:ModelField Name="SEQ_INDEX" />
                                                <ext:ModelField Name="YA_TIME" Type="Date" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                    <Parameters>
                                         <ext:StoreParameter Name="MATERIAL_ID" Mode="Raw" Value="#{pnlList}.getSelectionModel().hasSelection() ? #{pnlList}.getSelectionModel().getSelection()[0].data.MATERIAL_ID : -1  " />
                                         <ext:StoreParameter Name="STORE_PLACE_ID" Mode="Raw" Value="#{pnlList}.getSelectionModel().hasSelection() ? #{pnlList}.getSelectionModel().getSelection()[0].data.STORE_PLACE_ID : -1" />
                                    </Parameters>
                                </ext:Store>
                            </Store>
                            <%-- 头 --%>
                            <ColumnModel ID="ColumnModelDetail" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="GREEN_TYRE_NO" runat="server" Text="胎胚号" DataIndex="GREEN_TYRE_NO" Flex="1">
                                         <Renderer Fn="Barcode_Renderer" />
                                    </ext:Column>
                                    <ext:Column ID="MATERIAL_NAME" runat="server" Text="规格" DataIndex="MATERIAL_NAME" Width="250">
                                         <Renderer Fn="Barcode_Renderer" />
                                    </ext:Column>
                                    <ext:Column ID="STORENAME" runat="server" Text="仓库" DataIndex="STORE_NAME" Flex="1">
                                         <Renderer Fn="Barcode_Renderer" />
                                    </ext:Column>
                                    <ext:Column ID="STORE_PLACE_NAME" runat="server" Text="库位" DataIndex="STORE_PLACE_NAME" Flex="1">
                                         <Renderer Fn="Barcode_Renderer" />
                                    </ext:Column>
                                    <ext:Column ID="TOOLING_BARCODE" runat="server" Text="胎胚车号" DataIndex="TOOLING_BARCODE" Flex="1">
                                         <Renderer Fn="Barcode_Renderer" />
                                    </ext:Column>
                                   <%-- <ext:DateColumn ID="PRODUCT_DATE" runat="server" Text="生产日期" DataIndex="BEGIN_TIME" Flex="1" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="PRODUCT_SHIFT_NAME" runat="server" Text="生产班次" DataIndex="SHIFT_NAME" Flex="1" />--%>
                                    <ext:DateColumn ID="BACKUP_TIME" runat="server" Text="入库时间" DataIndex="BACKUP_TIME" Flex="1" Format="yyyy-MM-dd HH:mm:ss">
                                    </ext:DateColumn>
                                    <ext:Column ID="USER_NAME" runat="server" Text="入库人" DataIndex="USER_NAME" Flex="1">
                                         <Renderer Fn="Barcode_Renderer" />
                                    </ext:Column>
                                </Columns>
                            </ColumnModel>

                            <%--  <SelectionModel>
                                <ext:RowSelectionModel ID="rowSelectMutiDetail" runat="server" Mode="Single" />
                            </SelectionModel>--%>
                            <%-- 分页 --%>
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
