<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PlmHalfWeight.aspx.cs" Inherits="Plugins_Semis_PlmHalfWeight" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>半制品重量信息</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />

    <script type="text/javascript">

        var pnlListFresh = function () {
            //App.pnlList.store.reload();
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
                                    <Listeners>
                                        <Click Fn="pnlListFresh" />
                                    </Listeners>
                                </ext:Button>

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
                        <ext:Panel ID="pnlQuery" runat="server" AutoHeight="true">
                            <Items>
                                <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container ID="container_1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:TextField ID="SAP1" runat="server" FieldLabel="父项SAP" MaxLength="100"
                                                    LabelAlign="Right" />
                                                <ext:ComboBox ID="cbxzc" runat="server" FieldLabel="是否正常" LabelAlign="Right"
                                                    Editable="false">
                                                    <Items>
                                                        <ext:ListItem Text="是" Value="1">
                                                        </ext:ListItem>
                                                        <ext:ListItem Text="全部" Value="2">
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
                                        </ext:Container>
                                        <ext:Container ID="container_2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:TextField ID="SAP2" runat="server" FieldLabel="子项SAP" MaxLength="100"
                                                    LabelAlign="Right" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_3" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:ComboBox ID="cbxtype" runat="server" FieldLabel="阶段" LabelAlign="Right"
                                                    Editable="false">
                                                    <Items>
                                                        <ext:ListItem Text="试制" Value="01">
                                                        </ext:ListItem>
                                                        <ext:ListItem Text="试产" Value="02">
                                                        </ext:ListItem>
                                                        <ext:ListItem Text="投产" Value="03">
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
                                        </ext:Container>
                                    </Items>
                                </ext:FormPanel>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5 "
                    Title="">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="50">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="MASTERSAP" />
                                                <ext:ModelField Name="MASTERREVISION" />
                                                <ext:ModelField Name="MASTERSPEC" />
                                                <ext:ModelField Name="MASTERDESC" />
                                                <ext:ModelField Name="SUBITEMSAP" />
                                                <ext:ModelField Name="SUBITEMREVISION" />
                                                <ext:ModelField Name="SUBITEMSPEC" />
                                                <ext:ModelField Name="SUBITEMDESC" />
                                                <ext:ModelField Name="WEIGHT" />
                                                <ext:ModelField Name="UNIT" />
                                                <ext:ModelField Name="PROPHASE" />
                                                <ext:ModelField Name="FACTORY" />
                                                <ext:ModelField Name="WERKS" />
                                                <ext:ModelField Name="RECORD_TIME" />
                                                <ext:ModelField Name="TYPE" />
                                                <ext:ModelField Name="DELETEFLAG" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="DefectCode" runat="server" Text="主键" DataIndex="OBJID" Width="60" Visible="false" />
                                    <ext:Column ID="Column15" runat="server" Text="状态" DataIndex="DELETEFLAG" Width="80" />
                                    <ext:Column ID="Column1" runat="server" Text="父项品号" DataIndex="MASTERSAP" Width="100" />
                                    <ext:Column ID="Column2" runat="server" Text="父项版本" DataIndex="MASTERREVISION" Width="100" />
                                    <ext:Column ID="Column3" runat="server" Text="父项规格" DataIndex="MASTERSPEC" Width="100" />
                                    <ext:Column ID="Column4" runat="server" Text="父项描述" DataIndex="MASTERDESC" Width="100" />
                                    <ext:Column ID="Column5" runat="server" Text="子项品号" DataIndex="SUBITEMSAP" Width="100" />
                                    <ext:Column ID="Column6" runat="server" Text="子项版本" DataIndex="SUBITEMREVISION" Width="80" />
                                    <ext:Column ID="Column8" runat="server" Text="子项规格" DataIndex="SUBITEMSPEC" Width="100" />
                                    <ext:Column ID="Column9" runat="server" Text="子项描述" DataIndex="SUBITEMDESC" Width="100" />
                                    <ext:Column ID="Column10" runat="server" Text="重量" DataIndex="WEIGHT" Width="80" />
                                    <ext:Column ID="Column11" runat="server" Text="单位" DataIndex="UNIT" Width="80" />
                                    <ext:Column ID="Column12" runat="server" Text="阶段" DataIndex="TYPE" Width="80" />
                                    <ext:Column ID="Column13" runat="server" Text="分厂" DataIndex="FACTORY" Width="80" />
                                    <ext:Column ID="Column14" runat="server" Text="工厂" DataIndex="WERKS" Width="80" />
                                    <ext:DateColumn ID="Column7" runat="server" Text="下传时间" DataIndex="RECORD_TIME" Width="160" Format="yyyy-MM-dd HH:mm:ss" />
                                </Columns>
                            </ColumnModel>
                            <BottomBar>
                                <ext:PagingToolbar ID="pageToolbar" runat="server">
                                    <Items>
                                        <ext:Label ID="Label2" runat="server" Text="每页条数:" />
                                        <ext:ToolbarSpacer ID="ToolbarSpacer2" runat="server" Width="10" />
                                        <ext:ComboBox ID="ComboBox2" runat="server" Width="80">
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
                                                <Select Handler="#{pnlList}.store.pageSize = parseInt(this.getValue(), 10); #{pageToolbar}.doRefresh(); return false;" />
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
