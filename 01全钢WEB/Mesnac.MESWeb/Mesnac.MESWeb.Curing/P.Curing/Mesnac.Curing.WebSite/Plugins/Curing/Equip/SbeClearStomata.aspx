<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SbeClearStomata.aspx.cs" Inherits="Plugins_Curing_Equip_SbeClearStomata" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>气孔疏通预警</title>
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
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }

        var prepareToolbar = function (grid, toolbar, rowIndex, record) {

        }

        var Barcode_Renderer = function (value, metadata, record, rowIndex, colIndex, store, view) {
            if (record.data.USE_DAY >= 20) {
                metadata.style = "color: red;";
            }

            return value;
        };
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
                            <ext:ToolbarSeparator ID="tsMiddle" />
                            <ext:Button runat="server" Icon="PageExcel" Text="导出Excel" ID="btnExport">
                                <ToolTips>
                                    <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
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
                            <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                Padding="5">
                                <Items>
                                    <ext:TextField ID="txtEquipName" runat="server" FieldLabel="机台名称" LabelAlign="Left" EmptyText="使用天数>=20天预警">

                                    </ext:TextField>
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:FormPanel>
                </Items>
            </ext:Panel>
            <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5 "
                Title="气孔疏通预警" >
                <Items>
                    <ext:GridPanel ID="pnlList" runat="server">
                        <Store>
                            <ext:Store ID="store" runat="server" PageSize="20">
                                <Proxy>
                                    <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                </Proxy>
                                <Model>
                                    <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                        <Fields>
                                            <ext:ModelField Name="OBJID" />
                                            <ext:ModelField Name="EQUIPID" />
                                            <ext:ModelField Name="LEFTORR"/>
                                            <ext:ModelField Name="BEGIN_TIME" Type="Date"/>
                                            <ext:ModelField Name="END_TIME" Type="Date"/>
                                            <ext:ModelField Name="USE_DAY"/>
                                            <ext:ModelField Name="REMARK"/>
                                            <ext:ModelField Name="USER_NAME"/>
                                        </Fields>
                                    </ext:Model>
                                </Model>
                            </ext:Store>
                        </Store>
                        <ColumnModel ID="colModel" runat="server">
                            <Columns>
                                <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                <ext:Column ID="EQUIP_NAME" runat="server" Text="机台" DataIndex="EQUIPID" Width="160" >
                                <Renderer Fn="Barcode_Renderer" /></ext:Column>
                                <ext:Column ID="SHOW_NAME" runat="server" Text="左右模" DataIndex="LEFTORR" Width="120">
                                <Renderer Fn="Barcode_Renderer" /></ext:Column>
                                <ext:DateColumn ID="LAST_TIME" runat="server" Text="开始时间" DataIndex="BEGIN_TIME" Width="160"  Format="yyyy-MM-dd HH:mm:ss"/>
                                <ext:DateColumn ID="NEXT_TIME" runat="server" Text="结束时间" DataIndex="END_TIME" Width="160"  Format="yyyy-MM-dd HH:mm:ss"/>
                                <ext:Column ID="LEFT_DAY" runat="server" Text="已使用天数" DataIndex="USE_DAY" Width="120">
                                <Renderer Fn="Barcode_Renderer" /></ext:Column>
                                <ext:Column ID="Column1" runat="server" Text="记录人" DataIndex="USER_NAME" Width="120"/>
                                <ext:Column ID="Column2" runat="server" Text="备注" DataIndex="REMARK" Width="120"/>
                            </Columns>
                        </ColumnModel>
                        <BottomBar>
                            <ext:PagingToolbar ID="pageToolBar" runat="server">
                                <Items>
                                    <ext:Label ID="Label1" runat="server" Text="每页条数:" Hidden="true"/>
                                    <ext:ToolbarSpacer ID="ToolbarSpacer1" runat="server" Width="10" />
                                    <ext:ComboBox ID="ComboBox1" runat="server" Width="80" Hidden="true">
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
