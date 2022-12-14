<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StoragePlaceBaseInfo.aspx.cs" Inherits="Plugins_Semis_BasicInfo_StorageInfo_StoragePlaceBaseInfo" %>
<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js" ></script>
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell
        {
        	background-color: #FF8C69 !important;
        }
    </style>
    <script type="text/javascript">
        var defaultStoragePlace = function (value) {

            return Ext.String.format(value == 1 ? "百叶车" : "工字轮");
        }
        var defaultPositionType = function (value) {
            return Ext.String.format(value == "1" ? "投入库" : "产出库");
        }
        //树形结构点击刷新右侧方法
        var treePanelStorage = function (store, operation, options) {
            var node = operation.node;
            var nodeid = node.getId() || "";
            App.direct.treePanelStorageLoad(nodeid, {
                success: function (result) {
                    node.set('loading', false);
                    node.set('loaded', true);
                    var data = Ext.decode(result);
                    if (data != "") {
                        node.appendChild(data, undefined, true);
                        node.expand();
                    }
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('错误', errorMsg);
                }
            });
            return false;
        };

        var treeStorageClick = function (record) {

            App.direct.SetSelectStorageID(record.getId(), {
                success: function (result) {
                },
                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
          
        }

        var SetRowClass = function (record, rowIndex, rowParams, store) {
            if (record.get("USED_FLAG") == "0") {
                return "x-grid-row-collapsed";
            }
        }
        //点击修改按钮
        var commandcolumn_direct_edit = function (record) {
            var ObjID = record.data.OBJID;
            App.hiddenStorageName.setValue(record.data.STORE_NAME);
            App.hiddenStoragePlaceName.setValue(record.data.STORE_PLACE_NAME);
            App.hiddenStoragePlaceNum.setValue(record.data.STORAGE_NUMBER);
            App.hiddenMaterialName.setValue(record.data.MATERIAL_NAME);
            App.hiddenResponUser.setValue(record.data.DUMMY_2)
            App.hiddenMaterialId.setValue(record.data.MATERIAL_ID);
            App.hiddenSpecialFlag.setValue(record.data.SPECIAL_PLACE);
            App.hiddenPositonType.setValue(record.data.POSITION_TYPE);
            App.hiddenEquipName.setValue(record.data.EQUIP_NAME);
            App.hiddenEquipTypeName.setValue(record.data.MINOR_TYPE_NAME);
            App.hiddenLLBarcode.setValue(record.data.DUMMY_3);
            App.hiddenRemark.setValue(record.data.REMARK);
            App.direct.commandcolumn_direct_edit(ObjID, {
                success: function (result) {
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        //点击删除按钮
        var commandcolumn_direct_delete = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var ObjID = record.data.OBJID;
            App.direct.commandcolumn_direct_delete(ObjID, {
                success: function (result) {
                    Ext.Msg.alert('操作', result);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }


        //点击取消作废按钮
        var commandcolumn_direct_returncancel = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var ObjID = record.data.OBJID;
            App.direct.commandcolumn_direct_returncancel(ObjID, {
                success: function (result) {
                    Ext.Msg.alert('操作', result);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        //区分删除操作，并进行二次确认操作
        var commandcolumn_click_confirm = function (command, record) {
            if (command.toLowerCase() == "edit") {
                commandcolumn_direct_edit(record);
            }
            if (command.toLowerCase() == "delete") {
                Ext.Msg.confirm("提示", '您确定需要删除此条信息？', function (btn) { commandcolumn_direct_delete(btn, record) });
            }
            if (command.toLowerCase() == "returncancel") {
                Ext.Msg.confirm("提示", '您确定要作废吗？', function (btn) { commandcolumn_direct_returncancel(btn, record) });
            }
            return false;
        };

        //根据按钮类别进行删除和编辑操作
        var commandcolumn_click = function (command, record) {
            commandcolumn_click_confirm(command, record);
            return false;
        };

        Ext.apply(Ext.form.VTypes, {
            integer: function (val, field) {
                if (!val) {
                    return true;
                }
                try {
                    if (/^[\d]+$/.test(val)) {
                        return true;
                    }
                    else {
                        return false;
                    }
                }
                catch (e) {
                    return false;
                }
            },
            integerText: "此填入项格式为正整数"
        });


        var pnlListFresh = function () {
            if (App.txtStorageName.getValue() == "")
                App.hiddenSelectStorageId.setValue("");
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }

        var prepareToolbar = function (grid, toolbar, rowIndex, record) {
            if (record.get("USED_FLAG") == "0") {
                toolbar.items.getAt(2).hide();

            }
            else if (record.get("USED_FLAG") == "1") {
                toolbar.items.getAt(0).hide();
                toolbar.items.getAt(1).hide();
            }
        };

        var defaultChange = function (value) {
            return Ext.String.format(value ? "默认" : "");
        };

        var lockChange = function (value) {
            return Ext.String.format(value ? "已启用" : "否");
        };



        var commandcolumn_direct_useddflag = function (btn) {
            if (btn != "yes") {
                return;
            }
            App.direct.btnBatchUsing_Click({
                success: function (result) {
                    Ext.Msg.alert('操作', result);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        var SetLockedFlag = function () {
            var section = App.pnlList.getView().getSelectionModel().getSelection();
            var grid = App.pnlList;
            grid.store.model.getFields()
            //record = grid.store.getById(id);
            /*
            if (section.record.get("USED_FLAG") == "1")
            {
                debugger;
                alert('已经作废的不能启用！！！');
            }*/
            if (section && section.length == 0) {

                alert('您没有选择任何项，请选择！');
            }
            else {
            Ext.Msg.confirm("提示", '启用后下级库房同时启用，确定要启用吗？', function (btn) { commandcolumn_direct_useddflag(btn) });
            }
        }
    </script>

    <script type="text/javascript">
       
        var EditStorage = function () {//库房修改

            debugger;
            var queryWindow = App.Plugins_Semis_BasicInfo_CommonPage_QueryBasStorage_Window;
            var html = "<iframe src='../../BasicInfo/CommonPage/QueryBasStorage.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>";
            if (queryWindow.getBody()) {
                queryWindow.getBody().update(html);
            } else {
                queryWindow.html = html;
            }
            queryWindow.show();
        }
        
        Ext.create("Ext.window.Window", {//库房查询带窗体
            id: "Plugins_Semis_BasicInfo_CommonPage_QueryBasStorage_Window",
            height: 460,
            hidden: true,
            width: 360,
            html: "<iframe src='../../BasicInfo/CommonPage/QueryBasStorage.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择库房",
            modal: true
        })
        //END
        //--查询带弹出框--BEGIN
        var Plugins_Semis_BasicInfo_CommonPage_QueryBasStorage_Request = function (record) {//库房信息返回值处理
            if (!App.winAdd.hidden) {
                App.txtStorageName2.setValue(record.data.STORE_NAME);
                App.hiddenStorageId.setValue(record.data.STORE_CODE);
            }
            else if (!App.winModify.hidden) {

                App.txtStorageName1.setValue(record.data.STORE_NAME);
                App.hiddenStorageId.setValue(record.data.STORE_CODE);
            }
            else {
                App.txtStorageName.getTrigger(0).show();
                App.txtStorageName.setValue(record.data.STORE_NAME);
                App.hiddenSelectStorageId.setValue(record.data.STORE_CODE);
            }
        }

        var SelectStorage = function (field, trigger, index) {//库房查询
            switch (index) {
                case 0:
                    field.getTrigger(0).hide();
                    field.setValue('');
                    App.hiddenSelectStorageId.setValue("");
                    field.getEl().down('input.x-form-text').setStyle('background', "white");
                    break;
                case 1:
                    var url = "../../BasicInfo/CommonPage/QueryBasStorage.aspx?UsedFlag=0&&StorageType=" + App.cbxStorageType.getValue();
                    var html = "<iframe src='" + url + "' width=100% height=100% scrolling=no frameborder=0></iframe>";
                    if (App.Plugins_Semis_BasicInfo_CommonPage_QueryBasStorage_Window.getBody()) {
                        App.Plugins_Semis_BasicInfo_CommonPage_QueryBasStorage_Window.getBody().update(html);
                    } else {
                        App.Plugins_Semis_BasicInfo_CommonPage_QueryBasStorage_Window.html = html;
                    }
                    App.Plugins_Semis_BasicInfo_CommonPage_QueryBasStorage_Window.show();
                    break;
            }
        }

    </script>

    <script type="text/javascript">
        var EditMaterial = function () {//物料选择

            var queryWindow = App.Plugins_Semis_BasicInfo_CommonPage_QueryMaterial_Window;
            var html = "<iframe src='../../BasicInfo/CommonPage/QueryMaterial.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>";
            if (queryWindow.getBody()) {
                queryWindow.getBody().update(html);
            } else {
                queryWindow.html = html;
            }
            queryWindow.show();
        }
        var Plugins_Semis_BasicInfo_CommonPage_QueryMaterial_Request = function (record) {
            var queryWindow = App.Plugins_Semis_BasicInfo_CommonPage_QueryMaterial_Window;
            var thisIsModifyWindow = function (record) {
                if (App.winModify.hidden) {
                    return;
                }
                App.txtModifyMaterial.getTrigger(0).show();
                App.hiddenMaterialId.setValue(record.data.OBJID);
                App.txtModifyMaterial.setValue(record.data.MATERIAL_NAME);
            }
            thisIsModifyWindow(record);
            queryWindow.close();
        }
        Ext.create("Ext.window.Window", {//物料带窗体
            id: "Plugins_Semis_BasicInfo_CommonPage_QueryMaterial_Window",
            height: 460,
            hidden: true,
            width: 360,
            html: "<iframe src='../../BasicInfo/CommonPage/QueryMaterial.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择物料",
            modal: true
        })
    </script>

    <script type="text/javascript">
        var EditEquip = function () {//设备选择

            var queryWindow = App.Plugins_Semis_BasicInfo_CommonPage_QueryEquip_Window;
            var html = "<iframe src='../../BasicInfo/CommonPage/QueryEquip.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>";
            if (queryWindow.getBody()) {
                queryWindow.getBody().update(html);
            } else {
                queryWindow.html = html;
            }
            queryWindow.show();
        }
        var Plugins_Semis_BasicInfo_CommonPage_QueryEquip_Request = function (record) {
            var queryWindow = App.Plugins_Semis_BasicInfo_CommonPage_QueryEquip_Window;
            var thisIsModifyWindow = function (record) {
                if (App.winModify.hidden) {
                    return;
                }
                App.txtModifyEquip.getTrigger(0).show();
                debugger;
                App.hiddenEquipId.setValue(record.data.OBJID);
                App.txtModifyEquip.setValue(record.data.EQUIP_NAME);
            }
            thisIsModifyWindow(record);
            queryWindow.close();
        }
        Ext.create("Ext.window.Window", {//设备带窗体
            id: "Plugins_Semis_BasicInfo_CommonPage_QueryEquip_Window",
            height: 460,
            hidden: true,
            width: 360,
            html: "<iframe src='../../BasicInfo/CommonPage/QueryEquip.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择设备",
            modal: true
        })
    </script>

    <script type="text/javascript">
        var EditEquipType = function () {//设备小类选择

            var queryWindow = App.Plugins_Semis_BasicInfo_CommonPage_QueryEquipType_Window;
            var html = "<iframe src='../../BasicInfo/CommonPage/QueryEquipType.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>";
            if (queryWindow.getBody()) {
                queryWindow.getBody().update(html);
            } else {
                queryWindow.html = html;
            }
            queryWindow.show();
        }
        var Plugins_Semis_BasicInfo_CommonPage_QueryEquipType_Request = function (record) {
            var queryWindow = App.Plugins_Semis_BasicInfo_CommonPage_QueryEquipType_Window;
            var thisIsModifyWindow = function (record) {
                if (App.winModify.hidden) {
                    return;
                }
                App.txtModifyEquipType.getTrigger(0).show();
                debugger;
                App.hiddenEquipTypeId.setValue(record.data.OBJID);
                App.txtModifyEquipType.setValue(record.data.MINOR_TYPE_NAME);
            }
            thisIsModifyWindow(record);
            queryWindow.close();
        }
        Ext.create("Ext.window.Window", {//设备带窗体
            id: "Plugins_Semis_BasicInfo_CommonPage_QueryEquipType_Window",
            height: 460,
            hidden: true,
            width: 360,
            html: "<iframe src='../../BasicInfo/CommonPage/QueryEquipType.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择设备类型",
            modal: true
        })
    </script>

    
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="rmStoragePlace" runat="server" />
        <ext:Viewport ID="vpStoragePlace" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="Panel1" runat="server" Region="West" Width="235" Layout="BorderLayout">
                    <Items>
                         <ext:TreePanel ID="treePanel" runat="server" Title="库房列表" Region="Center"  Icon="FolderGo" AutoHeight="true" RootVisible="false">
                            <Store>
                                <ext:TreeStore ID="treeStorage" runat="server">
                                    <Proxy>
                                        <ext:PageProxy>
                                            <RequestConfig Method="GET" Type="Load" />
                                        </ext:PageProxy>
                                    </Proxy>
                                    <Root>
                                        <ext:Node NodeID="root" Expanded="true" />
                                    </Root>
                                </ext:TreeStore>
                            </Store>
                            <Listeners>
                                <BeforeLoad Fn="treePanelStorage" />
                                <ItemClick Handler="treeStorageClick(record)" />
                            </Listeners>
                        </ext:TreePanel>       
                    </Items>
                </ext:Panel>
                <ext:Panel ID="pnStoragePlaceTitle" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbStoragePlace">
                            <Items>
                                <ext:Button runat="server" Icon="Add" Text="添加" ID="btnAdd">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttAdd" runat="server" Html="点击进行添加" />
                                    </ToolTips>
                                    <DirectEvents>
                                        <Click OnEvent="btnAdd_Click">
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="tsBegin" />
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="点击进行查询" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="pnlListFresh"></Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="tsMiddle" />
                                 <ext:Button runat="server" Icon="LockEdit" Text="库位启用" ID="btnUsed">
                                    <%--<DirectEvents>
                                        <Click OnEvent="btnBatchUsing_Click" />
                                    </DirectEvents>--%>
                                    <Listeners>
                                        <Click Handler="SetLockedFlag();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="tsEnd" />
                                <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                                <ext:ToolbarFill ID="tfEnd" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>

                    <Items>
                        <ext:Panel ID="pnlStorageQuery" runat="server" AutoHeight="true">
                            <Items>
                                <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <%--<ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25" Padding="5">
                                            <Items>
                                                <ext:ComboBox ID="cbxStorageType" runat="server" FieldLabel="库房类型" LabelAlign="Right"  DisplayField="StoreName" ValueField="StoreCode">
                                                    <Store>
                                                        <ext:Store runat="server" ID="StoreType">
                                                            <Model>
                                                                <ext:Model ID="Model3" runat="server" IDProperty="ID">
                                                                    <Fields>
                                                                        <ext:ModelField Name="StoreCode" ></ext:ModelField>
                                                                        <ext:ModelField Name="StoreName" ></ext:ModelField>
                                                                    </Fields>
                                                                </ext:Model>
                                                                </Model>
                                                            </ext:Store>
                                                        </Store>
                                                </ext:ComboBox>
                                            </Items>
                                        </ext:Container> --%>
                                       <%-- <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".25" Padding="5">
                                            <Items>
                                                <ext:TriggerField ID="txtStorageName" runat="server" FieldLabel="库房名称" LabelAlign="Right" Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Fn="SelectStorage" />
                                                    </Listeners>
                                                </ext:TriggerField>
                                            </Items>
                                        </ext:Container>--%>
                                        <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".25" Padding="5">
                                            <Items>
                                                <ext:TextField ID="txtStorageName" runat="server" FieldLabel="库房名称" LabelAlign="Right" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25" Padding="5">
                                            <Items>
                                                <ext:TextField ID="txtStoragePlaceName" runat="server" FieldLabel="库位名称" LabelAlign="Right" />
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                    <Listeners>
                                        <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                                    </Listeners>
                                </ext:FormPanel>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:GridPanel ID="pnlList" runat="server" Region="Center">
                    <Store>
                        <ext:Store ID="store" runat="server" PageSize="50"> 
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="STORE_CODE" />
                                        <ext:ModelField Name="STORE_NAME" />
                                        <ext:ModelField Name="STORE_PLACE_CODE" />
                                        <ext:ModelField Name="STORE_PLACE_NAME" />
                                        <ext:ModelField Name="USER_NAME" />
                                        <ext:ModelField Name="USED_FLAG" />
                                        <ext:ModelField Name="DELETE_FLAG" />
                                        <ext:ModelField Name="AutoGenFlag" />
                                        <ext:ModelField Name="STORAGE_NUMBER" />
                                        <ext:ModelField Name="POSITION_TYPE" />
                                        <ext:ModelField Name="SPECIAL_PLACE" />
                                        <ext:ModelField Name="MATERIAL_NAME" />
                                        <ext:ModelField Name="MATERIAL_ID" />
                                        <ext:ModelField Name="DUMMY_2" />
                                        <ext:ModelField Name="DUMMY_3" />
                                        <ext:ModelField Name="MINOR_TYPE_NAME" />
                                        <ext:ModelField Name="EQUIP_NAME" />
                                        <ext:ModelField Name="REMARK" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                            <ext:Column ID="storageID" runat="server" Text="库房编号" Hidden="true" DataIndex="STORE_CODE"  />
                            <ext:Column ID="storageName" runat="server" Text="库房名称" DataIndex="STORE_NAME" Width="150"/>
                            <ext:Column ID="llBarcode" runat="server" Text="玲珑编码" DataIndex="DUMMY_3" Width="150"/>
                            <ext:Column ID="storagePlaceID" runat="server" Text="库位编号"  DataIndex="STORE_PLACE_CODE"  />
                            <ext:Column ID="storagePlaceName" runat="server" Text="库位名称" DataIndex="STORE_PLACE_NAME" />
                            <ext:Column ID="defaultFlag" runat="server" Text="是否默认库位" DataIndex="DefaultFlag" Hidden="true">
                                <Renderer Fn="defaultChange" />
                            </ext:Column>
                            <ext:Column ID="equipType" runat="server" Text="设备类型" DataIndex="MINOR_TYPE_NAME" Width="80" />
                            <ext:Column ID="equipName" runat="server" Text="设备名称" DataIndex="EQUIP_NAME" Width="100" />
                            <ext:Column ID="materialName" runat="server" Text="物料名称" DataIndex="MATERIAL_NAME" Width="150" />
                            <ext:CheckColumn ID="lockFlag" runat="server" Text="是否启用" DataIndex="USED_FLAG" Width="80">
                                <Renderer Fn="lockChange" />
                            </ext:CheckColumn>

                            <ext:Column ID="storagePlaceSubAmount" runat="server" Text="子库位数量" DataIndex="STORAGE_NUMBER" Width="80">
                            </ext:Column>
                            <ext:Column ID="specialStorage" runat="server" Text="工装类型" DataIndex="SPECIAL_PLACE" Width="80">
                                <Renderer Fn="defaultStoragePlace"></Renderer>
                            </ext:Column>
                            <ext:Column ID="Column1" runat="server" Text="库位类型" DataIndex="POSITION_TYPE" Width="80">
                                <Renderer Fn="defaultPositionType"></Renderer>
                            </ext:Column>
                            <ext:Column ID="userName" runat="server" Text="记录人" DataIndex="USER_NAME"  Width="100" />
                            <ext:Column ID="responUser" runat="server" Text="责任人" DataIndex="DUMMY_2"  Width="100" />
                            <ext:Column ID="remark" runat="server" Text="备注" DataIndex="REMARK"  Width="100" />
                            <ext:CommandColumn ID="commandCol" runat="server" Width="150" Text="操作" Align="Center">
                                <Commands>
                                    <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
                                        <ToolTip Text="修改本条数据" />
                                    </ext:GridCommand>
                                    <ext:GridCommand Icon="Delete" CommandName="Delete" Text="删除">
                                        <ToolTip Text="删除本条数据" />
                                    </ext:GridCommand>
                                    <ext:GridCommand Icon="TableEdit" CommandName="ReturnCancel" Text="作废">
                                    </ext:GridCommand>
                                </Commands>
                                <PrepareToolbar Fn="prepareToolbar" />
                                <Listeners>
                                    <Command Handler="return commandcolumn_click(command, record);" />
                                </Listeners>
                            </ext:CommandColumn>
                        </Columns>
                    </ColumnModel>
                    <SelectionModel>
                        <ext:RowSelectionModel ID="rowSelectMuti" runat="server" Mode="Single" />
                    </SelectionModel>
                    <View>
                        <ext:GridView ID="gvRows" runat="server" EnableTextSelection="true">
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
                <ext:Window ID="winModify" runat="server" Icon="MonitorEdit" Closable="false" Title="修改库位信息"
                    Width="320" Height="380" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
                    BodyPadding="5" Layout="Form">
                    <Items> 
                        <ext:FormPanel ID="pnlEdit" runat="server" Flex="1" BodyPadding="5">
                            <FieldDefaults>
                                <CustomConfig>
                                    <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                                    <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                                </CustomConfig>
                            </FieldDefaults>
                            <Items>
                                <ext:TextField ID="txtObjID1" runat="server" FieldLabel="库房编号" LabelAlign="Left" ReadOnly="true" Hidden="true" Enabled="true" />
                                <ext:TextField ID="txtStorageName1" runat="server" FieldLabel="库房名称" IndicatorText="*" IndicatorCls="red-text" LabelAlign="Left" Editable="false" ReadOnly="true">
                                </ext:TextField>
                                <ext:TextField ID="txtStoragePlaceName1" runat="server" FieldLabel="库位名称" AllowBlank="false" IndicatorText="*" IndicatorCls="red-text" LabelAlign="Left" IsRemoteValidation="true" >
                                     <RemoteValidation OnValidation="CheckField" />
                                </ext:TextField>
                                <ext:TextField ID="txtLLBarcode" runat="server" FieldLabel="玲珑编码" LabelAlign="Left" IsRemoteValidation="true" >
                                     <RemoteValidation OnValidation="CheckField2" />
                                </ext:TextField>
                                <ext:TextField ID="txtStoragePlacaSubAmount" runat="server" FieldLabel="子库位数量" LabelAlign="Left" IsRemoteValidation="true">
                                    <RemoteValidation OnValidation="CheckFieldAmount" />
                                </ext:TextField>
                                <ext:TriggerField ID="txtModifyEquipType" runat="server" FieldLabel="设备类型" LabelAlign="Left"  >
                                    <Triggers>
                                        <ext:FieldTrigger Icon="Search" />
                                    </Triggers>
                                    <Listeners>
                                        <TriggerClick Fn="EditEquipType" />
                                    </Listeners>
                                </ext:TriggerField>
                                <ext:TriggerField ID="txtModifyEquip" runat="server" FieldLabel="设备名称" LabelAlign="Left">
                                    <Triggers>
                                        <ext:FieldTrigger Icon="Search" />
                                    </Triggers>
                                    <Listeners>
                                        <TriggerClick Fn="EditEquip" />
                                    </Listeners>
                                </ext:TriggerField>

                                <ext:TriggerField ID="txtModifyMaterial" runat="server" FieldLabel="物料名称" LabelAlign="Left" Editable="false" Width="280">
                                    <Triggers>
                                        <ext:FieldTrigger Icon="Search" />
                                    </Triggers>
                                    <Listeners>
                                        <TriggerClick Fn="EditMaterial" />
                                    </Listeners>
                                </ext:TriggerField>
                                <ext:Checkbox ID="chkModifySpecialPlaceFlag" runat="server" FieldLabel="百叶车" LabelAlign="Left"/>
                                <ext:Checkbox ID="chkModifyPositionType" runat="server" FieldLabel="产出库" LabelAlign="Left"/>
                                <ext:TextField ID="txtResponUser" runat="server" FieldLabel="责任人" LabelAlign="Left" />
                                <ext:TextField ID="txtRemark1" runat="server" FieldLabel="备注" LabelAlign="Left" />
                            </Items>
                             <Listeners>
                                <ValidityChange Handler="#{btnModify}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="btnModify" runat="server" Text="确定" Icon="Accept">
                            <DirectEvents>
                                <Click OnEvent="btnModify_Click">
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button ID="btnModifyCancel" runat="server" Text="取消" Icon="Cancel">
                            <DirectEvents>
                                <Click OnEvent="btnCancel_Click">
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                    <Listeners>
                        <Show Handler="for(var i=0;i<#{vpStoragePlace}.items.length;i++){#{vpStoragePlace}.getComponent(i).disable(true);}" />
                        <Hide Handler="for(var i=0;i<#{vpStoragePlace}.items.length;i++){#{vpStoragePlace}.getComponent(i).enable(true);}" />
                    </Listeners>
                </ext:Window>
                <ext:Window ID="winAdd" runat="server" Icon="MonitorAdd" Closable="false" Title="添加库位信息" Width="320" Height="380" 
                    Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;" BodyPadding="5" Layout="Form">
                    <Items>
                        <ext:FormPanel ID="pnlAdd" runat="server" BodyPadding="5">
                             <FieldDefaults>
                                <CustomConfig>
                                    <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                                    <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                                </CustomConfig>
                            </FieldDefaults>
                            <Items>
                                <ext:TextField ID="txtStorageName2" runat="server" AllowBlank="false" FieldLabel="库房名称" IndicatorText="*" IndicatorCls="red-text" LabelAlign="Left" Editable="false" ReadOnly="true">
                                </ext:TextField>
                                <ext:TextField ID="txtStoragePlaceName2" runat="server" FieldLabel="库位名称" LabelAlign="Left" AllowBlank="false" IndicatorText="*" IndicatorCls="red-text" IsRemoteValidation="true">
                                    <RemoteValidation OnValidation="CheckField" />
                                </ext:TextField>
                                <ext:TextField ID="txtRemark2" runat="server" FieldLabel="备注" LabelAlign="Left" />
                            </Items>
                            <Listeners>
                                <ValidityChange Handler="#{btnAddSave}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                    </Items>
                     <Buttons>
                        <ext:Button ID="btnAddSave" runat="server" Text="确定" Icon="Accept" Disabled="true">
                            <DirectEvents>
                                <Click OnEvent="btnAddSave_Click">
                                    <EventMask ShowMask="true" Msg="Saving..." MinDelay="50" />
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button ID="btnAddCancel" runat="server" Text="取消" Icon="Cancel">
                            <DirectEvents>
                                <Click OnEvent="btnCancel_Click">
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                    <Listeners>
                        <Show Handler="for(var i=0;i<#{vpStoragePlace}.items.length;i++){#{vpStoragePlace}.getComponent(i).disable(true);}" />
                        <Hide Handler="for(var i=0;i<#{vpStoragePlace}.items.length;i++){#{vpStoragePlace}.getComponent(i).enable(true);}" />
                    </Listeners>
                </ext:Window>
                <ext:Hidden ID="hiddenSelectStorageId" runat="server"></ext:Hidden>
                <ext:Hidden ID="hiddenStorageId" runat="server"></ext:Hidden>
                <ext:Hidden ID="hiddenStoragePlaceNum" runat="server"></ext:Hidden>
                <ext:Hidden ID="hiddenStoragePlaceName" runat="server"></ext:Hidden>
                <ext:Hidden ID="hiddenStorageName" runat="server"></ext:Hidden>
                <ext:Hidden ID="hiddenMaterialName" runat="server"></ext:Hidden>
                <ext:Hidden ID="hiddenPositonType" runat="server"></ext:Hidden>
                <ext:Hidden ID="hiddenSpecialFlag" runat="server"></ext:Hidden>
                <ext:Hidden ID="hiddenNodeId" runat="server"></ext:Hidden>
                <ext:Hidden ID="hiddenResponUser" runat="server"></ext:Hidden>
                <ext:Hidden ID="hiddenEquipTypeId" runat="server"></ext:Hidden>
                <ext:Hidden ID="hiddenEquipId" runat="server"></ext:Hidden>
                <ext:Hidden ID="hiddenEquipName" runat="server"></ext:Hidden>
                <ext:Hidden ID="hiddenEquipTypeName" runat="server"></ext:Hidden>
                <ext:Hidden ID="hiddenLLBarcode" runat="server"></ext:Hidden>
                <ext:Hidden ID="hiddenMaterialId" runat="server"></ext:Hidden>
                <ext:Hidden ID="hiddenRemark" runat="server"></ext:Hidden>

            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
