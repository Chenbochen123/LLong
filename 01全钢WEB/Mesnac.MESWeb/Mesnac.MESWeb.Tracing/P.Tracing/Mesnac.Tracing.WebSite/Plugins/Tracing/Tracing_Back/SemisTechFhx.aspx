<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SemisTechFhx.aspx.cs" Inherits="Tracing_Back_SemisTechFhx" %>

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
        var ydata13;
        var ydata14;
        var ydata15;
        var ydata16;
        var ydata17;

        var refreshChart = function () {
            debugger;
            App.direct.chartMainBindData({
                success: function (result) {
                    debugger;
                    if (result[0] == 'T') {
                        result = result.slice(3);
                        refreshData(eval(result));
                    }
                    else if (result[0] == 'P') {
                        result = result.slice(5);
                        refreshData2(eval(result));
                    }
                    else if (result[0] == 'W') {
                        result = result.slice(6);
                        refreshData3(eval(result));
                    }
                    else if (result[0] == 'J') {
                        result = result.slice(6);
                        refreshData4(eval(result));
                    }
                    else if (result[0] == 'X') {
                        result = result.slice(6);
                        refreshData5(eval(result));
                    }
                    else if (result[0] == 'L') {
                        result = result.slice(6);
                        refreshData6(eval(result));
                    }
                    else if (result[0] == 'K') {
                        result = result.slice(7);
                        refreshData7(eval(result));
                    }
                    else if (result[0] == 'S') {
                        result = result.slice(6);
                        refreshData8(eval(result));
                    }
                    else if (result[0] == 'D') {
                        result = result.slice(6);
                        refreshData9(eval(result));
                    }
                    else if (result[0] == 'Z') {
                        result = result.slice(6);
                        refreshData10(eval(result));
                    }
                    else if (result[0] == 'A') {
                        result = result.slice(7);
                        refreshData11(eval(result));
                    }
                    else if (result[0] == 'B') {
                        result = result.slice(8);
                        refreshData12(eval(result));
                    }
                    else {
                        refreshData1(eval(result));
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

            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["HWSJTEMP"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["HBHWSJTEMP"]);
            }
            ydata3 = [];
            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["SJTEMP"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["ZJTEMP"]);
            }
            ydata5 = [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["XJTEMP"]);
            }
            ydata6 = [];
            for (var i = 0; i < data.length; i++) {
                //alert(data[i]["XJTEMP"]);
                ydata6.push(data[i]["MATERIAL_NAME"]);
            }
            //ydata7 = [];
            //for (var i = 0; i < data.length; i++) {
            //    ydata7.push(":" + data[i]["CARD_NO"]);
            //}
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxTmp.html' width=100% height=100% frameborder=0></iframe>");
        }
        //压力
        var refreshData2 = function (data) {
            debugger;
            xdata0 = [];

            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["SJPRE"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["ZJPRE"]);

            }
            ydata3 = [];

            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["XJPRE"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["QKPRE"]);
            }
            ydata5 = [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["MATERIAL_NAME"]);
            }
            //ydata6 = [];
            //for (var i = 0; i < data.length; i++) {
            //    ydata6.push(data[i]["CARD_NO"]);
            //}
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxPress.html' width=100% height=100% frameborder=0></iframe>");
        }
        //米重
        var refreshData1 = function (data) {
            debugger;
            xdata0 = [];

            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["QLXCVALUE"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["HLXCVALUE"]);

            }
            ydata3 = [];

            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["DTZVALUE"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["DTZCPK"]);
            }
            ydata5 = [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["HMZCPK"]);
            }

            ydata6 = [];
            for (var i = 0; i < data.length; i++) {
                ydata6.push(data[i]["MATERIAL_NAME"]);
            }
            //ydata7 = [];
            //for (var i = 0; i < data.length; i++) {
            //    ydata7.push(data[i]["CARD_NO"]);
            //}
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxMiZhong.html' width=100% height=100% frameborder=0></iframe>");
        }
        //温控温度
        var refreshData3 = function (data) {
            debugger;
            xdata0 = [];

            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["SJJTTEMP"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["ZJJTTEMP"]);

            }
            ydata3 = [];

            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["JTJTTEMP"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["MATERIAL_NAME"]);
            }
            ydata5 = [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["CARD_NO"]);
            }
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxWKTEMP.html' width=100% height=100% frameborder=0></iframe>");
        }

        //机筒温控
        var refreshData4 = function (data) {
            debugger;
            xdata0 = [];

            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["JTTEMP150"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["JTTEMP200"]);

            }
            ydata3 = [];

            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["JTTEMP250"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["MATERIAL_NAME"]);
            }
            //ydata5 = [];
            //for (var i = 0; i < data.length; i++) {
            //    ydata5.push(data[i]["CARD_NO"]);
            //}
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxJTTEMP.html' width=100% height=100% frameborder=0></iframe>");
        }

        //销钉温控
        var refreshData5 = function (data) {
            debugger;
            xdata0 = [];

            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["XDDTEMP150"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["XD1DTEMP200"]);

            }
            ydata3 = [];

            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["XD2DTEMP200"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["XD1DTEMP250"]);
            }
            ydata5 = [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["XD2DTEMP250"]);
            }
            ydata6 = [];
            for (var i = 0; i < data.length; i++) {
                ydata6.push(data[i]["MATERIAL_NAME"]);
            }
            //ydata7 = [];
            //for (var i = 0; i < data.length; i++) {
            //    ydata7.push(data[i]["CARD_NO"]);
            //}
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxXDTEMP.html' width=100% height=100% frameborder=0></iframe>");
        }

        //螺杆温控
        var refreshData6 = function (data) {
            debugger;
            xdata0 = [];

            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["LGTEMP150"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["LGTEMP200"]);

            }
            ydata3 = [];

            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["LGTEMP250"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["MATERIAL_NAME"]);
            }
            //ydata5 = [];
            //for (var i = 0; i < data.length; i++) {
            //    ydata5.push(data[i]["CARD_NO"]);
            //}
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxLGTEMP.html' width=100% height=100% frameborder=0></iframe>");
        }
        //口型盒
        var refreshData7 = function (data) {
            debugger;
            xdata0 = [];

            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["BKXHTEMP"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["NKXHTEMP"]);

            }
            ydata3 = [];

            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["LQSTEMP"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["PHVALUE"]);
            }
            ydata5 = [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["MATERIAL_NAME"]);
            }
            //ydata6 = [];
            //for (var i = 0; i < data.length; i++) {
            //    ydata6.push(data[i]["CARD_NO"]);
            //}
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxKXHTEMP.html' width=100% height=100% frameborder=0></iframe>");
        }
        //速度
        var refreshData8 = function (data) {
            debugger;
            xdata0 = [];

            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["JQSPEED"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["SS1SPEED"]);

            }
            ydata3 = [];

            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["SS2SPEED"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["SS3SPEED"]);
            }
            ydata5 = [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["SS4SPEED"]);
            }
            ydata6 = [];
            for (var i = 0; i < data.length; i++) {
                ydata6.push(data[i]["QLXCSPEED"]);
            }
            ydata7 = [];
            for (var i = 0; i < data.length; i++) {
                ydata7.push(data[i]["DZSPEED"]);
            }
            ydata8 = [];
            for (var i = 0; i < data.length; i++) {
                ydata8.push(data[i]["THCSPEED"]);
            }
            ydata9 = [];
            for (var i = 0; i < data.length; i++) {
                ydata9.push(data[i]["SPSPEED"]);
            }
            ydata10 = [];
            for (var i = 0; i < data.length; i++) {
                ydata10.push(data[i]["XPSPEED"]);
            }
            ydata11 = [];
            for (var i = 0; i < data.length; i++) {
                ydata11.push(data[i]["LQ1SPEED"]);
            }
            ydata12 = [];
            for (var i = 0; i < data.length; i++) {
                ydata12.push(data[i]["LQ2SPEED"]);
            }
            ydata13 = [];
            for (var i = 0; i < data.length; i++) {
                ydata13.push(data[i]["LQ3SPEED"]);
            }
            ydata14 = [];
            for (var i = 0; i < data.length; i++) {
                ydata14.push(data[i]["LQ4SPEED"]);
            }
            ydata15 = [];
            for (var i = 0; i < data.length; i++) {
                ydata15.push(data[i]["GZSPEED"]);
            }
            ydata16 = [];
            for (var i = 0; i < data.length; i++) {
                ydata16.push(data[i]["MATERIAL_NAME"]);
            }
            //ydata17 = [];
            //for (var i = 0; i < data.length; i++) {
            //    ydata17.push(data[i]["CARD_NO"]);
            //}
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxSDTEMP.html' width=100% height=100%  frameborder=0></iframe>");
        }

        //电流
        var refreshData9 = function (data) {
            debugger;
            xdata0 = [];

            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["SJCURRENT"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["ZJCURRENT"]);

            }
            ydata3 = [];

            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["XJCURRENT"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["MATERIAL_NAME"]);
            }
            //ydata5 = [];
            //for (var i = 0; i < data.length; i++) {
            //    ydata5.push(data[i]["CARD_NO"]);
            //}
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxDLTEMP.html' width=100% height=100%   frameborder=0></iframe>");
        }
        //转速
        var refreshData10 = function (data) {
            debugger;
            xdata0 = [];

            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["SJSPEED"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["ZJSPEED"]);

            }
            ydata3 = [];

            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["XJSPEED"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["MATERIAL_NAME"]);
            }
            //ydata5 = [];
            //for (var i = 0; i < data.length; i++) {
            //    ydata5.push(data[i]["CARD_NO"]);
            //}
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxZSTEMP.html' width=100% height=100%  frameborder=0></iframe>");
        }

        //转速
        var refreshData11 = function (data) {
            debugger;
            xdata0 = [];

            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["QCK1VALUE"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["QCK2VALUE"]);

            }
            ydata3 = [];

            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["HCK1VALUE"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["HCK2VALUE"]);
            }
            ydata5 = [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["MATERIAL_NAME"]);
            }
            //ydata5 = [];
            //for (var i = 0; i < data.length; i++) {
            //    ydata5.push(data[i]["CARD_NO"]);
            //}
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxKDTEMP.html' width=100% height=100%  frameborder=0></iframe>");
        }
        //SSB
        var refreshData12 = function (data) {
            debugger;
            xdata0 = [];

            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["SSB"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["MATERIAL_NAME"]);

            }
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxSSBTEMP.html' width=100% height=100% frameborder=0></iframe>");
        }

    </script>
</head>

<body>
    <form id="form1" runat="server">        
        <ext:ResourceManager runat="server" ID="ResourceManager1" />
        <ext:Viewport runat="server" ID="Viewport1" Layout="BorderLayout" >
            <Items>
                <ext:Panel runat="server" Region="Center" ID="SemisTechFhx" >
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

