<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CuringEquipMonitor.aspx.cs" Inherits="Plugins_Curing_Technology_CuringEquipMonitor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style>
        div.item-wrap {
            float: left;
            border: 1px solid transparent;
            margin: 5px 5px 5px 5px;
            width: 80px;
            cursor: pointer;
            height: 100px;
            text-align: center;
        }

            div.item-wrap img {
                margin: 0px 0px 0px 0px;
                width: 60px;
                height: 40px;
            }

            div.item-wrap h6 {
                font-size: 14px;
                color: #3A4B5B;
                font-family: tahoma,arial,san-serif;
            }

            div.item-wrap h3 {
                font-size: 8px;
                color: #3A4B5B;
                font-family: tahoma,arial,san-serif;
            }

        div.x-view-over {
            border: solid 1px silver;
        }

        #items-ct {
            padding: 0px 30px 24px 30px;
        }

            #items-ct h2 {
                border-bottom: 2px solid #3A4B5B;
                cursor: pointer;
            }

                #items-ct h2 div {
                    background: transparent url(resources/images/group-expand-sprite.gif) no-repeat 3px -47px;
                    padding: 4px 4px 4px 17px;
                    font-family: tahoma,arial,san-serif;
                    font-size: 12px;
                    color: #3A4B5B;
                }

            #items-ct .collapsed h2 div {
                background-position: 3px 3px;
            }

            #items-ct dl {
                margin-left: 2px;
            }

            #items-ct .collapsed dl {
                display: none;
            }
    </style>
    <script>
        var itemClick = function (view, record, item, index, e) {
            var group = e.getTarget("h2", 3, true);

            if (group) {
                group.up("div").toggleCls("collapsed");
                return false;
            }

            var item = e.getTarget(".item-wrap");
            if (item) {
                var axisModelTemp = "left";
                var leftModelTempTitle = "左模套温度"
                var rightModelTempTitle = "右模套温度"
                var leftPlateTempTitle = "左热板温度"
                var rightPlateTempTitle = "右热板温度"
                if (item.innerText.indexOf("蒸锅") > 0)
                {
                    axisModelTemp = "right";
                    leftModelTempTitle = "左外压"
                    rightModelTempTitle = "右外压"
                    leftPlateTempTitle = "左外温"
                    rightPlateTempTitle = "右外温"
                }

                var lines = "1,2,4,8,16,32,64,128".split(',');
                var chartMain = App.chartMain;
                var seriesMain = chartMain.series;
                var seriesLeftInnerTemp = seriesMain.getByKey("LEFT_INNER_TEMP");
                var seriesRightInnerTemp = seriesMain.getByKey("RIGHT_INNER_TEMP");
                var seriesLeftInnerPress = seriesMain.getByKey("LEFT_INNER_PRESS");
                var seriesRightInnerPress = seriesMain.getByKey("RIGHT_INNER_PRESS");
                var seriesLeftModelTemp = seriesMain.getByKey("LEFT_MODEL_TEMP");
                var seriesRightModelTemp = seriesMain.getByKey("RIGHT_MODEL_TEMP");
                var seriesLeftPlateTemp = seriesMain.getByKey("LEFT_PLATE_TEMP");
                var seriesRightPlateTemp = seriesMain.getByKey("RIGHT_PLATE_TEMP");

                //内温
                if (lines.indexOf("1") < 0) {
                    seriesLeftInnerTemp.hideAll();
                    seriesLeftInnerTemp.showInLegend = false;
                }
                else {
                    seriesLeftInnerTemp.showAll();
                    seriesLeftInnerTemp.showInLegend = true;
                }
                if (lines.indexOf("2") < 0) {
                    seriesRightInnerTemp.hideAll();
                    seriesRightInnerTemp.showInLegend = false;
                }
                else {
                    seriesRightInnerTemp.showAll();
                    seriesRightInnerTemp.showInLegend = true;
                }
                // 内压
                if (lines.indexOf("4") < 0) {
                    seriesLeftInnerPress.hideAll();
                    seriesLeftInnerPress.showInLegend = false;
                }
                else {
                    seriesLeftInnerPress.showAll();
                    seriesLeftInnerPress.showInLegend = true;
                }
                if (lines.indexOf("8") < 0) {
                    seriesRightInnerPress.hideAll();
                    seriesRightInnerPress.showInLegend = false;
                }
                else {
                    seriesRightInnerPress.showAll();
                    seriesRightInnerPress.showInLegend = true;
                }
                //模套温度/外压
                if (lines.indexOf("16") < 0) {
                    seriesLeftModelTemp.hideAll();
                    seriesLeftModelTemp.showInLegend = false;
                }
                else {
                    seriesLeftModelTemp.axis = axisModelTemp;
                    seriesLeftModelTemp.setTitle(0, leftModelTempTitle);
                    seriesLeftModelTemp.showAll();
                    seriesLeftModelTemp.showInLegend = true;
                }
                if (lines.indexOf("32") < 0) {
                    seriesRightModelTemp.hideAll();
                    seriesRightModelTemp.showInLegend = false;
                }
                else {
                    seriesRightModelTemp.axis = axisModelTemp;
                    seriesRightModelTemp.setTitle(0, rightModelTempTitle);
                    seriesRightModelTemp.showAll();
                    seriesRightModelTemp.showInLegend = true;
                }

                //热板温度/外温
                if (lines.indexOf("64") < 0) {
                    seriesLeftPlateTemp.hideAll();
                    seriesLeftPlateTemp.showInLegend = false;
                }
                else {
                    seriesLeftPlateTemp.setTitle(0, leftPlateTempTitle);
                    seriesLeftPlateTemp.showAll();
                    seriesLeftPlateTemp.showInLegend = true;
                }
                if (lines.indexOf("128") < 0) {
                    seriesRightPlateTemp.hideAll();
                    seriesRightPlateTemp.showInLegend = false;
                }
                else {
                    seriesRightPlateTemp.setTitle(0, rightPlateTempTitle);
                    seriesRightPlateTemp.showAll();
                    seriesRightPlateTemp.showInLegend = true;
                }

                App.direct.Dashboard_ItemClick(item.id, {
                    success: function (result) {
                        if (result != "") {
                            Ext.Msg.alert("提示", result);
                            return false;
                        }

                        chartMain.redraw();
                        //App.MainTabPanel.closeTab(App.PressTempPanel);
                        App.MainTabPanel.addTab(App.PressTempPanel);
                        App.MainTabPanel.setActiveTab(App.PressTempPanel);
                        App.TaskManager1.startTask("EquipState");
                        App.direct.chartMainBindData(item.id, {
                            success: function (result) {
                                if (result != "") {
                                    Ext.Msg.alert("提示", result);
                                    return false;
                                }
                                App.TaskManager1.startTask("PressTemp");
                            },
                            failure: function (errorMsg) {
                                Ext.Msg.alert("提示", errorMsg);
                                return false;
                            },
                            eventMask: {
                                showMask: true
                            }

                        });
                    },
                    failure: function (errorMsg) {
                        Ext.Msg.alert("提示", errorMsg);
                        return false;
                    },
                    eventMask: {
                        showMask: true
                    }

                });
                //Ext.Msg.alert("Click", "The node with id='" + item.id + "' has been clicked");
            }
        };


        var storeMain_DataChanged = function (store) {
            if (App.hdnLastBeginRecordTime.value != null
                && App.hdnLastBeginRecordTime.value != ""
                && store.data != null) {
                var lastBeginRecordTime = new Date(App.hdnLastBeginRecordTime.value);
                var dataLength = store.data.length;
                for (var i = 0; i < dataLength; i++) {
                    if (store.data.items[i].data.RECORD_TIME < lastBeginRecordTime) {
                        store.suspendEvents();
                        store.removeAt(0);
                        store.resumeEvents();
                        i = i - 1;
                        dataLength = dataLength - 1;
                    }
                    else {
                        return true;
                    }
                }
            }
        };

        var PressTempPanel_Close = function () {
            App.TaskManager1.stopTask("PressTemp");
            App.TaskManager1.stopTask("EquipState");
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager runat="server" ID="ResourceManager1" />
        <ext:Viewport runat="server" ID="Viewport1" Layout="BorderLayout">
            <Items>
                <ext:Panel runat="server" Region="North" Height="0">
                    <Items>
                    </Items>
                </ext:Panel>
                <ext:TabPanel runat="server" ID="MainTabPanel" Region="Center" Layout="FitLayout">
                    <Items>
                        <ext:Panel
                            ID="DashBoardPanel"
                            runat="server"
                            Cls="items-view"
                            Layout="FitLayout"
                            AutoHeight="true"
                            Width="800"
                            Border="false"
                            ActiveIndex="1"
                            ActiveItem="1"
                            Title="机台监控">
                            <TopBar>
                                <ext:Toolbar runat="server" Flat="true">
                                    <Items>
                                        <ext:ToolbarFill MaxWidth="50" />
                                        <ext:RadioGroup runat="server">
                                            <Items>
                                                <ext:Radio runat="server" ID="rdo_0" BoxLabel="全部" Checked="true" Width="100" InputValue="" />
                                                <ext:Radio runat="server" ID="rdo_5" BoxLabel="报警" Visible="false" InputValue="5" />
                                            </Items>
                                        </ext:RadioGroup>
                                        <ext:ToolbarFill />

                                        <ext:Button runat="server" Icon="BulletPlus" Text="全部展开">
                                            <Listeners>
                                                <Click Handler="#{Dashboard}.el.select('.group-header').removeCls('collapsed');" />
                                            </Listeners>
                                        </ext:Button>

                                        <ext:Button runat="server" Icon="BulletMinus" Text="全部收缩">
                                            <Listeners>
                                                <Click Handler="#{Dashboard}.el.select('.group-header').addCls('collapsed');" />
                                            </Listeners>
                                        </ext:Button>

                                        <ext:ToolbarSpacer runat="server" Width="30" />
                                    </Items>
                                </ext:Toolbar>
                            </TopBar>
                            <Items>
                                <ext:DataView
                                    ID="Dashboard"
                                    runat="server"
                                    SingleSelect="true"
                                    ItemSelector="div.group-header"
                                    AutoHeight="true"
                                    EmptyText="No items to display" AutoScroll="true">
                                    <Store>
                                        <ext:Store ID="Store1" runat="server">
                                            <Model>
                                                <ext:Model runat="server">
                                                    <Fields>
                                                        <ext:ModelField Name="Title" />
                                                        <ext:ModelField Name="Items" IsComplex="true" />
                                                    </Fields>
                                                </ext:Model>
                                            </Model>
                                        </ext:Store>
                                    </Store>
                                    <Tpl runat="server">
                                        <Html>
                                            <div id="items-ct">
								<tpl for=".">
									<div class="group-header">
										<h2><div>{Title}</div></h2>
										<dl>
											<tpl for="Items">
												<div id="{Id}" class="item-wrap">
													<div>
														<H6>机台：{EquipName}</H6>                                                    
													</div>
                                                    <div>
													    <img  src="{Icon}" />
                                                    </div>
                                                    <div>
                                                        <H3>{MinorTypeName}</H3>
                                                    </div>
                                                    <div>
                                                        <H3>状态：{EquipStateCaption}</H3>
                                                    </div>
												</div>
											</tpl>
											<div style="clear:left"></div>
										 </dl>
									</div>
								</tpl>
							</div>
                                        </Html>
                                    </Tpl>
                                    <Listeners>
                                        <ItemClick Fn="itemClick" />
                                        <Refresh Handler="this.el.select('.item-wrap').addClsOnOver('x-view-over');" Delay="100" />
                                    </Listeners>
                                </ext:DataView>
                            </Items>
                        </ext:Panel>
                        <ext:Panel runat="server" ID="PressTempPanel" ActiveIndex="2" ActiveItem="2" Title="实时监控" Layout="BorderLayout" Hidden="true" CloseAction="Hide" Closable="true">
                            <Items>
                                <ext:Panel runat="server" Region="Center" Layout="BorderLayout">
                                    <Items>
                                        <ext:Panel runat="server" Region="West" Width="220">
                                            <Items>
                                                <ext:ComboBox runat="server" ID="cboEquipId" FieldLabel="当前机台" HideEmptyLabel="true" LabelWidth="80" ForceSelection="true" ReadOnly="true"></ext:ComboBox>
                                                <ext:TextField runat="server" ID="txtEquipMinorTypeName" LabelAlign="Right" FieldLabel="机台类型" LabelWidth="80"></ext:TextField>
                                                <ext:TextField runat="server" ID="txtCurrentTime" LabelAlign="Right" FieldLabel="当前时间" LabelWidth="80"></ext:TextField>
                                                <ext:Image runat="server" ID="imgEquipState"></ext:Image>
                                                <ext:FieldSet runat="server" ID="fsValveState" Hidden="true" Title="阀门状态" Layout="ColumnLayout">
                                                    <Items>
                                                    </Items>
                                                </ext:FieldSet>
                                                <ext:Hidden runat="server" ID="hdnLastBeginRecordTime" />
                                                <ext:Hidden runat="server" ID="hdnLastEndRecordTime" />
                                            </Items>
                                        </ext:Panel>
                                        <ext:Panel runat="server" Region="Center" Layout="BorderLayout">
                                            <Items>
                                                <ext:Panel runat="server" Region="Center" Layout="FitLayout">
                                                    <Items>
                                                        <ext:Chart
                                                            ID="chartMain"
                                                            runat="server"
                                                            Animate="true" Legend="false">
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
                                                                    <Listeners>
                                                                        <DataChanged Handler="return storeMain_DataChanged(store);" />
                                                                    </Listeners>
                                                                </ext:Store>
                                                            </Store>
                                                            <Axes>
                                                                <ext:TimeAxis
                                                                    AxisID="RECORD_TIME"
                                                                    Title="硫化时间"
                                                                    Fields=""
                                                                    Position="Bottom"
                                                                    DateFormat="yyyy-MM-dd HH:mm:ss"
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
                                                                    Smooth="3"
                                                                    ShowInLegend="false">
                                                                    <HighlightConfig Size="1" Radius="1" />
                                                                    <MarkerConfig Type="None" Size="1" Radius="1" StrokeWidth="0" />
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
                                                                    Smooth="3"
                                                                    ShowInLegend="false">
                                                                    <HighlightConfig Size="1" Radius="1" />
                                                                    <MarkerConfig Type="None" Size="1" Radius="1" StrokeWidth="0" />
                                                                </ext:LineSeries>

                                                                <ext:LineSeries
                                                                    SeriesID="LEFT_INNER_PRESS"
                                                                    Title="左内压"
                                                                    XField="RECORD_TIME"
                                                                    YField="LEFT_INNER_PRESS"
                                                                    Axis="Right"
                                                                    Smooth="3"
                                                                    ShowInLegend="false">
                                                                    <HighlightConfig Size="1" Radius="1" />
                                                                    <MarkerConfig Type="None" Size="1" Radius="1" StrokeWidth="0" />
                                                                </ext:LineSeries>

                                                                <ext:LineSeries
                                                                    SeriesID="RIGHT_INNER_PRESS"
                                                                    Title="右内压"
                                                                    XField="RECORD_TIME"
                                                                    YField="RIGHT_INNER_PRESS"
                                                                    Axis="Right"
                                                                    Smooth="3"
                                                                    ShowInLegend="false">
                                                                    <HighlightConfig Size="1" Radius="1" />
                                                                    <MarkerConfig Type="None" Size="1" Radius="1" StrokeWidth="0" />
                                                                </ext:LineSeries>

                                                                <ext:LineSeries
                                                                    SeriesID="LEFT_MODEL_TEMP"
                                                                    Title="左模套温度/外压"
                                                                    XField="RECORD_TIME"
                                                                    YField="LEFT_MODEL_TEMP"
                                                                    Axis="Left"
                                                                    Smooth="3"
                                                                    ShowInLegend="false">
                                                                    <HighlightConfig Size="1" Radius="1" />
                                                                    <MarkerConfig Type="None" Size="1" Radius="1" StrokeWidth="0" />
                                                                </ext:LineSeries>

                                                                <ext:LineSeries
                                                                    SeriesID="RIGHT_MODEL_TEMP"
                                                                    Title="右模套温度/外压"
                                                                    XField="RECORD_TIME"
                                                                    YField="RIGHT_MODEL_TEMP"
                                                                    Axis="Left"
                                                                    Smooth="3"
                                                                    ShowInLegend="false">
                                                                    <HighlightConfig Size="1" Radius="1" />
                                                                    <MarkerConfig Type="None" Size="1" Radius="1" StrokeWidth="0" />
                                                                </ext:LineSeries>

                                                                <ext:LineSeries
                                                                    SeriesID="LEFT_PLATE_TEMP"
                                                                    Title="左热板温度/外温"
                                                                    XField="RECORD_TIME"
                                                                    YField="LEFT_PLATE_TEMP"
                                                                    Axis="Left"
                                                                    Smooth="3"
                                                                    ShowInLegend="false">
                                                                    <HighlightConfig Size="1" Radius="1" />
                                                                    <MarkerConfig Type="None" Size="1" Radius="1" StrokeWidth="0" />
                                                                </ext:LineSeries>

                                                                <ext:LineSeries
                                                                    SeriesID="RIGHT_PLATE_TEMP"
                                                                    Title="右热板温度/外温"
                                                                    XField="RECORD_TIME"
                                                                    YField="LEFT_PLATE_TEMP"
                                                                    Axis="Left"
                                                                    Smooth="3"
                                                                    ShowInLegend="false">
                                                                    <HighlightConfig Size="1" Radius="1" />
                                                                    <MarkerConfig Type="None" Size="1" Radius="1" StrokeWidth="0" />
                                                                </ext:LineSeries>

                                                            </Series>
                                                            <LegendConfig Position="Bottom"  />
                                                        </ext:Chart>
                                                    </Items>
                                                </ext:Panel>
                                                <ext:Panel runat="server" Region="South" Height="40" Layout="FitLayout" Frame="false" Border="false">
                                                    <Items>
                                                        <ext:FieldSet runat="server" Hidden="true" ID="fsAlarmState" Layout="ColumnLayout">
                                                            <Items>
                                                            </Items>
                                                        </ext:FieldSet>
                                                    </Items>
                                                </ext:Panel>
                                            </Items>
                                        </ext:Panel>
                                    </Items>
                                </ext:Panel>
                                <ext:Panel runat="server" Region="South" Layout="ColumnLayout" Height="140">
                                    <Items>
                                        <ext:Container runat="server" ColumnWidth="1" Layout="ColumnLayout">
                                            <Items>
                                                <ext:TextField runat="server" ID="txtEquipStateCaption" LabelAlign="Right" FieldLabel="工作状态" LabelWidth="80" InputWidth="80">
                                                </ext:TextField>
                                                <ext:TextField runat="server" ID="txtCurrentStep" LabelAlign="Right" FieldLabel="当前步序" LabelWidth="80" InputWidth="80">
                                                </ext:TextField>
                                                <ext:TextField runat="server" ID="txtModelTemp" LabelAlign="Right" FieldLabel="模套温度/外压" LabelWidth="80" InputWidth="120">
                                                </ext:TextField>
                                                <ext:TextField runat="server" ID="txtLeftTyreNo" LabelAlign="Right" FieldLabel="左硫化号" LabelWidth="80" InputWidth="120">
                                                </ext:TextField>
                                                <ext:TextField runat="server" ID="txtRightTyreNo" LabelAlign="Right" FieldLabel="右硫化号" LabelWidth="80" InputWidth="120">
                                                </ext:TextField>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container runat="server" ColumnWidth="1" Layout="ColumnLayout">
                                            <Items>
                                                <ext:TextField runat="server" ID="txtStopTime" LabelAlign="Right" FieldLabel="待机时间" LabelWidth="80" InputWidth="80">
                                                </ext:TextField>
                                                <ext:TextField runat="server" ID="txtStepTime" LabelAlign="Right" FieldLabel="步序剩余时间" LabelWidth="80" InputWidth="80">
                                                </ext:TextField>
                                                <ext:TextField runat="server" ID="txtPlateTemp" LabelAlign="Right" FieldLabel="热板温度/外温" LabelWidth="80" InputWidth="120">
                                                </ext:TextField>
                                                <ext:TextField runat="server" ID="txtLeftGreenTyreNo" LabelAlign="Right" FieldLabel="左成型号" LabelWidth="80" InputWidth="120">
                                                </ext:TextField>
                                                <ext:TextField runat="server" ID="txtRightGreenTyreNo" LabelAlign="Right" FieldLabel="右成型号" LabelWidth="80" InputWidth="120">
                                                </ext:TextField>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container runat="server" ColumnWidth="1" Layout="ColumnLayout">
                                            <Items>
                                                <ext:TextField runat="server" ID="txtBladderCount" LabelAlign="Right" FieldLabel="胶囊计数" LabelWidth="80" InputWidth="80">
                                                </ext:TextField>
                                                <ext:TextField runat="server" ID="txtCuringLeftTime" LabelAlign="Right" FieldLabel="硫化剩余时间" LabelWidth="80" InputWidth="80">
                                                </ext:TextField>
                                                <ext:TextField runat="server" ID="txtInnerTemp" LabelAlign="Right" FieldLabel="内温" LabelWidth="80" InputWidth="120">
                                                </ext:TextField>
                                                <ext:TextField runat="server" ID="txtLeftMouldCode" LabelAlign="Right" FieldLabel="左模具号" LabelWidth="80" InputWidth="120">
                                                </ext:TextField>
                                                <ext:TextField runat="server" ID="txtRightMouldCode" LabelAlign="Right" FieldLabel="右模具号" LabelWidth="80" InputWidth="120">
                                                </ext:TextField>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container runat="server" ColumnWidth="1" Layout="ColumnLayout">
                                            <Items>
                                                <ext:TextField runat="server" ID="txtMouldCount" LabelAlign="Right" FieldLabel="模具计数" LabelWidth="80" InputWidth="80">
                                                </ext:TextField>
                                                <ext:TextField runat="server" ID="txtCuringTime" LabelAlign="Right" FieldLabel="硫化总时间" LabelWidth="80" InputWidth="80">
                                                </ext:TextField>
                                                <ext:TextField runat="server" ID="txtInnerPress" LabelAlign="Right" FieldLabel="内压" LabelWidth="80" InputWidth="120">
                                                </ext:TextField>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container runat="server" ColumnWidth="1" Layout="ColumnLayout">
                                            <Items>
                                                <ext:TextField runat="server" ID="txtLeftMaterialName" LabelAlign="Right" FieldLabel="左模具规格" LabelWidth="80" InputWidth="450">
                                                </ext:TextField>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container runat="server" ColumnWidth="1" Layout="ColumnLayout">
                                            <Items>
                                                <ext:TextField runat="server" ID="txtRightMaterialName" LabelAlign="Right" FieldLabel="右模具规格" LabelWidth="80" InputWidth="450">
                                                </ext:TextField>
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:Panel>
                            </Items>
                            <Listeners>
                                <Close Handler="return PressTempPanel_Close();" />
                            </Listeners>
                        </ext:Panel>
                    </Items>
                </ext:TabPanel>
            </Items>
        </ext:Viewport>
        <ext:TaskManager runat="server" ID="TaskManager1" AutoRunDelay="1000">
            <Tasks>
                <ext:Task Interval="10000" AutoRun="true">
                    <DirectEvents>
                        <Update OnEvent="updateAllEquipState">
                        </Update>
                    </DirectEvents>
                </ext:Task>
                <ext:Task TaskID="EquipState" Interval="10000" AutoRun="false">
                    <DirectEvents>
                        <Update OnEvent="updateEquipState">
                        </Update>
                    </DirectEvents>
                </ext:Task>
                <ext:Task TaskID="PressTemp" Interval="10000" AutoRun="false">
                    <DirectEvents>
                        <Update OnEvent="updatePressTemp">
                        </Update>
                    </DirectEvents>
                </ext:Task>
            </Tasks>
        </ext:TaskManager>
    </form>
</body>
</html>
