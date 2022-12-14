<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CuringPressTemp.aspx.cs" Inherits="Plugins_Curing_Technology_CuringPressTemp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script type="text/javascript">
        var btnSearch_Click = function () {
            App.direct.chartMainBindData({
                success: function (result) {
                    if (result != "") {
                        Ext.Msg.alert("提示", result);
                        return false;
                    }
                },
                failure: function (errorMsg) {
                    Ext.Msg.alert("提示", errorMsg);
                    return false;
                },
                eventMask: {
                    showMask: true
                }
            });

            return true;
        };
        var cboSearchShiftId_Change = function (newValue) {
            if (newValue == null || newValue == "") {
                return false;
            }
            App.direct.setSearchTime(newValue, {
                success: function (result) {
                    if (result != "") {
                        Ext.Msg.alert("提示", result);
                        return false;
                    }
                },
                failure: function (errorMsg) {
                    Ext.Msg.alert("提示", errorMsg);
                    return false;
                },
                eventMask: {
                    showMask: true
                }
            });
            return true;
        };

        var cgpSearchPressTempLine_Change = function (item) {
            var selectValues = "";
            var chks = item.getChecked();
            for (var i = 0; i < chks.length; i++) {
                var auditUserId = chks[i].inputValue;
                if (selectValues == "") {
                    selectValues = auditUserId;
                }
                else {
                    selectValues = selectValues + "," + auditUserId;
                }
            }
            App.hdnSearchPressTempLine.setValue(selectValues);
        };

    </script>

    <script>
        var saveChart = function (btn) {
            Ext.MessageBox.confirm('Confirm Download', 'Would you like to download the chart as an image?', function (choice) {
                if (choice == 'yes') {
                    btn.up('panel').down('chart').save({
                        type: 'image/png'
                    });
                }
            });
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager runat="server" ID="ResourceManager1" />
        <ext:Viewport runat="server" ID="Viewport1" Layout="BorderLayout">
            <Items>
                <ext:Panel runat="server" Region="North" AutoScroll="true">
                    <TopBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:Button runat="server" ID="btnSearch" Icon="Find" Text="查询">
                                    <Listeners>
                                        <Click Handler="return btnSearch_Click();" />
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:Panel runat="server" Width="700" Border="false">
                            <Items>
                                <ext:FieldSet runat="server" Layout="FitLayout" ColumnWidth="1" Title="曲线">
                                    <Items>
                                        <ext:CheckboxGroup runat="server" ID="cgpSearchPressTempLine" ColumnsNumber="4" Layout="ColumnLayout">
                                            <Items>
                                                <%--<ext:Checkbox runat="server" InputID="LEFT_MODEL_TEMP" InputValue="L" BoxLabel="左内温" ColumnWidth="0.25" />
                                                <ext:Checkbox runat="server" InputID="LEFT_MODEL_TEMP" InputValue="L" BoxLabel="左内温" ColumnWidth="0.25" />
                                                <ext:Checkbox runat="server" InputID="LEFT_MODEL_TEMP" InputValue="L" BoxLabel="左内温" ColumnWidth="0.25" />
                                                <ext:Checkbox runat="server" InputID="LEFT_MODEL_TEMP" InputValue="L" BoxLabel="左内温" ColumnWidth="0.25" />
                                                <ext:Checkbox runat="server" InputID="LEFT_MODEL_TEMP" InputValue="L" BoxLabel="左内温" ColumnWidth="0.25" />
                                                <ext:Checkbox runat="server" InputID="RIGHT_MODEL_TEMP" InputValue="R" BoxLabel="右内温" ColumnWidth="0.25" />
                                                <ext:Checkbox runat="server" InputID="RIGHT_MODEL_TEMP" InputValue="R" BoxLabel="右内温" ColumnWidth="0.25" />
                                                <ext:Checkbox runat="server" InputID="RIGHT_MODEL_TEMP" InputValue="R" BoxLabel="右内温" ColumnWidth="0.25" />--%>
                                            </Items>
                                            <Listeners>
                                                <Change Handler="return cgpSearchPressTempLine_Change(item);" />
                                            </Listeners>
                                        </ext:CheckboxGroup>
                                        <ext:Hidden runat="server" ID="hdnSearchPressTempLine" />
                                    </Items>
                                </ext:FieldSet>
                                <ext:FieldContainer runat="server" Layout="ColumnLayout" ColumnWidth="1">
                                    <Items>
                                        <ext:ComboBox runat="server" ID="cboSearchEquipId" LabelAlign="Right" FieldLabel="硫化机台"
                                            QueryMode="Local" ForceSelection="true" LabelWidth="80" InputWidth="70">
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" Qtip="清空" HideTrigger="true" />
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Handler="this.setValue('');" />
                                            </Listeners>
                                        </ext:ComboBox>
                                        <ext:ComboBox runat="server" ID="cboSearchShiftId" LabelAlign="Right" FieldLabel="班次" Editable="false"
                                            LabelWidth="80" InputWidth="70">
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" Qtip="清空" HideTrigger="true" />
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Handler="this.setValue('');" />
                                                <Change Handler="return cboSearchShiftId_Change(newValue);" />
                                            </Listeners>
                                        </ext:ComboBox>
                                        <ext:DateField runat="server" ID="datSearchBeginDate" LabelAlign="Right" FieldLabel="时间" Format="yyyy-MM-dd" Editable="false"
                                            LabelWidth="80" InputWidth="90" />
                                        <ext:TimeField runat="server" ID="timSearchBeginTime" HideLabel="true" Format="HH:mm:ss"
                                            InputWidth="90" />
                                        <ext:Label runat="server" Text="~" />
                                        <ext:TimeField runat="server" ID="timSearchEndTime" HideLabel="true" Format="HH:mm:ss" InputWidth="90" />

                                    </Items>
                                </ext:FieldContainer>
                                <ext:FieldContainer runat="server" Layout="ColumnLayout" ColumnWidth="1">
                                    <Items>
                                        <ext:TextField runat="server" ID="txtSearchTyreNo" LabelAlign="Right" FieldLabel="硫化号"
                                            LabelWidth="80" InputWidth="220" />
                                    </Items>
                                </ext:FieldContainer>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:TabPanel runat="server" ID="tabPanelMain" Region="Center" Layout="FitLayout">
                    <Items>
                        <%--温压曲线--%>
                        <ext:Panel runat="server" ActiveIndex="1" ActiveItem="1" Layout="FitLayout" Title="温压曲线">
                            <Items>
                                <ext:Chart
                                    ID="chartMain"
                                    runat="server"
                                    Animate="true">
                                    <Store>
                                        <ext:Store runat="server">
                                            <Model>
                                                <ext:Model runat="server">
                                                    <Fields>
                                                        <ext:ModelField Name="RECORD_TIME" Type="Date" />
                                                        <ext:ModelField Name="SHOW_TIME" />
                                                        <ext:ModelField Name="LEFT_INNER_TEMP" />
                                                        <ext:ModelField Name="RIGHT_INNER_TEMP" />
                                                        <ext:ModelField Name="LEFT_INNER_PRESS" />
                                                        <ext:ModelField Name="RIGHT_INNER_PRESS" />
                                                        <ext:ModelField Name="LEFT_MODEL_TEMP" />
                                                        <ext:ModelField Name="RIGHT_MODEL_TEMP" />
                                                        <ext:ModelField Name="LEFT_PLATE_TEMP" />
                                                        <ext:ModelField Name="RIGHT_PLATE_TEMP" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                        </ext:Store>
                                    </Store>
                                    <Axes>
                                        <ext:TimeAxis
                                            AxisID="RECORD_TIME"
                                            Title="硫化时间"
                                            Fields=""
                                            Position="Bottom"
                                            DateFormat="HH:mm:ss"
                                            Constrain="false"
                                            Grid="true"
                                            AutoDataBind="true" />

                                        <ext:NumericAxis
                                            AxisID="TEMP"
                                            Title="温度"
                                            Fields=""
                                            Position="Left"
                                            Maximum="240"
                                            Minimum="0"
                                            MajorTickSteps="11"
                                            MinorTickSteps="1"
                                            Grid="true">
                                            <LabelTitle Fill="#115fa6" />
                                            <Label Fill="#115fa6" />
                                            <Label Font="10px Arial">
                                                <Renderer Handler="return Ext.util.Format.number(value, '0,0');" />
                                            </Label>
                                        </ext:NumericAxis>

                                        <ext:NumericAxis
                                            AxisID="PRESS"
                                            Title="压力"
                                            Fields=""
                                            Position="Right"
                                            Maximum="3.6"
                                            Minimum="0"
                                            MajorTickSteps="11"
                                            MinorTickSteps="0">
                                            <LabelTitle Fill="#94ae0a" />
                                            <Label Fill="#94ae0a" />
                                        </ext:NumericAxis>
                                    </Axes>
                                    <Series>
                                        <ext:LineSeries
                                            SeriesID="LEFT_INNER_TEMP"
                                            Title="左内温"
                                            XField="RECORD_TIME"
                                            YField="LEFT_INNER_TEMP"
                                            Axis="Left"
                                            Smooth="3">
                                            <HighlightConfig Size="1" Radius="1" />
                                            <MarkerConfig Size="1" Radius="1" StrokeWidth="0" />
                                            <%--<Tips runat="server" TrackMouse="true" Width="120" Height="240">
                                                <Renderer Handler="this.setTitle(storeItem.get('SHOW_TIME') + '<br />左内温' + storeItem.get('LEFT_INNER_TEMP')); this.update(storeItem.get('LEFT_INNER_TEMP'));"></Renderer>
                                            </Tips>
                                            <Style Fill="#38B8BF" Stroke="#38B8BF" StrokeWidth="3" />--%>
                                        </ext:LineSeries>

                                        <ext:LineSeries
                                            SeriesID="RIGHT_INNER_TEMP"
                                            Title="右内温"
                                            XField="RECORD_TIME"
                                            YField="RIGHT_INNER_TEMP"
                                            Axis="Left"
                                            Smooth="3">
                                            <HighlightConfig Size="1" Radius="1" />
                                            <MarkerConfig Size="1" Radius="1" StrokeWidth="0" />
                                        </ext:LineSeries>

                                        <ext:LineSeries
                                            SeriesID="LEFT_INNER_PRESS"
                                            Title="左内压"
                                            XField="RECORD_TIME"
                                            YField="LEFT_INNER_PRESS"
                                            Axis="Right"
                                            Smooth="3">
                                            <HighlightConfig Size="1" Radius="1" />
                                            <MarkerConfig Size="1" Radius="1" StrokeWidth="0" />
                                        </ext:LineSeries>

                                        <ext:LineSeries
                                            SeriesID="RIGHT_INNER_PRESS"
                                            Title="右内压"
                                            XField="RECORD_TIME"
                                            YField="RIGHT_INNER_PRESS"
                                            Axis="Right"
                                            Smooth="3">
                                            <HighlightConfig Size="1" Radius="1" />
                                            <MarkerConfig Size="1" Radius="1" StrokeWidth="0" />
                                        </ext:LineSeries>

                                        <ext:LineSeries
                                            SeriesID="LEFT_MODEL_TEMP"
                                            Title="左模套温度/外压"
                                            XField="RECORD_TIME"
                                            YField=""
                                            Axis="Left"
                                            Smooth="3">
                                            <HighlightConfig Size="1" Radius="1" />
                                            <MarkerConfig Size="1" Radius="1" StrokeWidth="0" />
                                        </ext:LineSeries>

                                        <ext:LineSeries
                                            SeriesID="LEFT_OUTER_PRESS"
                                            Title="左模套温度/外压"
                                            XField="RECORD_TIME"
                                            YField=""
                                            Axis="Right"
                                            Smooth="3"
                                            ShowInLegend="false">
                                            <HighlightConfig Size="1" Radius="1" />
                                            <MarkerConfig Size="1" Radius="1" StrokeWidth="0" />
                                        </ext:LineSeries>

                                        <ext:LineSeries
                                            SeriesID="RIGHT_MODEL_TEMP"
                                            Title="右模套温度/外压"
                                            XField="RECORD_TIME"
                                            YField=""
                                            Axis="Left"
                                            Smooth="3">
                                            <HighlightConfig Size="1" Radius="1" />
                                            <MarkerConfig Size="1" Radius="1" StrokeWidth="0" />
                                        </ext:LineSeries>

                                        <ext:LineSeries
                                            SeriesID="RIGHT_OUTER_PRESS"
                                            Title="右模套温度/外压"
                                            XField="RECORD_TIME"
                                            YField=""
                                            Axis="Right"
                                            Smooth="3"
                                            ShowInLegend="false">
                                            <HighlightConfig Size="1" Radius="1" />
                                            <MarkerConfig Size="1" Radius="1" StrokeWidth="0" />
                                        </ext:LineSeries>

                                        <ext:LineSeries
                                            SeriesID="LEFT_PLATE_TEMP"
                                            Title="左热板温度/外温"
                                            XField="RECORD_TIME"
                                            YField="LEFT_PLATE_TEMP"
                                            Axis="Left"
                                            Smooth="3">
                                            <HighlightConfig Size="1" Radius="1" />
                                            <MarkerConfig Size="1" Radius="1" StrokeWidth="0" />
                                        </ext:LineSeries>

                                        <ext:LineSeries
                                            SeriesID="RIGHT_PLATE_TEMP"
                                            Title="右热板温度/外温"
                                            XField="RECORD_TIME"
                                            YField="LEFT_PLATE_TEMP"
                                            Axis="Left"
                                            Smooth="3">
                                            <HighlightConfig Size="1" Radius="1" />
                                            <MarkerConfig Size="1" Radius="1" StrokeWidth="0" />
                                        </ext:LineSeries>

                                    </Series>
                                    <LegendConfig Position="Bottom" />
                                </ext:Chart>
                            </Items>
                        </ext:Panel>
                        <%--实时曲线--%>
                        <%--                        <ext:Panel runat="server" ActiveIndex="2" ActiveItem="2" Layout="FitLayout" Title="实时曲线">
                            <Items>
                                <ext:Chart
                                    ID="chartRealtime"
                                    runat="server"
                                    StyleSpec="background:#fff;"
                                    Animate="true" Hidden="false">
                                    <Store>
                                        <ext:Store runat="server">
                                            <Model>
                                                <ext:Model runat="server">
                                                    <Fields>
                                                        <ext:ModelField Name="Date" Type="Date" />
                                                        <ext:ModelField Name="Visits" />
                                                        <ext:ModelField Name="Views" />
                                                        <ext:ModelField Name="Users" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                            <Listeners>
                                                --remove old (time) data--
                                                <DataChanged Handler="if(this.getCount() > 10){this.suspendEvents(); this.removeAt(0);this.resumeEvents();}" />
                                            </Listeners>
                                        </ext:Store>
                                    </Store>
                                    <Axes>
                                        <ext:NumericAxis
                                            Fields="Views,Visits,Users"
                                            Title="Number of Hits"
                                            Minimum="0"
                                            Maximum="100">
                                            <GridConfig>
                                                <Odd Opacity="1" Fill="#dedede" Stroke="#ddd" StrokeWidth="0.5" />
                                            </GridConfig>
                                        </ext:NumericAxis>

                                        <ext:TimeAxis
                                            Position="Bottom"
                                            Fields="Date"
                                            Title="Minutes"
                                            DateFormat="HH:mm:ss"
                                            Constrain="true"
                                            StepUnit="Second"
                                            Step="1"
                                            FromDate="<%# StartDate %>"
                                            ToDate="<%# StartDate.AddMinutes(1) %>"
                                            Grid="true"
                                            AutoDataBind="true" />
                                    </Axes>
                                    <Series>
                                        <ext:LineSeries Axes="Left,Bottom" XField="Date" YField="Visits">
                                            <Label Display="None" Field="Visits" TextAnchor="middle" />
                                            <MarkerConfig Size="5" Radius="5" />
                                        </ext:LineSeries>

                                        <ext:LineSeries Axes="Left,Bottom" XField="Date" YField="Views">
                                            <Label Display="None" Field="Visits" TextAnchor="middle" />
                                            <MarkerConfig Size="5" Radius="5" />
                                        </ext:LineSeries>

                                        <ext:LineSeries Axes="Left,Bottom" XField="Date" YField="Users">
                                            <Label Display="None" Field="Visits" TextAnchor="middle" />
                                            <MarkerConfig Size="5" Radius="5" />
                                        </ext:LineSeries>
                                    </Series>
                                </ext:Chart>

                            </Items>
                        </ext:Panel>--%>
                        <%--双曲线--%>
                        <%--                        <ext:Panel runat="server" ActiveIndex="3" ActiveItem="3" Layout="FitLayout" Title="双曲线">
                            <Items>
                                <ext:Chart
                                    ID="chartDouble"
                                    runat="server"
                                    Animate="true">
                                    <Store>
                                        <ext:Store runat="server">
                                            <Model>
                                                <ext:Model runat="server">
                                                    <Fields>
                                                        <ext:ModelField Name="Date" Type="Date" />
                                                        <ext:ModelField Name="Data1" />
                                                        <ext:ModelField Name="Data2" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                        </ext:Store>
                                    </Store>
                                    <Axes>
                                        <ext:TimeAxis
                                            Title="Date"
                                            Fields="Date"
                                            Position="Bottom"
                                            DateFormat="MMM dd HH"
                                            StepUnit="Hour"
                                            Grid="true"
                                            Constrain="true"
                                            AutoDataBind="true" />

                                        <ext:NumericAxis
                                            Title="Data (blue)"
                                            Fields="Data1"
                                            Position="Left"
                                            Maximum="10">
                                            <LabelTitle Fill="#115fa6" />
                                            <Label Fill="#115fa6" />
                                        </ext:NumericAxis>

                                        <ext:NumericAxis
                                            Title="Data (green)"
                                            Fields="Data2"
                                            Position="Right"
                                            Maximum="100">
                                            <LabelTitle Fill="#94ae0a" />
                                            <Label Fill="#94ae0a" />
                                        </ext:NumericAxis>
                                    </Axes>
                                    <Series>
                                        <ext:LineSeries
                                            Titles="Blue Line"
                                            XField="Date"
                                            YField="Data1"
                                            Axis="Left"
                                            Smooth="3">
                                            <HighlightConfig Size="7" Radius="7" />
                                            <MarkerConfig Size="4" Radius="4" StrokeWidth="0" />
                                        </ext:LineSeries>

                                        <ext:LineSeries
                                            Titles="Green Line"
                                            XField="Date"
                                            YField="Data2"
                                            Axis="Right"
                                            Smooth="3">
                                            <HighlightConfig Size="7" Radius="7" />
                                            <MarkerConfig Size="4" Radius="4" StrokeWidth="0" />
                                        </ext:LineSeries>
                                    </Series>
                                    <LegendConfig Position="Bottom" />
                                </ext:Chart>
                            </Items>
                        </ext:Panel>--%>
                        <%--曲线3--%>
                        <%--                        <ext:Panel runat="server" ActiveIndex="4" ActiveItem="4" Layout="FitLayout" Title="曲线3">
                            <Items>
                                <ext:Chart
                                    ID="Chart3"
                                    runat="server"
                                    Animate="true">
                                    <Store>
                                        <ext:Store runat="server">
                                            <Model>
                                                <ext:Model runat="server">
                                                    <Fields>
                                                        <ext:ModelField Name="Date" Type="Date" />
                                                        <ext:ModelField Name="Data1" />
                                                        <ext:ModelField Name="Data2" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                        </ext:Store>
                                    </Store>
                                    <Axes>
                                        <ext:TimeAxis
                                            Title="Date"
                                            Fields="Date"
                                            Position="Bottom"
                                            Constrain="true"
                                            Grid="true"
                                            StepUnit="Second"
                                            AutoDataBind="true">
                                        </ext:TimeAxis>

                                        <ext:NumericAxis
                                            Title="Data (blue)"
                                            Fields="Data1"
                                            Position="Left"
                                            Maximum="10">
                                            <LabelTitle Fill="#115fa6" />
                                            <Label Fill="#115fa6" />
                                        </ext:NumericAxis>

                                        <ext:NumericAxis
                                            Title="Data (green)"
                                            Fields="Data2"
                                            Position="Right"
                                            Maximum="100">
                                            <LabelTitle Fill="#94ae0a" />
                                            <Label Fill="#94ae0a" />
                                        </ext:NumericAxis>
                                    </Axes>
                                    <Series>
                                        <ext:LineSeries
                                            Titles="Blue Line"
                                            XField="Date"
                                            YField="Data1"
                                            Axis="Left"
                                            Smooth="3">
                                            <HighlightConfig Size="7" Radius="7" />
                                            <MarkerConfig Size="4" Radius="4" StrokeWidth="0" />
                                        </ext:LineSeries>

                                        <ext:LineSeries
                                            Titles="Green Line"
                                            XField="Date"
                                            YField="Data2"
                                            Axis="Right"
                                            Smooth="3">
                                            <HighlightConfig Size="7" Radius="7" />
                                            <MarkerConfig Size="4" Radius="4" StrokeWidth="0" />
                                        </ext:LineSeries>
                                    </Series>
                                    <Plugins>
                                    </Plugins>
                                    <LegendConfig Position="Bottom" />
                                </ext:Chart>

                            </Items>
                        </ext:Panel>--%>
                        <%--曲线4--%>
                        <%--                        <ext:Panel runat="server" ActiveIndex="11" ActiveItem="11" Layout="FitLayout" Title="曲线4">
                            <Items>
                                <ext:Chart runat="server" ID="chart4" InsetPadding="30" Hidden="false">
                                    <Store>
                                        <ext:Store
                                            runat="server"
                                            AutoDataBind="false">
                                            <Model>
                                                <ext:Model runat="server">
                                                    <Fields>
                                                        <ext:ModelField Name="RECORD_TIME" Type="Date" />
                                                        <ext:ModelField Name="SHOW_TIME" />
                                                        <ext:ModelField Name="LEFT_INNER_TEMP" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                        </ext:Store>
                                    </Store>

                                    <Axes>
                                        <ext:NumericAxis Minimum="0" Fields="LEFT_INNER_TEMP" Grid="true" Maximum="100">
                                            <Label Font="10px Arial">
                                                <Renderer Handler="return Ext.util.Format.number(value, '0,0');" />
                                            </Label>
                                        </ext:NumericAxis>
                                        <ext:TimeAxis Position="Bottom" Fields="RECORD_TIME" Title="硫化时间">

                                            <Label Font="11px Arial">
                                                <Renderer Handler="return value.substr(0, 3) + ' 07';" />
                                            </Label>
                                        </ext:TimeAxis>
                                    </Axes>

                                    <Series>
                                        <ext:ScatterSeries Axis="Left" XField="RECORD_TIME" YField="LEFT_INNER_TEMP">
                                            <Tips runat="server" TrackMouse="true" Width="80" Height="40">
                                                <Renderer Handler="this.setTitle(storeItem.get('SHOW_TIME') + '<br />' + storeItem.get('LEFT_INNER_TEMP')); this.update(storeItem.get('LEFT_INNER_TEMP'));"></Renderer>
                                            </Tips>

                                            <Style Fill="#38B8BF" Stroke="#38B8BF" StrokeWidth="3" />

                                            <MarkerConfig
                                                Type="Circle"
                                                Size="4"
                                                Radius="4"
                                                StrokeWidth="0"
                                                Fill="#38B8BF"
                                                Stroke="#38B8BF" />
                                        </ext:ScatterSeries>
                                    </Series>
                                </ext:Chart>

                            </Items>
                        </ext:Panel>--%>
                        <%--曲线5--%>
                        <%--                        <ext:Panel runat="server" ActiveIndex="12" ActiveItem="12" Layout="FitLayout" Title="曲线5">
                            <Items>
                                <ext:Chart
                                    ID="Chart5"
                                    runat="server"
                                    StyleSpec="background:#fff;"
                                    Animate="true" Hidden="false">
                                    <Store>
                                        <ext:Store runat="server">
                                            <Model>
                                                <ext:Model runat="server">
                                                    <Fields>
                                                        <ext:ModelField Name="Date" Type="Date" />
                                                        <ext:ModelField Name="Visits" />
                                                        <ext:ModelField Name="Views" />
                                                        <ext:ModelField Name="Users" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                            <Listeners>
                                                remove old (time) data
                                                <DataChanged Handler="if(this.getCount() > 10){this.suspendEvents(); this.removeAt(0);this.resumeEvents();}" />
                                            </Listeners>
                                        </ext:Store>
                                    </Store>
                                    <Axes>
                                        <ext:NumericAxis
                                            Fields="Views,Visits,Users"
                                            Title="Number of Hits"
                                            Minimum="0"
                                            Maximum="100">
                                            <GridConfig>
                                                <Odd Opacity="1" Fill="#dedede" Stroke="#ddd" StrokeWidth="0.5" />
                                            </GridConfig>
                                        </ext:NumericAxis>

                                        <ext:TimeAxis
                                            Position="Bottom"
                                            Fields="Date"
                                            Title="硫化时间"
                                            DateFormat="HH:mm:ss"
                                            Grid="true"
                                            AutoDataBind="false">
                                        </ext:TimeAxis>
                                    </Axes>
                                    <Series>
                                        <ext:LineSeries Axes="Left,Bottom" XField="Date" YField="Visits">
                                            <Label Display="None" Field="Visits" TextAnchor="middle" />
                                            <MarkerConfig Size="5" Radius="5" />
                                        </ext:LineSeries>

                                        <ext:LineSeries Axes="Left,Bottom" XField="Date" YField="Views">
                                            <Label Display="None" Field="Visits" TextAnchor="middle" />
                                            <MarkerConfig Size="5" Radius="5" />
                                        </ext:LineSeries>

                                        <ext:LineSeries Axes="Left,Bottom" XField="Date" YField="Users">
                                            <Label Display="None" Field="Visits" TextAnchor="middle" />
                                            <MarkerConfig Size="5" Radius="5" />
                                        </ext:LineSeries>
                                    </Series>
                                </ext:Chart>

                            </Items>
                        </ext:Panel>--%>
                    </Items>
                </ext:TabPanel>
            </Items>
        </ext:Viewport>
        <ext:TaskManager runat="server">
            <Tasks>
                <%--实时曲线任务--%>
                <%--                <ext:Task TaskID="DataTask" AutoRun="false" Interval="5000">
                    <DirectEvents>
                        <Update OnEvent="GetNewData" />
                    </DirectEvents>
                </ext:Task>--%>
            </Tasks>
        </ext:TaskManager>
    </form>
</body>
</html>
