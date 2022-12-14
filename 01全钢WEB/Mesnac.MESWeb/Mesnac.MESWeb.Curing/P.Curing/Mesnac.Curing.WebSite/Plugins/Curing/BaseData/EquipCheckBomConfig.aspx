<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EquipCheckBomConfig.aspx.cs" Inherits="Plugins_Curing_BaseData_EquipCheckBomConfig" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script type="text/javascript">
        //保存
        var pnListSave = function () {
            Ext.Msg.confirm("提示", '您确定要保存修改的内容吗？', function (btn) {
                if (btn != "yes") { return; }

                var arr = new Array();
                var store = App.store;
                if (store.type == "store") {
                    Ext.each(store.data.items, function (record) {
                        arr.push(record.data);
                    });
                }
                var str = Ext.encode(arr);
                App.direct.commandcolumn_direct_saveStandard(str, {
                    success: function (result) {
                        Ext.Msg.alert('提示', result);
                    },

                    failure: function (errorMsg) {
                        Ext.Msg.alert('提示', errorMsg);
                    }
                });
            });
        }
        //列表刷新数据重载方法
        var pnlListFresh = function () {
            //App.hidden_delete_flag.setValue("0");            
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }
        //未锁定的标示
        var SetRowClass = function (record, rowIndex, rowParams, store) {
            if (record.get("IS_CHECKBOM") == "0") {
                return "x-grid-row-deleted";
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="rmUser" runat="server" />
        <ext:Viewport ID="vwUnit" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnlUserTitle" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="barUser">
                            <Items>
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="点击进行查询" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="pnlListFresh">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle_1" />
                                <ext:Button runat="server" Icon="Lock" Text="保存" ID="btnCheckClock">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="保存选定" />
                                    </ToolTips>
                                    <Listeners>
                                         <Click Fn="pnListSave" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" />
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:Panel ID="pnlUserQuery" runat="server" AutoHeight="true">
                            <Items>
                                <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container ID="container_1" runat="server" Layout="FormLayout" ColumnWidth=".10"
                                            Padding="5">
                                            <Items>
                                                <ext:TextField ID="txtSearchEquipCode" runat="server" FieldLabel="硫化机台" MaxLength="25"
                                        LabelAlign="Right" LabelWidth="60" InputWidth="80"/>
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:FormPanel>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:GridPanel ID="pnlList" runat="server" Region="Center">
                    <Store>
                        <ext:Store ID="store" runat="server" PageSize="20">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="EQUIP_CODE" />
                                        <ext:ModelField Name="EQUIP_NAME" />
                                        <ext:ModelField Name="IS_CHECKBOM" />
                                        <ext:ModelField Name="IS_CHECKCONTROL" />
                                        <ext:ModelField Name="IS_CHECKMATER" />
                                        <ext:ModelField Name="RECORD_TIME" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
               <%--     <SelectionModel>
                        <ext:CheckboxSelectionModel ID="CheckboxSelectionModel1" runat="server" Mode="Multi" />
                    </SelectionModel>--%>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <%--<ext:RowNumbererColumn ID="rowNumCol" Width="45" runat="server" />--%>
                            <%--<ext:Column runat="server" Text="编号" DataIndex="OBJID" Width="40" />--%>
                            <ext:Column runat="server" Text="设备编码" DataIndex="EQUIP_CODE" Width="70" />
                            <ext:Column runat="server" Text="设备名称" DataIndex="EQUIP_NAME" Width="60" />
                            <ext:CheckColumn runat="server" Text="是否验证BOM" DataIndex="IS_CHECKBOM" Editable="true" Width="100" />
                            <ext:CheckColumn runat="server" Text="是否验证人员" DataIndex="IS_CHECKCONTROL" Editable="true" Width="100" />
                            <ext:CheckColumn runat="server" Text="是否验证物料" DataIndex="IS_CHECKMATER" Editable="true" Width="100" />
                            <ext:DateColumn runat="server" Text="修改时间" DataIndex="RECORD_TIME" Width="110" Format="yyyy-MM-dd" />
                        </Columns>
                    </ColumnModel>
                    <View>
                        <ext:GridView ID="gvRows" runat="server">
                            <GetRowClass Fn="SetRowClass" />
                        </ext:GridView>
                    </View>
                    <BottomBar>
                        <ext:PagingToolbar ID="pageToolBar" runat="server">
                            <Plugins>
                                <ext:ProgressBarPager ID="ProgressBarPager" runat="server" />
                            </Plugins>
                        </ext:PagingToolbar>
                    </BottomBar>
                </ext:GridPanel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
