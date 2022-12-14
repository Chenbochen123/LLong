<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SbeShiGongUser.aspx.cs" Inherits="Plugins_MoldingBG_Technology_SbeShiGongUser" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>施工表人员维护</title>
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

        var commandcolumn_direct_editdefect = function (record) {
            var Item = record.data.ITEM;
            var zbid = record.data.ZB_WORKID;
            var jdid = record.data.JD_WORKID;
            var shid = record.data.SH_WORKID;
            var pzid = record.data.PZ_WORKID;
            debugger;
            App.direct.commandcolumn_direct_editdefect(Item, zbid,jdid,shid,pzid, {
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
                                <%--<ext:TextField ID="CppSap" runat="server" FieldLabel="外胎SAP" LabelAlign="Right"
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
                                </ext:ComboBox>--%>
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
                                                <ext:ModelField Name="ITEM" />
                                                <ext:ModelField Name="ZB_WORKID" />
                                                <ext:ModelField Name="JD_WORKID" />
                                                <ext:ModelField Name="SH_WORKID" />
                                                <ext:ModelField Name="PZ_WORKID" />
                                                <ext:ModelField Name="ZBUSER" />
                                                <ext:ModelField Name="JDUSER" />
                                                <ext:ModelField Name="SHUSER" />
                                                <ext:ModelField Name="PZUSER" />
                                                <ext:ModelField Name="RECORD_TIME" Type="Date" />
                                                <ext:ModelField Name="RECORDUSER" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="DefectCode" runat="server" Text="外胎SAP" DataIndex="ITEM" Flex="1" />
                                    <ext:Column ID="Column1" runat="server" Text="制表人工号" DataIndex="ZB_WORKID" Flex="1" />
                                    <ext:Column ID="Column2" runat="server" Text="制表人" DataIndex="ZBUSER" Flex="1" />
                                    <ext:Column ID="Column3" runat="server" Text="校对人工号" DataIndex="JD_WORKID" Flex="1" />
                                    <ext:Column ID="Column4" runat="server" Text="校对人" DataIndex="JDUSER" Flex="1" />
                                    <ext:Column ID="Column6" runat="server" Text="审核人工号" DataIndex="SH_WORKID" Flex="1" />
                                    <ext:Column ID="Column5" runat="server" Text="审核人" DataIndex="SHUSER" Flex="1" />
                                    <ext:Column ID="Column7" runat="server" Text="批准人工号" DataIndex="PZ_WORKID" Flex="1" />
                                    <ext:Column ID="Column8" runat="server" Text="批准人" DataIndex="PZUSER" Flex="1" />
                                    <ext:Column ID="Column9" runat="server" Text="编辑人" DataIndex="RECORDUSER" Flex="1" />
                                    <ext:DateColumn ID="DateColumn1" runat="server" Text="编辑时间" DataIndex="RECORD_TIME" Flex="1" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:CommandColumn ID="commandCol" runat="server" Width="70" Text="操作" Align="Center">
                                        <Commands>
                                            <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改" />
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
                <%--修改病疵信息--%>
                <ext:Window ID="winModifyDefect" runat="server" Icon="MonitorEdit" Closable="false"
                    Title="" Width="320" Height="300" Resizable="false" Hidden="true" Modal="false"
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
                                                <ext:TextField ID="edititem" runat="server" FieldLabel="工序"
                                                    LabelAlign="Right" AllowBlank="false" ReadOnly="true"/>
                                                <ext:TextField ID="editzb" runat="server" FieldLabel="制表人工号"
                                                    LabelAlign="Right" AllowBlank="false" />
                                                <ext:TextField ID="editjd" runat="server" FieldLabel="校对人工号"
                                                    LabelAlign="Right" AllowBlank="false" />
                                                <ext:TextField ID="editsh" runat="server" FieldLabel="审核人工号"
                                                    LabelAlign="Right" AllowBlank="false" />
                                                <ext:TextField ID="editpz" runat="server" FieldLabel="批准人工号"
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
