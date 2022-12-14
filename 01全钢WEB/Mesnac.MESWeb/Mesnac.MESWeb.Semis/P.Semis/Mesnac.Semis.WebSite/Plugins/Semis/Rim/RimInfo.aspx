<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RimInfo.aspx.cs" Inherits="Plugins_Semis_Rim_RimInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>轮辋信息维护</title>
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
            if (command.toLowerCase() == "delete") {
                Ext.Msg.confirm("提示", '您确定要删除此条信息吗？', function (btn) { commandcolumn_direct_deletedefect(btn, record) });
            }
            return false;
        };

        var commandcolumn_direct_editdefect = function (record) {
            var ObjID = record.data.OBJID;
            App.direct.commandcolumn_direct_editdefect(ObjID, {
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

                                <ext:Button runat="server" Icon="PageExcel" Text="导出" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将放行记录导出到Excel中" />
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
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtlwcode" runat="server" FieldLabel="轮辋编号" LabelAlign="Right" Editable="false" />
                                        <ext:ComboBox ID="cbxtype" runat="server" FieldLabel="轮辋类型" LabelAlign="Right" Editable="false" />
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtdc" runat="server" FieldLabel="段差" LabelAlign="Right" Editable="false" />
                                        <ext:TextField ID="txtck" runat="server" FieldLabel="寸口" LabelAlign="Right" Editable="false" />
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxstate" runat="server" FieldLabel="轮辋状态" LabelAlign="Right" Editable="false" />
                                        <ext:ComboBox ID="cbxplace" runat="server" FieldLabel="库位" LabelAlign="Right" Editable="false" />
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5 "
                    Title="">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <View>
                                <ext:GridView EnableTextSelection="true"></ext:GridView>
                            </View>
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="10">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="LW_CODE" />
                                                <ext:ModelField Name="TYPE" />
                                                <ext:ModelField Name="DC" />
                                                <ext:ModelField Name="CK" />
                                                <ext:ModelField Name="FACTORY" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="STORE_NAME" />
                                                <ext:ModelField Name="STOREPLACE_NAME" />
                                                <ext:ModelField Name="STATE" />
                                                <ext:ModelField Name="SUPPLIER" />
                                                <ext:ModelField Name="REMARK" />
                                                <ext:ModelField Name="USER_NAME" />
                                                <ext:ModelField Name="RECORD_TIME" Type="Date" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="DefectCode" runat="server" Text="主键" DataIndex="OBJID" Width="60" Visible="false" />
                                    <ext:Column ID="Column1" runat="server" Text="轮辋编号" DataIndex="LW_CODE" Width="120" />
                                    <ext:Column ID="DefectName" runat="server" Text="轮辋类型" DataIndex="TYPE" Width="120" />
                                    <ext:Column ID="Remark" runat="server" Text="段差" DataIndex="DC" Width="120" />
                                    <ext:Column ID="Column3" runat="server" Text="寸口" DataIndex="CK" Width="120" />
                                    <ext:Column ID="Column4" runat="server" Text="生产厂家" DataIndex="FACTORY" Width="120" />
                                    <ext:Column ID="Column5" runat="server" Text="物料名称" DataIndex="MATERIAL_NAME" Width="120" />
                                    <ext:Column ID="Column6" runat="server" Text="库区" DataIndex="STORE_NAME" Width="120" />
                                    <ext:Column ID="Column7" runat="server" Text="库位" DataIndex="STOREPLACE_NAME" Width="120" />
                                    <ext:Column ID="Column8" runat="server" Text="轮辋状态" DataIndex="STATE" Width="120" />
                                    <ext:Column ID="Column9" runat="server" Text="供应商" DataIndex="SUPPLIER" Width="120" />
                                    <ext:Column ID="Column10" runat="server" Text="备注" DataIndex="REMARK" Width="120" />
                                    <ext:Column ID="Column11" runat="server" Text="操作人" DataIndex="USER_NAME" Width="120" />
                                    <ext:DateColumn ID="Column2" runat="server" Text="操作时间" DataIndex="RECORD_TIME" Width="160" Format="yyyy-MM-dd HH:mm:ss" />

                                    <ext:CommandColumn ID="commandCol" runat="server" Width="200" Text="操作" Align="Center">
                                        <Commands>
                                            <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改" />
                                            <ext:CommandSeparator />
                                            <ext:GridCommand Icon="TableDelete" CommandName="Delete" Text="删除" />
                                        </Commands>
                                        <Listeners>
                                            <Command Handler="return commandcolumn_click(command, record);" />
                                        </Listeners>

                                    </ext:CommandColumn>
                                </Columns>
                            </ColumnModel>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
                <ext:Window ID="winAddDefect" runat="server" Icon="MonitorAdd" Closable="true" Title="添加轮辋信息"
                    Width="400" Height="400" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
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
                                                <ext:TextField ID="add_lwcode" runat="server" FieldLabel="轮辋编号" LabelAlign="Right" AllowBlank="false" />
                                                <ext:ComboBox ID="add_type" runat="server" FieldLabel="轮辋类型" LabelAlign="Right" Editable="false" />
                                                <ext:TextField ID="add_dc" runat="server" FieldLabel="段差" LabelAlign="Right" AllowBlank="false" />
                                                <ext:TextField ID="add_ck" runat="server" FieldLabel="寸口" LabelAlign="Right" AllowBlank="false" />
                                                <ext:ComboBox ID="add_fac" runat="server" FieldLabel="生产厂家" LabelAlign="Right"   Editable="false"  />
                                                <ext:ComboBox ID="add_supplier" runat="server" FieldLabel="供应商" LabelAlign="Right"  Editable="false" />
                                                <ext:TextField ID="add_sap" runat="server" FieldLabel="物料SAP" LabelAlign="Right" AllowBlank="false" />
                                                <ext:ComboBox ID="add_store" runat="server" FieldLabel="库区" LabelAlign="Right" Editable="false" />
                                                <ext:ComboBox ID="add_place" runat="server" FieldLabel="库位" LabelAlign="Right" Editable="false" />
                                                <ext:ComboBox ID="add_state" runat="server" FieldLabel="轮辋状态" LabelAlign="Right" Editable="false" />
                                                <ext:TextField ID="add_remark" runat="server" FieldLabel="备注" LabelAlign="Right" AllowBlank="false" />
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
                    Title="修改轮辋信息" Width="320" Height="400" Resizable="false" Hidden="true" Modal="false"
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
                                                <ext:TextField ID="ed_lwcode" runat="server" FieldLabel="轮辋编号" LabelAlign="Right" AllowBlank="false" />
                                                <ext:ComboBox ID="ed_type" runat="server" FieldLabel="轮辋类型" LabelAlign="Right" Editable="false" />
                                                <ext:TextField ID="ed_dc" runat="server" FieldLabel="段差" LabelAlign="Right" AllowBlank="false" />
                                                <ext:TextField ID="ed_ck" runat="server" FieldLabel="寸口" LabelAlign="Right" AllowBlank="false" />
                                                <ext:ComboBox ID="ed_fac" runat="server" FieldLabel="生产厂家" LabelAlign="Right" Editable="false"  />
                                                <ext:ComboBox ID="ed_sup" runat="server" FieldLabel="供应商" LabelAlign="Right"  Editable="false"  />
                                                <ext:TextField ID="ed_sap" runat="server" FieldLabel="物料SAP" LabelAlign="Right" AllowBlank="false" />
                                                <ext:ComboBox ID="ed_store" runat="server" FieldLabel="库区" LabelAlign="Right" Editable="false" />
                                                <ext:ComboBox ID="ed_place" runat="server" FieldLabel="库位" LabelAlign="Right" Editable="false" />
                                                <ext:ComboBox ID="ed_state" runat="server" FieldLabel="轮辋状态" LabelAlign="Right" Editable="false" />
                                                <ext:TextField ID="ed_remark" runat="server" FieldLabel="备注" LabelAlign="Right" AllowBlank="false" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Hidden runat="server" ID="hiddenObjid"></ext:Hidden>
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
