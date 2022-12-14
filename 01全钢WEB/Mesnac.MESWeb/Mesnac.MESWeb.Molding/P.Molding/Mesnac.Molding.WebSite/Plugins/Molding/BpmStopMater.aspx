<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BpmStopMater.aspx.cs" Inherits="Plugins_Molding_BpmStopMater" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>成品胎例查不合格管控</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell {
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
            return false;
        };

        var prepareToolbar = function (grid, toolbar, rowIndex, record) {

        }

        var commandcolumn_direct_editdefect = function (record) {
            var ObjID = record.data.OBJID;
            var b_objid = record.data.B_OBJID;
            debugger;
            App.direct.commandcolumn_direct_editdefect(ObjID, b_objid, {
                success: function (result) {
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
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
                                <ext:ToolbarSeparator ID="tsEnd" />
                                <ext:Button runat="server" Icon="PageExcel" Text="导出Excel" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                                <ext:ToolbarFill ID="tfEnd" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true"
                            Collapsible="false">
                            <Items>
                                <%--<ext:ComboBox ID="cbxreason" runat="server" FieldLabel="解锁原因" LabelAlign="Right"
                                Editable="false" Width="200"/>--%>

                                <ext:TextField ID="CppSap" runat="server" FieldLabel="外胎SAP" LabelAlign="Right"
                                    Editable="false"  />
                                <ext:TextField ID="BpmCpp" runat="server" FieldLabel="胎胚SAP" LabelAlign="Right"
                                    Editable="false" />
                                <ext:TextField ID="txtreason" runat="server" FieldLabel="停机原因" LabelAlign="Right"
                                    Editable="false"   />
                                <ext:ComboBox ID="cbxtype" runat="server" FieldLabel="状态" LabelAlign="Right"
                                    Editable="false">
                                    <Items>
                                        <ext:ListItem Text="正用" Value="正用">
                                        </ext:ListItem>
                                        <ext:ListItem Text="作废" Value="作废">
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
                            </Items>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5 ">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="10">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="CPP_SAP" />
                                                <ext:ModelField Name="CPP_MATER" />
                                                <ext:ModelField Name="BPM_SAP" />
                                                <ext:ModelField Name="BPM_MATER" />
                                                <ext:ModelField Name="STOP_REASON" />
                                                <ext:ModelField Name="STATE" />
                                                <ext:ModelField Name="EQUIPSTATE" />
                                                <ext:ModelField Name="TEST_NUM" />
                                                <ext:ModelField Name="REAL_NUM" />
                                                <ext:ModelField Name="STOP_BEGINTIME" Type="Date" />
                                                <ext:ModelField Name="STOP_ENDTIME" Type="Date" />
                                                <ext:ModelField Name="RECORD_TIME" Type="Date" />
                                                <ext:ModelField Name="USER_NAME" />
                                                <ext:ModelField Name="B_OBJID" />
                                                <ext:ModelField Name="EQUIP_NAME" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="DefectCode" runat="server" Text="外胎SAP" DataIndex="CPP_SAP" Flex="1" />
                                    <ext:Column ID="Column1" runat="server" Text="外胎规格" DataIndex="CPP_MATER" Flex="1" />
                                    <ext:Column ID="Column2" runat="server" Text="胎胚SAP" DataIndex="BPM_SAP" Flex="1" />
                                    <ext:Column ID="Column3" runat="server" Text="胎胚规格" DataIndex="BPM_MATER" Flex="1" />
                                    <ext:Column ID="Column4" runat="server" Text="停机原因" DataIndex="STOP_REASON" Flex="1" />
                                    <ext:Column ID="Column6" runat="server" Text="状态" DataIndex="STATE" Flex="1" />
                                    <ext:Column ID="Column5" runat="server" Text="机台" DataIndex="EQUIP_NAME" Flex="1" />
                                    <ext:Column ID="Column7" runat="server" Text="机台状态" DataIndex="EQUIPSTATE" Flex="1" />
                                    <ext:Column ID="Column8" runat="server" Text="试产数量" DataIndex="TEST_NUM" Flex="1" />
                                    <ext:Column ID="Column9" runat="server" Text="实际生产数量" DataIndex="REAL_NUM" Flex="1" />
                                    <ext:DateColumn ID="DateColumn1" runat="server" Text="停机开始时间" DataIndex="STOP_BEGINTIME" Flex="1" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:DateColumn ID="DateColumn2" runat="server" Text="停机结束时间" DataIndex="STOP_ENDTIME" Flex="1" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:DateColumn ID="DateColumn3" runat="server" Text="记录时间" DataIndex="RECORD_TIME" Flex="1" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="Column10" runat="server" Text="记录人" DataIndex="USER_NAME" Flex="1" />
                                    <ext:CommandColumn ID="commandCol" runat="server" Width="70" Text="操作" Align="Center">
                                        <Commands>
                                            <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改" />
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
                <ext:Window ID="winAddMouldDrum" runat="server" Icon="MonitorAdd" Closable="true" Title="添加停机规格"
                    Width="400" Height="200" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
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
                                                <ext:TextField ID="addcppsap" runat="server" FieldLabel="外胎SAP"
                                                    LabelAlign="Right" AllowBlank="false" />
                                                <ext:TextField ID="addbpmsap" runat="server" FieldLabel="胎胚SAP"
                                                    LabelAlign="Right" AllowBlank="false" />
                                                <ext:TextField ID="addreason" runat="server" FieldLabel="停机原因"
                                                    LabelAlign="Right" AllowBlank="false" />
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="btnAddMouldDrum" runat="server" Text="确定" Icon="Accept">
                            <DirectEvents>
                                <Click OnEvent="btnAddMouldDrum_Click">
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button ID="btnAddMouldDrumCancel" runat="server" Text="取消" Icon="Cancel">
                            <Listeners>
                                <Click Handler=" App.winAddMouldDrum.close(); return false;" />
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
                    Title="修改停机规格" Width="320" Height="200" Resizable="false" Hidden="true" Modal="false"
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

                                                <ext:ComboBox ID="editState" runat="server" FieldLabel="状态" LabelAlign="Right"
                                                    Editable="false">
                                                    <Items>
                                                        <ext:ListItem Text="正用" Value="正用">
                                                        </ext:ListItem>
                                                        <ext:ListItem Text="作废" Value="作废">
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
                                                <ext:ComboBox ID="editEquipstate" runat="server" FieldLabel="机台状态" LabelAlign="Right"
                                                    Editable="false">
                                                    <Items>
                                                        <ext:ListItem Text="停机" Value="停机">
                                                        </ext:ListItem>
                                                        <ext:ListItem Text="试产" Value="试产">
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
                                                <ext:TextField ID="editTestnum" runat="server" FieldLabel="试产数量"
                                                    LabelAlign="Right" AllowBlank="false" />
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
                <ext:Hidden ID="hidden_objid" runat="server"></ext:Hidden>
                <ext:Hidden ID="hidden_objid2" runat="server"></ext:Hidden>
                <%--end 修改机台信息--%>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
