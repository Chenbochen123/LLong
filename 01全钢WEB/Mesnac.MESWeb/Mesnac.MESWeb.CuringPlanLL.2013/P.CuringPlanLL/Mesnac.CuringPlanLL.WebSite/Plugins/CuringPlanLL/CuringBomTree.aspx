<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CuringBomTree.aspx.cs" Inherits="Plugins_CuringPlanLL_CuringBomTree" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>BOM</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <script type="text/javascript">
        var gridPanelMainRefresh = function () {
            App.gridPanelMainStore.currentPage = 1;
            App.gridPanelMainPagingToolbar.doRefresh();
            //App.tabPanelMain.setActiveTab(1);
            return false;
        };
        var btnSearch_Click = function () {
            return gridPanelMainRefresh();
        };
        var treePanelCbm = function (store, operation, options) {
            var node = operation.node;
            var nodeid = node.getId() || "";
            App.direct.IniCbmTree(nodeid, {
                success: function (result) {
                    node.set('loading', false);
                    node.set('loaded', true);
                    for (var i = 0; i < result.children.length; i++) {
                        var data = result.children[i];
                        node.appendChild(data, undefined, true);
                    }
                    node.expand();
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('错误', errorMsg);
                }
            });
            return false;
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        <ext:Viewport ID="viewport" runat="server" Layout="BorderLayout">
            <Items>
                <ext:Panel ID="northPanel" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="northToolbar">
                            <Items>
                                <ext:ToolbarSpacer runat="server" ID="tspacerBegin" />
                                <ext:Hidden runat="server" ID="hiddenIsSearchAllInfo" Text="0" />
                                <ext:Button runat="server" Icon="Find" Text="查询信息" ID="btnSearch">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="点击进行查询" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="return btnSearch_Click();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="tsBegin" />
                                <ext:ToolbarFill ID="tfEnd" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:Panel ID="panelNorthQueryParam" runat="server" AutoHeight="true">
                            <Items>
                                <ext:Container ID="containerQueryParam" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:TextField ID="txtTyreSAP" Vtype="integer" runat="server" FieldLabel="SAP品号"
                                            LabelAlign="Right" />
                                        <ext:ComboBox ID="cboBomState" runat="server" FieldLabel="Bom状态" LabelAlign="Right" Editable="false" />
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="Panel1" runat="server" Region="Center" Width="200" Layout="BorderLayout">
                    <Items>
                        <ext:TreePanel ID="treeCbm" runat="server" Title="物料信息" Region="Center" Icon="FolderGo" AutoHeight="true" RootVisible="false" MultiSelect="false">
                            <Store>
                                <ext:TreeStore ID="TreeStore1" runat="server" PageSize="20">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelDetailBindData" AutoDataBind="true" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model1" runat="server">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="SAP_CODE" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="SAP_FULL_CODE" />
                                                <ext:ModelField Name="MATERIAL_FULL_NAME" />
                                                <ext:ModelField Name="MATERIAL_CODE" />
                                                <ext:ModelField Name="RECORD_TIME" />
                                                <ext:ModelField Name="DELETE_FLAG" />
                                                <ext:ModelField Name="BOM_VERSION" />
                                                <ext:ModelField Name="GROUP_UNIT_NUM" />
                                                <ext:ModelField Name="UNIT_NAME" />
                                                <ext:ModelField Name="TYPENAME" />
                                                <ext:ModelField Name="TYPE_NAME" />
                                                <ext:ModelField Name="BOM_FACTROY" />
                                                <ext:ModelField Name="GREENTYRE_VERSION" />
                                                <ext:ModelField Name="GREENTYRE_MATERIAL_ID" />
                                                <ext:ModelField Name="SUB_ITEM_REVISION" />
                                                <ext:ModelField Name="EXPIRED_DATE" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                    <Listeners>
                                        <BeforeLoad Fn="treePanelCbm" />
                                    </Listeners>
                                </ext:TreeStore>
                            </Store>
                            <ColumnModel>
                                <Columns>
                                    <ext:TreeColumn runat="server" Text="SAP品号" Sortable="true"  Width="150"  DataIndex="SAP_CODE"/>
                                    <ext:Column runat="server" Text="物料编码" Flex="1" Sortable="true" DataIndex="MATERIAL_CODE" />
                                    <ext:Column runat="server" Text="物料名称" Flex="1" Sortable="true" DataIndex="MATERIAL_NAME" />
                                    <ext:Column runat="server" Text="SAP完整品号" Flex="1" Sortable="true" DataIndex="SAP_FULL_CODE" />
                                    <ext:Column runat="server" Text="系列" Width="100" Sortable="true" DataIndex="TYPENAME" />
                                    <ext:Column runat="server" Text="父物料版本" Width="100" Sortable="true" DataIndex="GREENTYRE_VERSION" />
                                    <ext:Column runat="server" Text="子物料版本" Width="100" Sortable="true" DataIndex="SUB_ITEM_REVISION" />
                                    <ext:Column runat="server" Text="废止时间" Width="100" Sortable="true" DataIndex="EXPIRED_DATE" />
                                    <ext:Column runat="server" Text="Bom版本" Width="60" Sortable="true" DataIndex="BOM_VERSION" />
                                    <ext:Column runat="server" Text="Bom类型" Width="60" Sortable="true" DataIndex="TYPE_NAME" />
                                    <ext:Column runat="server" Text="单位" Width="60" Sortable="true" DataIndex="UNIT_NAME" />
                                    <ext:Column runat="server" Text="数量" Width="60" Sortable="true" DataIndex="GROUP_UNIT_NUM" />
                                    <ext:Column runat="server" Text="厂区代码" Width="60" Sortable="true" DataIndex="BOM_FACTROY" />
                                    <ext:Column runat="server" Text="记录时间"  Sortable="true" DataIndex="RECORD_TIME"  Width="150" />
                                    <ext:Column runat="server" Text="状态" Sortable="true" DataIndex="DELETE_FLAG" Width="40"/>
                                    <ext:Column runat="server" Text="轮胎物料ID" Sortable="true" DataIndex="GREENTYRE_MATERIAL_ID" Hidden="true" Width="40"/>
                                </Columns>
                            </ColumnModel>
                        </ext:TreePanel>
                    </Items>
                </ext:Panel>
                <%--分页GRID--%>
                <ext:GridPanel ID="pnlList" runat="server" Region="South">
                    <Store>
                        <ext:Store ID="gridPanelMainStore" runat="server" PageSize="20">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model2" runat="server">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="SAP_CODE" />
                                        <ext:ModelField Name="MATERIAL_NAME" />
                                        <ext:ModelField Name="SAP_FULL_CODE" />
                                        <ext:ModelField Name="MATERIAL_FULL_NAME" />
                                        <ext:ModelField Name="MATERIAL_CODE" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <BottomBar>
                        <ext:PagingToolbar ID="gridPanelMainPagingToolbar" runat="server">
                            <Plugins>
                                <ext:ProgressBarPager ID="ProgressBarPager1" runat="server" />
                            </Plugins>
                        </ext:PagingToolbar>
                    </BottomBar>
                </ext:GridPanel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
