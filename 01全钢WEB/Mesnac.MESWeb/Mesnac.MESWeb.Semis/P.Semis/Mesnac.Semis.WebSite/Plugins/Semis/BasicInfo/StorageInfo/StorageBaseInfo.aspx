<%@ Page Language="C#" AutoEventWireup="true" CodeFile="StorageBaseInfo.aspx.cs" Inherits="Plugins_Semis_BasicInfo_StorageInfo_StorageBaseInfo" %>
<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell
        {
        	background-color: #FF8C69 !important;
        }
    </style>
    <script type="text/javascript">
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
            App.hiddenHigherLevel.setValue(record.getId());
            App.hiddenNodeID.setValue(record.getId());
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
  
        }

        //点击修改按钮
        var commandcolumn_direct_edit = function (record) {
            var ObjID = record.data.OBJID;
            //App.hiddenNoStorageID.setValue(record.data.StorageID);
            App.hiddenHppStoreObjID.setValue(ObjID);
            App.hiddenStorageName.setValue(record.data.STORE_NAME);
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

        //点击作废按钮
        var commandcolumn_direct_cancel = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            debugger;
            var ObjID = record.data.OBJID;
            App.direct.commandcolumn_direct_cancel(ObjID, {
                success: function (result) {
                    Ext.Msg.alert('操作', result);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        //点击启用按钮
        var commandcolumn_direct_returncancel = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var ObjID = record.data.OBJID;
            App.direct.commandcolumn_direct_returncancel(ObjID, {
                success: function (result) {
                    Ext.Msg.alert('操作', result);
                    //Ext.Msg.prompt('Notice','请输入你的姓名：',function callback(id,msg){alert('单击的按钮ID：'+id+'\n您输入的姓名是：'+msg);},this,false); 
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
                Ext.Msg.confirm("提示", '您确定要删除此条信息吗？', function (btn) { commandcolumn_direct_delete(btn, record) });
            }
            if (command.toLowerCase() == "cancel") {
                Ext.Msg.confirm("提示", '您确定要作废此条信息吗？', function (btn) { commandcolumn_direct_cancel(btn, record) });
            }
            if (command.toLowerCase() == "returncancel") {
                Ext.Msg.confirm("提示", '您确定要启用吗？', function (btn) { commandcolumn_direct_returncancel(btn, record) });
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
            App.hiddenHigherLevel.setValue("");
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }

        var prepareToolbar = function (grid, toolbar, rowIndex, record) {
            if (record.get("USED_FLAG") == "1") {
                toolbar.items.getAt(0).hide();
                toolbar.items.getAt(1).hide();
                toolbar.items.getAt(3).hide();
            }
            else {
                toolbar.items.getAt(2).hide();
            }
        };

        var startTrack = function () {
            this.checkboxes = [];
            var cb;

            Ext.select(".x-form-item", false).each(function (checkEl) {
                cb = Ext.getCmp(checkEl.dom.id.selected);
                cb.setValue(false);
                this.rowselect.push(cb);
            }, this);
        };

        dragTrack = function () {
            var tracker = this,
            grid = App.pnlList,
            view = grid.getView(),
            columns = grid.columns,
            row,
            sel,
            value;

            grid.getStore().each(function (record, i) {
                    row = Ext.fly(view.getNode(i)); 
                    sel = tracker.dragRegion.intersect(row.getRegion());

                    if (sel) {
                        grid.getSelectionModel().select(record, true, true);
                    }
                    else {
                        grid.getSelectionModel().deselect(record, true);
                    }
                });
            };

            //--查询带弹出框--BEGIN
        var Plugins_Semis_BasicInfo_CommonPage_QueryBasStorage_Request = function (record) {//库房信息返回值处理
            if (!App.winAdd.hidden) {
                debugger;
                App.txtStorageHigherLevel2.setValue(record.data.STORE_NAME);
                App.hiddenStorageID.setValue(record.data.STORE_CODE);
                App.hiddenObjID.setValue(record.data.OBJID);
                }
            else if (!App.winModify.hidden) {
                debugger;
                    App.txtStorageHigherLevel1.getTrigger(0).show();
                    App.txtStorageHigherLevel1.setValue(record.data.STORE_NAME);
                    App.hiddenStorageID.setValue(record.data.STORE_CODE);
                    App.hiddenObjID.setValue(record.data.OBJID);
                }
            }

        var AddStorage = function () {//库房添加
            debugger;
                var queryWindow = App.Plugins_Semis_BasicInfo_CommonPage_QueryBasStorage_Window;
                var html = "<iframe src='../../BasicInfo/CommonPage/QueryBasStorage.aspx?UsedFlag=1' width=100% height=100% scrolling=no  frameborder=0></iframe>";
                if (queryWindow.getBody()) {
                    queryWindow.getBody().update(html);
                } else {
                    queryWindow.html = html;
                }
                queryWindow.show();
            }

            var EditStorage = function (field, trigger, index) {//库房修改
                var url = "../../BasicInfo/CommonPage/QueryBasStorage.aspx?UsedFlag=0&&NoStorageID=" + App.hiddenNoStorageID.getValue();
                var html = "<iframe src='" + url + "' width=100% height=100% scrolling=no  frameborder=0></iframe>";
                if (App.Plugins_Semis_BasicInfo_CommonPage_QueryBasStorage_Window.getBody()) {
                    App.Plugins_Semis_BasicInfo_CommonPage_QueryBasStorage_Window.getBody().update(html);
                } else {
                    App.Plugins_Semis_BasicInfo_CommonPage_QueryBasStorage_Window.html = html;
                }
                switch (index) {
                    case 0:
                        field.getTrigger(0).hide();
                        field.setValue('');
                        App.hiddenStorageID.setValue("");
                        field.getEl().down('input.x-form-text').setStyle('background', "white");
                        break;
                    case 1:
                        App.Plugins_Semis_BasicInfo_CommonPage_QueryBasStorage_Window.show();
                        break;
                }
            }
//            var EditStorage = function () {//库房修改
//                App.Manager_BasicInfo_CommonPage_QueryBasStorage_Window.show();
//            }

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

            var commandcolumn_direct_usedflag = function (btn) {
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

            var SetUsedFlag = function () {
                var section = App.pnlList.getView().getSelectionModel().getSelection();
                
                if (section && section.length == 0) {
                    alert('您没有选择任何项，请选择！');
                }
                else {
                    Ext.Msg.confirm("提示", '启用后下级库房同时启用，确定要启用吗？', function (btn) { commandcolumn_direct_usedflag(btn) });
                }
            }

            var usedChange = function (value) {
                return Ext.String.format(value ? "已启用" : "否");
            };

    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="rmStorage" runat="server" />
        <ext:Viewport ID="vpStorage" runat="server" Layout="border">
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
                <ext:Panel ID="pnStorageTitle" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbStorage">
                            <Items>
                                <ext:Button runat="server" Icon="Add" Text="添加" ID="btnAdd">
                                    <DirectEvents>
                                        <Click OnEvent="btnAdd_Click" />
                                    </DirectEvents>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="tsBegin" />
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <Listeners>
                                        <Click Fn="pnlListFresh" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="tsMiddle" />
                                <ext:Button runat="server" Icon="LockEdit" Text="库房启用" ID="btnUsed">

                                    <Listeners>
                                        <Click Handler="SetUsedFlag();" />
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
                                        <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25" Padding="5">
                                            <Items>
                                                <ext:TextField ID="txtStorageName" runat="server" FieldLabel="库房名称" LabelAlign="Right" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25" Padding="5">
                                            <Items>
                                                <ext:ComboBox ID="cbxUsedFlag" runat="server" FieldLabel="是否启用" LabelAlign="Right">
                                                    <SelectedItems>
                                                        <ext:ListItem Value="all"></ext:ListItem>
                                                    </SelectedItems>
                                                    <Items>
                                                        <ext:ListItem Text="全部" Value="all" AutoDataBind="true"></ext:ListItem>
                                                        <ext:ListItem Text="是" Value="1"></ext:ListItem>
                                                        <ext:ListItem Text="否" Value="0"></ext:ListItem>
                                                    </Items>
                                                </ext:ComboBox>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container5" runat="server" Layout="FormLayout" ColumnWidth=".25" Padding="5">
                                            <Items>
                                                <ext:TextField ID="txtSapCode" runat="server" FieldLabel="SAP编号" LabelAlign="Right" />
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
                <ext:GridPanel ID="pnlList" runat="server" Cls="x-grid-custom" Region="Center">
                    <Store>
                        <ext:Store ID="store" runat="server" PageSize="20"> 
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server" IDProperty="STORE_CODE">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="STORE_CODE" />
                                        <ext:ModelField Name="STORE_NAME" />
                                        <ext:ModelField Name="USED_FLAG" />
                                        <ext:ModelField Name="RESPONPERSON" />
                                        <ext:ModelField Name="SAP_CODE" />
                                        <ext:ModelField Name="USER_NAME" />                                        
                                        <ext:ModelField Name="REMARK" />
                                        <ext:ModelField Name="HIGHER_STORE_NAME" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                            <ext:Column ID="objID" runat="server" Text="ID" Hidden="true" DataIndex="OBJID" Flex="1" />
                            <ext:Column ID="storageID" runat="server" Text="库房编号" DataIndex="STORE_CODE" Hidden="true" />
                            <ext:Column ID="storageName" runat="server" Text="库房名称" DataIndex="STORE_NAME" Flex="1" />
                            <ext:Column ID="storageHigherLevel" runat="server" Text="上级库房" DataIndex="HIGHER_STORE_NAME" Flex="1" />
                            <ext:Column ID="usedFlag" runat="server" Text="是否启用" DataIndex="USED_FLAG" Flex="1" >
                                <Renderer Fn="usedChange" />
                            </ext:Column>
                            <ext:Column ID="userName" runat="server" Text="记录人" DataIndex="USER_NAME" Flex="1" />
                            <ext:Column ID="responsiblePerson" runat="server" Text="负责人" DataIndex="RESPONPERSON" Flex="1" />
                            <ext:Column ID="Column1" runat="server" Text="SAP编号" DataIndex="SAP_CODE" Flex="1" />
                            <ext:Column ID="remark" runat="server" Text="备注" DataIndex="REMARK" Flex="1" />
                            <ext:CommandColumn ID="commandCol" runat="server" Width="200" Text="操作" Align="Center">
                                <Commands>
                                    <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
                                        <ToolTip Text="修改本条数据" />
                                    </ext:GridCommand>
                                    <ext:GridCommand Icon="Delete" CommandName="Delete" Text="删除">
                                        <ToolTip Text="删除本条数据" />
                                    </ext:GridCommand>
                                    <ext:GridCommand Icon="Delete" CommandName="Cancel" Text="作废">
                                        <ToolTip Text="作废本条数据" />
                                    </ext:GridCommand>
                                    <ext:GridCommand Icon="TableEdit" CommandName="ReturnCancel" Text="启用">
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
                        <ext:GridView EnableTextSelection="true"></ext:GridView>
                    </View> 
                    <BottomBar>
                        <ext:PagingToolbar ID="pageToolBar" runat="server">
                            <Plugins>
                                <ext:ProgressBarPager ID="ProgressBarPager" runat="server" />
                            </Plugins>
                        </ext:PagingToolbar>
                    </BottomBar>
                </ext:GridPanel>

                <ext:Window ID="winModify" runat="server" Icon="MonitorEdit" Closable="false" Title="修改库房信息"
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
                                <ext:ComboBox ID="cbxStorageType2" runat="server" FieldLabel="库房类型" LabelAlign="Left"  DisplayField="StoreName" ValueField="StoreCode" Hidden="true">
                                    <Store>
                                        <ext:Store runat="server" ID="StoreType2">
                                            <Model>
                                                <ext:Model ID="Model1" runat="server" IDProperty="ID">
                                                    <Fields>
                                                        <ext:ModelField Name="StoreCode" ></ext:ModelField>
                                                        <ext:ModelField Name="StoreName" ></ext:ModelField>
                                                    </Fields>
                                                </ext:Model>
                                                </Model>
                                            </ext:Store>
                                        </Store>
                                </ext:ComboBox>

                                <ext:TextField ID="txtObjID1" runat="server" FieldLabel="库房编号" LabelAlign="Left" Hidden="true" Enabled="true" />
                                <ext:TextField ID="txtStorageName1" runat="server" FieldLabel="库房名称" AllowBlank="false" IndicatorText="*" IndicatorCls="red-text" LabelAlign="Left" IsRemoteValidation="true" >
                                     <RemoteValidation OnValidation="CheckField" />
                                </ext:TextField>
                                 <ext:TriggerField ID="txtStorageHigherLevel1" runat="server" FieldLabel="上级库房"  LabelAlign="Left" Editable="false" Hidden="true">
                                    <Triggers>
                                        <ext:FieldTrigger Icon="Search" />
                                    </Triggers>
                                    <Listeners>
                                        <TriggerClick Fn="AddStorage" />
                                    </Listeners>
                                </ext:TriggerField>

                                <ext:TextField ID="txtERPCode1" runat="server" FieldLabel="SAP编号" LabelAlign="Left" />
                                <ext:TextField ID="txtResponsiblePerson1" runat="server" FieldLabel="负责人" LabelAlign="Left" />
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
                        <Show Handler="for(var i=0;i<#{vpStorage}.items.length;i++){#{vpStorage}.getComponent(i).disable(true);}" />
                        <Hide Handler="for(var i=0;i<#{vpStorage}.items.length;i++){#{vpStorage}.getComponent(i).enable(true);}" />
                    </Listeners>
                </ext:Window>
                <ext:Window ID="winAdd" runat="server" Icon="MonitorAdd" Closable="false" Title="添加库房信息" Width="320" Height="380" 
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
                                <ext:ComboBox ID="cbxStorageType3" runat="server" FieldLabel="库房类型" LabelAlign="Left"  DisplayField="StoreName" ValueField="StoreCode">
                                    <Store>
                                        <ext:Store runat="server" ID="StoreType3">
                                            <Model>
                                                <ext:Model ID="Model2" runat="server" IDProperty="ID">
                                                    <Fields>
                                                        <ext:ModelField Name="StoreCode" ></ext:ModelField>
                                                        <ext:ModelField Name="StoreName" ></ext:ModelField>
                                                    </Fields>
                                                </ext:Model>
                                                </Model>
                                            </ext:Store>
                                        </Store>
                                </ext:ComboBox>
                                

                                <ext:TextField ID="txtStorageName2" runat="server" FieldLabel="库房名称" AllowBlank="false" IndicatorText="*" IndicatorCls="red-text" LabelAlign="Left" IsRemoteValidation="true" >
                                     <RemoteValidation OnValidation="CheckField" />
                                </ext:TextField>
                                <ext:TriggerField ID="txtStorageHigherLevel2" runat="server" FieldLabel="上级库房" LabelAlign="Left" Editable="false">
                                    <Triggers>
                                        <ext:FieldTrigger Icon="Search" />
                                    </Triggers>
                                    <Listeners>
                                        <TriggerClick Fn="AddStorage" />
                                    </Listeners>
                                </ext:TriggerField>

                                <ext:TextField ID="txtERPCode2" runat="server" FieldLabel="ERP编号" LabelAlign="Left" />
                                <ext:TextField ID="txtResponsiblePerson2" runat="server" FieldLabel="负责人" LabelAlign="Left" />
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
                        <Show Handler="for(var i=0;i<#{vpStorage}.items.length;i++){#{vpStorage}.getComponent(i).disable(true);}" />
                        <Hide Handler="for(var i=0;i<#{vpStorage}.items.length;i++){#{vpStorage}.getComponent(i).enable(true);}" />
                    </Listeners>
                </ext:Window>
                <ext:Hidden ID="hiddenStorageID" runat="server"></ext:Hidden>
                <ext:Hidden ID="hiddenStorageName" runat="server"></ext:Hidden>
                <ext:Hidden ID="hiddenObjID" runat="server"></ext:Hidden>
                <ext:Hidden ID="hiddenHppStoreObjID" runat="server"></ext:Hidden>
                <ext:Hidden ID="hiddenNoStorageID" runat="server"></ext:Hidden>
                <ext:Hidden ID="hiddenHigherLevel" runat="server"></ext:Hidden>
                <ext:Hidden ID="hiddenNodeID" runat="server"></ext:Hidden>
            </Items>
        </ext:Viewport>
        <ext:DragTracker ID="DragTracker1" runat="server" ConstrainTo="={#{pnlList}.body}" Target="={#{pnlList}.body}" ProxyCls="black-view-selector">
            <Listeners>
                <Drag Fn="dragTrack" />
            </Listeners>
        </ext:DragTracker>

    </form>
</body>
</html>
