<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CuringAlarmChart.aspx.cs" Inherits="Plugins_Curing_Technology_CuringAlarmChart" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <script type="text/javascript">
        //列表刷新数据重载方法
        var pnlListFresh = function () {
            App.direct.GridPanelBindData();
            return false;
        }

    </script>
    <script>
        function saveChart(btn) {
            Ext.MessageBox.confirm('Confirm Download', 'Would you like to download the chart as an image?', function (choice) {
                if (choice == 'yes') {
                    App.Chart1.save({
                        type: 'image/png'
                    });
                }
            });
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">

        <ext:ResourceManager ID="rmUser" runat="server" />
        <ext:Viewport ID="vwUnit" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnlUserTitle" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="barUser">
                            <Items>
                                <ext:ToolbarSeparator ID="toolbarSeparator_begin" />
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="点击进行查询" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="pnlListFresh">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle" />
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle_2" Hidden="true" />
                                <ext:Button runat="server" Icon="PageWhiteExcel" Text="导出" Hidden="true" ID="btnExport" Handler="saveChart">
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" />
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:Panel ID="pnlUserQuery" runat="server" AutoHeight="true">
                            <Items>
                                <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container ID="container_1" runat="server" Layout="FormLayout" ColumnWidth=".3" Padding="5">
                                            <Items>
                                                <ext:FieldContainer ID="container1" runat="server" Layout="HBoxLayout" FieldLabel="开始时间" LabelAlign="Right">
                                                    <Items>
                                                        <ext:DateField runat="server" ID="datSearchBeginDate" Flex="1" LabelAlign="Right" Format="yyyy-MM-dd" Editable="false" />
                                                        <ext:TimeField runat="server" ID="timSearchBeginTime"  Format="HH:mm:ss" Width="80" />
                                                    </Items>
                                                </ext:FieldContainer>
                                                <ext:ComboBox runat="server" ID="cboSearchEquipId" Flex="1" LabelAlign="Right" FieldLabel="硫化机台"
                                                    QueryMode="Local" ForceSelection="true">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" HideTrigger="true" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".3" Padding="5">
                                            <Items>
                                                <ext:FieldContainer ID="container3" runat="server" Layout="HBoxLayout" FieldLabel="结束时间" LabelAlign="Right">
                                                    <Items>
                                                        <ext:DateField runat="server" ID="datSearchEndDate" Flex="1" LabelAlign="Right" Format="yyyy-MM-dd" Editable="false" />
                                                        <ext:TimeField runat="server" ID="timSearchEndTime" Format="HH:mm:ss" Width="80" />
                                                    </Items>
                                                </ext:FieldContainer>
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:FormPanel>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:Chart
                    ID="Chart1"
                    runat="server"
                    Shadow="true"
                    StyleSpec="background:#fff"
                    Animate="true">
                    <Store>
                        <ext:Store runat="server" AutoDataBind="true" ID="chart_store">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="ITEM_NAME" />
                                        <ext:ModelField Name="ITEM_COUNT" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Axes>
                        <ext:NumericAxis
                            Fields="ITEM_COUNT"
                            Grid="true"
                            Title="报警数量"
                            Minimum="0">
                            <Label>
                                <Renderer Handler="return Ext.util.Format.number(value, '0');" />
                            </Label>
                        </ext:NumericAxis>
                        <ext:CategoryAxis
                            Position="Bottom"
                            Fields="ITEM_NAME"
                            Title="报警类型" />
                    </Axes>
                    <Series>
                        <ext:ColumnSeries
                            Axis="Left"
                            Highlight="true"
                            XField="ITEM_NAME"
                            YField="ITEM_COUNT">
                            <Tips runat="server" TrackMouse="true" Width="140" Height="28">
                                <Renderer Handler="this.setTitle(storeItem.get('ITEM_NAME') + ': ' + storeItem.get('ITEM_COUNT'));" />
                            </Tips>
                            <Label
                                Display="InsideEnd"
                                Field="ITEM_COUNT"
                                Orientation="Horizontal"
                                Color="#333"
                                TextAnchor="middle">
                                <Renderer Handler="return Ext.util.Format.number(value, '0');" />
                            </Label>
                        </ext:ColumnSeries>
                    </Series>
                </ext:Chart>

            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
