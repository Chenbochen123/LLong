<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CuringCommitStorage.aspx.cs" Inherits="Plugins_Curing_CuringStorage_CuringCommitStorage" %>

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

        //var prepareToolbar = function (grid, toolbar, rowIndex, record) {
        //    if (record.get("FiledFlag") == "1") {
        //        toolbar.items.getAt(0).hide();
        //        toolbar.items.getAt(1).hide();
        //    }
        //    else if (record.get("LockedFlag") == "1") {
        //        toolbar.items.getAt(0).hide();
        //        toolbar.items.getAt(1).hide();
        //    }
        //};

        //var commandcolumn_click = function (command, record) {
        //    commandcolumn_direct_showpic(record);
        //    return false;
        //};


        var pnlListFresh = function () {
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
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

                <ext:Panel ID="pnMoldingStorage" runat="server" Region="North" Height="90">
                    <%-- 菜单 --%>
                    <TopBar>

                        <ext:Toolbar runat="server" ID="tbMoldingStorage">
                            <Items>
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                   <Listeners>
                                       <Click Fn="pnlListFresh" />
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
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtMaterialName" runat="server" FieldLabel="规格" LabelAlign="Right" Editable="false"></ext:TextField>
                                        <ext:TextField ID="txtGreenTyreNo" runat="server" FieldLabel="胎胚号" LabelAlign="Right" Editable="false"></ext:TextField>
                                    </Items>
                                </ext:Container>

                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxStore" runat="server" FieldLabel="现仓库" LabelAlign="Right" Editable="false">
                                            <Listeners>
                                                <Select Handler="#{cbxStorePlace}.clearValue(); #{PlaceStore}.reload();" />
                                            </Listeners>
                                        </ext:ComboBox>
                                        <ext:ComboBox ID="cbxStorePlace" runat="server" DisplayField="STORE_PLACE_NAME"
                                            ValueField="OBJID" FieldLabel="现库位" LabelAlign="Right" Editable="false">
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
                                        <ext:TextField ID="txtToolingBarcode" runat="server" FieldLabel="胎胚车号" LabelAlign="Right" Editable="false">
                                        </ext:TextField>
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

             <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5" Title="调拨明细查询">
                    <Items>
                        <ext:GridPanel ID="pnlDetailList" runat="server" MarginsSummary="0 5 5 5">
                          <View><ext:GridView EnableTextSelection="true"></ext:GridView></View>
                            <Store>
                                 <ext:Store ID="store" runat="server" PageSize="15">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                           
                                     <Model>
                                        <ext:Model ID="modelDetail" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="GREEN_TYRE_NO" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="OLD_STORE_NAME" />
                                                <ext:ModelField Name="OLD_STORE_PLACE_NAME" />
                                                <ext:ModelField Name="TOOLING_BARCODE" />
                                                <ext:ModelField Name="NEW_STORE_NAME" />
                                                <ext:ModelField Name="NEW_STORE_PLACE_NAME" />
                                                <ext:ModelField Name="RECORD_TIME"  Type="Date"/>
                                                <ext:ModelField Name="USER_NAME" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                    </ext:Store>
                            </Store>
                            <%-- 头 --%>
                            <ColumnModel ID="ColumnModelDetail" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="GREEN_TYRE_NO" runat="server" Text="胎胚号" DataIndex="GREEN_TYRE_NO" Flex="1" />
                                    <ext:Column ID="MATERIAL_NAME" runat="server" Text="规格" DataIndex="MATERIAL_NAME" Width="250" />
                                    <ext:Column ID="OLD_STORE_NAME" runat="server" Text="原仓库" DataIndex="OLD_STORE_NAME" Flex="1" />
                                    <ext:Column ID="OLD_STORE_PLACE_NAME" runat="server" Text="原库位" DataIndex="OLD_STORE_PLACE_NAME" Flex="1" />
                                    <ext:Column ID="TOOLING_BARCODE" runat="server" Text="胎胚车号" DataIndex="TOOLING_BARCODE" Flex="1" />
                                     <ext:Column ID="NEW_STORE_NAME" runat="server" Text="现仓库" DataIndex="NEW_STORE_NAME" Flex="1" />
                                    <ext:Column ID="NEW_STORE_PLACE_NAME" runat="server" Text="现库位" DataIndex="NEW_STORE_PLACE_NAME" Flex="1" />
                                    <ext:DateColumn ID="RECORD_TIME" runat="server" Text="调拨时间" DataIndex="RECORD_TIME" Flex="1" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="USER_NAME" runat="server" Text="调拨人" DataIndex="USER_NAME" Flex="1" />
                                </Columns>
                            </ColumnModel>

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
