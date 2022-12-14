<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SbeALvSummary.aspx.cs" Inherits="Plugins_Quality_SbeALvSummary" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>A率统计报表</title>
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
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmChkBill" runat="server" />
        <ext:Viewport ID="vpChkBill" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnChkBill" runat="server" Region="North">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbChkBill">
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
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txtmater" runat="server" FieldLabel="物料规格" MaxLength="25"
                                            LabelAlign="Right" />
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:ComboBox ID="cbxType" runat="server" FieldLabel="类型" MaxLength="25"
                                            LabelAlign="Right">
                                            <Items>
                                                <ext:ListItem Text="一类" Value="一类">
                                                </ext:ListItem>
                                                <ext:ListItem Text="二类" Value="二类">
                                                </ext:ListItem>
                                                <ext:ListItem Text="三类" Value="三类">
                                                </ext:ListItem>
                                                <ext:ListItem Text="试制" Value="试制">
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
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxReturn" runat="server" FieldLabel="是否退库" MaxLength="25"
                                            LabelAlign="Right">
                                            <Items>
                                                <ext:ListItem Text="退库" Value="退库">
                                                </ext:ListItem>
                                                <ext:ListItem Text="在库" Value="在库">
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
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="TYPE_NAME" />
                                                <ext:ModelField Name="A" />
                                                <ext:ModelField Name="B" />
                                                <ext:ModelField Name="C" />
                                                <ext:ModelField Name="F" />
                                                <ext:ModelField Name="HEGE" />
                                                <ext:ModelField Name="ALLCOUNT" />
                                                <ext:ModelField Name="ALV" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:Column ID="MajorType" runat="server" Text="物料规格" DataIndex="MATERIAL_NAME" Width="240" />
                                    <ext:Column ID="MinorType" runat="server" Text="类型" DataIndex="TYPE_NAME" Width="120" />
                                    <ext:Column ID="EquipCode" runat="server" Text="A级品" DataIndex="A" Width="120" />
                                    <ext:Column ID="EquipName" runat="server" Text="B级品" DataIndex="B" Width="120" />
                                    <ext:Column ID="Column2" runat="server" Text="合格品" DataIndex="HEGE" Width="120" />
                                    <ext:Column ID="ShowName" runat="server" Text="次品" DataIndex="C" Width="120"  />
                                    <ext:Column ID="Column1" runat="server" Text="废品" DataIndex="F" Width="120" />
                                    <ext:Column ID="Column3" runat="server" Text="合计" DataIndex="ALLCOUNT" Width="120" />
                                    <ext:Column ID="Column4" runat="server" Text="A级品率" DataIndex="ALV" Width="120" />
                                </Columns>
                            </ColumnModel>
                            <BottomBar>
                                <ext:PagingToolbar ID="pageToolBar" runat="server">
                                    <Items>
                                        <ext:Label ID="Label1" runat="server" Text="每页条数:" Hidden="true" />
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
