<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CuringMaterialRelationBC.aspx.cs" Inherits="Plugins_Curing_Technology_CuringMaterialRelationBC" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>胎胚成品规格关联</title>
    <script type="text/javascript">
        // 刷新胎胚
        var gridPanelBMaterRefresh = function () {
            App.gridPanelBMaterStore.currentPage = 1;
            App.gridPanelBMaterSelectionModel.doDeselect(App.gridPanelBMaterSelectionModel.selected);
            App.gridPanelBMaterPagingToolbar.doRefresh();
            return true;
        }

        // 查询
        var btnSearch_Click = function () {
            return gridPanelBMaterRefresh();
        };

        // 刷新成品胎
        var gridPanelCMaterRefresh = function () {
            App.gridPanelCMaterStore.currentPage = 1;
            App.gridPanelCMaterPagingToolbar.doRefresh();
            return true;
        }

        // 选择
        var gridPanelBMaterSelectionModel_SelectionChange = function (item, selected) {
            var buildingMaterialId = "";
            if (selected.length > 0) {
                buildingMaterialId = selected[0].data.BUILDING_MATERIAL_ID;
            }
            App.hdnBuildingMaterialId.setValue(buildingMaterialId);
            gridPanelCMaterRefresh();
            return true;
        };

        // 添加
        var btnAdd_Click = function () {
            App.hdnBuildingMaterialId.setValue("");
            App.direct.AddMaterialRelationBC({
                success: function (result) {

                },
                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        };

        // 修改
        var btnEdit_Click = function () {
            var buildingMaterialId = "";
            var selected = App.gridPanelBMaterSelectionModel.selected;
            if (selected.items.length == 0) {
                Ext.Msg.alert("提示", "请选择要修改的记录");
                return false;
            }
            buildingMaterialId = selected.items[0].data.BUILDING_MATERIAL_ID;
            App.hdnBuildingMaterialId.setValue(buildingMaterialId);
            App.direct.EditMaterialRelationBC(buildingMaterialId, {
                success: function (result) {

                },
                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        };

        //拖拽产生提示文字
        var getDragDropText = function () {
            var buf = [];

            buf.push("<ul>");

            Ext.each(this.view.panel.getSelectionModel().getSelection(), function (record) {
                buf.push("<li>" + record.data.CURING_MATERIAL_NAME + "</li>");
            });

            buf.push("</ul>");

            return buf.join("");
        };

        // 保存
        var btnMainSave_Click = function () {
            Ext.Msg.confirm("提示", '您确定要保存设置吗？', function (btn) {
                if (btn != "yes") {
                    return false;
                }
                var buildingMaterialId = App.hdnBuildingMaterialId.getValue();
                var jsonStr = Ext.encode(App.gridPanelRelated.getRowsValues());
                App.direct.SaveMaterialRelationBC(buildingMaterialId, jsonStr, {
                    success: function (result) {
                        if (result != "") {
                            Ext.Msg.alert('操作', result);
                            return false;
                        }
                        gridPanelBMaterRefresh();
                        App.winMain.close();
                        Ext.Msg.alert("成功", "保存成功");
                    },
                    failure: function (errorMsg) {
                        Ext.Msg.alert('操作', errorMsg);
                        return false;
                    }
                });
            });
            return true;
        };

        // 删除
        var btnDelete_Click = function () {
            var selected = App.gridPanelBMaterSelectionModel.selected;
            if (selected.items.length == 0) {
                Ext.Msg.alert("提示", "请选择要删除的记录");
                return false;
            }

            var buildingMaterialId = selected.items[0].data.BUILDING_MATERIAL_ID;
            var buildingMaterialName = selected.items[0].data.BUILDING_MATERIAL_NAME;

            Ext.Msg.confirm("提示", '您确定要删除吗？', function (btn) {
                if (btn != "yes") {
                    return false;
                }

                App.direct.DeleteMaterialRelationBC(buildingMaterialId, {
                    success: function (result) {
                        if (result != "") {
                            Ext.Msg.alert('操作', result);
                            return false;
                        }
                        gridPanelBMaterRefresh();
                        Ext.Msg.alert("成功", "删除成功");
                    },
                    failure: function (errorMsg) {
                        Ext.Msg.alert('操作', errorMsg);
                        return false;
                    }
                });

                return true;
            });

        };

        // 拖拽前
        var gridPanelRelated_BeforeDrow = function (node, data) {
            var curingMaterialId = data.records[0].data.CURING_MATERIAL_ID;
            var records = App.gridPanelRelated.getRowsValues();
            if (records.length == 0) {
                return true;
            }
            for (var i = 0; i < records.length; i++) {
                if (records[i].CURING_MATERIAL_ID == curingMaterialId) {
                    Ext.Msg.notify("操作", "请勿重复添加此成品胎规格");
                    return false;
                }
            }

            return true;
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager runat="server" ID="ResourceManager1">
        </ext:ResourceManager>
        <ext:Viewport runat="server" ID="Viewport1" Layout="BorderLayout">
            <Items>
                <%--显示条件--%>
                <ext:Panel runat="server" Region="North" Layout="FitLayout">
                    <TopBar>
                        <%--按钮列表--%>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:Button runat="server" ID="btnSearch" Icon="Find" Text="查询">
                                    <Listeners>
                                        <Click Handler="return btnSearch_Click();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" ID="btnAdd" Icon="Add" Text="添加">
                                    <Listeners>
                                        <Click Handler="return btnAdd_Click();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" ID="btnEdit" Icon="PageEdit" Text="修改">
                                    <Listeners>
                                        <Click Handler="return btnEdit_Click();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" ID="btnDelete" Icon="Delete" Text="删除">
                                    <Listeners>
                                        <Click Handler="return btnDelete_Click();" />
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <%--查询条件--%>
                        <ext:Panel runat="server" Layout="ColumnLayout">
                            <Items>
                                <ext:TextField runat="server" ID="txtSearchBuildingMaterialName" LabelAlign="Right" FieldLabel="胎胚规格" Width="280" />
                                <ext:TextField runat="server" ID="txtSearchCuringMaterialName" LabelAlign="Right" FieldLabel="成品胎规格" Width="420" />
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <%--显示内容--%>
                <ext:Panel runat="server" Region="Center" Layout="BorderLayout">
                    <Items>
                        <%--已关联的胎胚规格--%>
                        <ext:Panel runat="server" Region="West" Width="270" Layout="FitLayout">
                            <Items>
                                <ext:Hidden runat="server" ID="hdnBuildingMaterialId" />
                                <ext:GridPanel runat="server" ID="gridPanelBMater">
                                    <Store>
                                        <ext:Store runat="server" ID="gridPanelBMaterStore" AutoLoad="false" PageSize="20">
                                            <Proxy>
                                                <ext:PageProxy DirectFn="App.direct.GridPanelBMaterRelatedBindData" />
                                            </Proxy>
                                            <Model>
                                                <ext:Model runat="server" IDProperty="BUILDING_MATERIAL_ID">
                                                    <Fields>
                                                        <ext:ModelField Name="BUILDING_MATERIAL_ID" />
                                                        <ext:ModelField Name="BUILDING_MATERIAL_NAME" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel>
                                        <Columns>
                                            <ext:RowNumbererColumn Width="40" />
                                            <ext:Column DataIndex="BUILDING_MATERIAL_NAME" Text="胎胚规格" Width="200" />
                                        </Columns>
                                    </ColumnModel>
                                    <SelectionModel>
                                        <ext:CheckboxSelectionModel runat="server" ID="gridPanelBMaterSelectionModel" AllowDeselect="true" Mode="Single"
                                            ShowHeaderCheckbox="false">
                                            <Listeners>
                                                <SelectionChange Handler="return gridPanelBMaterSelectionModel_SelectionChange(item,selected);" />
                                            </Listeners>
                                        </ext:CheckboxSelectionModel>
                                    </SelectionModel>
                                    <View>
                                        <ext:GridView EnableTextSelection="true" />
                                    </View>
                                    <BottomBar>
                                        <ext:PagingToolbar runat="server" ID="gridPanelBMaterPagingToolbar" />
                                    </BottomBar>
                                </ext:GridPanel>
                            </Items>
                        </ext:Panel>
                        <%--已关联的成品胎规格--%>
                        <ext:Panel runat="server" Region="Center" Layout="FitLayout">
                            <Items>
                                <ext:GridPanel runat="server" ID="gridPanelCMater">
                                    <Store>
                                        <ext:Store runat="server" ID="gridPanelCMaterStore" PageSize="20" AutoLoad="false">
                                            <Proxy>
                                                <ext:PageProxy DirectFn="App.direct.GridPanelCMaterBindData" />
                                            </Proxy>
                                            <Model>
                                                <ext:Model runat="server">
                                                    <Fields>
                                                        <ext:ModelField Name="CURING_MATERIAL_ID" />
                                                        <ext:ModelField Name="CURING_MATERIAL_NAME" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel>
                                        <Columns>
                                            <ext:RowNumbererColumn Width="40" />
                                            <ext:Column DataIndex="CURING_MATERIAL_NAME" Text="成品胎规格" Width="350" />
                                        </Columns>
                                    </ColumnModel>
                                    <View>
                                        <ext:GridView EnableTextSelection="true" />
                                    </View>
                                    <BottomBar>
                                        <ext:PagingToolbar runat="server" ID="gridPanelCMaterPagingToolbar" />
                                    </BottomBar>
                                </ext:GridPanel>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <%--弹出窗口--%>
                <ext:Window runat="server" ID="winMain" Width="800" Height="450" Layout="FitLayout" Hidden="true" Modal="true">
                    <Items>
                        <ext:Panel runat="server" Layout="BorderLayout">
                            <TopBar>
                                <ext:Toolbar runat="server">
                                    <Items>
                                        <ext:ComboBox runat="server" ID="cboMainBuildingMaterial" LabelAlign="Right" FieldLabel="胎胚规格"
                                            DisplayField="BUILDING_MATERIAL_NAME" ValueField="BUILDING_MATERIAL_ID" AllowBlank="false"
                                            ForceSelection="true" QueryMode="Local">
                                            <Store>
                                                <ext:Store runat="server" ID="cboMainBuildingMaterialStore" AutoLoad="false">
                                                    <Model>
                                                        <ext:Model runat="server">
                                                            <Fields>
                                                                <ext:ModelField Name="BUILDING_MATERIAL_ID" />
                                                                <ext:ModelField Name="BUILDING_MATERIAL_NAME" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                        </ext:ComboBox>
                                        <ext:Component Width="50" />
                                        <ext:Button runat="server" ID="btnMainSave" Text="保存设置" Icon="Accept">
                                            <Listeners>
                                                <Click Handler="return btnMainSave_Click();" />
                                            </Listeners>
                                        </ext:Button>
                                        <ext:Button runat="server" ID="btnMainCancel" Text="取消" Icon="Cancel">
                                            <Listeners>
                                                <Click Handler="#{winMain}.close(); return false;" />
                                            </Listeners>
                                        </ext:Button>
                                    </Items>
                                </ext:Toolbar>
                            </TopBar>
                            <Items>
                                <ext:GridPanel runat="server" ID="gridPanelRelated" Region="West" Title="已关联的成品胎规格" Width="395">
                                    <Store>
                                        <ext:Store runat="server" AutoLoad="false" PageSize="500">
                                            <Proxy>
                                                <ext:PageProxy DirectFn="App.direct.GridPanelRelatedBindData" />
                                            </Proxy>
                                            <Model>
                                                <ext:Model runat="server">
                                                    <Fields>
                                                        <ext:ModelField Name="CURING_MATERIAL_ID" />
                                                        <ext:ModelField Name="CURING_MATERIAL_NAME" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel>
                                        <Columns>
                                            <ext:RowNumbererColumn Width="40" />
                                            <ext:Column DataIndex="CURING_MATERIAL_NAME" Text="成品胎规格" Width="350" />
                                        </Columns>
                                    </ColumnModel>
                                    <View>
                                        <ext:GridView EnableTextSelection="false">
                                            <Plugins>
                                                <ext:GridDragDrop DragGroup="firstGridDDGroup" DropGroup="secondGridDDGroup" />
                                            </Plugins>
                                            <Listeners>
                                                <BeforeDrop Handler="return gridPanelRelated_BeforeDrow(node, data);" />
                                                <AfterRender Handler="this.plugins[0].dragZone.getDragText = getDragDropText;" />
                                                <Drop Handler="Ext.net.Notification.show({title:'提示', html:'添加关联成品胎规格： ' + data.records[0].get('CURING_MATERIAL_NAME') + '成功'});" />
                                            </Listeners>
                                        </ext:GridView>
                                    </View>
                                    <BottomBar>
                                        <ext:PagingToolbar runat="server" ID="gridPanelRelatedPagingToolbar" Hidden="true" />
                                    </BottomBar>
                                </ext:GridPanel>
                                <ext:GridPanel runat="server" ID="gridPanelNotRelated" Region="Center" Title="未关联的成品胎规格">
                                    <Store>
                                        <ext:Store runat="server" AutoLoad="false" PageSize="200">
                                            <Proxy>
                                                <ext:PageProxy DirectFn="App.direct.GridPanelNotRelatedBindData" />
                                            </Proxy>
                                            <Model>
                                                <ext:Model runat="server">
                                                    <Fields>
                                                        <ext:ModelField Name="CURING_MATERIAL_ID" />
                                                        <ext:ModelField Name="CURING_MATERIAL_NAME" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                        </ext:Store>
                                    </Store>
                                    <ColumnModel>
                                        <Columns>
                                            <ext:RowNumbererColumn Width="40" />
                                            <ext:Column DataIndex="CURING_MATERIAL_NAME" Text="成品胎规格" Width="350" />
                                        </Columns>
                                    </ColumnModel>
                                    <View>
                                        <ext:GridView EnableTextSelection="false">
                                            <Plugins>
                                                <ext:GridDragDrop DragGroup="secondGridDDGroup" DropGroup="firstGridDDGroup" />
                                            </Plugins>
                                            <Listeners>
                                                <AfterRender Handler="this.plugins[0].dragZone.getDragText = getDragDropText;" />
                                                <Drop Handler="var dropOn = overModel ? ' ' + dropPosition + ' ' + overModel.get('CURING_MATERIAL_NAME') : ' on empty view';" />
                                            </Listeners>
                                        </ext:GridView>
                                    </View>
                                    <BottomBar>
                                        <ext:PagingToolbar runat="server" ID="gridPanelNotRelatedPagingToolbar" Hidden="false" HideRefresh="true" />
                                    </BottomBar>
                                </ext:GridPanel>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Window>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
