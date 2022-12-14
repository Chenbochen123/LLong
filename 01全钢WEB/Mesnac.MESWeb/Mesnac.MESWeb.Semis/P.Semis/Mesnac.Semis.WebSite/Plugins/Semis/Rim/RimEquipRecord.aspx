<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RimEquipRecord.aspx.cs" Inherits="Plugins_Semis_Rim_RimEquipRecord" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>轮辋上下机记录</title>
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
                                        <ext:FieldContainer runat="server" FieldLabel="上机开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txtsap" runat="server" FieldLabel="SAP号" LabelAlign="Right" Editable="false"/>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="上机结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtlwcode" runat="server" FieldLabel="轮辋编号" LabelAlign="Right" Editable="false"/>
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
                                                <ext:ModelField Name="NUM" />
                                                <ext:ModelField Name="UPRECORD_TIME" Type="Date"/>
                                                <ext:ModelField Name="DOWNRECORD_TIME" Type="Date"/>
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="UP_USERNAME" />
                                                <ext:ModelField Name="DOWN_USERNAME"/>
                                                <ext:ModelField Name="TYPE"/>
                                                <ext:ModelField Name="MATER_SAP"/>
                                                <ext:ModelField Name="MATERIAL_NAME"/>
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="Column1" runat="server" Text="轮辋编号" DataIndex="LW_CODE" Width="100" />
                                    <ext:Column ID="Column2" runat="server" Text="轮辋类型" DataIndex="TYPE" Width="100" />
                                    <ext:Column ID="Column7" runat="server" Text="检测数量" DataIndex="NUM" Width="100" />
                                    <ext:Column ID="Column8" runat="server" Text="机台" DataIndex="EQUIP_NAME" Width="160" />
                                    <ext:Column ID="Column3" runat="server" Text="SAP号" DataIndex="MATER_SAP" Width="100" />
                                    <ext:Column ID="DefectName" runat="server" Text="物料规格" DataIndex="MATERIAL_NAME" Width="100" />
                                    <ext:Column ID="Column4" runat="server" Text="上机人" DataIndex="UP_USERNAME" Width="100" />
                                    <ext:DateColumn ID="Column9" runat="server" Text="上机时间" DataIndex="UPRECORD_TIME" Width="160" Format="yyyy-MM-dd HH:mm:ss"/>
                                    <ext:Column ID="Remark" runat="server" Text="下机人" DataIndex="DOWN_USERNAME" Width="100" />
                                    <ext:DateColumn ID="DateColumn1" runat="server" Text="下机时间" DataIndex="DOWNRECORD_TIME" Width="160" Format="yyyy-MM-dd HH:mm:ss"/>
                                   
                                </Columns>
                            </ColumnModel>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
