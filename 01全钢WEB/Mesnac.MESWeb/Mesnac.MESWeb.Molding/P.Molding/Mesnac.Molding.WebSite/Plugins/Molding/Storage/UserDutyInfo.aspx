<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UserDutyInfo.aspx.cs" Inherits="Plugins_Molding_Storage_UserDutyInfo" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>人员值班信息</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript">
        var thisDirUrl = "<%= Page.ResolveUrl("./") %>";
        var thisRootUrl = "<%= Page.ResolveUrl("~/") %>";
    </script>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <script type="text/javascript">
        //-------用户-----查询带回弹出框--BEGIN
        var McUI_SearchBox_SearchBoxSsbUser_Request = function (record) {//用户返回值处理
            if (!App.winAdd.hidden) {
                App.add_user.setValue(record.data.USER_NAME);
                App.hidden_add_user.setValue(record.data.OBJID);
            }
        }
        var UpdateUser = function (field, trigger, index) {//员工查询
            App.McUI_SearchBox_SearchBoxSsbUser_Window.show();
        }
        Ext.create("Ext.window.Window", {//员工查询带回窗体
            id: "McUI_SearchBox_SearchBoxSsbUser_Window",
            height: 430,
            hidden: true,
            width: 360,
            html: "<iframe src='" + thisRootUrl + "McUI/SearchBox/SearchBoxSsbUser.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择员工",
            modal: true
        })
        //------------查询带回弹出框--END 
    </script>
    <script type="text/javascript">

        //点击修改按钮
        var commandcolumn_direct_edit = function (record) {
            var USER_ID = record.data.USER_ID;
            var USER_NAME = record.data.USER_NAME;
            var PLAN_DATE = record.data.PLAN_DATE;
            var REMARK = record.data.REMARK;
            var BEGIN_TIME = record.data.BEGIN_TIME;
            var END_TIME = record.data.END_TIME;
            var PROCEDURE = record.data.PROCEDURE;
            debugger;
            App.direct.commandcolumn_direct_edit(USER_ID, USER_NAME, PLAN_DATE, REMARK, BEGIN_TIME, END_TIME, PROCEDURE ,{
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
            var USER_ID = record.data.USER_ID;
            var PLAN_DATE = record.data.PLAN_DATE;
            var PROCEDURE = record.data.PROCEDURE;
            App.direct.commandcolumn_direct_delete(USER_ID, PLAN_DATE, PROCEDURE, {
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
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }
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
                                 <ext:Button runat="server" Icon="PageWhiteExcel" Text="导入" ID="btnImport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip4" runat="server" Html="点击将进入文件导入" />
                                    </ToolTips>
                                    <DirectEvents>
                                        <Click OnEvent="btnImport_Click">
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
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
                                        <ext:Container ID="container_1" runat="server" Layout="FormLayout" ColumnWidth=".2"
                                            Padding="5">
                                            <Items>
                                                <ext:TextField ID="txt_work_barcode" Vtype="integer" runat="server" FieldLabel="用户工号"
                                                    LabelAlign="Right" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_2" runat="server" Layout="FormLayout" ColumnWidth=".2"
                                            Padding="5">
                                            <Items>
                                                <ext:TextField ID="txt_user_name" runat="server" FieldLabel="用户名称" LabelAlign="Right" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_3" runat="server" Layout="FormLayout" ColumnWidth=".2"
                                            Padding="5">
                                            <Items>
                                                 <ext:DateField ID="txtPlanDateBegin" FieldLabel="计划开始日期" LabelAlign="Right" runat="server" Editable="false" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".2"
                                            Padding="5">
                                            <Items>
                                                 <ext:DateField ID="txtPlanDateEnd" FieldLabel="计划结束日期" LabelAlign="Right" runat="server" Editable="false" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_4" runat="server" Layout="FormLayout" ColumnWidth=".2"
                                            Padding="5">
                                            <Items>
                                                <ext:ComboBox ID="cbxProcedure" runat="server" FieldLabel="工序" LabelAlign="Right" Editable="false">
                                                </ext:ComboBox>
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
                                        <ext:ModelField Name="PROCEDURE" />
                                        <ext:ModelField Name="PROCEDURE_NAME" />
                                        <ext:ModelField Name="PLAN_DATE" />
                                        <ext:ModelField Name="USER_ID" />
                                        <ext:ModelField Name="WORK_BARCODE" />
                                        <ext:ModelField Name="USER_NAME" />
                                        <ext:ModelField Name="TELEPHONE" />
                                        <ext:ModelField Name="BEGIN_TIME" Type="Date" />
                                        <ext:ModelField Name="END_TIME" Type="Date" />
                                        <ext:ModelField Name="REMARK" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn ID="rowNumCol" Width="45" runat="server" />
                            <ext:Column ID="PROCEDURE_NAME" runat="server" Text="工序" DataIndex="PROCEDURE_NAME" Width="60" />
                            <ext:DateColumn ID="PLAN_DATE" runat="server" Text="计划日期" Format="yyyy-MM-dd" DataIndex="PLAN_DATE" Width="90"/>
                            <ext:Column ID="Column1" runat="server" Text="用户名称" DataIndex="USER_NAME" Width="65"/>
                            <ext:Column ID="WORK_BARCODE" runat="server" Text="用户工号" DataIndex="WORK_BARCODE" Width="65"/>
                            <ext:Column ID="TELEPHONE" runat="server" Text="电话" DataIndex="TELEPHONE" Width="100"/>
                            <ext:DateColumn ID="BEGIN_TIME" runat="server" Text="开始时间" Format="yyyy-MM-dd HH:mm:ss" DataIndex="BEGIN_TIME" Width="140"/>
                            <ext:DateColumn ID="END_TIME" runat="server" Text="结束时间" Format="yyyy-MM-dd HH:mm:ss" DataIndex="END_TIME" Width="140"/>
                            <ext:Column ID="REMARK" runat="server" Text="备注" DataIndex="REMARK" Width="65"/>
                            <ext:CommandColumn ID="commandCol" runat="server" Width="150" Text="操作" Align="Center">
                                <Commands>
                                    <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
                                        <ToolTip Text="修改本条数据" />
                                    </ext:GridCommand>
                                    <ext:CommandSeparator />
                                    <ext:GridCommand Icon="Delete" CommandName="Delete" Text="删除">
                                        <ToolTip Text="删除本条数据" />
                                    </ext:GridCommand>
                                </Commands>
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
                <ext:Window ID="winModify" runat="server" Icon="MonitorEdit" Closable="false" Title="修改员工值班信息"
                    Width="600" Height="350" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
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
                                        <ext:Container runat="server" Layout="FormLayout" ColumnWidth="1" Padding="1">
                                            <Items>
                                                <ext:TriggerField ID="modify_user" runat="server" FieldLabel="员工名称" LabelAlign="right" ReadOnly="true"/>
                                                <ext:Hidden ID="hidden_modify_user" runat="server" />
                                                <ext:DateField runat="server" ID="modify_plan_date" FieldLabel="计划日期" Editable="false" ReadOnly="true" LabelAlign="Right" />
                                                <ext:ComboBox ID="modify_procedure" runat="server" FieldLabel="工序" LabelAlign="right" ReadOnly="true">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.clearValue();" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:FieldContainer runat="server" FieldLabel="开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                                    <Items>
                                                        <ext:DateField ID="modify_BeginDate" runat="server" Flex="1" Editable="false" />
                                                        <ext:TimeField ID="modify_BeginTime" Increment="60" runat="server" Width="180" Editable="false" />
                                                    </Items>
                                                </ext:FieldContainer>
                                                <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                                    <Items>
                                                        <ext:DateField ID="modify_EndDate" runat="server" Flex="1" Editable="false" />
                                                        <ext:TimeField ID="modify_EndTime" Increment="60" runat="server" Width="180" Editable="false" />
                                                    </Items>
                                                </ext:FieldContainer>
                                                <ext:TextField runat="server" FieldLabel="备注" ID="modify_remark" Editable="true" LabelAlign="Right" />
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
                <ext:Window ID="winAdd" runat="server" Icon="MonitorAdd" Closable="false" Title="添加员工值班信息"
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
                                        <ext:Container runat="server" Layout="FormLayout" ColumnWidth="1" Padding="1">
                                            <Items>
                                                <ext:TriggerField ID="add_user" runat="server" FieldLabel="员工名称" LabelAlign="right"
                                                    Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Fn="UpdateUser" />
                                                    </Listeners>
                                                </ext:TriggerField>
                                                <ext:Hidden ID="hidden_add_user" runat="server" />
                                                <ext:DateField runat="server" ID="add_plan_date" FieldLabel="计划日期" Editable="false" LabelAlign="Right"  OnDirectChange="add_planDateChange" />
                                                <ext:ComboBox ID="add_procedure" runat="server" FieldLabel="工序" LabelAlign="right">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.clearValue();" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:FieldContainer runat="server" FieldLabel="开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                                    <Items>
                                                        <ext:DateField ID="add_BeginDate" runat="server" Flex="1" Editable="false" />
                                                        <ext:TimeField ID="add_BeginTime" Increment="60" runat="server" Width="180" Editable="false" />
                                                    </Items>
                                                </ext:FieldContainer>
                                                <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                                    <Items>
                                                        <ext:DateField ID="add_EndDate" runat="server" Flex="1" Editable="false" />
                                                        <ext:TimeField ID="add_EndTime" Increment="60" runat="server" Width="180" Editable="false" />
                                                    </Items>
                                                </ext:FieldContainer>
                                                <ext:TextField runat="server" FieldLabel="备注" ID="add_remark" Editable="true" LabelAlign="Right" />
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
                <ext:Window ID="winImport" runat="server" Icon="MonitorEdit" Closable="true"
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
                                <ext:FileUploadField runat="server" ID="fileUploadFieldExcel" EmptyText="选择导入的Excel文件"
                                    FieldLabel="导入计划文件" ButtonText="" Icon="PageExcel" AllowBlank="false" Width="320"
                                    LabelAlign="Right" />
                            </Items>
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
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
