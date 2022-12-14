<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RubberMaterInfo.aspx.cs" Inherits="Plugins_Semis_RubberMaterInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>胶料原材料库存查询</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript">
        var thisDirUrl = "<%= Page.ResolveUrl("./") %>";
        var thisRootUrl = "<%= Page.ResolveUrl("~/") %>";
    </script>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <script type="text/javascript">
        //-------物料-----查询带回弹出框--BEGIN
        var McUI_SearchBox_SearchBoxSbmMaterialSemis_Request = function (record) {//物料返回值处理
                App.txt_material.getTrigger(0).show();
                App.txt_material.setValue(record.data.MATERIAL_NAME);
                App.hidden_txt_material.setValue(record.data.OBJID);
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
                    App.McUI_SearchBox_SearchBoxSbmMaterialSemis_Window.show();
                    break;
            }
        }

        var UpdateDepartment = function (field, trigger, index) {//物料查询
            App.McUI_SearchBox_SearchBoxSbmMaterialSemis_Window.show();
        }
        Ext.create("Ext.window.Window", {//物料查询带回窗体
            id: "McUI_SearchBox_SearchBoxSbmMaterialSemis_Window",
            height: 430,
            hidden: true,
            width: 360,
            html: "<iframe src='" + thisRootUrl + "McUI/SearchBox/SearchBoxSbmMaterialSemis.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
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
                                <%--<ext:Button runat="server" Icon="Add" Text="添加" ID="btnAdd">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttAdd" runat="server" Html="点击进行添加" />
                                    </ToolTips>
                                    <DirectEvents>
                                        <Click OnEvent="btnAdd_Click">
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_begin" />--%>
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
                                <%--<ext:Button runat="server" Icon="Find" Text="手工重新获取" ID="btnGetPlan">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip1" runat="server" Html="点击进行计划拆分" />
                                    </ToolTips>
                                    <DirectEvents>
                                        <Click OnEvent="btnGetPlan_Click">
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle1" />--%>
                                <ext:Hidden ID="hidden_delete_flag" runat="server" Text="0" />
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
                                                <ext:DateField runat="server" ID="PlanDateStart" FieldLabel="领料开始日期" LabelAlign="Right">
                                                </ext:DateField>
                                                <%--<ext:ComboBox runat="server" ID="cbxShift" FieldLabel="计划班次" LabelAlign="Right">
                                                </ext:ComboBox>--%>
                                                <ext:ComboBox ID="cbxEquip" runat="server" FieldLabel="计划机台" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:DateField runat="server" ID="PlanDateEnd" FieldLabel="领料结束日期" LabelAlign="Right">
                                                </ext:DateField>
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
                                        <ext:Container ID="container_3" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:TextField runat="server" ID="TextBarcode" LabelAlign="Right" FieldLabel="条码号">
                                                </ext:TextField>
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
                        <ext:Store ID="store" runat="server" PageSize="30">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="BARCODE" />
                                        <ext:ModelField Name="MATERIAL_ID" />
                                        <ext:ModelField Name="MATERIAL_NAME" />
                                        <ext:ModelField Name="SAP_CODE" />
                                        <ext:ModelField Name="PICK_EQUIP_NAME" />
                                        <ext:ModelField Name="EQUIP_NAME" />
                                        <ext:ModelField Name="SET_QUANTITY" />
                                        <ext:ModelField Name="LEFT_QUANTITY" />
                                        <ext:ModelField Name="STORE_PLACE_NAME" />
                                        <ext:ModelField Name="USER_NAME" />
                                        <ext:ModelField Name="LLNAME" />
                                        <ext:ModelField Name="RECORD_TIME" Type="Date" />
                                        <ext:ModelField Name="LLTIME" Type="Date" />
                                        <ext:ModelField Name="YC_TIME" Type="Date" />
                                        <ext:ModelField Name="YMATER" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn ID="rowNumCol" Width="45" runat="server" />
                            <ext:Column ID="OBJID" runat="server" Text="编号" DataIndex="OBJID" Width="60" Hidden="true" />
                            <ext:Column ID="BARCODE" runat="server" Text="条码号" DataIndex="BARCODE" Width="150" />
                            <ext:Column ID="MATERIAL_NAME" runat="server" Text="物料名称" DataIndex="MATERIAL_NAME" Width="160" />
                            <ext:Column ID="Column2" runat="server" Text="物料简称" DataIndex="YMATER" Width="100" />
                            <ext:Column ID="SAP_CODE" runat="server" Text="SAP编码" DataIndex="SAP_CODE" Width="90" />
                            <ext:Column ID="PICK_EQUIP_NAME" runat="server" Text="领料机台" DataIndex="PICK_EQUIP_NAME" Width="100" />
                            <ext:Column ID="EQUIP_NAME" runat="server" Text="生产机台" DataIndex="EQUIP_NAME" Width="100" />
                            <ext:Column ID="SET_QUANTITY" runat="server" Text="领料数量" DataIndex="SET_QUANTITY" Width="80" />
                            <ext:Column ID="LEFT_QUANTITY" runat="server" Text="剩余数量" DataIndex="LEFT_QUANTITY" Width="80" />
                            <ext:Column ID="STORE_PLACE_NAME" runat="server" Text="库位" DataIndex="STORE_PLACE_NAME" Width="160" />
                            <ext:Column ID="Column1" runat="server" Text="领料人" DataIndex="LLNAME" Width="70" />
                            <ext:DateColumn ID="DateColumn1" runat="server" Text="领料时间" DataIndex="LLTIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                            <ext:Column ID="USER_NAME" runat="server" Text="操作人" DataIndex="USER_NAME" Width="70" />
                            <ext:DateColumn ID="RECORD_TIME" runat="server" Text="操作时间" DataIndex="RECORD_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                            <ext:DateColumn ID="YC_TIME" runat="server" Text="拆箱钢丝有效期" DataIndex="YC_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                            <ext:CommandColumn ID="commandCol" runat="server" Width="60" Text="操作" Align="Center">
                                <Commands>
                                    <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
                                        <ToolTip Text="修改本条数据" />
                                    </ext:GridCommand>
                                    <ext:CommandSeparator />
                                    <ext:GridCommand Icon="Delete" CommandName="Delete" Text="删除" Hidden="true">
                                        <ToolTip Text="删除本条数据" />
                                    </ext:GridCommand>
                                    <ext:GridCommand Icon="Accept" CommandName="Recover" Text="恢复" Hidden="true">
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
                    <BottomBar>
                        <ext:PagingToolbar ID="pageToolBar" runat="server">
                            <Plugins>
                                <ext:ProgressBarPager ID="ProgressBarPager" runat="server" />
                            </Plugins>
                        </ext:PagingToolbar>
                    </BottomBar>

                </ext:GridPanel>

                <ext:Window ID="winModify" runat="server" Icon="MonitorEdit" Closable="false" Title="修改条码数量"
                    Width="360" Height="220" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
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
                                                <ext:TextField ID="modify_BARCODE" runat="server" FieldLabel="条码号" LabelAlign="Left" ReadOnly="true" />
                                                <ext:TextField ID="modify_EQUIP_NAME" runat="server" FieldLabel="机台" LabelAlign="Left" ReadOnly="true" />
                                                <ext:TextField ID="modify_QTY" runat="server" FieldLabel="数量" LabelAlign="Left" />
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

                <%--<ext:Window ID="winAdd" runat="server" Icon="MonitorAdd" Closable="false" Title="添加胶料领料计划"
                    Width="360" Height="240" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
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
                                                <ext:DateField ID="add_SHIFT_DATE" runat="server" FieldLabel="计划日期" LabelAlign="Right" />
                                                <ext:ComboBox ID="add_SHIFT_ID" runat="server" FieldLabel="计划班次" LabelAlign="Right" Editable="false"/>
                                                <ext:ComboBox ID="add_EQUIP_ID" runat="server" FieldLabel="计划机台" LabelAlign="Right" Editable="false"/>
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
                </ext:Window>--%>

                <%--<ext:Window ID="winSplit" runat="server" Icon="MonitorAdd" Closable="false" Title="拆分胶料领料计划"
                    Width="360" Height="200" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
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
                                <ext:Container runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container runat="server" Layout="FormLayout" ColumnWidth="1" Padding="5">
                                            <Items>
                                                <ext:DateField ID="split_SHIFT_DATE" runat="server" FieldLabel="计划日期" LabelAlign="Right" />
                                                <ext:ComboBox ID="split_SHIFT_ID" runat="server" FieldLabel="计划班次" LabelAlign="Right" Editable="false"/>
                                                <ext:ComboBox ID="split_EQUIP_ID" runat="server" FieldLabel="计划机台" LabelAlign="Right" Editable="false"/>
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="btnSplitSave" runat="server" Text="确定" Icon="Accept">
                            <DirectEvents>
                                <Click OnEvent="BtnSplitSave_Click">
                                    <EventMask ShowMask="true" Msg="拆分中..." MinDelay="50" />
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button ID="btnSplitCancel" runat="server" Text="取消" Icon="Cancel">
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
                </ext:Window>--%>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>