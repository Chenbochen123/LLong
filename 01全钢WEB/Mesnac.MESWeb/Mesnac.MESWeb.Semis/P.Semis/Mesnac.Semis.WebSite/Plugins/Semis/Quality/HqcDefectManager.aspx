<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HqcDefectManager.aspx.cs" Inherits="Plugins_Semis_BqcDefectManager" %>

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
            var defectName = record.data.DEFECT_NAME;
            var Remark = record.data.REMARK;
            //rec DefectPos
            var defectPos = record.data.DEFECT_POS;
            App.direct.commandcolumn_direct_editdefect(ObjID, defectName, Remark,defectPos, {
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
                                      <ext:TextField ID="txbName" runat="server" FieldLabel="半部件类型" MaxLength="100"
                                        LabelAlign="Right" />
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:FormPanel>
                </Items>
            </ext:Panel>
            <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5 "
                Title="">
                <Items>
                    <ext:GridPanel ID="pnlList" runat="server" >
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
                                            <ext:ModelField Name="DEFECT_CODE" />
                                            <ext:ModelField Name="DEFECT_NAME" />
                                            <ext:ModelField Name="DEFECT_POS" />
                                            <ext:ModelField Name="DEFECT_POS2" />
                                            <ext:ModelField Name="REMARK" />
                                        </Fields>
                                    </ext:Model>
                                </Model>
                            </ext:Store>
                        </Store>
                        <ColumnModel ID="colModel" runat="server">
                            <Columns>
                                <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                 <ext:Column ID="DefectCode" runat="server" Text="病疵编码" DataIndex="DEFECT_CODE" Width="60"   Visible="false" />
                                <ext:Column ID="DefectPos" runat="server" Text="半部件类型" DataIndex="DEFECT_POS2" Width="120" />
                                <ext:Column ID="DefectName" runat="server" Text="病疵名称" DataIndex="DEFECT_NAME" Width="260" />
                                <ext:Column ID="Remark" runat="server" Text="备注" DataIndex="REMARK" Width="260" />
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
                                            <ext:TextField ID="txtAddDefectName" runat="server" FieldLabel="病疵名称" MaxLength="100"
                                                LabelAlign="Right" Editable="false" AllowBlank="false" >
                                            </ext:TextField>
                                            <ext:TextField ID="txtAddRemark" runat="server" FieldLabel="备注" MaxLength="100"
                                                LabelAlign="Right" />
                                            <ext:ComboBox ID="txtAddDefectPos" runat="server" FieldLabel="半部件类型" LabelAlign="Right" Editable="false"  
                                                DisplayField="DefectPos" ValueField="Objid" >
                                                <Store>
                                                    <ext:Store runat="server" ID="storeDefectPos">
                                                        <Model>
                                                            <ext:Model ID="Model1" runat="server" IDProperty="ID">
                                                                <Fields>
                                                                    <ext:ModelField Name="Objid" ></ext:ModelField>
                                                                    <ext:ModelField Name="DefectPos" ></ext:ModelField>
                                                                </Fields>
                                                            </ext:Model>
                                                            </Model>
                                                        </ext:Store>
                                                    </Store>
                                                </ext:ComboBox>
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
                Title="修改病疵信息" Width="320" Height="250" Resizable="false" Hidden="true" Modal="false"
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
                                             <ext:TextField ID="modify_Remark" runat="server" FieldLabel="备注" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true"/>
                                            <ext:ComboBox ID="txtAddDefectPos2" runat="server" FieldLabel="半部件类型" LabelAlign="Left" Editable="false"  
                                                DisplayField="DefectPos" ValueField="Objid" >
                                                <Store>
                                                    <ext:Store runat="server" ID="storeDefectPos2">
                                                        <Model>
                                                            <ext:Model ID="Model2" runat="server" IDProperty="ID">
                                                                <Fields>
                                                                    <ext:ModelField Name="Objid" ></ext:ModelField>
                                                                    <ext:ModelField Name="DefectPos" ></ext:ModelField>
                                                                </Fields>
                                                            </ext:Model>
                                                            </Model>
                                                        </ext:Store>
                                                    </Store>
                                                </ext:ComboBox>
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
