<%@ page language="C#" autoeventwireup="true" inherits="Plugins_Curing_ProductPlan_MonthPlan, Mesnac.CuringPlanLL.WebSite" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>月度计划</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript">
        var thisDirUrl = "<%= Page.ResolveUrl("./") %>";
        var thisRootUrl = "<%= Page.ResolveUrl("~/") %>";
    </script>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <script type="text/javascript">
        //-------物料-----查询带回弹出框--BEGIN
        var McUI_SearchBox_SearchBoxSbmMaterialCuring_Request = function (record) {//物料返回值处理
            if (!App.winAdd.hidden) {
                App.add_MATERIAL.setValue(record.data.MATERIAL_NAME);
                App.hidden_add_MATERIAL.setValue(record.data.OBJID);
            }
            else if (!App.winModify.hidden) {
                App.modify_MATERIAL.setValue(record.data.MATERIAL_NAME);
                App.hidden_modify_MATERIAL.setValue(record.data.OBJID);
            }
            else {
                App.txt_material.getTrigger(0).show();
                App.txt_material.setValue(record.data.MATERIAL_NAME);
                App.hidden_txt_material.setValue(record.data.OBJID);
            }
        }

        var SelectMaterial = function (field, trigger, index) {//物料查询
            switch (index) {
                case 0:
                    field.getTrigger(0).hide();
                    field.setValue('');
                    App.hidden_txt_material.setValue("");
                    field.getEl().down('input.x-form-text').setStyle('background', "white");
                    break;
                case 1:
                    App.McUI_SearchBox_SearchBoxSbmMaterialCuring_Window.show();
                    break;
            }
        }

        var UpdateDepartment = function (field, trigger, index) {//物料查询
            App.McUI_SearchBox_SearchBoxSbmMaterialCuring_Window.show();
        }
        Ext.create("Ext.window.Window", {//物料查询带回窗体
            id: "McUI_SearchBox_SearchBoxSbmMaterialCuring_Window",
            height: 430,
            hidden: true,
            width: 360,
            html: "<iframe src='" + thisRootUrl + "McUI/SearchBox/SearchBoxSbmMaterialCuring.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择物料",
            modal: true
        })
        //------------查询带回弹出框--END 
    </script>
    <script type="text/javascript">

        //点击修改按钮
        var commandcolumn_direct_edit = function (record) {
            var ObjId = record.data.OBJID;
            App.direct.commandcolumn_direct_edit(ObjId, {
                success: function (result) {
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        //点击恢复按钮
        var commandcolumn_direct_recover = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var ObjId = record.data.OBJID;
            App.direct.commandcolumn_direct_recover(ObjId, {
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
            var ObjId = record.data.OBJID;
            App.direct.commandcolumn_direct_delete(ObjId, {
                success: function (result) {
                    Ext.Msg.alert('操作', result);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }


        //点击删除密码按钮
        var commandcolumn_direct_deletepwd = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var ObjId = record.data.OBJID;
            App.direct.commandcolumn_direct_deletepwd(ObjId, {
                success: function (result) {
                    Ext.Msg.alert('操作', result);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        //点击初始化密码按钮
        var commandcolumn_direct_initpwd = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var ObjId = record.data.OBJID;
            App.direct.commandcolumn_direct_initpwd(ObjId, {
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
            if (command.toLowerCase() == "recover") {
                Ext.Msg.confirm("提示", '您确定需要恢复此条信息？', function (btn) { commandcolumn_direct_recover(btn, record) });
            }
            if (command.toLowerCase() == "deletepwd") {
                Ext.Msg.confirm("提示", '您确定需要禁止该用户登录系统？', function (btn) { commandcolumn_direct_deletepwd(btn, record) });
            }
            if (command.toLowerCase() == "initpwd") {
                Ext.Msg.confirm("提示", '您确定需要初始化密码？', function (btn) { commandcolumn_direct_initpwd(btn, record) });
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


        //列表刷新数据重载方法
        var pnlListFresh = function () {
            App.hidden_delete_flag.setValue("0");
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }

        //历史查询按钮点击列表刷新数据重载方法
        var pnlHistoryListFresh = function () {
            App.hidden_delete_flag.setValue("");
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }

        //历史查询根据DeleteFlag的值进行样式绑定
        var SetRowClass = function (record, rowIndex, rowParams, store) {
            if (record.get("DELETE_FLAG") == "1") {
                return "x-grid-row-deleted";
            }
        }
        //历史查询的每行按钮准备加载
        var prepareToolbar = function (grid, toolbar, rowIndex, record) {
            if (record.get("DELETE_FLAG") == "1") {
                toolbar.items.getAt(0).hide();
                toolbar.items.getAt(1).hide();
                toolbar.items.getAt(2).hide();
            } else {
                toolbar.items.getAt(3).hide();
            }
        }
    </script>
</head>
<body>
    <form id="fmUser" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        <ext:Viewport ID="Viewport1" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnlQueryTitle" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="barUser">
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
                                <ext:ToolbarSeparator ID="toolbarSeparator_begin" />
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="点击进行查询" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="pnlListFresh">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle" />
                                <ext:Button runat="server" Icon="Note" Text="历史查询" ID="btnHistorySearch">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip1" runat="server" Html="点击进行历史查询" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="pnlHistoryListFresh">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:Hidden ID="hidden_delete_flag" runat="server" Text="0" />
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle_2" />
                                <ext:Button runat="server" Icon="PageWhiteExcel" Text="导出" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" />
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:Panel ID="pnlQuery" runat="server" AutoHeight="true">
                            <Items>
                                <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container ID="container_1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:TextField ID="txt_month_query" Vtype="integer" runat="server" FieldLabel="年月"
                                                    LabelAlign="Right" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:TriggerField ID="txt_material" runat="server" FieldLabel="物料信息" LabelAlign="Right"
                                                    Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Fn="SelectMaterial" />
                                                    </Listeners>
                                                </ext:TriggerField>
                                                <ext:Hidden ID="hidden_txt_material" runat="server" />
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
                        <ext:Store ID="store" runat="server" PageSize="10">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="PLAN_MONTH" />
                                        <ext:ModelField Name="MATERIAL_ID" />
                                        <ext:ModelField Name="MATERIAL_NAME" />
                                        <ext:ModelField Name="PLAN_QTY" />
                                        <ext:ModelField Name="ADJUST_QTY" />
                                        <ext:ModelField Name="START_DATE" Type="Date"/>
                                        <ext:ModelField Name="END_DATE" Type="Date"/>
                                        <ext:ModelField Name="PLAN_CREATE_DATE"/>
                                        <ext:ModelField Name="PLAN_UPDATE_DATE"/>
                                        <ext:ModelField Name="RECORD_USER_ID" />
                                        <ext:ModelField Name="RECORD_TIME" />
                                        <ext:ModelField Name="BACKUP_FLAG" />
                                        <ext:ModelField Name="BACKUP_TIME" />
                                        <ext:ModelField Name="DELETE_FLAG" />
                                        <ext:ModelField Name="REMARK" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn ID="rowNumCol" Width="45" runat="server" />
                            <ext:Column ID="OBJID" runat="server" Text="编号" DataIndex="OBJID" Width="60"  Hidden="true"/>
                            <ext:Column ID="PLAN_MONTH" runat="server" Text="年月" DataIndex="PLAN_MONTH" Width="80" />
                            <ext:DateColumn ID="START_DATE" runat="server" Text="开始时间" DataIndex="START_DATE" Width="180" Format="yyyy-MM-dd"/>
                            <ext:DateColumn ID="END_DATE" runat="server" Text="结束时间" DataIndex="END_DATE" Width="180" Format="yyyy-MM-dd"/>
                            <ext:Column ID="MATERIAL_NAME" runat="server" Text="物料名称" DataIndex="MATERIAL_NAME" Width="200" />
                            <ext:Column ID="PLAN_QTY" runat="server" Text="计划数量" DataIndex="PLAN_QTY" Width="80" />
                            <ext:Column ID="ADJUST_QTY" runat="server" Text="调整后数量" DataIndex="ADJUST_QTY" Width="80" />
                            <ext:Column ID="REMARK" runat="server" Text="备注" DataIndex="REMARK" Width="60" />
                            <ext:CommandColumn ID="commandCol" runat="server" Width="120" Text="操作" Align="Center">
                                <Commands>
                                    <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
                                        <ToolTip Text="修改本条数据" />
                                    </ext:GridCommand>
                                    <ext:CommandSeparator />
                                    <ext:GridCommand Icon="Delete" CommandName="Delete" Text="删除">
                                        <ToolTip Text="删除本条数据" />
                                    </ext:GridCommand>
                                    <ext:GridCommand Icon="Accept" CommandName="Recover" Text="恢复">
                                        <ToolTip Text="恢复本条数据" />
                                    </ext:GridCommand>
                                </Commands>
                                <PrepareToolbar Fn="prepareToolbar" />
                                <Listeners>
                                    <Command Handler="return commandcolumn_click(command, record);" />
                                </Listeners>
                            </ext:CommandColumn>
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
                <ext:Window ID="winModify" runat="server" Icon="MonitorEdit" Closable="false" Title="修改月度计划信息"
                    Width="360" Height="280" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
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
                                <ext:Container runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container runat="server" Layout="FormLayout" ColumnWidth="1" Padding="5">
                                            <Items>
                                                <ext:TextField ID="modify_PLAN_MONTH" runat="server" FieldLabel="年月" LabelAlign="Left"  ReadOnly="true"/>
                                                <ext:DateField ID="modify_START_DATE" runat="server" FieldLabel="开始时间" LabelAlign="Right" />
                                                <ext:DateField ID="modify_END_DATE" runat="server" FieldLabel="结束时间" LabelAlign="Right" />
                                                <ext:TextField ID="modify_MATERIAL" runat="server" FieldLabel="物料名称" LabelAlign="Left"  ReadOnly="true"/>
                                                <ext:TextField ID="modify_PLAN_QTY" runat="server" FieldLabel="计划数量" LabelAlign="Left"  ReadOnly="true"/>
                                                <ext:TextField ID="modify_ADJUST_QTY" runat="server" FieldLabel="调整后数量" LabelAlign="Left" />
                                                <ext:TextField ID="modify_REMARK" runat="server" FieldLabel="备注" LabelAlign="Left" />
                                           
                                                <ext:Hidden ID="hidden_modify_objid" runat="server" />
                                           </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="btnModifySave" runat="server" Text="确定" Icon="Accept">
                            <DirectEvents>
                                <Click OnEvent="BtnModifySave_Click">
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button ID="btnModifyCancel" runat="server" Text="取消" Icon="Cancel">
                            <DirectEvents>
                                <Click OnEvent="BtnCancel_Click">
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                    <Listeners>
                        <Show Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).disable(true);}" />
                        <Hide Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).enable(true);}" />
                    </Listeners>
                </ext:Window>
                <ext:Window ID="winAdd" runat="server" Icon="MonitorAdd" Closable="false" Title="添加用户基础信息"
                    Width="360" Height="280" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
                    BodyPadding="5" Layout="Form">
                    <Items>
                        <ext:FormPanel ID="pnlAdd" runat="server" BodyPadding="5">
                            <FieldDefaults>
                                <CustomConfig>
                                    <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                                    <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                                </CustomConfig>
                            </FieldDefaults>
                            <Items>
                                <ext:Container runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container runat="server" Layout="FormLayout" ColumnWidth="1" Padding="5">
                                            <Items>
                                                <ext:TextField ID="add_PLAN_MONTH" runat="server" FieldLabel="年月" LabelAlign="Right" />
                                                <ext:DateField ID="add_PLAN_StartDate" runat="server" FieldLabel="开始时间" LabelAlign="Right" />
                                                <ext:DateField ID="add_PLAN_EndDate" runat="server" FieldLabel="结束时间" LabelAlign="Right" />
                                                <ext:TriggerField ID="add_MATERIAL" runat="server" FieldLabel="物料名称" LabelAlign="Right" Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Fn="SelectMaterial" />
                                                    </Listeners>
                                                </ext:TriggerField>
                                                <ext:TextField ID="add_PLAN_QTY" runat="server" FieldLabel="计划数量" LabelAlign="Right" />
                                                <ext:TextField ID="add_REMARK" runat="server" FieldLabel="备注" LabelAlign="Right" />
                                                <ext:Hidden ID="hidden_add_MATERIAL" runat="server" />
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="btnAddSave" runat="server" Text="确定" Icon="Accept">
                            <DirectEvents>
                                <Click OnEvent="BtnAddSave_Click">
                                    <EventMask ShowMask="true" Msg="保存中..." MinDelay="50" />
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button ID="btnAddCancel" runat="server" Text="取消" Icon="Cancel">
                            <DirectEvents>
                                <Click OnEvent="BtnCancel_Click">
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                    <Listeners>
                        <Show Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).disable(true);}" />
                        <Hide Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).enable(true);}" />
                    </Listeners>
                </ext:Window>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
