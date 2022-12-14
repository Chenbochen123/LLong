<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SemisTechBjp.aspx.cs" Inherits="Tracing_Back_SemisTechBjp" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

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
        var xdata1;
        var xdata2;
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

        var refreshChart = function () {
            debugger;
            App.direct.chartMainBindData2({
                success: function (result) {
                    debugger;
                    if (result[0] == 'T') {
                        result = result.slice(3);
                        refreshData(eval(result));
                    }
                    else if (result[0] == 'H') {
                        result = result.slice(4);
                        refreshData1(eval(result));
                    }
                    else if (result[0] == 'C') {
                        result = result.slice(2);
                        refreshData3(eval(result));
                    }
                    else {
                        refreshData2(eval(result));
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
        //温度
        var refreshData = function (data) {
            debugger;
            xdata0 = [];
            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata8 = [];
            for (var i = 0; i < data.length; i++) {
                ydata8.push(data[i]["JCTEMP"]);
            }

            ydata9 = [];
            for (var i = 0; i < data.length; i++) {
                ydata9.push(data[i]["LGTEMP"]);
            }

            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["SH1TEMP"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["SH2TEMP"]);
            }
            ydata3 = [];
            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["YYJSZTEMP"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["YYJXZTEMP"]);
            }
            ydata5 = [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["YYJCJTEMP"]);
            }
            ydata6 = [];
            for (var i = 0; i < data.length; i++) {
                ydata6.push(data[i]["JQTEMP"]);
            }
            ydata7 = [];
            for (var i = 0; i < data.length; i++) {
                ydata7.push(data[i]["JTTEMP"]);
            }
            ydata10 = [];
            for (var i = 0; i < data.length; i++) {
                ydata10.push(data[i]["MATERIAL_NAME"]);
            }
            App.SemisTechBjp.getBody().update("<iframe src='SemisTechBjpTmp.html' width=100% height=100%  frameborder=0></iframe>");
        }
        //速度
        var refreshData2 = function (data) {
            debugger;
            xdata0 = [];
            
            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["LQG1SPEED"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["LQG2SPEED"]);

            }
            ydata3 = [];

            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["LQG3SPEED"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["LQG4SPEED"]);
            }
            ydata5 = [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["MCJQSPEED"]);
            }
            ydata6 = [];
            for (var i = 0; i < data.length; i++) {
                ydata6.push(data[i]["JCJSPEED"]);
            }
            ydata7 = [];
            for (var i = 0; i < data.length; i++) {
                ydata7.push(data[i]["WLSPEED"]);
            }
            ydata8 = [];
            for (var i = 0; i < data.length; i++) {
                ydata8.push(data[i]["FHJSPEED"]);
            }
            ydata9 = [];
            for (var i = 0; i < data.length; i++) {
                ydata9.push(data[i]["YYJSPEED"]);
            }
            ydata10 = [];
            for (var i = 0; i < data.length; i++) {
                ydata10.push(data[i]["LCGSPEED"]);
            }
            ydata11 = [];
            for (var i = 0; i < data.length; i++) {
                ydata11.push(data[i]["JQSPEED"]);
            }
            ydata12 = [];
            for (var i = 0; i < data.length; i++) {
                ydata12.push(data[i]["MATERIAL_NAME"]);
            }

            App.SemisTechBjp.getBody().update("<iframe src='SemisTechBjpSpeed.html' width=100% height=100%  frameborder=0></iframe>");
        }
        //厚度宽度
        var refreshData1 = function (data) {
            debugger;
            xdata0 = [];
            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["JPTHICKNESS"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["JPTHICKNESSCPK"]);
            }
            ydata3 = [];
            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["JPWIDTH"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["JPWIDTHCPK"]);
            }
            ydata5 = [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["MATERIAL_NAME"]);
            }
            App.SemisTechBjp.getBody().update("<iframe src='SemisTechBjpHDKD.html' width=100% height=100%   frameborder=0></iframe>");
        }

        //侧轴
        var refreshData3 = function (data) {
            debugger;
            xdata0 = [];
            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["QDCAXISCROSS"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["CZCAXISCROSS"]);
            }
            ydata3 = [];
            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["QDCROLLDISTANCE"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["CZCROLLDISTANCE"]);
            }
            ydata5 = [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["MATERIAL_NAME"]);
            }
            App.SemisTechBjp.getBody().update("<iframe src='SemisTechBjpCZ.html' width=100% height=100%  frameborder=0></iframe>");
        }


    </script>
</head>

<body>
    <form id="form1" runat="server">
        <ext:ResourceManager runat="server" ID="ResourceManager1" />
        <ext:Viewport runat="server" ID="Viewport1" Layout="BorderLayout">
            <Items>
                <ext:Panel runat="server" Region="Center" AutoScroll="true" ID="SemisTechBjp">
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