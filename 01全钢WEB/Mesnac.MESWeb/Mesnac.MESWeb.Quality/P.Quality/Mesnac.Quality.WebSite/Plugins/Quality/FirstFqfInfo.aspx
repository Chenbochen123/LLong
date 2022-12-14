<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FirstFqfInfo.aspx.cs" Inherits="Plugins_Quality_FirstFqfInfo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>外观一次交检率</title>
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
                                        <ext:FieldContainer runat="server" FieldLabel="开始日期" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:ComboBox ID="cbxhuizong" runat="server" FieldLabel="汇总" LabelAlign="Right"
                                            Editable="false">
                                            <Items>
                                                <ext:ListItem Text="汇总" Value="汇总">
                                                </ext:ListItem>
                                                <ext:ListItem Text="班次" Value="班次">
                                                </ext:ListItem>
                                                <ext:ListItem Text="天" Value="天">
                                                </ext:ListItem>
                                                <ext:ListItem Text="规格" Value="规格">
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
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="结束日期" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                            </Items>
                                        </ext:FieldContainer>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtMater" runat="server" FieldLabel="规格" LabelAlign="Right" />
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
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="100">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server">
                                            <Fields>
                                                <ext:ModelField Name="检测数量" />
                                                <ext:ModelField Name="合格数量" />
                                                <ext:ModelField Name="MES返修数" />
                                                <ext:ModelField Name="降级胎数" />
                                                <ext:ModelField Name="SHIFT_NAME" />
                                                <ext:ModelField Name="DAY" Type="Date"/>
                                                <ext:ModelField Name="SAP_CODE" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="胎侧缺胶" />
                                                <ext:ModelField Name="胎冠缺胶" />
                                                <ext:ModelField Name="子口缺胶" />
                                                <ext:ModelField Name="压杂物" />
                                                <ext:ModelField Name="子口气泡" />
                                                <ext:ModelField Name="胎侧气泡" />
                                                <ext:ModelField Name="胎肩缺胶" />
                                                <ext:ModelField Name="子口大边" />
                                                <ext:ModelField Name="压杂物隔离剂" />
                                                <ext:ModelField Name="压杂物胶边" />
                                                <ext:ModelField Name="压杂物油泥" />
                                                <ext:ModelField Name="压杂物固体杂物" />
                                                <ext:ModelField Name="压杂物其他" />
                                                <ext:ModelField Name="模型污垢模具脏" />
                                                <ext:ModelField Name="ALLBINGCI" />
                                                <ext:ModelField Name="返修总数" />
                                                <ext:ModelField Name="ALV" />
                                                <ext:ModelField Name="其它" />
                                                <ext:ModelField Name="压杂物LV" />
                                                <ext:ModelField Name="缺胶LV" />
                                                <ext:ModelField Name="子口气泡LV" />
                                                <ext:ModelField Name="胎冠缺胶LV" />
                                                <ext:ModelField Name="子口缺胶LV" />
                                                <ext:ModelField Name="胎侧缺胶LV" />
                                                <ext:ModelField Name="胎侧气泡LV" />
                                                <ext:ModelField Name="胎肩缺胶LV" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="Column37" runat="server" Text="班次" DataIndex="SHIFT_NAME" Width="80" />
                                    <ext:DateColumn ID="Column38" runat="server" Text="日期" DataIndex="DAY" Width="100" Format="yyyy-MM-dd"/>
                                    <ext:Column ID="Column36" runat="server" Text="SAP" DataIndex="SAP_CODE" Width="80" />
                                    <ext:Column ID="Column39" runat="server" Text="物料规格" DataIndex="MATERIAL_NAME" Width="180" />
                                    <ext:Column ID="ALLNUM" runat="server" Text="检测数量" DataIndex="检测数量" Width="80" />
                                    <ext:Column ID="Column1" runat="server" Text="合格数量" DataIndex="合格数量" Width="80" />
                                    <ext:Column ID="Column40" runat="server" Text="降级胎数量" DataIndex="降级胎数" Width="80" />
                                    <ext:Column ID="Column41" runat="server" Text="MES返修数" DataIndex="MES返修数" Width="80" />
                                    <ext:Column ID="Column2" runat="server" Text="返修总数" DataIndex="返修总数" Width="80" />
                                    <ext:Column ID="Column19" runat="server" Text="一次交检合格率" DataIndex="ALV" Width="100" />
                                    <ext:Column ID="Column3" runat="server" Text="胎侧缺胶" DataIndex="胎侧缺胶" Width="80" />
                                    <ext:Column ID="Column4" runat="server" Text="胎冠缺胶" DataIndex="胎冠缺胶" Width="80" />
                                    <ext:Column ID="Column5" runat="server" Text="子口缺胶" DataIndex="子口缺胶" Width="80" />
                                    <ext:Column ID="Column6" runat="server" Text="压杂物" DataIndex="压杂物" Width="80" />
                                    <ext:Column ID="Column7" runat="server" Text="子口气泡" DataIndex="子口气泡" Width="80" />
                                    <ext:Column ID="Column8" runat="server" Text="胎侧气泡" DataIndex="胎侧气泡" Width="80" />
                                    <ext:Column ID="Column9" runat="server" Text="胎肩缺胶" DataIndex="胎肩缺胶" Width="80" />
                                    <ext:Column ID="Column10" runat="server" Text="子口大边" DataIndex="子口大边" Width="80" />
                                    <ext:Column ID="Column12" runat="server" Text="压杂物（隔离剂）" DataIndex="压杂物隔离剂" Width="80" />
                                    <ext:Column ID="Column13" runat="server" Text="压杂物（胶边）" DataIndex="压杂物胶边" Width="80" />
                                    <ext:Column ID="Column14" runat="server" Text="压杂物（油泥）" DataIndex="压杂物油泥" Width="80" />
                                    <ext:Column ID="Column15" runat="server" Text="压杂物（固体杂物）" DataIndex="压杂物固体杂物" Width="80" />
                                    <ext:Column ID="Column16" runat="server" Text="压杂物（其他）" DataIndex="压杂物其他" Width="80" />
                                    <ext:Column ID="Column17" runat="server" Text="模型污垢（模具脏）" DataIndex="模型污垢模具脏" Width="80" />
                                    <ext:Column ID="Column18" runat="server" Text="其它" DataIndex="其它" Width="80" />
                                    <ext:Column ID="Column20" runat="server" Text="压杂物率" DataIndex="压杂物LV" Width="80" />
                                    <ext:Column ID="Column21" runat="server" Text="缺胶率" DataIndex="缺胶LV" Width="80" />
                                    <ext:Column ID="Column22" runat="server" Text="子口气泡率" DataIndex="子口气泡LV" Width="80" />
                                    <ext:Column ID="Column23" runat="server" Text="胎冠缺胶率" DataIndex="胎冠缺胶LV" Width="80" />
                                    <ext:Column ID="Column24" runat="server" Text="子口缺胶率" DataIndex="子口缺胶LV" Width="80" />
                                    <ext:Column ID="Column25" runat="server" Text="胎侧缺胶率" DataIndex="胎侧缺胶LV" Width="80" />
                                    <ext:Column ID="Column26" runat="server" Text="胎侧气泡率" DataIndex="胎侧气泡LV" Width="80" />
                                    <ext:Column ID="Column27" runat="server" Text="胎肩缺胶率" DataIndex="胎肩缺胶LV" Width="80" />

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
                                                <Select Handler="#{pnlDetailList}.storeDetail.pageSize = parseInt(this.getValue(), 10); #{pageToolBar}.doRefresh(); return false;" />
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
