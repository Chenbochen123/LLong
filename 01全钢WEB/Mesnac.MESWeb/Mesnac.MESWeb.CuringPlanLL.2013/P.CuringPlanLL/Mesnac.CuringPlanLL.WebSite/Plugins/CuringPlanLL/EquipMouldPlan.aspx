<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EquipMouldPlan.aspx.cs" Inherits="Plugins_Curing_ProductPlan_EquipMouldPlan" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>换模计划</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript">
        var thisDirUrl = "<%= Page.ResolveUrl("./") %>";
        var thisRootUrl = "<%= Page.ResolveUrl("~/") %>";
    </script>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <script type="text/javascript">
        //-------部门-----查询带回弹出框--BEGIN
        var McUI_SearchBox_SearchBoxCuringEquip_Request = function (record) {//返回值处理
            if (!App.winAdd.hidden) {
                App.txt_add_equip.setValue(record.data.EQUIP_NAME);
                App.hidden_add_equip_id.setValue(record.data.OBJID);
            }
            else {
                App.txt_equip.getTrigger(0).show();
                App.txt_equip.setValue(record.data.EQUIP_NAME);
                App.hidden_equip_id.setValue(record.data.OBJID);
            }
        }

        var SelectCuringEquip = function (field, trigger, index) {//查询
            switch (index) {
                case 0:
                    field.getTrigger(0).hide();
                    field.setValue('');
                    App.hidden_equip_id.setValue("");
                    field.getEl().down('input.x-form-text').setStyle('background', "white");
                    break;
                case 1:
                    App.McUI_SearchBox_SearchBoxCuringEquip_Window.show();
                    break;
            }
        }

        var UpdateCuringEquip = function (field, trigger, index) {//查询
            App.McUI_SearchBox_SearchBoxCuringEquip_Window.show();
        }
        Ext.create("Ext.window.Window", {//查询带回窗体
            id: "McUI_SearchBox_SearchBoxCuringEquip_Window",
            height: 430,
            hidden: true,
            width: 360,
            html: "<iframe src='" + thisRootUrl + "McUI/SearchBox/SearchBoxCuringEquip.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择机台",
            modal: true
        })
        //------------查询带回弹出框--END 
    </script>


    <script type="text/javascript">
        var pad = function (num, n) {
            var len = num.toString().length;
            while (len < n) {
                num = "0" + num;
                len++;
            }
            return num;
        }
        //-------月度计划-----查询带回弹出框--BEGIN
        var McUI_SearchBox_SearchCuringMonthPlan_Request = function (record) {//物料返回值处理
            App.hidden_material_id.setValue(record.data.MATERIAL_ID);
            App.add_month_date.setValue(record.data.PLAN_MONTH);
            App.add_month_material_name.setValue(record.data.MATERIAL_NAME);
            App.direct.IniCuringMonthPlanInfo(record.data.OBJID);
        }

        var SearchCuringMonthPlanWindowShow = function () {
            var window = App.McUI_SearchBox_SearchCuringMonthPlan_Window;
            window.show();
        }
        Ext.create("Ext.window.Window", {//物料查询带回窗体
            id: "McUI_SearchBox_SearchCuringMonthPlan_Window",
            height: 430,
            hidden: true,
            width: 360,
            html: "<iframe src='" + thisRootUrl + "McUI/SearchBox/SearchCuringMonthPlan.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "选择月度计划",
            modal: true
        })
        //------------查询带回弹出框--END 
    </script>

    <script type="text/javascript">
        //下发计划
        var update_plan_state_confirm = function (isall) {
            Ext.Msg.confirm("提示", '您确定需要下发计划吗？', function (btn) {
                if (btn != "yes") {
                    return;
                }
                App.direct.update_plan_state(isall);
            });
        };
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
        var on_bom_version_change = function (sender) {//物料返回值处理
            App.direct.on_bom_version_change(sender.getValue());
        }
        var prepareToolbar = function (grid, toolbar, rowIndex, record) {
            if (record.get("PLAN_STATE_NAME") == "已下达") {
                toolbar.items.getAt(0).hide();
            }
            if (record.get("PLAN_STATE_NAME") == "已接收") {
                toolbar.items.getAt(0).hide();
            }
        };
    </script>
</head>
<body>
    <form id="fmUser" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmUser" runat="server" />
        <ext:Viewport ID="vwUnit" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnlUserTitle" runat="server" Region="North" AutoHeight="true">
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
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle_1" />
                                <ext:Button runat="server" Icon="Find" Text="下发选中计划" ID="btnCheckPlanState">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip1" runat="server" Html="下发选中计划" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="update_plan_state_confirm(0);" />
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
                        <ext:Panel ID="pnlUserQuery" runat="server" AutoHeight="true">
                            <Items>
                                <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container ID="container_1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:DateField ID="txt_begin_date" runat="server" FieldLabel="开始日期" LabelAlign="Right" />
                                                <ext:TriggerField ID="txt_equip" runat="server" FieldLabel="机台" LabelAlign="Right"
                                                    Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Fn="SelectCuringEquip" />
                                                    </Listeners>
                                                </ext:TriggerField>
                                                <ext:Hidden ID="hidden_equip_id" runat="server" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:DateField ID="txt_end_date" runat="server" FieldLabel="开始日期" LabelAlign="Right" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_3" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:ComboBox ID="txt_plan_state" runat="server" FieldLabel="计划状态" LabelAlign="Right" Editable="false" />
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
                        <ext:Store ID="store" runat="server" PageSize="50">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="PLAN_DATE" type="Date"/>
                                        <ext:ModelField Name="PLAN_STATE" />
                                        <ext:ModelField Name="EQUIP_ID" />
                                        <ext:ModelField Name="SHIFT_ID" />
                                        <ext:ModelField Name="MATERIAL_ID" />
                                        <ext:ModelField Name="BOM_ID" />
                                        <ext:ModelField Name="TECH_ID" />
                                        <ext:ModelField Name="EQUIP_POSITION" />
                                        <ext:ModelField Name="BOM_NAME" />
                                        <ext:ModelField Name="TECH_NAME" />
                                        <ext:ModelField Name="MATERIAL_NAME" />
                                        <ext:ModelField Name="MATERIAL_SAP_CODE" />
                                        <ext:ModelField Name="PLAN_STATE_NAME" />
                                        <ext:ModelField Name="EQUIP_NAME" />
                                        <ext:ModelField Name="EQUIP_POSITION_NAME" />
                                        <ext:ModelField Name="RECORD_TIME"  type="Date"/>
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <SelectionModel>
                        <ext:CheckboxSelectionModel ID="CheckboxSelectionModel1" runat="server" Mode="Multi" />
                    </SelectionModel>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn ID="rowNumCol" Width="45" runat="server" />
                            <ext:Column runat="server" Text="编号" DataIndex="OBJID" Width="60" />
                            <ext:Column runat="server" Text="计划状态" DataIndex="PLAN_STATE_NAME" Width="70" />
                            <ext:Column runat="server" Text="设备名称" DataIndex="EQUIP_NAME" Width="60" />
                            <ext:Column runat="server" Text="左右模具" DataIndex="EQUIP_POSITION_NAME" Width="60" />
                            <ext:DateColumn runat="server" Text="计划日期" DataIndex="PLAN_DATE" Width="80" Format="yyyy-MM-dd" />
                            <ext:Column runat="server" Text="物料名称" DataIndex="MATERIAL_NAME" Width="200" />
                            <ext:Column runat="server" Text="物料编号" DataIndex="MATERIAL_SAP_CODE" Width="90" />
                            <ext:Column runat="server" Text="BOM版本" DataIndex="BOM_NAME" Width="160" />
                            <ext:Column runat="server" Text="工艺版本" DataIndex="TECH_NAME" Width="240" />
                            <ext:DateColumn runat="server" Text="创建日期" DataIndex="RECORD_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                            <ext:CommandColumn ID="commandCol" runat="server" Width="60" Text="操作" Align="Center">
                                <Commands>
                                    <ext:GridCommand Icon="Delete" CommandName="Delete" Text="删除">
                                        <ToolTip Text="删除本条数据" />
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
                <ext:Window ID="winAdd" runat="server" Icon="MonitorAdd" Closable="false" Title="添加计划信息"
                    Width="600" Height="350" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
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
                                        <ext:Container runat="server" Layout="FormLayout" Padding="5">
                                            <Items>
                                                <ext:DateField ID="add_date" runat="server" FieldLabel="计划日期" LabelAlign="Right" />
                                                <ext:TriggerField ID="add_month_date" runat="server" FieldLabel="月度计划" LabelAlign="right"
                                                    Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Fn="SearchCuringMonthPlanWindowShow" />
                                                    </Listeners>
                                                </ext:TriggerField>
                                                <ext:Hidden ID="hidden_material_id" runat="server" />
                                                <ext:TextField ID="add_month_material_name" runat="server" FieldLabel="计划物料" LabelAlign="right" ReadOnly="true" />
                                                <ext:ComboBox ID="txt_bom_version" runat="server" FieldLabel="BOM版本" LabelAlign="Right" Editable="false"
                                                    ValueField="value" DisplayField="text">
                                                    <Store>
                                                        <ext:Store ID="bom_version_store" runat="server">
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
                                                    <Listeners>
                                                        <Change Fn="on_bom_version_change" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:Hidden ID="hidden_tech_version" runat="server" />
                                                <ext:ComboBox ID="txt_tech_version" runat="server" FieldLabel="工艺版本" LabelAlign="Right" Editable="false"
                                                    ValueField="value" DisplayField="text">
                                                    <Store>
                                                        <ext:Store ID="tech_version_store" runat="server">
                                                            <Model>
                                                                <ext:Model ID="Model2" runat="server">
                                                                    <Fields>
                                                                        <ext:ModelField Name="value" Mapping="OBJID" />
                                                                        <ext:ModelField Name="text" Mapping="V" />
                                                                    </Fields>
                                                                </ext:Model>
                                                            </Model>
                                                        </ext:Store>
                                                    </Store>
                                                </ext:ComboBox>

                                                <ext:TriggerField ID="txt_add_equip" runat="server" FieldLabel="机台" LabelAlign="Right"
                                                    Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Fn="UpdateCuringEquip" />
                                                    </Listeners>
                                                </ext:TriggerField>
                                                <ext:Hidden ID="hidden_add_equip_id" runat="server" />
                                                <ext:ComboBox ID="add_EquipPosition" runat="server" FieldLabel="左右模" LabelAlign="right" Editable="false" />
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
