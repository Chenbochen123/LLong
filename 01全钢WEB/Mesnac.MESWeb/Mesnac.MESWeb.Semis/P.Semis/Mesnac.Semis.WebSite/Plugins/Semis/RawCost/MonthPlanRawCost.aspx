<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MonthPlanRawCost.aspx.cs" Inherits="Plugins_Semis_MonthPlanRawCost_MonthPlanRawCost" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>原材料消耗计划</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script>
        var pnlListRefresh = function () {
            if (App.PlanDate.getValue() == '' || App.PlanDate.getValue() == null) {
                Ext.Msg.alert('提示', '请选择月份');
                return;
            }
            App.direct.GetData(App.PlanDate.getRawValue(), {
                success: function (result) {
                    if (result != '') {
                        Ext.Msg.alert('操作', result);
                    }
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                },
                eventMask: {
                    showMask: true,
                    target: 'customtarget',
                    customTarget: 'pnlList',
                }
            });
        }

        var btnExportClick = function () {
            var data = App.pnlList.getRowsValues({ selectedOnly: false, visibleOnly: true, dirtyOnly: false, currentPageOnly: false });
            //var data = App.pnlListStore.data.items.map(item => item.data);
            //删除自带的id，添加行号，自带的id中可以过滤出行号
            data.forEach(function (item, index) { delete item['id']; });
            App.exportData.setValue(JSON.stringify(data));
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        <ext:Hidden ID="exportData" runat="server" />
        <ext:Viewport ID="Viewport1" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnlQueryTitle" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="barUser">
                            <Items>
                                <ext:ToolbarSeparator></ext:ToolbarSeparator>
                                <ext:DateField runat="server" ID="PlanDate" Text="月份" Format="yyyy-MM-dd" Type="Month">
                                </ext:DateField>
                                <ext:ToolbarSeparator></ext:ToolbarSeparator>
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <Listeners>
                                        <Click Fn="pnlListRefresh" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator></ext:ToolbarSeparator>
                                <ext:Button runat="server" Icon="PageExcel" Text="导出" ID="btnExport" AutoPostBack="true" OnClick="btnExport_Click">
                                    <Listeners>
                                        <Click Fn="btnExportClick" />
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                </ext:Panel>
                <ext:GridPanel ID="pnlList" runat="server" Region="Center" MaskOnDisable="true">
                    <Store>
                        <ext:Store ID="store" runat="server">
                            <Model>
                                <ext:Model ID="model" runat="server" IDProperty="PlanInfo">
                                    <Fields>
                                        <ext:ModelField Name="月份" ServerMapping="Month" />
                                        <ext:ModelField Name="物料编码" ServerMapping="MATERAL_CODE" />
                                        <ext:ModelField Name="物料名称" ServerMapping="MATERIAL_NAME" />
                                        <ext:ModelField Name="计划消耗" ServerMapping="NUM" />
                                        <ext:ModelField Name="实际消耗" ServerMapping="REAL_NUM" />
                                        <ext:ModelField Name="单位" ServerMapping="UNIT" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:Column runat="server" Text="月份" DataIndex="月份" Width="100" />
                            <ext:Column runat="server" Text="物料名称" DataIndex="物料名称" Width="300" />
                            <ext:Column runat="server" Text="物料编码" DataIndex="物料编码" Width="200" />
                            <ext:Column runat="server" Text="计划消耗" DataIndex="计划消耗" Width="100" />
                            <ext:Column runat="server" Text="实际消耗" DataIndex="实际消耗" Width="100" />
                            <ext:Column runat="server" Text="单位" DataIndex="单位" Width="100" />
                        </Columns>
                    </ColumnModel>
                    <View>
                        <ext:GridView EnableTextSelection="true" PreserveScrollOnRefresh="true">
                        </ext:GridView>
                    </View>
                    <SelectionModel>
                        <ext:RowSelectionModel runat="server" Mode="Single" />
                    </SelectionModel>
                </ext:GridPanel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
