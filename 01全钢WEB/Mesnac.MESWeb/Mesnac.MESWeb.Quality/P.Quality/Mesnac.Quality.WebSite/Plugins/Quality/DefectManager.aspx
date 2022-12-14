<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DefectManager.aspx.cs" Inherits="Plugins_Quality_DefectManager" %>

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

        var pnlListFresh = function () {
            App.pnlList.store.reload();
            return false;
        }

        var commandcolumn_click = function (command, record) {
            commandcolumn_click_confirm(command, record);
            return false;
        };

        //区分删除操作，并进行二次确认操作
        var commandcolumn_click_confirm = function (command, record) {
            if (command.toLowerCase() == "edit") {
                commandcolumn_direct_editdefect(record);
            }
            if (command.toLowerCase() == "delete") {
                Ext.Msg.confirm("提示", '您确定要删除此条信息吗？', function (btn) { commandcolumn_direct_deletedefect(btn, record) });
            }
            return false;
        };

        var prepareToolbar = function (grid, toolbar, rowIndex, record) {

        }

        var commandcolumn_direct_editdefect = function (record) {
            var ObjID = record.data.OBJID;
            var DefectName = record.data.DEFECTNAME;
            var DefectCode = record.data.DEFECTCODE;
            var WorkProcessName = record.data.PROCEDURE_NAME;
            var WorkProcessID = record.data.WORK_PROCESS_ID;
            var Remark = record.data.REMARK;
            var Count = record.data.ALARM_COUNT;
            var Countjj = record.data.ALARM_COUNT_JJ;
            var Time = record.data.ALARM_TIME;
            var Control = record.data.ALARM_CONTROL;
            App.direct.commandcolumn_direct_editdefect(ObjID, DefectName, DefectCode, WorkProcessID, WorkProcessName, Remark, Count, Countjj, Time, Control, {
                success: function (result) {
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        //点击删除按钮
        var commandcolumn_direct_deletedefect = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var id = record.data.OBJID;
            App.direct.commandcolumn_direct_deletedefect(id, {
                success: function (result) {
                    Ext.Msg.alert('操作', result);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
            this.pnlListFresh();
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager ID="rmDefect" runat="server" />
    <ext:Viewport ID="vpDefect" runat="server" Layout="border">
        <Items>
            <ext:Panel ID="pnDefect" runat="server" Region="North">
                <TopBar>
                    <ext:Toolbar runat="server" ID="tbDefect">
                        <Items>
                            <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                <Listeners>
                                    <Click Fn="pnlListFresh" />
                                </Listeners>
                            </ext:Button>
                            <ext:ToolbarSeparator ID="tsBegin" />
                            <ext:Button runat="server" Icon="Add" Text="添加" ID="btnAdd">
                                <DirectEvents>
                                    <Click OnEvent="btnAdd_Click">
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                            <ext:Hidden runat="server" ID="hiddenCode"></ext:Hidden>
                            <ext:Hidden runat="server" ID="hiddenProcessID"></ext:Hidden>
                             <ext:Hidden runat="server" ID="hiddenName"></ext:Hidden>
                            <ext:ToolbarSeparator ID="tsEnd" />
                            <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                            <ext:ToolbarFill ID="tfEnd" />
                        </Items>
                    </ext:Toolbar>
                </TopBar>
                <Items>
                    <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true"
                        Collapsible="false">
                        <Items>
                             <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                Padding="5">
                                <Items>
                                      <ext:TextField ID="txbName" runat="server" FieldLabel="病疵名称" MaxLength="25"
                                        LabelAlign="Right" />
                                </Items>
                            </ext:Container>
                             <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".34"
                                Padding="5">
                                <Items>
                                    <ext:ComboBox ID="cbxProcedure" runat="server" FieldLabel="工序名称" MaxLength="25"
                                        LabelAlign="Right" />
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:FormPanel>
                </Items>
            </ext:Panel>
            <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5 "
                Title="病疵信息管理">
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
                                            <ext:ModelField Name="DEFECTCODE" />
                                            <ext:ModelField Name="DEFECTNAME" />
                                            <ext:ModelField Name="WORK_PROCESS_ID" />
                                            <ext:ModelField Name="PROCEDURE_NAME" />
                                            <ext:ModelField Name="REMARK" />
                                            <ext:ModelField Name="ALARM_COUNT" />
                                            <ext:ModelField Name="ALARM_COUNT_JJ" />
                                            <ext:ModelField Name="ALARM_TIME" />
                                            <ext:ModelField Name="ALARM_CONTROL" />
                                        </Fields>
                                    </ext:Model>
                                </Model>
                            </ext:Store>
                        </Store>
                        <ColumnModel ID="colModel" runat="server">
                            <Columns>
                                <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                <ext:Column ID="DefectName" runat="server" Text="病疵名称" DataIndex="DEFECTNAME" Width="160" />
                                <ext:Column ID="DefectCode" runat="server" Text="病疵编号" DataIndex="DEFECTCODE" Width="100" />
                                <ext:Column ID="WorkProcessID" runat="server" Text="工序编码" DataIndex="WORK_PROCESS_ID" Width="160" hidden="true"/>
                                 <ext:Column ID="Procedure_Name" runat="server" Text="工序名称" DataIndex="PROCEDURE_NAME" Width="160" />
                                 <ext:Column ID="Column4" runat="server" Text="返修报警次数" DataIndex="ALARM_COUNT" Width="160" />
                                 <ext:Column ID="Column5" runat="server" Text="降级报警次数" DataIndex="ALARM_COUNT_JJ" Width="160" />
                                 <ext:Column ID="Column2" runat="server" Text="报警时间范围" DataIndex="ALARM_TIME" Width="160" />
                                 <ext:Column ID="Column3" runat="server" Text="报警控制" DataIndex="ALARM_CONTROL" Width="160" />
                                <ext:Column ID="Remark" runat="server" Text="备注" DataIndex="REMARK" Width="160" flex="1"/>
                                <ext:CommandColumn ID="commandCol" runat="server" Width="200" Text="操作" Align="Center">
                                    <Commands>
                                        <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改" />
                                        <ext:CommandSeparator />
                                        <ext:GridCommand Icon="TableDelete" CommandName="Delete" Text="删除" />
                                    </Commands>
                                    <PrepareToolbar Fn="prepareToolbar" />
                                    <Listeners>
                                        <Command Handler="return commandcolumn_click(command, record);" />
                                    </Listeners>
                                    
                                </ext:CommandColumn>
                            </Columns>
                        </ColumnModel>
                    </ext:GridPanel>
                </Items>
            </ext:Panel>
              <ext:Window ID="winAddDefect" runat="server" Icon="MonitorAdd" Closable="true" Title="添加病疵信息"
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
                                            <ext:TextField ID="txtAddDefectName" runat="server" FieldLabel="病疵名称" MaxLength="25"
                                                LabelAlign="Right" Editable="false" AllowBlank="false">
                                            </ext:TextField>
                                             <ext:TextField ID="txtAddDefectCode" runat="server" FieldLabel="病疵编号" MaxLength="25"
                                                LabelAlign="Right" Editable="false" AllowBlank="false">
                                            </ext:TextField>
                                            <ext:ComboBox ID="txtAddWorkProc" runat="server" FieldLabel="工序名称" MaxLength="25"
                                                LabelAlign="Right" Editable="true" />
                                            <ext:TextField ID="add_count" runat="server" FieldLabel="返修报警次数" MaxLength="25"
                                                LabelAlign="Right">
                                            </ext:TextField>
                                            <ext:TextField ID="add_countjj" runat="server" FieldLabel="降级报警次数" MaxLength="25"
                                                LabelAlign="Right">
                                            </ext:TextField>
                                            <ext:TextField ID="add_time" runat="server" FieldLabel="报警时间范围" MaxLength="25"
                                                LabelAlign="Right">
                                            </ext:TextField>
                                            <ext:ComboBox ID="add_control" runat="server" FieldLabel="报警控制" LabelAlign="Right"
                                                Editable="false">
                                                <Items>
                                                    <ext:ListItem Text="是" Value="1">
                                                    </ext:ListItem>
                                                    <ext:ListItem Text="否" Value="0">
                                                    </ext:ListItem>
                                                </Items>
                                                <Triggers>
                                                    <ext:FieldTrigger Icon="Clear" Qtip="清空">
                                                    </ext:FieldTrigger>
                                                </Triggers>
                                                <Listeners>
                                                    <TriggerClick Handler="this.setValue('');" />
                                                </Listeners>
                                            </ext:ComboBox>
                                            <ext:TextField ID="txtAddRemark" runat="server" FieldLabel="备注" MaxLength="25"
                                                LabelAlign="Right" />
                                        </Items>
                                    </ext:Container>
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:FormPanel>
                </Items>
                <Buttons>
                    <ext:Button ID="btnAddDefectSave" runat="server" Text="确定" Icon="Accept">
                        <DirectEvents>
                            <Click OnEvent="btnAddDefectSave_Click">
                            </Click>
                        </DirectEvents>
                    </ext:Button>
                    <ext:Button ID="btnAddDefectCancel" runat="server" Text="取消" Icon="Cancel">
                        <Listeners>
                            <Click Handler=" App.winAddDefect.close(); return false;" />
                        </Listeners>
                    </ext:Button>
                </Buttons>
                <Listeners>
                    <Show Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).disable(true);}" />
                    <Hide Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).enable(true);}" />
                </Listeners>
            </ext:Window>
            <%--end 添加病疵信息--%>
            <%--修改病疵信息--%>
            <ext:Window ID="winModifyDefect" runat="server" Icon="MonitorEdit" Closable="false"
                Title="修改病疵信息" Width="320" Height="280" Resizable="false" Hidden="true" Modal="false"
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
                                            <ext:TextField ID="modify_objID" Hidden="true" runat="server" LabelAlign="Left"
                                                FieldLabel="ID">
                                            </ext:TextField>
                                            <ext:TextField ID="modify_DefectName" runat="server" FieldLabel="病疵名称" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                             <ext:TextField ID="modify_DefectCode" runat="server" FieldLabel="病疵编号" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                             <ext:ComboBox ID="modify_WorkProc" runat="server" FieldLabel="工序名称" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                            <ext:TextField ID="mod_count" runat="server" FieldLabel="返修报警次数" MaxLength="25"
                                                LabelAlign="Left">
                                            </ext:TextField>
                                            <ext:TextField ID="mod_countjj" runat="server" FieldLabel="降级报警次数" MaxLength="25"
                                                LabelAlign="Left">
                                            </ext:TextField>
                                            <ext:TextField ID="mod_time" runat="server" FieldLabel="报警时间范围" MaxLength="25"
                                                LabelAlign="Left">
                                            </ext:TextField>
                                            <ext:ComboBox ID="mod_control" runat="server" FieldLabel="报警控制" LabelAlign="Left"
                                                Editable="false">
                                                <Items>
                                                    <ext:ListItem Text="是" Value="1">
                                                    </ext:ListItem>
                                                    <ext:ListItem Text="否" Value="0">
                                                    </ext:ListItem>
                                                </Items>
                                                <Triggers>
                                                    <ext:FieldTrigger Icon="Clear" Qtip="清空">
                                                    </ext:FieldTrigger>
                                                </Triggers>
                                                <Listeners>
                                                    <TriggerClick Handler="this.setValue('');" />
                                                </Listeners>
                                            </ext:ComboBox>
                                             <ext:TextField ID="modify_Remark" runat="server" FieldLabel="备注" LabelAlign="Left"
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
                            <Click OnEvent="btnModifyDefectSave_Click">
                            </Click>
                        </DirectEvents>
                    </ext:Button>
                    <ext:Button ID="btnModifyDetailCancel" runat="server" Text="取消" Icon="Cancel">
                        <Listeners>
                            <Click Handler=" App.winModifyDefect.close(); return false;" />
                        </Listeners>
                    </ext:Button>
                </Buttons>
                <Listeners>
                    <Show Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).disable(true);}" />
                    <Hide Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).enable(true);}" />
                </Listeners>
            </ext:Window>
            <%--end 修改机台信息--%>
        </Items>
    </ext:Viewport>
    </form>
</body>
</html>
