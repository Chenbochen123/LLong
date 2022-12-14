<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BppToolingPlan.aspx.cs" Inherits="Plugins_Molding_ProductPlan_BppToolingPlan" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
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
            return false;
        }

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
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="rmMEquipControl" runat="server" />
        <ext:Viewport ID="vpMEquipControl" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnMEquipControl" runat="server" Region="North" Height="90">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbMEquipControl">
                            <Items>

                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <Listeners>
                                        <Click Fn="pnlListFresh" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="tsBegin" />
                                <%--   <ext:Button runat="server" Icon="PageSave" Text="保存" ID="btnSave">
                                    <Listeners>
                                        <Click Fn="pnListSave" />
                                    </Listeners>
                                </ext:Button>--%>
                               <%-- <ext:ToolbarSeparator ID="tsEnd" />--%>
                                <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                                <ext:ToolbarFill ID="tfEnd" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>

                    <Items>
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".34"
                                    Padding="5">
                                    <Items>
                                        <ext:DateField ID="txtPlanDate" runat="server" FieldLabel="计划日期" Flex="1" LabelAlign="Right" Editable="false">
                                        </ext:DateField>
                                        <ext:TextField ID="txtToolingPlanNo" runat="server" FieldLabel="工装计划号"  LabelAlign="Right" Flex="1">
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".34"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxShift" runat="server" FieldLabel="成型班次" LabelAlign="Right" Editable="false">
                                        </ext:ComboBox>
                                        <ext:ComboBox ID="cbxEquip" runat="server" FieldLabel="机台名称" LabelAlign="Right" Editable="true" EnableKeyEvents="true">
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

                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5" Title="工装计划执行状态">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="15">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="SHOW_NAME" />
                                                <ext:ModelField Name="EQUIP_ID" />
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="MATERIAL_ID" />
                                                <ext:ModelField Name="TOOLING_PLAN_DATE" Type="Date" />
                                                <ext:ModelField Name="BOM_ID" />
                                                <ext:ModelField Name="TECH_ID" />
                                                <ext:ModelField Name="BOM_NAME" />
                                                <ext:ModelField Name="TECH_NAME" />
                                                <ext:ModelField Name="SHIFT_ID" />
                                                <ext:ModelField Name="SHIFT_NAME" />
                                                <ext:ModelField Name="PLAN_DETAIL_ID" />
                                                <ext:ModelField Name="RECORD_TIME" Type="Date" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                                    <ext:Column ID="OBJID" runat="server" Text="工装计划号" DataIndex="OBJID"  Width="100" Hidden="false" />
                                    <ext:Column ID="SHOW_NAME" runat="server" Text="计划状态" DataIndex="SHOW_NAME" Width="100" />
                                    <ext:DateColumn ID="TOOLING_PLAN_DATE" runat="server" Text="计划日期" DataIndex="TOOLING_PLAN_DATE" Width="120" Format="yyyy-MM-dd" />
                                    <ext:Column ID="SHIFT_NAME" runat="server" Text="班次" DataIndex="SHIFT_NAME" Width="80" />
                                    <ext:Column ID="EQUIP_NAME" runat="server" Text="机台名称" DataIndex="EQUIP_NAME" Width="100" />
                                    <ext:Column ID="MATERIAL_NAME" runat="server" Text="规格" DataIndex="MATERIAL_NAME" Width="260" />
                                    <ext:Column ID="TECH_NAME" runat="server" Text="工艺版本" DataIndex="TECH_NAME" Width="300" />
                                    <ext:Column ID="BOM_NAME" runat="server" Text="BOM版本" DataIndex="BOM_NAME" Width="300" />
                                    <ext:DateColumn ID="RECORD_TIME" runat="server" Text="计划生成时间" DataIndex="RECORD_TIME" Width="200" Format="yyyy-MM-dd HH:mm:ss" />
                                </Columns>
                            </ColumnModel>
                            <Plugins>
                                <ext:CellEditing ID="cellEditing1" runat="server" ClicksToEdit="1">
                                </ext:CellEditing>
                            </Plugins>

                            <SelectionModel>
                                <ext:RowSelectionModel ID="rowSelectMuti" runat="server" Mode="Single">
                                    <Listeners>
                                        <Select Handler="#{storeDetail}.reload();" Buffer="250" />
                                    </Listeners>
                                </ext:RowSelectionModel>
                            </SelectionModel>

                            <BottomBar>
                                <ext:PagingToolbar ID="pageToolBar" runat="server" >
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
