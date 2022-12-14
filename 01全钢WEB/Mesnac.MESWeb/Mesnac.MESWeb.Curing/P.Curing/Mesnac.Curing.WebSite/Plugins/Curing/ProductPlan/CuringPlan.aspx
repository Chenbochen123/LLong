<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CuringPlan.aspx.cs" Inherits="Plugins_Curing_ProductPlan_CuringPlan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell
        {
            background-color: #B0FFBA !important;
        }
    </style>
    <script type="text/javascript">
        //列表刷新数据重载方法
        var pnlListFresh = function () {
            App.hiddenPlanDetailId.setValue("");
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            getPlanDetailByPlanId("");
            return false;
        }
        var getPlanDetailByPlanId = function (id) {
            App.hiddenPlanDetailId.setValue(id);
            App.PlanDetail.currentPage = 1;
            App.PagingToolbar1.doRefresh();
            return false;
        }
        var SetRowClass = function (record, rowIndex, rowParams, store) {
            if (record.get("SendChkFlag") == "1") {
                return "x-grid-row-collapsed";
            }
            if (record.get("PlanState") == "下发") {
                return "x-grid-row-deleted";
            }
        }
        //command列按钮控制
        var prepareToolbar = function (grid, toolbar, rowIndex, record) {

        }

        var plansend_click = function () {
            Ext.Msg.confirm("提示", '您确定要下发选中的计划吗？', function (btn) {
                if (btn != "yes") { return; }
                App.direct.commandcolumn_direct_planSend()
            });
        }

        var plansendall_click = function () {
            Ext.Msg.confirm("提示", '您确定要下发所有查询的计划吗？', function (btn) {
                if (btn != "yes") { return; }
                App.direct.commandcolumn_direct_planSendAll()
            });
        }

        //根据按钮类别进行删除和编辑操作
        var commandcolumn_click = function (command, record) {
            commandcolumn_click_confirm(command, record);
            return false;
        };

        //区分删除操作，并进行二次确认操作
        var commandcolumn_click_confirm = function (command, record) {
            if (command.toLowerCase() == "editdetail") {
                commandcolumn_direct_editdetail(record);
            }
            if (command.toLowerCase() == "deleteplan") {
                Ext.Msg.confirm("提示", '您确定要删除此条信息吗？', function (btn) { commandcolumn_direct_deleteplan(btn, record) });
            }
            if (command.toLowerCase() == "deletedetail") {
                Ext.Msg.confirm("提示", '您确定要删除此条信息吗？', function (btn) { commandcolumn_direct_deletedetail(btn, record) });
            }
            if (command.toLowerCase() == "savedetail") {
                commandcolumn_direct_savedetail(btn, record);
            }
            if (command.toLowerCase() == "adddatial") {
                commandcolumn_direct_adddatail(record);
            }
            if (command.toLowerCase() == "viewdetail") {
                commandcolumn_direct_viewdetail(record);
            }
            return false;
        };
        //手工添加计划明细
        var commandcolumn_direct_adddatail = function (record) {
            var PlanID = record.data.OBJID;
            App.direct.commandcolumn_direct_adddatail(PlanID, {
                success: function (result) {
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }
        //查看明细计划
        var commandcolumn_direct_viewdetail = function (record) {
            var PlanID = record.data.OBJID;
            getPlanDetailByPlanId(PlanID);
            return false;
        }
        //点击修改按钮
        var commandcolumn_direct_editdetail = function (record) {
            var ObjID = record.data.OBJID;
            App.plan_DetailID.setValue(ObjID);
            var PlanID = record.data.PLAN_ID;
            var Priority = record.data.PRIORITY;
            var PlanAmount = record.data.PLAN_AMOUNT;
            var SeqIdx = record.data.SEQ_INDEX;
            App.direct.commandcolumn_direct_editdetail(PlanID, Priority, PlanAmount, SeqIdx, {
                success: function (result) {
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }
        //点击删除按钮
        var commandcolumn_direct_deleteplan = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var id = record.data.OBJID;
            App.direct.commandcolumn_direct_deleteplan(id, {
                success: function (result) {
                    Ext.Msg.alert('操作', result);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }
        //点击删除按钮
        var commandcolumn_direct_deletedetail = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var id = record.data.OBJID;
            App.direct.commandcolumn_direct_deletedetail(id, {
                success: function (result) {
                    Ext.Msg.alert('操作', result);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        var _viewportAfterRender = function () {
            try {
                viewportAfterRender();
            }
            catch (e) {
            }
            return false;
        }

        var viewportAfterRender = function () {

        }
    </script>
    <script type="text/javascript">
        //-------设备类别-----查询带回弹出框--BEGIN
        var McUI_SearchBox_SearchBoxCbeCuringEquip_Request = function (record) {
            if (!App.winAddPlan.hidden) {
                App.txtAddPlanEquipId.setValue(record.data.EQUIP_NAME);
                App.hidden_AddPlanEquipId.setValue(record.data.OBJID);
            }
            else {
                App.txtSelectEquipID.getTrigger(0).show();
                App.txtSelectEquipID.setValue(record.data.EQUIP_NAME);
                App.hidden_select_EquipId.setValue(record.data.OBJID);
            }
        }

        var querySelectEquipInfo = function (field, trigger, index) {//设备查询
            switch (index) {
                case 0:
                    field.getTrigger(0).hide();
                    field.setValue('');
                    App.hidden_select_EquipId.setValue("");
                    field.getEl().down('input.x-form-text').setStyle('background', "white");
                    break;
                case 1:
                    App.Manager_BasicInfo_CommonPage_EqmEquipInfo_Window.show();
                    break;
            }
        }


        var queryAddEquipInfo = function (field, trigger, index) {//设备查询
            App.McUI_SearchBox_SearchBoxCbeCuringEquip_Window.show();
        }

        Ext.create("Ext.window.Window", {//设备查询带回窗体
            id: "McUI_SearchBox_SearchBoxCbeCuringEquip_Window",
            height: 460,
            hidden: true,
            width: 560,
            html: "<iframe src='../../../McUI/SearchBox/SearchBoxCbeCuringEquip.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择设备",
            modal: true
        })
        //------------查询带回弹出框--END 
    </script>
    <script type="text/javascript">
        //-------物料信息-----查询带回弹出框--BEGIN
        var McUI_SearchBox_SearchBoxVCbmMaterial_Request = function (record) {
            if (!App.winAddPlan.hidden) {
                App.txtAddPlanMaterial.setValue(record.data.MATERIAL_NAME + "|" + record.data.MATERIAL_CODE);
                App.hidden_AddPlanMaterial.setValue(record.data.OBJID);
            } else {
                App.txtAddPlanDetailMaterial.setValue(record.data.MATERIAL_NAME + "|" + record.data.MATERIAL_CODE);
                App.hidden_AddPlanDetailMaterial.setValue(record.data.OBJID);
            }
        }
        var queryAddMaterialInfo = function () {//物料查询
            App.McUI_SearchBox_SearchBoxVCbmMaterial_Window.show();
        }

        Ext.create("Ext.window.Window", {//物料查询带回窗体
            id: "McUI_SearchBox_SearchBoxVCbmMaterial_Window",
            height: 460,
            hidden: true,
            width: 600,
            html: "<iframe src='../../../McUI/SearchBox/SearchBoxVCbmMaterial.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择物料",
            modal: true
        })
        //------------查询带回弹出框--END 

        var txtBeginTime_Change = function (item, newValue, oldValue) {
            if (newValue != null) {
                var txtEndTime = App.txtEndTime;
                var endTime =txtEndTime.getValue();
                if (endTime == null || endTime < newValue) {
                    txtEndTime.setValue(newValue);
                }
            }
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
        OnClick="btnExportSubmit_Click" />
    <ext:ResourceManager ID="rmChkBill" runat="server" />
    <ext:Viewport ID="vpChkBill" runat="server" Layout="border">
        <Items>
            <ext:Panel ID="pnChkBill" runat="server" Region="North">
                <TopBar>
                    <ext:Toolbar runat="server" ID="tbChkBill">
                        <Items>
                            <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                <Listeners>
                                    <Click Fn="pnlListFresh" />
                                </Listeners>
                            </ext:Button>
                            <ext:ToolbarSeparator ID="tsBegin" />
                            <ext:Button runat="server" Icon="Add" Text="新建" ID="btnNewPlan">
                                <DirectEvents>
                                    <Click OnEvent="btnNewPlan_Click">
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                            <ext:ToolbarSeparator ID="ToolbarSeparator1" />
                            <ext:Button runat="server" Icon="Accept" Text="下发" ID="btnSend">
                                <Listeners>
                                    <Click Fn="plansend_click">
                                    </Click>
                                </Listeners>
                            </ext:Button>
                            <ext:Button runat="server" Icon="Accept" Text="全部下发" ID="btnSendAll">
                                <Listeners>
                                    <Click Fn="plansendall_click">
                                    </Click>
                                </Listeners>
                            </ext:Button>
                            <ext:ToolbarSeparator ID="tsMiddle" />
                            <ext:Button runat="server" Icon="LockEdit" Text="导入" ID="btnImport">
                                <DirectEvents>
                                    <Click OnEvent="btnImport_Click">
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                            <ext:ToolbarSeparator ID="ToolbarSeparator2" />
                            <ext:Button runat="server" Icon="PageExcel" Text="导出Excel" ID="btnExport">
                                <ToolTips>
                                    <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                </ToolTips>
                                <Listeners>
                                    <Click Handler="$('#btnExportSubmit').click();">
                                    </Click>
                                </Listeners>
                            </ext:Button>
                            <ext:ToolbarSeparator ID="tsEnd" />
                            <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                            <ext:HyperLink runat="server" Target="_blank" NavigateUrl="模板示例.xls" Text="模板示例" />
                            <ext:ToolbarFill ID="tfEnd" />
                        </Items>
                    </ext:Toolbar>
                </TopBar>
                <Items>
                    <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true"
                        Collapsible="false">
                        <Items>
                            <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                Padding="5">
                                <Items>
                                    <ext:DateField ID="txtBeginTime" runat="server" FieldLabel="开始时间" LabelAlign="Right">
                                        <Listeners>
                                            <Change Handler="return txtBeginTime_Change(item,newValue,oldValue);" />
                                        </Listeners>
                                    </ext:DateField>
                                    <ext:TextField ID="txtMaterialName" runat="server" FieldLabel="物料名称" MaxLength="25"
                                        LabelAlign="Right" />
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                Padding="5">
                                <Items>
                                    <ext:DateField ID="txtEndTime" runat="server" FieldLabel="结束时间" LabelAlign="Right" />
                                    <ext:TextField ID="txtMaterialCode" runat="server" FieldLabel="物料别名" MaxLength="25"
                                        LabelAlign="Right" />
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                Padding="5">
                                <Items>
                                    <ext:ComboBox ID="cbxQueryPlanShift" runat="server" FieldLabel="班次" LabelAlign="Right">
                                    </ext:ComboBox>
                                    <ext:TextField ID="txtSelectEquipID" runat="server" FieldLabel="机台" MaxLength="25"
                                        LabelAlign="Right" />
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                Padding="5">
                                <Items>
                                    <ext:ComboBox ID="cbxPlanState" runat="server" FieldLabel="状态" LabelAlign="Right"
                                        Editable="false">
                                    </ext:ComboBox>
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:FormPanel>
                </Items>
            </ext:Panel>
            <%--<!--主表显示-->--%>
            <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5"
                Title="计划信息">
                <Items>
                    <ext:GridPanel ID="pnlList" runat="server">
                        <Store>
                            <ext:Store ID="store" runat="server" PageSize="10">
                                <Proxy>
                                    <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                </Proxy>
                                <Model>
                                    <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                        <Fields>
                                            <ext:ModelField Name="OBJID" />
                                            <ext:ModelField Name="PLAN_DATE" Type="Date" />
                                            <ext:ModelField Name="SHIFT_ID" />
                                            <ext:ModelField Name="SHIFT_NAME" />
                                            <ext:ModelField Name="EUQIP_ID" />
                                            <ext:ModelField Name="EQUIP_NAME" />
                                            <ext:ModelField Name="SENDCHKFLAG" />
                                            <ext:ModelField Name="PLAN_STATE" />
                                            <ext:ModelField Name="PLAN_STATE_CAPTION" />
                                            <ext:ModelField Name="PLAN_TYPE" />
                                            <ext:ModelField Name="PLAN_TYPE_CAPTION" />
                                            <ext:ModelField Name="RECORD_USER_ID" />
                                            <ext:ModelField Name="RECORD_USER_NAME" />
                                            <ext:ModelField Name="RECORD_TIME" Type="Date" />
                                            <ext:ModelField Name="REMARK" />
                                        </Fields>
                                    </ext:Model>
                                </Model>
                            </ext:Store>
                        </Store>
                        <ColumnModel ID="colModel" runat="server">
                            <Columns>
                                <ext:DateColumn ID="PlanDate" runat="server" Text="日期" DataIndex="PLAN_DATE" Width="100"
                                    Format="yyyy-MM-dd" />
                                <ext:Column ID="EquipName" runat="server" Text="机台" DataIndex="EQUIP_NAME" Width="40" />
                                <ext:Column ID="ShiftName" runat="server" Text="班次" DataIndex="SHIFT_NAME" Width="40" />
                                <ext:Column ID="PlanStateCaption" runat="server" Text="计划状态" DataIndex="PLAN_STATE_CAPTION"
                                    Width="60" />
                                <ext:DateColumn ID="DateColumn2" runat="server" Text="录入时间" DataIndex="RECORD_TIME"
                                    Width="160" Format="yyyy-MM-dd HH:mm:ss" />
                                <ext:Column ID="UserName" runat="server" Text="录入人员" DataIndex="RECORD_USER_NAME" Flex="1" />
                                <ext:Column ID="REMARK" runat="server" Text="备注" Visible="false" DataIndex="Remark"
                                    Flex="1" />
                                <ext:CommandColumn ID="commandCol" runat="server" Width="246" Text="操作" Align="Center">
                                    <Commands>
                                        <ext:GridCommand Icon="Find" CommandName="ViewDetail" Text="查看明细" />
                                        <ext:CommandSeparator />
                                        <ext:GridCommand Icon="Add" CommandName="AddDatial" Text="添加明细" />
                                        <ext:GridCommand Icon="Delete" CommandName="DeletePlan" Text="删除计划" />
                                    </Commands>
                                    <PrepareToolbar Fn="prepareToolbar" />
                                    <Listeners>
                                        <Command Handler="return commandcolumn_click(command, record);" />
                                    </Listeners>
                                </ext:CommandColumn>
                            </Columns>
                        </ColumnModel>
                        <SelectionModel>
                            <ext:CheckboxSelectionModel ID="CheckboxSelectionModel1" runat="server" Mode="Multi" />
                        </SelectionModel>
                        <View>
                            <ext:GridView ID="gvRows" runat="server">
                                <GetRowClass Fn="SetRowClass" />
                            </ext:GridView>
                        </View>
                        <BottomBar>
                            <ext:PagingToolbar ID="pageToolBar" runat="server">
                                <Items>
                                    <ext:Label ID="Label1" runat="server" Text="每页条数:" />
                                    <ext:ToolbarSpacer ID="ToolbarSpacer1" runat="server" Width="10" />
                                    <ext:ComboBox ID="ComboBox1" runat="server" Width="80">
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
                                            <Select Handler="#{pnlList}.store.pageSize = parseInt(this.getValue(), 10); #{pageToolBar}.doRefresh(); return false;" />
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
            <%--end 主表显示--%>
            <%--明细表显示--%>
            <ext:Panel ID="pnlSouth" runat="server" Region="South" Title="计划单明细" Height="180"
                Icon="Basket" Layout="Fit" Collapsible="true" Split="true" MarginsSummary="0 5 5 5">
                <Items>
                    <ext:Hidden ID="hiddenPlanDetailId" runat="server" />
                    <ext:GridPanel ID="pnlDetailList" runat="server" MarginsSummary="0 5 5 5">
                        <Store>
                            <ext:Store ID="PlanDetail" runat="server" PageSize="10">
                                <Proxy>
                                    <ext:PageProxy DirectFn="App.direct.GridPanelDeatailBindData" />
                                </Proxy>
                                <Model>
                                    <ext:Model ID="modelDetail" runat="server" IDProperty="OBJID">
                                        <Fields>
                                            <ext:ModelField Name="OBJID" />
                                            <ext:ModelField Name="PLAN_DATE" Type="Date" />
                                            <ext:ModelField Name="SHIFT_ID" />
                                            <ext:ModelField Name="SHIFT_NAME" />
                                            <ext:ModelField Name="EQUIP_NAME" />
                                            <ext:ModelField Name="PLAN_ID" />
                                            <ext:ModelField Name="SEQ_INDEX" />
                                            <ext:ModelField Name="PRIORITY" />
                                            <ext:ModelField Name="MATERIAL_ID" />
                                            <ext:ModelField Name="MATERIAL_CODE" />
                                            <ext:ModelField Name="MATERIAL_NAME" />
                                            <ext:ModelField Name="PLAN_AMOUNT" Type="Float" />
                                            <ext:ModelField Name="PLAN_STATE" />
                                            <ext:ModelField Name="PLAN_STATE_CAPTION" />
                                            <ext:ModelField Name="PLAN_TYPE" />
                                            <ext:ModelField Name="PLAN_TYPE_CAPTION" />
                                            <ext:ModelField Name="REMARK" />
                                            <ext:ModelField Name="Record_USER_ID" />
                                            <ext:ModelField Name="RECORD_USER_NAME" />
                                            <ext:ModelField Name="RECORD_TIME" Type="Date" />
                                            <ext:ModelField Name="REAL_AMOUNT" Type="Float" />
                                            <ext:ModelField Name="BomVersion" />
                                            <ext:ModelField Name="StartTime" Type="Date" />
                                            <ext:ModelField Name="FinishTime" Type="Date" />
                                        </Fields>
                                    </ext:Model>
                                </Model>
                                <Parameters>
                                    <ext:StoreParameter Name="PlanID" Value="#{pnlList}.getSelectionModel().hasSelection() ? #{pnlList}.getSelectionModel().getSelection()[0].data.PlanID : -1"
                                        Mode="Raw" />
                                </Parameters>
                            </ext:Store>
                        </Store>
                        <ColumnModel ID="ColumnModelDetail" runat="server">
                            <Columns>
                                <ext:CommandColumn ID="DetailCommandCol" runat="server" Width="120" Text="操作" Align="Center">
                                    <Commands>
                                        <ext:GridCommand Icon="TableEdit" CommandName="EditDetail" Text="修改" />
                                        <ext:CommandSeparator />
                                        <ext:GridCommand Icon="TableDelete" CommandName="DeleteDetail" Text="删除" />
                                    </Commands>
                                    <PrepareToolbar Fn="prepareToolbar" />
                                    <Listeners>
                                        <Command Handler="return commandcolumn_click(command, record);" />
                                    </Listeners>
                                </ext:CommandColumn>
                                <ext:DateColumn ID="DateColumn1" runat="server" Text="日期" DataIndex="PLAN_DATE" Width="100"
                                    Format="yyyy-MM-dd" />
                                <ext:Column ID="Column2" runat="server" Text="机台" DataIndex="EQUIP_NAME" Width="60" />
                                <ext:Column ID="Column3" runat="server" Text="班次" DataIndex="SHIFT_NAME" Width="40" />
                                <ext:Column ID="DetailMaterialCode" runat="server" Text="物料名称" DataIndex="MATERIAL_NAME"
                                    Width="280" />
                                <ext:Column ID="DetailMaterialName" runat="server" Text="物料别名" DataIndex="MATERIAL_CODE"
                                    Width="60" Hidden="true" />
                                <ext:Column ID="DetailPriority" runat="server" Text="优先级" DataIndex="PRIORITY" Width="40"
                                    Hidden="true" />
                                <ext:Column ID="DetailPlanStateCaption" runat="server" Text="计划状态" DataIndex="PLAN_STATE_CAPTION"
                                    Width="60" />
                                <ext:Column ID="DetailPlanAmount" runat="server" Text="计划数量" DataIndex="PLAN_AMOUNT"
                                    Width="60">
                                </ext:Column>
                                <ext:Column ID="DetailRealAmount" runat="server" Text="完成数量" DataIndex="REAL_AMOUNT"
                                    Width="60" />
                                <ext:DateColumn ID="DateColumn3" runat="server" Text="录入时间" DataIndex="RECORD_TIME"
                                    Width="160" Format="yyyy-MM-dd HH:mm:ss" />
                                <ext:Column ID="Column1" runat="server" Text="备注" DataIndex="REMARK" Flex="1" />
                            </Columns>
                        </ColumnModel>
                        <SelectionModel>
                            <ext:CheckboxSelectionModel ID="detailCheckboxSelectionModel" runat="server" Mode="Multi" />
                        </SelectionModel>
                        <BottomBar>
                            <ext:PagingToolbar ID="PagingToolbar1" runat="server">
                                <Items>
                                    <ext:Label ID="Label2" runat="server" Text="每页条数:" />
                                    <ext:ToolbarSpacer ID="ToolbarSpacer2" runat="server" Width="10" />
                                    <ext:ComboBox ID="ComboBox2" runat="server" Width="80">
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
                                            <Select Handler="#{pnlDetailList}.store.pageSize = parseInt(this.getValue(), 10); #{PagingToolbar1}.doRefresh(); return false;" />
                                        </Listeners>
                                    </ext:ComboBox>
                                </Items>
                                <Plugins>
                                    <ext:ProgressBarPager ID="ProgressBarPager1" runat="server" />
                                </Plugins>
                            </ext:PagingToolbar>
                        </BottomBar>
                    </ext:GridPanel>
                </Items>
            </ext:Panel>
            <%--end 明细表显示--%>
            <%--导入对话框--%>
            <ext:Window ID="winPlanImport" runat="server" Icon="MonitorEdit" Closable="true"
                Title="选择导入文件" Width="360" Height="160" Resizable="false" Hidden="true" Modal="true"
                BodyStyle="background-color:#fff;" BodyPadding="5" Layout="FitLayout">
                <Items>
                    <ext:FormPanel ID="panelImport" runat="server" Flex="1" BodyPadding="5">
                        <Defaults>
                            <ext:Parameter Name="allowBlank" Value="false" Mode="Raw" />
                        </Defaults>
                        <FieldDefaults>
                            <CustomConfig>
                                <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                                <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                            </CustomConfig>
                        </FieldDefaults>
                        <Items>
                            <ext:DateField runat="server" ID="importPlanDate" FieldLabel="导入计划时间">
                            </ext:DateField>
                            <ext:FileUploadField runat="server" ID="fileUploadFieldExcel" EmptyText="选择导入的Excel文件"
                                FieldLabel="导入计划文件" ButtonText="" Icon="PageExcel" AllowBlank="false" Width="320"
                                LabelAlign="Right" />
                        </Items>
                        <Listeners>
                            <ValidityChange Handler="#{btnImportUpload}.setDisabled(!valid);" />
                        </Listeners>
                    </ext:FormPanel>
                </Items>
                <Buttons>
                    <ext:Button ID="btnImportUpload" runat="server" Text="上传" Disabled="false">
                        <DirectEvents>
                            <Click OnEvent="btnImportUpload_Click" Before="Ext.Msg.wait('正在上传文件...', '上传中');"
                                Failure="Ext.Msg.show({ 
                                                title   : '错误', 
                                                msg     : '上传文件处理失败', 
                                                minWidth: 200, 
                                                modal   : true, 
                                                icon    : Ext.Msg.ERROR, 
                                                buttons : Ext.Msg.OK 
                                        });">
                            </Click>
                        </DirectEvents>
                    </ext:Button>
                    <ext:Button ID="btnImportReset" runat="server" Text="重置">
                        <Listeners>
                            <Click Handler="#{panelImport}.getForm().reset();" />
                        </Listeners>
                    </ext:Button>
                </Buttons>
            </ext:Window>
            <%--end 导入对话框--%>
            <%--修改计划数量--%>
            <ext:Window ID="winModifyDetail" runat="server" Icon="MonitorEdit" Closable="false"
                Title="修改计划" Width="320" Height="200" Resizable="false" Hidden="true" Modal="false"
                BodyStyle="background-color:#fff;" BodyPadding="5" Layout="Form">
                <Items>
                    <ext:FormPanel ID="pnlEdit" runat="server" Flex="1" BodyPadding="5">
                        <FieldDefaults>
                            <CustomConfig>
                                <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                                <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                            </CustomConfig>
                        </FieldDefaults>
                        <Items>
                            <ext:Container ID="Container5" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                <Items>
                                    <ext:Container ID="Container6" runat="server" Layout="FormLayout" ColumnWidth="1"
                                        Padding="2">
                                        <Items>
                                            <ext:TextField ID="plan_DetailID" Hidden="true" runat="server" LabelAlign="Left"
                                                FieldLabel="ID">
                                            </ext:TextField>
                                            <ext:NumberField ID="modify_Priority" runat="server" FieldLabel="优先级" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                            <ext:NumberField ID="modify_PlanAmount" runat="server" FieldLabel="计划数量" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                        </Items>
                                    </ext:Container>
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:FormPanel>
                </Items>
                <Buttons>
                    <ext:Button ID="btnModifyDetailSave" runat="server" Text="确定" Icon="Accept">
                        <DirectEvents>
                            <Click OnEvent="btnModifyDetailSave_Click">
                            </Click>
                        </DirectEvents>
                    </ext:Button>
                    <ext:Button ID="btnModifyDetailCancel" runat="server" Text="取消" Icon="Cancel">
                        <Listeners>
                            <Click Handler=" App.winModifyDetail.close(); return false;" />
                        </Listeners>
                    </ext:Button>
                </Buttons>
                <Listeners>
                    <Show Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).disable(true);}" />
                    <Hide Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).enable(true);}" />
                </Listeners>
            </ext:Window>
            <%--end 修改计划数量--%>
            <%--手工添加计划--%>
            <ext:Window ID="winAddPlan" runat="server" Icon="MonitorAdd" Closable="true" Title="添加计划信息"
                Width="400" Height="340" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
                BodyPadding="5" Layout="Form">
                <Items>
                    <ext:FormPanel ID="FormPanel1" runat="server" BodyPadding="5">
                        <FieldDefaults>
                            <CustomConfig>
                                <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                                <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                            </CustomConfig>
                        </FieldDefaults>
                        <Items>
                            <ext:Container ID="Container10" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                <Items>
                                    <ext:Container ID="Container11" runat="server" Layout="FormLayout" ColumnWidth="1"
                                        Padding="5">
                                        <Items>
                                            <ext:TriggerField ID="txtAddPlanEquipId" runat="server" FieldLabel="计划机台" MaxLength="25"
                                                LabelAlign="Right" Editable="false" AllowBlank="false">
                                                <Triggers>
                                                    <ext:FieldTrigger Icon="Search" />
                                                </Triggers>
                                                <Listeners>
                                                    <TriggerClick Fn="queryAddEquipInfo" />
                                                </Listeners>
                                            </ext:TriggerField>
                                            <ext:Hidden ID="hidden_AddPlanEquipId" runat="server" />
                                            <ext:ComboBox ID="cbAddPlanEquipPart" runat="server" FieldLabel="左右模" MaxLength="25"
                                                LabelAlign="Right" Editable="false" />
                                            <ext:DateField ID="txtAddPlanDate" runat="server" FieldLabel="计划日期" MaxLength="25"
                                                LabelAlign="Right" Editable="true" />
                                            <ext:ComboBox ID="cbbAddPlanShift" runat="server" FieldLabel="计划班次" MaxLength="25"
                                                LabelAlign="Right" Editable="false" />
                                            <ext:TextField ID="txtAddPlanRemark" runat="server" FieldLabel="备注" MaxLength="25"
                                                LabelAlign="Right" />
                                            <ext:TriggerField ID="txtAddPlanMaterial" runat="server" FieldLabel="物料" MaxLength="50"
                                                LabelAlign="Right" Enabled="true" AllowBlank="false">
                                                <Triggers>
                                                    <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                                    <ext:FieldTrigger Icon="Search" />
                                                </Triggers>
                                                <Listeners>
                                                    <TriggerClick Fn="queryAddMaterialInfo" />
                                                </Listeners>
                                            </ext:TriggerField>
                                            <ext:Hidden ID="hidden_AddPlanMaterial" runat="server">
                                            </ext:Hidden>
                                            <ext:NumberField ID="txtAddPlanPriority" runat="server" FieldLabel="优先级" MaxLength="25"
                                                LabelAlign="Right" Enabled="true" Text="1" />
                                            <ext:NumberField ID="txtAddPlanAmount" runat="server" FieldLabel="计划数量" MaxLength="25"
                                                LabelAlign="Right" Enabled="true" Text="1" />
                                        </Items>
                                    </ext:Container>
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:FormPanel>
                </Items>
                <Buttons>
                    <ext:Button ID="btnAddPlanCancelPlanSave" runat="server" Text="确定" Icon="Accept">
                        <DirectEvents>
                            <Click OnEvent="btnAddPlanSave_Click">
                            </Click>
                        </DirectEvents>
                    </ext:Button>
                    <ext:Button ID="btnAddPlanCancel" runat="server" Text="取消" Icon="Cancel">
                        <Listeners>
                            <Click Handler=" App.winAddPlan.close(); return false;" />
                        </Listeners>
                    </ext:Button>
                </Buttons>
                <Listeners>
                    <Show Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).disable(true);}" />
                    <Hide Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).enable(true);}" />
                </Listeners>
            </ext:Window>
            <%--end 手工添加计划--%>
            <%--添加计划明细信息--%>
            <ext:Window ID="winAddDetail" runat="server" Icon="MonitorAdd" Closable="true" Title="添加计划明细信息"
                Width="400" Height="260" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
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
                            <ext:Container ID="Container7" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                <Items>
                                    <ext:Container ID="Container8" runat="server" Layout="FormLayout" ColumnWidth="1"
                                        Padding="5">
                                        <Items>
                                            <ext:ComboBox ID="cbAddPlanDeatailEquipPart" runat="server" FieldLabel="左右模" MaxLength="25"
                                                LabelAlign="Right" Editable="false" />
                                            <ext:TriggerField ID="txtAddPlanDetailMaterial" runat="server" FieldLabel="物料" MaxLength="50"
                                                LabelAlign="Right" Enabled="true" AllowBlank="false">
                                                <Triggers>
                                                    <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                                    <ext:FieldTrigger Icon="Search" />
                                                </Triggers>
                                                <Listeners>
                                                    <TriggerClick Fn="queryAddMaterialInfo" />
                                                </Listeners>
                                            </ext:TriggerField>
                                            <ext:Hidden ID="hidden_AddPlanDetailMaterial" runat="server">
                                            </ext:Hidden>
                                            <ext:NumberField ID="txtAddPlanDetailPriority" runat="server" FieldLabel="优先级" MaxLength="25"
                                                LabelAlign="Right" Enabled="true" Text="1" />
                                            <ext:NumberField ID="txtAddPlanDetailAmount" runat="server" FieldLabel="计划数量" MaxLength="25"
                                                LabelAlign="Right" Enabled="true" Text="1" />
                                            <ext:TextField ID="txtAddPlanDetailRemark" runat="server" FieldLabel="备注" MaxLength="25"
                                                LabelAlign="Right" Enabled="true" />
                                        </Items>
                                    </ext:Container>
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:FormPanel>
                </Items>
                <Buttons>
                    <ext:Button ID="btnAddDetailCancelDetailSave" runat="server" Text="确定" Icon="Accept">
                        <DirectEvents>
                            <Click OnEvent="btnAddDetailSave_Click">
                            </Click>
                        </DirectEvents>
                    </ext:Button>
                    <ext:Button ID="btnAddDetailCancel" runat="server" Text="取消" Icon="Cancel">
                        <Listeners>
                            <Click Handler=" App.winAddDetail.close(); return false;" />
                        </Listeners>
                    </ext:Button>
                </Buttons>
                <Listeners>
                    <Show Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).disable(true);}" />
                    <Hide Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).enable(true);}" />
                </Listeners>
            </ext:Window>
            <%--end 添加计划明细信息--%>
            <ext:Hidden ID="hidden_DetailPlanID" runat="server">
            </ext:Hidden>
            <ext:Hidden ID="hidden_SeqIdx" runat="server">
            </ext:Hidden>
        </Items>
        <Listeners>
            <AfterRender Fn="_viewportAfterRender"></AfterRender>
        </Listeners>
    </ext:Viewport>
    </form>
</body>
</html>
