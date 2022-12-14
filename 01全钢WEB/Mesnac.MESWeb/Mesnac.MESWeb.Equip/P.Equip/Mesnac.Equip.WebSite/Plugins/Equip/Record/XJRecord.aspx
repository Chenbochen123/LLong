<%@ Page Language="C#" AutoEventWireup="true" CodeFile="XJRecord.aspx.cs" Inherits="Plugins_Equip_Record_XJRecord" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>设备巡检记录</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>

    <script type="text/javascript">
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
            } else {
                //toolbar.items.getAt(3).hide();
            }
        };

        var gridPanelCellDblClick = function (grid, td, tdindex, record, tr, trindex, e, fn) {
            showDetailWindow(record.data.OBJID);
        }

        var showDetailWindow = function (OBJID) {
            var url = "../Equip/Record/XJRecordDetail.aspx?OBJID=" + OBJID;
            var tabid = "Record_XJRecordDetail";
            var tabp = parent.App.mainTabPanel;
            var tab = tabp.getComponent("id=" + tabid);
            if (tab) {
                tab.close();
            }
            parent.addTab(tabid, "设备点检明细", url, true);
        }

        //根据按钮类别进行删除和编辑操作
        var commandcolumn_click = function (command, record) {
            commandcolumn_click_confirm(command, record);
            return false;
        };
        //区分删除操作，并进行二次确认操作
        var commandcolumn_click_confirm = function (command, record) {

            if (command.toLowerCase() == "edit") {
                commandcolumn_direct_edit(record);
            }
            if (command.toLowerCase() == "delete") {
                Ext.Msg.confirm("提示", '您确定需要关闭此条信息？', function (btn) { commandcolumn_direct_delete(btn, record) });
            }
            return false;
        };
        //点击修改按钮
        var commandcolumn_direct_edit = function (record) {
            debugger;
            var ObjID = record.data.OBJID;
            var InspectionUser = record.data.INSPECTION_USER_NAME;
            debugger;
            App.direct.commandcolumn_direct_edit(ObjID,InspectionUser, {
                success: function (result) {
                },
                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }
        //点击删除按钮
        var commandcolumn_direct_delete = function (btn, record) {
            debugger;
            if (btn != "yes") {
                return;
            }
            var ObjID = record.data.OBJID;
            debugger;
            App.direct.commandcolumn_direct_delete(ObjID, {
                success: function (result) {
                    Ext.Msg.alert('操作', result);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }
        //机台代码返回值处理
        var Plugins_Equip_BasicInfo_QueryEquipment_Request = function (record) {
            if (!App.winAdd.hidden) {
                App.add_equip_name.setValue(record.data.EQUIP_NAME);
                App.add_equip_name.getTrigger(0).show();
                App.hidden_add_equip_id.setValue(record.data.OBJID);
            }
            else if (!App.winModify.hidden) {
                App.modify_equip_name.setValue(record.data.EQUIP_NAME);
                App.modify_equip_name.getTrigger(0).show();
                App.hidden_modify_equip_id.setValue(record.data.OBJID);
            }
            else {
                App.txt_equip_code.setValue(record.data.EQUIP_NAME);
                App.txt_equip_code.getTrigger(0).show();
                App.hidden_select_equip_id.setValue(record.data.OBJID);
            }
        }
        //设备信息
        var SelectEquipInfo = function (field, trigger, index) {
            switch (index) {
                case 0:
                    App.hidden_select_equip_id.setValue("");
                    field.getTrigger(0).hide();
                    field.setValue('');
                    field.getEl().down('input.x-form-text').setStyle('background', "white");
                    break;
                case 1:

                    App.Plugins_Equip_BasicInfo_QueryEquipment_Window.show();
                    break;
            }
        }
        Ext.create("Ext.window.Window", {//机台代码查询带回窗体
            id: "Plugins_Equip_BasicInfo_QueryEquipment_Window",
            height: 460,
            hidden: true,
            width: 360,
            html: "<iframe src='../BasicInfo/QueryEquipment.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择机台名称",
            modal: true
        })
    </script>

    <script>
        //停机类型信息
        var SelectStopTypeInfo = function (field, trigger, index) {
            switch (index) {
                case 0:
                    App.hidden_select_equip_id.setValue("");
                    field.getTrigger(0).hide();
                    field.setValue('');
                    field.getEl().down('input.x-form-text').setStyle('background', "white");
                    break;
                case 1:

                    App.Plugins_Equip_BasicInfo_QueryStopType_Window.show();
                    break;
            }
        }
        var Plugins_Equip_BasicInfo_QueryStopType_Request = function (record) {
            if (!App.winAdd.hidden) {
                App.add_stop_type.setValue(record.data.EQUIP_STOP_TYPE_NAME);
                App.add_stop_type.getTrigger(0).show();
                App.hidden_add_stop_type.setValue(record.data.OBJID);
            }
            else if (!App.winModify.hidden) {
                App.modify_stop_type.setValue(record.data.EQUIP_STOP_TYPE_NAME);
                App.modify_stop_type.getTrigger(0).show();
                App.hidden_modify_stop_type.setValue(record.data.OBJID);
            }
            else {
                App.add_stop_type.setValue(record.data.EQUIP_STOP_TYPE_NAME);
                App.add_stop_type.getTrigger(0).show();
                App.hidden_add_stop_type.setValue(record.data.OBJID);
            }
        }
        Ext.create("Ext.window.Window", {//停机原因代码查询带回窗体
            id: "Plugins_Equip_BasicInfo_QueryStopType_Window",
            height: 460,
            hidden: true,
            width: 360,
            html: "<iframe src='../BasicInfo/QueryStopType.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择停机类型",
            modal: true
        })
    </script>

    <script>
        //停机原因信息
        var SelectStopReasonInfo = function (field, trigger, index) {
            switch (index) {
                case 0:
                    App.hidden_select_equip_id.setValue("");
                    field.getTrigger(0).hide();
                    field.setValue('');
                    field.getEl().down('input.x-form-text').setStyle('background', "white");
                    break;
                case 1:

                    App.Plugins_Equip_BasicInfo_QueryStopReason_Window.show();
                    break;
            }
        }
        var Plugins_Equip_BasicInfo_QueryStopReason_Request = function (record) {
            if (!App.winAdd.hidden) {
                App.add_stop_reason.setValue(record.data.EQUIP_STOP_REASON_NAME);
                App.add_stop_reason.getTrigger(0).show();
                App.hidden_add_stop_reason.setValue(record.data.OBJID);
            }
            if (!App.winModify.hidden) {
                App.modify_stop_reason.setValue(record.data.EQUIP_STOP_REASON_NAME);
                App.modify_stop_reason.getTrigger(0).show();
                App.hidden_modify_stop_reason.setValue(record.data.OBJID);
            }
            else {
                App.add_stop_reason.setValue(record.data.EQUIP_STOP_REASON_NAME);
                App.add_stop_reason.getTrigger(0).show();
                App.hidden_add_stop_reason.setValue(record.data.OBJID);
            }
        }
        Ext.create("Ext.window.Window", {//停机原因代码查询带回窗体
            id: "Plugins_Equip_BasicInfo_QueryStopReason_Window",
            height: 460,
            hidden: true,
            width: 360,
            html: "<iframe src='../BasicInfo/QueryStopReason.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择停机原因",
            modal: true
        })

        var SelectUserCode = function (field, trigger, index, userType, hiddenId) {//人员绑定查询
            switch (index) {
                case 0:
                    field.setValue('');
                    document.getElementById(hiddenId).value = '';
                    break;
                case 1:
                    App.hidden_user_type.setValue(userType);
                    App.Plugins_Equip_BasicInfo_QueryBasUser_Window.show();
                    break;
            }
        }

        var Plugins_Equip_BasicInfo_QueryBasUser_Request = function (record) {//人员绑定
            var userType = App.hidden_user_type.value;
            if (!App.winModify.hidden) {
                switch (userType) {
                    case "1":
                        App.add_response_user.setValue(record.data.USER_NAME);
                        App.hidden_txt_response_user.setValue(record.data.OBJID);
                        break;
                    case "2":
                        App.modify_response_user.setValue(record.data.USER_NAME);
                        App.hidden_txt_response_user.setValue(record.data.OBJID);
                        break;
                    default:
                }
            }
            if (!App.winAdd.hidden) {
                switch (userType) {
                    case "1":
                        App.add_response_user.setValue(record.data.USER_NAME);
                        App.hidden_txt_response_user.setValue(record.data.OBJID);
                        break;
                    case "2":
                        App.modify_response_user.setValue(record.data.USER_NAME);
                        App.hidden_txt_response_user.setValue(record.data.OBJID);
                        break;
                    default:
                }
            }
        }

        Ext.create("Ext.window.Window", {//人员绑定查询带回窗体
            id: "Plugins_Equip_BasicInfo_QueryBasUser_Window",
            height: 460,
            hidden: true,
            width: 360,
            html: "<iframe src='../BasicInfo/QueryBasUser.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择人员",
            modal: true
        })
    </script>
</head>
<body>
    <form id="fmUnit" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button" OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmUnit" runat="server" />
        <ext:Viewport ID="vwUnit" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnlUnitTitle" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="barUnit">
                            <Items>
                                <ext:Button runat="server" Icon="Add" Text="添加" ID="btn_add">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttAdd" runat="server" Html="点击进行添加" />
                                    </ToolTips>
                                    <DirectEvents>
                                        <Click OnEvent="btn_add_Click">
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_begin" />
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="点击进行查询" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="pnlListFresh"></Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle_2" />
                                <ext:Button runat="server" Icon="Note" Text="历史查询" ID="btn_history_search" Hidden="true">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip1" runat="server" Html="点击进行历史查询" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="pnlHistoryListFresh"></Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle_1" />
                                <ext:Button runat="server" Icon="PageWhiteExcel" Text="导出" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();"></Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" />
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:Panel ID="pnlUnitQuery" runat="server" AutoHeight="true">
                            <Items>
                                <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container ID="container_1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:TriggerField ID="txt_equip_code" runat="server" FieldLabel="设备名称" LabelAlign="Right" Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Fn="SelectEquipInfo" />
                                                    </Listeners>
                                                </ext:TriggerField>
                                                <ext:TextField ID="equip_code" runat="server" FieldLabel="设备号码" LabelAlign="Right" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:DateField ID="txt_begin_stop_date" runat="server" FieldLabel="开始时间" LabelAlign="Right" Editable="false" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_3" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:DateField ID="txt_end_stop_date" runat="server" FieldLabel="结束时间" LabelAlign="Right" Editable="false" />
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
                        <ext:Store ID="store" runat="server" PageSize="15">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" AutoDataBind="false" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="DELETE_FLAG" />
                                        <ext:ModelField Name="BILL_NO" />
                                        <ext:ModelField Name="EQUIP_NAME" />
                                        <ext:ModelField Name="INSPECTION_PLAN_DATE" />
                                        <ext:ModelField Name="INSPECTION_BEGIN_TIME" />
                                        <ext:ModelField Name="INSPECTION_END_TIME" />
                                        <ext:ModelField Name="FANGAN_NAME" />
                                        <ext:ModelField Name="INSPECTION_USER_NAME" />
                                        <ext:ModelField Name="STATUS" />
                                        <ext:ModelField Name="PLAN_TYPE_NAME" />
                                        <ext:ModelField Name="REMARK" />
                                        <ext:ModelField Name="RECORD_TIME" />

                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                            <ext:Column ID="ObjID" runat="server" Text="ObjID" DataIndex="OBJID" Hidden="true" />
                            <ext:Column ID="BILL_NO" runat="server" Text="巡检单" DataIndex="BILL_NO" Width="150" />
                            <ext:Column ID="EQUIP_NAME" runat="server" Text="机台" DataIndex="EQUIP_NAME" Width="100" />
                            <ext:DateColumn ID="INSPECTION_PLAN_DATE" runat="server" Text="计划时间" DataIndex="INSPECTION_PLAN_DATE" Width="100" Format="yyyy-MM-dd" />
                            <ext:DateColumn ID="INSPECTION_BEGIN_TIME" runat="server" Text="巡检开始时间" DataIndex="INSPECTION_BEGIN_TIME" Width="135" Format="yyyy-MM-dd HH:mm:ss" />
                            <ext:DateColumn ID="INSPECTION_END_TIME" runat="server" Text="巡检结束时间" DataIndex="INSPECTION_END_TIME" Width="135" Format="yyyy-MM-dd HH:mm:ss" />
                            <ext:Column ID="FANGAN_NAME" runat="server" Text="巡检方案" DataIndex="FANGAN_NAME" Width="150" />
                            <ext:Column ID="INSPECTION_USER_NAME" runat="server" Text="巡检人" DataIndex="INSPECTION_USER_NAME" Width="70" />
                            <ext:Column ID="STATUS" runat="server" Text="巡检状态" DataIndex="STATUS" Width="70" />
                            <ext:Column ID="PLAN_TYPE_NAME" runat="server" Text="计划类型" DataIndex="PLAN_TYPE_NAME" Width="70" />
                            <ext:DateColumn ID="RECORD_TIME" runat="server" Text="创建时间" DataIndex="RECORD_TIME" Width="135" Format="yyyy-MM-dd HH:mm:ss" />
                            <ext:Column ID="REMARK" runat="server" Text="备注" DataIndex="REMARK" Width="100" />
                            <ext:CommandColumn ID="cmdCol" runat="server" Align="Center" Text="操作" Width="120">
                                <Commands>
                                    <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改" />
                                    <ext:GridCommand Icon="TableDelete" CommandName="Delete" Text="删除" />
                                </Commands>
                                <PrepareToolbar Fn="prepareToolbar" />
                                <Listeners>
                                    <Command Handler="commandcolumn_click(command, record);" />
                                </Listeners>
                            </ext:CommandColumn>
                        </Columns>
                    </ColumnModel>
                    <View>
                        <ext:GridView ID="GridView1" runat="server" LoadMask="false" EnableTextSelection="true">
                            <GetRowClass Fn="SetRowClass" />
                        </ext:GridView>
                    </View>
                    <Listeners>
                        <CellDblClick Fn="gridPanelCellDblClick" />
                    </Listeners>
                    <BottomBar>
                        <ext:PagingToolbar ID="pageToolBar" runat="server">
                            <Plugins>
                                <ext:ProgressBarPager ID="ProgressBarPager" runat="server" />
                            </Plugins>
                        </ext:PagingToolbar>
                    </BottomBar>
                </ext:GridPanel>

                <ext:Window ID="winAdd" runat="server" Icon="MonitorAdd" Closable="false" Title="添加设备巡检记录"
                    Width="600" Height="290" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
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
                                <ext:Container ID="Container4" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container ID="Container5" runat="server" Layout="FormLayout" ColumnWidth=".5"
                                            Padding="5">
                                            <Items>
                                                <ext:ComboBox ID="add_equip_major" runat="server" FieldLabel="设备大类" LabelAlign="Left" Editable="false"
                                                    ValueField="value" DisplayField="text" >
                                                    <Store>
                                                        <ext:Store ID="equip_store" runat="server">
                                                            <Model>
                                                                <ext:Model ID="Model1" runat="server">
                                                                    <Fields>
                                                                        <ext:ModelField Name="value" Mapping="OBJID" />
                                                                        <ext:ModelField Name="text" Mapping="V" />
                                                                    </Fields>
                                                                </ext:Model>
                                                            </Model>
                                                        </ext:Store>
                                                    </Store>
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.clearValue();" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:TriggerField ID="add_equip_name" runat="server" FieldLabel="设备名称" LabelAlign="Left" Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Fn="SelectEquipInfo" />
                                                    </Listeners>
                                                </ext:TriggerField>

                                                <ext:TriggerField ID="add_response_user" runat="server" FieldLabel="巡检人" LabelAlign="Left" Editable="false" AllowBlank="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="SelectUserCode(this, trigger, index , 1 , 'hidden_txt_response_user')" />
                                                    </Listeners>
                                                </ext:TriggerField>

                                                <ext:FieldContainer runat="server" FieldLabel="计划时间" LabelAlign="Left" Layout="HBoxLayout" AllowBlank="false" Editable="false">
                                                    <Items>
                                                        <ext:DateField ID="add_plan_date" Width="100" runat="server" AllowBlank="false"/>
                                                    </Items>
                                                </ext:FieldContainer>

                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="Container6" runat="server" Layout="FormLayout" ColumnWidth=".5"
                                            Padding="5">
                                            <Items>
                                                <ext:TextArea runat="server" ID="add_remark" FieldLabel="备注" LabelAlign="Left"  >
                                                </ext:TextArea>
                                            </Items>
                                        </ext:Container>

                                    </Items>

                                </ext:Container>
                            </Items>
                            <Listeners>
                                <ValidityChange Handler="#{btnAddSave}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="btnAddSave" runat="server" Text="确定" Icon="Accept" Disabled="true">
                            <DirectEvents>
                                <Click OnEvent="BtnAddSave_Click">
                                    <EventMask ShowMask="true" Msg="Saving..." MinDelay="50" />
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

                <ext:Window ID="winModify" runat="server" Icon="MonitorEdit" Closable="false" Title="修改设备巡检记录"
                    Width="600" Height="280" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
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
                                <ext:Container ID="Container1" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container ID="Container2" runat="server" Layout="FormLayout" ColumnWidth=".5"
                                            Padding="5">
                                            <Items>
                                                <ext:TextField ID="modify_obj_id" runat="server" Hidden="true" />
                                                <ext:TriggerField ID="modify_equip_name" runat="server" FieldLabel="设备名称" LabelAlign="Left" AllowBlank="false" Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Fn="SelectEquipInfo" />
                                                    </Listeners>
                                                </ext:TriggerField>

                                                <ext:TriggerField ID="modify_response_user" runat="server" FieldLabel="巡检人" LabelAlign="Left" Editable="false" AllowBlank="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="SelectUserCode(this, trigger, index , 2 , 'hidden_txt_response_user')" />
                                                    </Listeners>
                                                </ext:TriggerField>

                                                <ext:FieldContainer runat="server" FieldLabel="巡检开始时间" LabelAlign="Left" Layout="HBoxLayout" AllowBlank="false" Editable="false">
                                                    <Items>
                                                        <ext:DateField ID="modify_begin_date" Width="100" Format="yyyy-MM-dd" runat="server" />
                                                        <ext:TimeField ID="modify_begin_time" runat="server" Width="90" Format="HH:mm:ss"></ext:TimeField>
                                                    </Items>
                                                </ext:FieldContainer>

                                                <ext:FieldContainer runat="server" FieldLabel="巡检结束时间" LabelAlign="Left" Layout="HBoxLayout" AllowBlank="false" Editable="false">
                                                    <Items>
                                                        <ext:DateField ID="modify_stop_date" Width="100" Format="yyyy-MM-dd" runat="server" />
                                                        <ext:TimeField ID="modify_stop_time" runat="server" Width="90" Format="HH:mm:ss"></ext:TimeField>
                                                    </Items>
                                                </ext:FieldContainer>

                                                <ext:TextField ID="modify_bill_no" runat="server" FieldLabel="巡检单" LabelAlign="Left" ReadOnly="true" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="Container3" runat="server" Layout="FormLayout" ColumnWidth=".5"
                                            Padding="5">
                                            <Items>
                                                <ext:FieldContainer runat="server" FieldLabel="计划时间" LabelAlign="Left" Layout="HBoxLayout" AllowBlank="false" Editable="false">
                                                    <Items>
                                                        <ext:DateField ID="modify_plan_date" Width="100" runat="server" AllowBlank="false"/>
                                                    </Items>
                                                </ext:FieldContainer>

                                                <ext:TextArea runat="server" ID="modify_remark" FieldLabel="备注" LabelAlign="Left"  Height="100">
                                                </ext:TextArea>

                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:Container>
                            </Items>
                            <Listeners>
                                <ValidityChange Handler="#{btnModifySave}.setDisabled(!valid);" />
                            </Listeners>
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

                <ext:Hidden ID="hidden_user_type" runat="server" />
                <ext:Hidden ID="hidden_delete_flag" runat="server" />
                <ext:Hidden ID="hidden_txt_response_user" runat="server" />

                <ext:Hidden ID="hidden_add_equip_id" runat="server" />
                <ext:Hidden ID="hidden_add_stop_type" runat="server" />
                <ext:Hidden ID="hidden_add_stop_reason" runat="server" />

                <ext:Hidden ID="hidden_modify_stop_reason" runat="server" />
                <ext:Hidden ID="hidden_modify_finish_user" runat="server" />
                <ext:Hidden ID="hidden_modify_confirm_user" runat="server" />
                <ext:Hidden ID="hidden_modify_plan_stop_time" runat="server" />
                <ext:Hidden ID="hidden_modify_equip_id" runat="server"></ext:Hidden>
                <ext:Hidden ID="hidden_modify_stop_type" runat="server" />
                <ext:Hidden runat="server" ID="hidden_select_equip_id" />
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
