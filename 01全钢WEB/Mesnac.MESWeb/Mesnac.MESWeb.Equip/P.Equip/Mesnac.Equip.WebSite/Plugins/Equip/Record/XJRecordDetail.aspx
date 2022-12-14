<%@ Page Language="C#" AutoEventWireup="true" CodeFile="XJRecordDetail.aspx.cs" Inherits="Plugins_Equip_Record_XJRecordDetail" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>设备巡检项目维护</title>
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
            var Objid = record.data.OBJID;
            var MajorName = record.data.MAJOR_TYPE_NAME;
            var MinorName = record.data.MINOR_TYPE_NAME;
            var TypeName = record.data.INSPECTION_TYPE_NAME;
            var SeqIndex = record.data.SEQ_INDEX
            var Content = record.data.INSPECTION_CONTENT;
            var Standard = record.data.INSPECTION_STANDARD;
            var Method = record.data.INSPECTION_METHOD;
            var Record = record.data.INSPECTION_RECORD;
            var RepairTime = record.data.REPAIR_TIME;
            var Remark = record.data.REMARK;
            
            debugger;
            App.direct.commandcolumn_direct_edit(Objid, MajorName, MinorName, TypeName, SeqIndex, Content, Standard, Method, Record, RepairTime, Remark, {
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
                                <ext:ToolbarSeparator ID="toolbarSeparator_begin" />
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
                </ext:Panel>
                <ext:GridPanel ID="pnlList" runat="server" Region="Center">
                    <Store>
                        <ext:Store ID="store" runat="server" PageSize="200">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" AutoDataBind="false" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="MAJOR_TYPE_NAME" />
                                        <ext:ModelField Name="MINOR_TYPE_NAME" />
                                        <ext:ModelField Name="EQUIP_NAME" />
                                        <ext:ModelField Name="INSPECTION_TYPE_NAME" />
                                        <ext:ModelField Name="INSPECTION_CONTENT" />
                                        <ext:ModelField Name="INSPECTION_STANDARD" />
                                        <ext:ModelField Name="INSPECTION_METHOD" />
                                        <ext:ModelField Name="USER_NAME" />
                                        <ext:ModelField Name="RECORD_TIME" />
                                        <ext:ModelField Name="SEQ_INDEX" />
                                        <ext:ModelField Name="INSPECTION_RECORD" />
                                        <ext:ModelField Name="REPAIR_TIME" />
                                        <ext:ModelField Name="REMARK" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                            <ext:Column ID="OBJID" runat="server" Text="OBJID" DataIndex="OBJID" Hidden="true" />
                            <ext:Column ID="MAJOR_TYPE_NAME" runat="server" Text="设备大类" DataIndex="MAJOR_TYPE_NAME" Width="60" />
                            <ext:Column ID="MINOR_TYPE_NAME" runat="server" Text="设备细类" DataIndex="MINOR_TYPE_NAME" Width="100" />
                            <ext:Column ID="EQUIP_NAME" runat="server" Text="设备名称" DataIndex="EQUIP_NAME" Width="80" />
                            <ext:Column ID="INSPECTION_TYPE_NAME" runat="server" Text="巡检项目类别" DataIndex="INSPECTION_TYPE_NAME" Width="100" />
                            <ext:Column ID="SEQ_INDEX" runat="server" Text="序号" DataIndex="SEQ_INDEX" Width="50" />
                            <ext:Column ID="INSPECTION_CONTENT" runat="server" Text="巡检内容" DataIndex="INSPECTION_CONTENT" Width="200" />
                            <ext:Column ID="INSPECTION_STANDARD" runat="server" Text="巡检标准" DataIndex="INSPECTION_STANDARD" Width="160" />
                            <ext:Column ID="INSPECTION_METHOD" runat="server" Text="点检方法" DataIndex="INSPECTION_METHOD" Width="80" />
                            <ext:Column ID="INSPECTION_RECORD" runat="server" Text="巡检情况" DataIndex="INSPECTION_RECORD" Width="200" />
                            <ext:DateColumn ID="REPAIR_TIME" runat="server" Text="整改时间" DataIndex="REPAIR_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                            <ext:Column ID="REMARK" runat="server" Text="备注" DataIndex="REMARK" Width="100" />
                            <ext:Column ID="USER_NAME" runat="server" Text="记录人" DataIndex="USER_NAME" Width="70" />
                            <ext:DateColumn ID="RECORD_TIME" runat="server" Text="记录时间" DataIndex="RECORD_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                            <ext:CommandColumn ID="cmdCol" runat="server" Align="Center" Text="操作" Width="60">
                                <Commands>
                                    <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改" />
                                    <ext:GridCommand Icon="TableDelete" CommandName="Delete" Text="删除" Hidden="true" />
                                </Commands>
                                <Listeners>
                                    <Command Handler="commandcolumn_click(command, record);" />
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

                <ext:Window ID="winModify" runat="server" Icon="MonitorEdit" Closable="false" Title="修改设备点检项目"
                    Width="500" Height="400" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
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
                                        <ext:Container ID="Container2" runat="server" Layout="FormLayout" ColumnWidth="1"
                                            Padding="5">
                                            <Items>
                                                <ext:TextField ID="modify_obj_id" runat="server" Hidden="true" />
                                                <ext:TextField ID="modify_equip_major" runat="server" FieldLabel="设备大类" LabelAlign="Right" ReadOnly="true" />
                                                <ext:TextField ID="modify_equip_minor" runat="server" FieldLabel="设备细类" LabelAlign="Right" ReadOnly="true" />
                                                <ext:TextField ID="modify_type_name" runat="server" FieldLabel="巡检项目类别" LabelAlign="Right" ReadOnly="true" />
                                                <ext:TextField ID="modify_index" runat="server" FieldLabel="序号" LabelAlign="Right" ReadOnly="true" />
                                                <ext:TextArea ID="modify_content" runat="server" FieldLabel="巡检内容" LabelAlign="Right" ReadOnly="true" />
                                                <ext:TextField ID="modify_standard" runat="server" FieldLabel="巡检标准" LabelAlign="Right" ReadOnly="true" />
                                                <ext:TextField ID="modify_method" runat="server" FieldLabel="点检方法" LabelAlign="Right" ReadOnly="true" />
                                                <ext:TextField ID="modify_record" runat="server" FieldLabel="巡检情况" LabelAlign="Right"  />
                                                <ext:FieldContainer runat="server" FieldLabel="整改时间" Layout="HBoxLayout" LabelAlign="Right">
                                                    <Items>
                                                        <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="true" />
                                                        <ext:TimeField ID="txtBeginTime" runat="server"  Editable="true" />
                                                    </Items>
                                                </ext:FieldContainer>
                                                <ext:TextField ID="modify_remark" runat="server" FieldLabel="备注" LabelAlign="Right"  />
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
                </ext:Window>

                <ext:Hidden ID="hidden_plan_id" runat="server" />
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
