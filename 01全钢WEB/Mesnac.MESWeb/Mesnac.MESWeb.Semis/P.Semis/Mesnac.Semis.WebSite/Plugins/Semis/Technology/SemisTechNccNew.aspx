<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SemisTechNccNew.aspx.cs" Inherits="Plugins_Semis_Technology_SemisTechNccNew" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../../../resources/js/jquery-1.7.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        var btnSearch_Click = function () {
            if (timSearchBeginTime == null) {
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
        var ydata21;
        var ydata22;
        var ydata23;
        var ydata24;
        var legendData;
        var serialData;
        var ydata0;


        var refreshChart = function () {
            debugger;
            App.direct.chartMainBindData2({
                success: function (result) {
                    
                        switch (result[0]) {
                            case "1":
                                result = result.slice(1);
                                refreshData1(eval(result));
                                break;
                            case "2":
                                result = result.slice(1);
                                refreshData2(eval(result));
                                break;
                            case "3":
                                result = result.slice(1);
                                refreshData3(eval(result));
                                break;
                            case "4":
                                result = result.slice(1);
                                refreshData4(eval(result));
                                break;
                            case "5":
                                result = result.slice(1);
                                refreshData5(eval(result));
                                break;
                            case "6":
                                result = result.slice(1);
                                refreshData6(eval(result));
                                break;
                            case "7":
                                result = result.slice(1);
                                refreshData7(eval(result));
                                break;
                            case "8":
                                result = result.slice(1);
                                refreshData8(eval(result));
                                break;
                            case "9":
                                result = result.slice(1);
                                refreshData9(eval(result));
                                break;
                            default:
                                break;
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
        //挤出温度
        var refreshData1 = function (data) {
            debugger;
            xdata0 = [];
            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["JCJ1JTTEMP"]);
            }

            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["JCJ1SH1TEMP"]);
            }

            ydata3 = [];
            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["JCJ1SH2TEMP"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["JCJ1JCTEMP"]);
            }
            ydata5= [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["JCJ1LGTEMP"]);
            }
            ydata6 = [];
            for (var i = 0; i < data.length; i++) {
                ydata6.push(data[i]["JCJ2JTTEMP"]);
            }
            ydata7 = [];
            for (var i = 0; i < data.length; i++) {
                ydata7.push(data[i]["JCJ2SH1TEMP"]);
            }
            ydata8 = [];
            for (var i = 0; i < data.length; i++) {
                ydata8.push(data[i]["JCJ2SH2TEMP"]);
            }
            ydata9 = [];
            for (var i = 0; i < data.length; i++) {
                ydata9.push(data[i]["JCJ2JCTEMP"]);
            }
            ydata10 = [];
            for (var i = 0; i < data.length; i++) {
                ydata10.push(data[i]["JCJ2LGTEMP"]);
            }
            ydata11 = [];
            for (var i = 0; i < data.length; i++) {
                ydata11.push(data[i]["MATERIAL_NAME"]);
            }
            App.SemisTechNcc.getBody().update("<iframe src='SemisTechNccJCTmp.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        //内衬层压延温度
        var refreshData2 = function (data) {
            debugger;
            xdata0 = [];

            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["YYJ1SZTEMP"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["YYJ1XZTEMP"]);

            }
            ydata3 = [];

            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["YYJ2SZTEMP"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["YYJ2XZTEMP"]);
            }
            ydata5 = [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["YYJ1CJTEMP"]);
            }
            ydata6 = [];
            for (var i = 0; i < data.length; i++) {
                ydata6.push(data[i]["YYJ2CJTEMP"]);
            }
            ydata7 = [];
            for (var i = 0; i < data.length; i++) {
                ydata7.push(data[i]["MATERIAL_NAME"]);
            }

            App.SemisTechNcc.getBody().update("<iframe src='SemisTechNccYYTmp.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        //内衬层冷却温度
        var refreshData3 = function (data) {
            debugger;
            xdata0 = [];

            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["LQJTEMP"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["LQSTEMP"]);

            }
            ydata3 = [];
            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["MATERIAL_NAME"]);

            }
            App.SemisTechNcc.getBody().update("<iframe src='SemisTechNccLQTmp.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }

        //内衬层厚度
        var refreshData4 = function (data) {
            debugger;
            xdata0 = [];
            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["JLTHICKNESS1"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["JLTHICKNESS2"]);
            }
            ydata3 = [];
            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["NCCTOTALTHICKNESS"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["NCCTOTALTHICKNESSCPK"]);
            }
            ydata5 = [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["MATERIAL_NAME"]);
            }
      
            App.SemisTechNcc.getBody().update("<iframe src='SemisTechNccHD.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        //内衬层宽度
        var refreshData5 = function (data) {
            debugger;
            xdata0 = [];

            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["JLACTUALWIDTH1"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["JLACTUALWIDTH2"]);

            }
            ydata3 = [];

            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["JPWIDTHCPK"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["NCCTOTALWIDTH"]);
            }
            ydata5 = [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["NCCTOTALWIDTHCPK"]);
            }
            ydata6 = [];
            for (var i = 0; i < data.length; i++) {
                ydata6.push(data[i]["MATERIAL_NAME"]);
            }
            App.SemisTechNcc.getBody().update("<iframe src='SemisTechNccKD.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        //内衬层侧轴
        var refreshData6 = function (data) {
            debugger;
            xdata0 = [];

            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["YYJ1CZCROLLDISTANCE"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["YYJ1QDCROLLDISTANCE"]);

            }
            ydata3 = [];

            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["YYJ2CZCROLLDISTANCE"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["YYJ2QDCROLLDISTANCE"]);
            }
            ydata5 = [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["YYJ1CZCAXISCROSS"]);
            }
            ydata6 = [];
            for (var i = 0; i < data.length; i++) {
                ydata6.push(data[i]["YYJ1QDCAXISCROSS"]);
            }
            ydata7 = [];
            for (var i = 0; i < data.length; i++) {
                ydata7.push(data[i]["YYJ2CZCAXISCROSS"]);
            }
            ydata8 = [];
            for (var i = 0; i < data.length; i++) {
                ydata8.push(data[i]["YYJ2QDCAXISCROSS"]);
            }
            ydata9 = [];
            for (var i = 0; i < data.length; i++) {
                ydata9.push(data[i]["MATERIAL_NAME"]);
            }
            App.SemisTechNcc.getBody().update("<iframe src='SemisTechNccCZ.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        //内衬层速度
        var refreshData7 = function (data) {
            debugger;
            xdata0 = [];

            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["WL1SPEED"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["JCJ1SPEED"]);

            }
            ydata3 = [];

            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["FHJ1SPEED"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["YYJ1SPEED"]);
            }
            ydata5 = [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["LCG1SPEED"]);
            }
            ydata6 = [];
            for (var i = 0; i < data.length; i++) {
                ydata6.push(data[i]["JQ1SPEED"]);
            }
            ydata7 = [];
            for (var i = 0; i < data.length; i++) {
                ydata7.push(data[i]["DZSPEED"]);
            }
            ydata8 = [];
            for (var i = 0; i < data.length; i++) {
                ydata8.push(data[i]["THSPEED"]);
            }
            ydata9 = [];
            for (var i = 0; i < data.length; i++) {
                ydata9.push(data[i]["WL2SPEED"]);
            }
            ydata10 = [];
            for (var i = 0; i < data.length; i++) {
                ydata10.push(data[i]["JCJ2SPEED"]);
            }
            ydata11 = [];
            for (var i = 0; i < data.length; i++) {
                ydata11.push(data[i]["FHJ2SPEED"]);
            }
            ydata12 = [];
            for (var i = 0; i < data.length; i++) {
                ydata12.push(data[i]["YYJ2SPEED"]);
            }
            ydata13 = [];
            for (var i = 0; i < data.length; i++) {
                ydata13.push(data[i]["LCG2SPEED"]);
            }
            ydata14 = [];
            for (var i = 0; i < data.length; i++) {
                ydata14.push(data[i]["JQ2SPEED"]);
            }
            ydata15 = [];
            for (var i = 0; i < data.length; i++) {
                ydata15.push(data[i]["LQG1SPEED"]);
            }
            ydata16 = [];
            for (var i = 0; i < data.length; i++) {
                ydata16.push(data[i]["LQG2SPEED"]);
            }
            ydata17 = [];
            for (var i = 0; i < data.length; i++) {
                ydata17.push(data[i]["LQG3SPEED"]);
            }
            ydata18 = [];
            for (var i = 0; i < data.length; i++) {
                ydata18.push(data[i]["LQG4SPEED"]);
            }
            ydata19 = [];
            for (var i = 0; i < data.length; i++) {
                ydata19.push(data[i]["XPSPEED"]);
            }
            ydata20= [];
            for (var i = 0; i < data.length; i++) {
                ydata20.push(data[i]["MCJQSPEED"]);
            }
            ydata21 = [];
            for (var i = 0; i < data.length; i++) {
                ydata21.push(data[i]["JUANQ1SPEED"]);
            }
            ydata22 = [];
            for (var i = 0; i < data.length; i++) {
                ydata22.push(data[i]["JUANQ2SPEED"]);
            }
            ydata23 = [];
            for (var i = 0; i < data.length; i++) {
                ydata23.push(data[i]["CDSPEED"]);
            }
            ydata24 = [];
            for (var i = 0; i < data.length; i++) {
                ydata24.push(data[i]["MATERIAL_NAME"]);
            }
            App.SemisTechNcc.getBody().update("<iframe src='SemisTechNccSpeed.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        //内衬层压力
        var refreshData8 = function (data) {
            debugger;
            xdata0 = [];

            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["LQSJSPRE"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["LQSCSPRE"]);

            }
            ydata3 = [];

            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["LQSPREDIF"]);
            }
            ydata4 = [];

            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["MATERIAL_NAME"]);
            }
            App.SemisTechNcc.getBody().update("<iframe src='SemisTechNccPress.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        //自选
        var refreshData9 = function (data) {
            xdata0 = [];
            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata0 = [];
            for (var i = 0; i < data.length; i++) {
                ydata0.push(data[i]["MATERIAL_NAME"]);
            }

            legendData = App.selectType2.getValue().split(',');
            debugger;
            let selectLines = App.selectType.getValue().split(',');
            serialData = [];

            for (var j = 0; j < selectLines.length; j++) {
                let ydata = [];
                for (var i = 0; i < data.length; i++) {
                    ydata.push(data[i][selectLines[j]] - 0);
                }
                let serial = {
                    name: legendData[j],
                    type: 'line',
                    yAxisIndex: 0,
                    data: ydata
                };
                serialData.push(serial);
            }

            App.SemisTechNcc.getBody().update("<iframe src='SemisTechNccMuch.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
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
                                <ext:Button runat="server" ID="btnSearch" Icon="Find" Text="查询">
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
                        <ext:Panel runat="server" Width="1100" Border="false">
                            <Items>
                                <ext:FieldSet runat="server" Layout="ColumnLayout" ColumnWidth="1" Title="曲线">
                                    <Items>
                                        <ext:ComboBox runat="server" ID="ComboBox1"
                                            Editable="false"
                                            QueryMode="Local"
                                            TriggerAction="All"
                                            EmptyText="选择查询类型">
                                            <Listeners>
                                                <Select Handler="#{ComboBox2}.clearValue(); #{CitiesStore}.reload();" />
                                            </Listeners>
                                            <Items>
                                                <ext:ListItem Text="挤出温度" Value="NccJCTemp" />
                                                <ext:ListItem Text="压延温度" Value="NccYYTemp" />
                                                <ext:ListItem Text="冷却温度" Value="NccLQTEMP" />
                                                <ext:ListItem Text="厚度" Value="NccHD" />
                                                <ext:ListItem Text="宽度" Value="NccKD" />
                                                <ext:ListItem Text="侧轴" Value="NccCZ" />
                                                <ext:ListItem Text="速度" Value="NccSpeed" />
                                                <ext:ListItem Text="压力" Value="NccPress" />
                                            </Items>
                                        </ext:ComboBox>

                                        <ext:ComboBox
                                            ID="ComboBox2"
                                            MultiSelect="true"
                                            Editable="false"
                                            runat="server"
                                            TypeAhead="true"
                                            QueryMode="Local"
                                            ForceSelection="true"
                                            TriggerAction="All"
                                            DisplayField="name"
                                            ValueField="id"
                                            EmptyText="Loading..."
                                            ValueNotFoundText="Loading...">
                                            <Store>
                                                <ext:Store
                                                    runat="server"
                                                    ID="CitiesStore"
                                                    AutoLoad="false"
                                                    OnReadData="CitiesStore_ReadData">
                                                    <Model>
                                                        <ext:Model runat="server" IDProperty="Id">
                                                            <Fields>
                                                                <ext:ModelField Name="id" Type="String" ServerMapping="Id" />
                                                                <ext:ModelField Name="name" Type="String" ServerMapping="Name" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                    <Listeners>

                                                        <Load Handler="#{ComboBox2}.setValue(#{ComboBox2}.store.getAt(0).get('id'));" />

                                                    </Listeners>
                                                </ext:Store>
                                            </Store>

                                        </ext:ComboBox>
                                        <ext:Button runat="server" ID="Button1" Icon="Find" Text="合并">
                                             <DirectEvents>
                                                <Click OnEvent="Bingru"/>
                                            </DirectEvents>
                                           <%-- <Listeners>
                                                <Click Handler="Bingru2(false); return false;" />
                                            </Listeners>--%>
                                        </ext:Button>
                                        <ext:Button runat="server" ID="Button2" Icon="Find" Text="清除">
                                             <DirectEvents>
                                                <Click OnEvent="CleanText"/>
                                            </DirectEvents>
                                        </ext:Button>

                                        <ext:Hidden runat="server" ID="hdnSearchPressTempLine" />
                                        <ext:DateField runat="server" ID="datSearchBeginDate" LabelAlign="Right" FieldLabel="时间" Format="yyyy-MM-dd" Editable="false"
                                            LabelWidth="80" InputWidth="90" />
                                        <ext:TimeField runat="server" ID="timSearchBeginTime" HideLabel="true" Format="HH:mm:ss"
                                            InputWidth="90" OnDirectChange="timSearchTime_DirectChange" />
                                        <ext:Label runat="server" Text="~" />
                                        <ext:TimeField runat="server" ID="timSearchEndTime" HideLabel="true" Format="HH:mm:ss" 
                                            InputWidth="90" OnDirectChange="timSearchTime_DirectChange" />
                                        <ext:TextField runat="server" ID="txtMater" LabelAlign="Right" FieldLabel="物料规格" Editable="true"
                                            LabelWidth="100" EmptyText="模糊查询"/>

                                        <ext:TextField ID="selectType" runat="server" Text=""  Hidden="true"/>
                                        <ext:TextField ID="selectType2" runat="server" Text=""  Hidden="true"/>
                                        <ext:TextField ID="selectTypeName" runat="server" Text="" ReadOnly="true" Width="300"/>
                                    </Items>
                                </ext:FieldSet>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:Panel runat="server" Region="Center" AutoScroll="true" ID="SemisTechNcc">
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
