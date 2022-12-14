<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HsmToolingUpdate.aspx.cs" Inherits="Plugins_Semis_HsmToolingUpdate" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
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
            App.pageToolbar.doRefresh();
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
                                    <DirectEvents>
                                        <Click OnEvent="SelectData">
                                        </Click>
                                    </DirectEvents>
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
                                <ext:Container runat="server" Layout="ColumnLayout" ColumnWidth="1">
                                    <Items>
                                        <ext:Container runat="server" ColumnWidth="0.33" Layout="ColumnLayout" Padding="2">
                                            <Items>
                                                <ext:DateField runat="server" ID="dtSearchBeginDate" FieldLabel="开始日期" LabelAlign="Right" LabelWidth="100" Format="yyyy-MM-dd" Width="220">
                                                </ext:DateField>
                                                <ext:TimeField runat="server" ID="tmSearchBeginTime" Format="HH:mm:ss" Hidden="true" Width="75" HideMode="Visibility">
                                                </ext:TimeField>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container runat="server" ColumnWidth="0.33" Layout="ColumnLayout" Padding="2">
                                            <Items>
                                                <ext:DateField runat="server" ID="dtSearchEndDate" FieldLabel="结束日期" LabelAlign="Right" Format="yyyy-MM-dd" Width="220">
                                                </ext:DateField>
                                                <ext:TimeField runat="server" ID="tmSearchEndTime" Format="HH:mm:ss" Hidden="true" Width="75">
                                                </ext:TimeField>
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth="0.33"
                                    Padding="2">
                                    <Items>
                                        <ext:TextField ID="txbName" runat="server" FieldLabel="卡片号" MaxLength="100"
                                            LabelAlign="Right" />
                                    </Items>
                                </ext:Container>
                                    <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth="0.33"
                                    Padding="2">
                                    <Items>
                                        <ext:TextField ID="TextField1" runat="server" FieldLabel="工装RFID条码" MaxLength="100"
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
                        <ext:GridPanel ID="pnlList" runat="server">
                            <View>
                                <ext:GridView EnableTextSelection="true"></ext:GridView>
                            </View>
                            <Store>
                                <ext:Store ID="store" runat="server">
<%--                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>--%>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="CARD_NO" />
                                                <ext:ModelField Name="TOOLING_RFID_BARCODE" />
                                                <ext:ModelField Name="TOOLING_TYPE" />
                                                <ext:ModelField Name="TOOLING_TYPE_NAME" />
                                                <ext:ModelField Name="USER_NAME" />
                                                <ext:ModelField Name="RECORD_TIME" />
                                                <ext:ModelField Name="DUMMY3" />
                                                <ext:ModelField Name="DUMMY4" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="CARD_NO" runat="server" Text="卡片号" DataIndex="CARD_NO" Width="200" />
                                    <ext:Column ID="TOOLING_RFID_BARCODE" runat="server" Text="工装RFID号" DataIndex="TOOLING_RFID_BARCODE" Width="120" />
                                    <ext:Column ID="TOOLING_TYPE" runat="server" Text="工装类型" DataIndex="TOOLING_TYPE" Width="120" />
                                    <ext:Column ID="TOOLING_TYPE_NAME" runat="server" Text="工装类型名称" DataIndex="TOOLING_TYPE_NAME" Width="120" />
                                    <ext:Column ID="USER_NAME" runat="server" Text="记录人" DataIndex="USER_NAME" Width="120" />
                                    <ext:Column ID="RECORD_TIME" runat="server" Text=" 记录时间" DataIndex="RECORD_TIME" Width="200" />
                                    <ext:Column ID="DUMMY3" runat="server" Text="原卡片号" DataIndex="DUMMY3" Width="200" />
                                    <ext:Column ID="Column1" runat="server" Text="修改原因" DataIndex="DUMMY4" Width="200" />
                                </Columns>
                            </ColumnModel>
                            <BottomBar>
                                <ext:PagingToolbar ID="pageToolBar" runat="server">
                                    <Items>
                                        <ext:Label ID="Label2" runat="server" Text="每页条数:" Hidden="true"/>
                                        <ext:ToolbarSpacer ID="ToolbarSpacer2" runat="server" Width="10" />
                                        <ext:ComboBox ID="ComboBox2" runat="server" Width="80" Hidden="true">
                                            <Items>
                                                <ext:ListItem Text="10" />
                                                <ext:ListItem Text="50" />
                                                <ext:ListItem Text="100" />
                                                <ext:ListItem Text="200" />
                                            </Items>
                                            <SelectedItems>
                                                <ext:ListItem Value="10" />
                                            </SelectedItems>
                                            <Listeners>
                                                <Select Handler="#{pnlList}.store.pageSize = parseInt(this.getValue(), 10); #{pageToolBar}.doRefresh(); return false;" />
                                            </Listeners>
                                        </ext:ComboBox>
                                    </Items>
                                    <Plugins>
                                        <ext:ProgressBarPager ID="ProgressBarPager" runat="server" />
                                    </Plugins>
                                </ext:PagingToolbar>
                            </BottomBar>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
