<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SemisTechNcc.aspx.cs" Inherits="Tracing_Back_SemisTechNcc" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
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


        var refreshChart = function () {
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
            App.SemisTechNcc.getBody().update("<iframe src='SemisTechNccJCTmp.html' width=100% height=100%  frameborder=0></iframe>");
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

            App.SemisTechNcc.getBody().update("<iframe src='SemisTechNccYYTmp.html' width=100% height=100% frameborder=0></iframe>");
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
            App.SemisTechNcc.getBody().update("<iframe src='SemisTechNccLQTmp.html' width=100% height=100% frameborder=0></iframe>");
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
      
            App.SemisTechNcc.getBody().update("<iframe src='SemisTechNccHD.html' width=100% height=100%  frameborder=0></iframe>");
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
            App.SemisTechNcc.getBody().update("<iframe src='SemisTechNccKD.html' width=100% height=100% frameborder=0></iframe>");
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
            App.SemisTechNcc.getBody().update("<iframe src='SemisTechNccCZ.html' width=100% height=100% frameborder=0></iframe>");
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
            App.SemisTechNcc.getBody().update("<iframe src='SemisTechNccSpeed.html' width=100% height=100% frameborder=0></iframe>");
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
            App.SemisTechNcc.getBody().update("<iframe src='SemisTechNccPress.html' width=100% height=100%  frameborder=0></iframe>");
        }
    </script>
</head>

<body>
    <form id="form1" runat="server">
        <ext:ResourceManager runat="server" ID="ResourceManager1" />
        <ext:Viewport runat="server" ID="Viewport1" Layout="BorderLayout">
            <Items>            
                <ext:Panel runat="server" Region="Center" AutoScroll="true" ID="SemisTechNcc">
                </ext:Panel>
                <ext:Hidden runat="server" ID="HiddenEquipId"></ext:Hidden>
                <ext:Hidden runat="server" ID="HiddenTypeid"></ext:Hidden>
                <ext:Hidden runat="server" ID="HiddenBeginTime"></ext:Hidden>
                <ext:Hidden runat="server" ID="HiddenEndTime"></ext:Hidden>
            </Items>
        </ext:Viewport>

    </form>
</body>
</html>
