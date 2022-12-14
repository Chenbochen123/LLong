<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SemisTechXc15.aspx.cs" Inherits="Plugins_Semis_Technology_SemisTechXc15" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>15度斜裁曲线查询</title>
    <script src="../../../resources/js/jquery-1.7.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        var btnSearch_Click = function () {
            if (App.ComboBox0.getValue() == '' || App.ComboBox0.getValue() == null) {
                Ext.Msg.alert("错误", "请选择机台");
                return false;
            }

            if ( timSearchBeginTime==null)
            {
                Ext.Msg.alert("错误", "请选择时间");
                return false;
            }
            return true;
        };

    </script>

    <script>
        var xdata0;
        var ydata1;
        var ydata2;
        var ydata3;
        var ydata4;
        var ydata5;
        var ydata6;
        var ydata7;
        var ydata8;
        var ydata9;
        var ydata10;
        var ydata11;
        var ydata12;
        var ydata13;
        var ydata14;
        var ydata15;
        var ydata16;
        var ydata17;
        var ydata18;
        var ydata19;
        var ydata20;

        var refreshChart = function () {
            debugger;

            if (App.ComboBox0.getValue() == '' || App.ComboBox0.getValue() == null) {
                Ext.Msg.alert("错误", "请选择机台");
                return false;
            }

            App.direct.chartMainBindData({
                success: function (result) {
                    if (result != '') {
                        //console.log(eval(result));
                        if (App.ComboBox1.getValue() == 0) {
                            refreshData0(eval(result));
                        }
                        else if (App.ComboBox1.getValue() == 1) {
                            refreshData1(eval(result));
                        }
                        else if (App.ComboBox1.getValue() == 2) {
                            refreshData2(eval(result));
                        }
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
            return false;
        }
        //宽度
        var refreshData0 = function (data) {
            debugger;
            xdata0 = [];
            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }

            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["SIDEAWIDTH"]-0);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["SIDEBWIDTH"]-0);
            }
            ydata3 = [];
            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["MATERIAL_NAME"]);
            }

            App.SemisTech15Xc.getBody().update("<iframe src='SemisTechXc15Width.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        //宽度CPK
        var refreshData1 = function (data) {
            debugger;
            xdata0 = [];
            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["SIDEAWIDTHCPK"]-0);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["SIDEBWIDTHCPK"]-0);
            }
            ydata3 = [];
            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["MATERIAL_NAME"]);
            }

            App.SemisTech15Xc.getBody().update("<iframe src='SemisTechXc15WidthCpk.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        //详细数据
        var refreshData2 = function (data) {
            debugger;
            xdata0 = [];
            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata3 = [];
            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["WIDTH"] - 0);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["SIDEASTANDARDWIDTH"] - 0);
            }
            ydata5 = [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["SIDEBSTANDARDWIDTH"] - 0);
            }
            ydata6 = [];
            for (var i = 0; i < data.length; i++) {
                ydata6.push(data[i]["SIDEEARLYALARMTOL"] - 0);
            }
            ydata7 = [];
            for (var i = 0; i < data.length; i++) {
                ydata7.push(data[i]["SIDEALARMTOL"] - 0);
            }
            ydata8 = [];
            for (var i = 0; i < data.length; i++) {
                ydata8.push(data[i]["CBEARLYALARMTOL"] - 0);
            }
            ydata9 = [];
            for (var i = 0; i < data.length; i++) {
                ydata9.push(data[i]["CBALARMTOL"] - 0);
            }
            ydata10 = [];
            for (var i = 0; i < data.length; i++) {
                ydata10.push(data[i]["GAPEARLYALARMTOL"] - 0);
            }
            ydata11 = [];
            for (var i = 0; i < data.length; i++) {
                ydata11.push(data[i]["GAPALARMTOL"] - 0);
            }
            ydata12 = [];
            for (var i = 0; i < data.length; i++) {
                ydata12.push(data[i]["ANGLESTANDARD"] - 0);
            }
            ydata13 = [];
            for (var i = 0; i < data.length; i++) {
                ydata13.push(data[i]["ANGLEEARLYALARMTOL"] - 0);
            }
            ydata14 = [];
            for (var i = 0; i < data.length; i++) {
                ydata14.push(data[i]["ANGLEALARMTOL"] - 0);
            }
            ydata15 = [];
            for (var i = 0; i < data.length; i++) {
                ydata15.push(data[i]["JOINTSTANDARD"] - 0);
            }
            ydata16 = [];
            for (var i = 0; i < data.length; i++) {
                ydata16.push(data[i]["JOINTEARLYALARMTOL"] - 0);
            }
            ydata17 = [];
            for (var i = 0; i < data.length; i++) {
                ydata17.push(data[i]["JOINTALARMTOL"] - 0);
            }
            ydata18 = [];
            for (var i = 0; i < data.length; i++) {
                ydata18.push(data[i]["ANGLEREAL"] - 0);
            }
            ydata19 = [];
            for (var i = 0; i < data.length; i++) {
                ydata19.push(data[i]["TOGGLE"] - 0);
            }
            ydata20 = [];
            for (var i = 0; i < data.length; i++) {
                ydata20.push(data[i]["MATERIAL_NAME"]);
            }

            App.SemisTech15Xc.getBody().update("<iframe src='SemisTechXc15Other.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        
    </script>
</head>

<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager runat="server" ID="ResourceManager1" />
        <ext:Viewport runat="server" ID="Viewport1" Layout="BorderLayout">
            <Items>
                <ext:Panel runat="server" Region="North" AutoScroll="true">
                    <TopBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:Button runat="server" ID="btnSearch" Icon="Find" Text="查询" >
                                     <Listeners>
                                        <Click Handler="refreshChart(false); return false;" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" Icon="PageExcel" Text="导出" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:Panel runat="server" Width="800" Border="false">
                            <Items>
                                <ext:FieldSet runat="server" Layout="ColumnLayout" ColumnWidth="1" Title="曲线"  >
                                    <Items>
                                        <ext:ComboBox runat="server" ID="ComboBox0" 
                                            Editable="false"
                                            QueryMode="Local"
                                            TriggerAction="All"
                                             EmptyText="15度斜裁" ValueField="OBJID" DisplayField="EQUIP_NAME">
                                            <Store>
                                                <ext:Store runat="server">
                                                    <Model>
                                                        <ext:Model runat="server">
                                                            <Fields>
                                                                <ext:ModelField Name="OBJID" />
                                                                <ext:ModelField Name="EQUIP_NAME" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                          </ext:ComboBox>
                                        <ext:ComboBox runat="server" ID="ComboBox1" Editable="false" EmptyText="选择查询类型">
                                            <Items>
                                                <ext:ListItem Text="宽度" Value="0" />
                                                <ext:ListItem Text="宽度CPK" Value="1" />
                                                <ext:ListItem Text="详细数据" Value="2" />
                                            </Items>
                                            <SelectedItems>
                                                <ext:ListItem Value="0" />
                                            </SelectedItems>
                                        </ext:ComboBox>

                                        <ext:Hidden runat="server" ID="hdnSearchPressTempLine" />
                                         <ext:DateField runat="server" ID="datSearchBeginDate" LabelAlign="Right" FieldLabel="时间" Format="yyyy-MM-dd" Editable="false"
                                            LabelWidth="80" InputWidth="90" />
                                        <ext:TimeField runat="server" ID="timSearchBeginTime" HideLabel="true" Format="HH:mm:ss"
                                            InputWidth="90" OnDirectChange="timSearchTime_DirectChange" />
                                        <ext:Label runat="server" Text="~" />
                                        <ext:TimeField runat="server" ID="timSearchEndTime" HideLabel="true" Format="HH:mm:ss" 
                                            InputWidth="90" OnDirectChange="timSearchTime_DirectChange" />
                                       
                                    </Items>
                                </ext:FieldSet>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:Panel runat="server" Region="Center" AutoScroll="true" ID="SemisTech15Xc">
                </ext:Panel>
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

