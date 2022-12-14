<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HppClearJCJInfo.aspx.cs" Inherits="Plugins_Semis_HppClearJCJInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>挤出机机头清洗记录</title>
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
                                <ext:Hidden runat="server" ID="hiddenName"></ext:Hidden>
                                <ext:ToolbarSeparator ID="tsEnd" />
                                <ext:Button runat="server" Icon="PageWhiteExcel" Text="导出" ID="btnExport">
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
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txt_lastmater" runat="server" FieldLabel="上一计划规格" MaxLength="25"
                                            LabelAlign="Right" />
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txt_nowmater" runat="server" FieldLabel="当前计划规格" MaxLength="25"
                                            LabelAlign="Right" />
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txt_equip" runat="server" FieldLabel="机台" MaxLength="25"
                                            LabelAlign="Right" />
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5 ">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="50">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server">
                                            <Fields>
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="JCJ_NAME" />
                                                <ext:ModelField Name="LASTSAP" />
                                                <ext:ModelField Name="LASTMATER" />
                                                <ext:ModelField Name="LASTRUBBER" />
                                                <ext:ModelField Name="NOWSAP" />
                                                <ext:ModelField Name="NOWMATER" />
                                                <ext:ModelField Name="NOWRUBBER" />
                                                <ext:ModelField Name="BEGIN_TIME" Type="Date" />
                                                <ext:ModelField Name="END_TIME" Type="Date" />
                                                <ext:ModelField Name="USER_NAME" />
                                                <ext:ModelField Name="UPLOAD_TIME" Type="Date" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="PASS_REASON" runat="server" Text="机台" DataIndex="EQUIP_NAME" Width="100" />
                                    <ext:Column ID="REMARK" runat="server" Text="挤出机" DataIndex="JCJ_NAME" Width="100" />
                                    <ext:Column ID="USER_NAME" runat="server" Text="上一计划品号" DataIndex="LASTSAP" Width="100" />
                                    <ext:Column ID="Column1" runat="server" Text="上一计划规格" DataIndex="LASTMATER" Width="120" />
                                    <ext:Column ID="Column2" runat="server" Text="上一计划胶料" DataIndex="LASTRUBBER" Width="120" />
                                    <ext:Column ID="Column3" runat="server" Text="当前计划品号" DataIndex="NOWSAP" Width="100" />
                                    <ext:Column ID="Column4" runat="server" Text="当前计划规格" DataIndex="NOWMATER" Width="120" />
                                    <ext:Column ID="Column5" runat="server" Text="当前计划胶料" DataIndex="NOWRUBBER" Width="120" />
                                    <ext:DateColumn ID="RECORD_TIME" runat="server" Text="清胶开始时间" DataIndex="BEGIN_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:DateColumn ID="DateColumn1" runat="server" Text="清胶结束时间" DataIndex="END_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="Column6" runat="server" Text="操作人" DataIndex="USER_NAME" Width="80" />
                                    <ext:DateColumn ID="DateColumn2" runat="server" Text="信号下发时间" DataIndex="UPLOAD_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />

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
