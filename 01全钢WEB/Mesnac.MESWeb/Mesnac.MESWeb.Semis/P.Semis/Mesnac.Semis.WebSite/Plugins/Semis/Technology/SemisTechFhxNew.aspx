<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SemisTechFhxNew.aspx.cs" Inherits="Plugins_Semis_Technology_SemisTechFhxNew" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

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
        var legendData;
        var serialData;
        var ydata0;

        var refreshChart = function () {
            App.direct.chartMainBindData({
                success: function (result) {
                    if (result[0] == 'M') {
                        result = result.slice(4);
                        refreshData15(eval(result));
                    }
                    else if (result[0] == 'T') {
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
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxTmp.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        //压力
        var refreshData2 = function (data) {
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
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxPress.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        //米重
        var refreshData1 = function (data) {
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
            ydata7 = [];
            for (var i = 0; i < data.length; i++) {
                ydata7.push(data[i]["DTC50VALUE"]);
            }
            ydata8 = [];
            for (var i = 0; i < data.length; i++) {
                ydata8.push(data[i]["HLXCQDVALUE"]);
            }
            ydata9 = [];
            for (var i = 0; i < data.length; i++) {
                ydata9.push(data[i]["HLXCCZVALUE"]);
            }
            ydata10 = [];
            for (var i = 0; i < data.length; i++) {
                ydata10.push(data[i]["QLXCQDVALUE"]);
            }
            ydata11 = [];
            for (var i = 0; i < data.length; i++) {
                ydata11.push(data[i]["QLXCCZVALUE"]);
            }

            ydata6 = [];
            for (var i = 0; i < data.length; i++) {
                ydata6.push(data[i]["MATERIAL_NAME"]);
            }
            //ydata7 = [];
            //for (var i = 0; i < data.length; i++) {
            //    ydata7.push(data[i]["CARD_NO"]);
            //}
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxMiZhong.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        //温控温度
        var refreshData3 = function (data) {
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
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxWKTEMP.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }

        //机筒温控
        var refreshData4 = function (data) {
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
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxJTTEMP.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }

        //销钉温控
        var refreshData5 = function (data) {
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
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxXDTEMP.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }

        //螺杆温控
        var refreshData6 = function (data) {
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
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxLGTEMP.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        //口型盒
        var refreshData7 = function (data) {
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
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxKXHTEMP.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        //速度
        var refreshData8 = function (data) {
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
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxSDTEMP.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }

        //电流
        var refreshData9 = function (data) {
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
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxDLTEMP.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        //转速
        var refreshData10 = function (data) {
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
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxZSTEMP.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }

        //转速
        var refreshData11 = function (data) {
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
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxKDTEMP.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        //SSB
        var refreshData12 = function (data) {
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
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxSSBTEMP.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }

        //综合
        var refreshData15 = function (data) {
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


            App.SemisTechFhx.getBody().update("<iframe src='SemisTechFhxMuch.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
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
                        <ext:Panel runat="server" Width="1200" Border="false">
                            <Items>
                                <ext:FieldSet runat="server" Layout="ColumnLayout" ColumnWidth="1" Title="曲线"  >
                                    <Items>
                                        <ext:ComboBox runat="server" ID="ComboBox0" 
                                            Editable="false"
                                            QueryMode="Local"
                                            TriggerAction="All"
                                             EmptyText="复合线" >
                                            <Items>
                                                <ext:ListItem Text="复合一线" Value="FH1"  />
                                                <ext:ListItem Text="复合二线" Value="FH2" />
                                                <ext:ListItem Text="复合三线" Value="FH3" />
                                                <ext:ListItem Text="复合四线" Value="FH4" />
                                            </Items>
                                          </ext:ComboBox>
                                        <ext:ComboBox runat="server" ID="ComboBox1" 
                                            Editable="false"
                                            QueryMode="Local"
                                            TriggerAction="All"
                                             EmptyText="选择查询类型" >
                                            <Listeners>
                                                <Select Handler="#{ComboBox2}.clearValue(); #{CitiesStore}.reload();" />
                                            </Listeners>
                                            <Items>
                                                <ext:ListItem Text="温度" Value="Temp"  />
                                                <ext:ListItem Text="温控温度" Value="WKTemp"  />
                                                <ext:ListItem Text="机筒温控" Value="JTTemp"  />
                                                <ext:ListItem Text="销钉温控" Value="XDTemp"  />
                                                <ext:ListItem Text="螺杆温控" Value="LGTemp"  />
                                                <ext:ListItem Text="压力" Value="Press" />
                                                <ext:ListItem Text="速度" Value="BG" />
                                                <ext:ListItem Text="电流" Value="CA" />
                                                <ext:ListItem Text="转速" Value="CL" />
                                                <ext:ListItem Text="米重" Value="MZ" />
                                                <ext:ListItem Text="口型盒" Value="KXH" />
                                                <ext:ListItem Text="宽度" Value="KD" />
                                                <ext:ListItem Text="测厚" Value="CH" />
                                                <ext:ListItem Text="收缩比" Value="SSB" />
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
                                                    OnReadData="CitiesStore_ReadData" >
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
                <ext:Panel runat="server" Region="Center" AutoScroll="true" ID="SemisTechFhx">
                </ext:Panel>
                 <ext:Panel ID="Panel2" runat="server" Region="Center" AutoScroll="true" Title="测厚" Hidden="true">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="15">
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="RECORD_TIME" />
                                                <ext:ModelField Name="PLAN_ID" />
                                                <ext:ModelField Name="PLAN_DETAIL_ID" />
                                                <ext:ModelField Name="SD_WIDTH_TOL" />
                                                <ext:ModelField Name="SD_AREA_SYM_TOL" />
                                                <ext:ModelField Name="SD_AREA_TOL" />
                                                <ext:ModelField Name="SD_SHOULDER_WIDTH" />
                                                <ext:ModelField Name="SD_SHOULDER_WIDTH_TOL" />
                                                <ext:ModelField Name="KEY_POINTS" />
                                                <ext:ModelField Name="MEASURE_POINTS" />
                                                <ext:ModelField Name="TOTAL_AREA" />
                                                <ext:ModelField Name="LEFT_AREA" />
                                                <ext:ModelField Name="RIGHT_AREA" />
                                                <ext:ModelField Name="TOTAL_WIDTH" />
                                                <ext:ModelField Name="SHOULDER_WIDTH" />
                                                <ext:ModelField Name="LEFT_SHOULDER_THICK" />
                                                <ext:ModelField Name="RIGHT_SHOULDER_THICK" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                                    <ext:Column ID="OBJID" runat="server" Text="编号" DataIndex="OBJID" Flex="1" Hidden="true" />
                                    <ext:Column ID="txtEquipName" runat="server" Text="机台名称" DataIndex="EQUIP_NAME" Width="100" />
                                    <ext:Column ID="Column1" runat="server" Text="测量时间" DataIndex="RECORD_TIME" Width="100" />
                                    <ext:Column ID="Column2" runat="server" Text="计划号" DataIndex="PLAN_ID" Width="100" />
                                    <ext:Column ID="Column3" runat="server" Text="计划明细号" DataIndex="PLAN_DETAIL_ID" Width="100" />
                                    <ext:Column ID="Column4" runat="server" Text="总宽度公差" DataIndex="SD_WIDTH_TOL" Width="100" />
                                    <ext:Column ID="Column5" runat="server" Text="面积对称公差" DataIndex="SD_AREA_SYM_TOL" Width="100" />
                                    <ext:Column ID="Column6" runat="server" Text="面积公差" DataIndex="SD_AREA_TOL" Width="100" />
                                    <ext:Column ID="Column7" runat="server" Text="肩宽度" DataIndex="SD_SHOULDER_WIDTH" Width="100" />
                                    <ext:Column ID="Column8" runat="server" Text="肩宽度公差" DataIndex="SD_SHOULDER_WIDTH_TOL" Width="100" />
                                    <ext:Column ID="Column9" runat="server" Text="标准轮廓关键点" DataIndex="KEY_POINTS" Width="100" />
                                    <ext:Column ID="Column10" runat="server" Text="实测轮廓关键点" DataIndex="MEASURE_POINTS" Width="100" />
                                    <ext:Column ID="Column11" runat="server" Text="总面积" DataIndex="TOTAL_AREA" Width="100" />
                                    <ext:Column ID="Column12" runat="server" Text="左面积" DataIndex="LEFT_AREA" Width="100" />
                                    <ext:Column ID="Column13" runat="server" Text="右面积" DataIndex="RIGHT_AREA" Width="100" />
                                    <ext:Column ID="Column14" runat="server" Text="总宽" DataIndex="TOTAL_WIDTH" Width="100" />
                                    <ext:Column ID="Column15" runat="server" Text="肩部宽" DataIndex="SHOULDER_WIDTH" Width="100" />
                                    <ext:Column ID="Column16" runat="server" Text="肩部厚（左）" DataIndex="LEFT_SHOULDER_THICK" Width="100" />
                                    <ext:Column ID="Column17" runat="server" Text="肩部厚（右）" DataIndex="RIGHT_SHOULDER_THICK" Width="100" />
                                </Columns>
                            </ColumnModel>
                            <View>
                                <ext:GridView ID="gvRows" runat="server" EnableTextSelection="true">
                                </ext:GridView>
                            </View>
                            <Plugins>
                                <ext:CellEditing ID="cellEditing1" runat="server" ClicksToEdit="1">
                                </ext:CellEditing>
                            </Plugins>
                            <BottomBar>
                                <ext:PagingToolbar ID="pageToolBar" runat="server">
                                    <Items>
                                        <ext:ToolbarSpacer ID="ToolbarSpacer1" runat="server" Width="10" />
                                        <ext:ComboBox ID="ComboBox3" runat="server" Width="80"  Hidden="true">
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
                                                <Select Handler="#{pnlDetailList}.storeData.pageSize = parseInt(this.getValue(), 10); #{pageToolBar}.doRefresh(); return false;" />
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

