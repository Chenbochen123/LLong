<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CuringPressTemp3.aspx.cs" Inherits="Tracing_Compare_CuringPressTemp3" %>

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
        var item;

        var refreshChart = function () {
            App.direct.chartMainBindData2({
                success: function (result) {
                    var data = new Array();
                    for(var i=0;i<11;i++)
                    {
                        if (result[i] != null || result[i] != '') {
                            data[i] = eval(result[i]);
                        }
                    }
                    refreshData(data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7], data[8], data[9], data[10], result[11],result[12])
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

        var refreshData = function (data1,data2,data3,data4,data5,data6,data7,data8,data9,data10,data11,data12,data13) {

            xdata0 = [];

            for (var i = 0; i < data11.length; i++) {
                xdata0.push(data11[i]["SHOW_TIME"]);
            }

            xdata1 = [];
            var strs = data12.split(",");
            for (var i = 0; i < strs.length; i++) {
                xdata1.push(strs[i]);
            }

            ydata1 = []; 
            if (data1 != null) {
                for (var i = 0; i < data1.length; i++) {
                    ydata1.push(data1[i]["PARM"]);
                }
            }

            ydata2 = [];
            if (data2 != null) {
                for (var i = 0; i < data2.length; i++) {
                    ydata2.push(data2[i]["PARM"]);
                }
            }

            ydata3 = [];
            if (data3 != null) {
                for (var i = 0; i < data3.length; i++) {
                    ydata3.push(data3[i]["PARM"]);
                }
            }
            ydata4 = [];
            if (data4 != null) {
                for (var i = 0; i < data4.length; i++) {
                    ydata4.push(data4[i]["PARM"]);
                }
            }
            ydata5 = [];
            if (data5 != null) {
                for (var i = 0; i < data5.length; i++) {
                    ydata5.push(data5[i]["PARM"]);
                }
            }
            ydata6 = [];
            if (data6 != null) {
                for (var i = 0; i < data6.length; i++) {
                    ydata6.push(data6[i]["PARM"]);
                }
            }
            ydata7 = [];
            if (data7 != null) {
                for (var i = 0; i < data7.length; i++) {
                    ydata7.push(data7[i]["PARM"]);
                }
            }
            ydata8 = [];
            if (data8 != null) {
                for (var i = 0; i < data8.length; i++) {
                    ydata8.push(data8[i]["PARM"]);
                }
            }
            ydata9 = [];
            if (data9 != null) {
                for (var i = 0; i < data9.length; i++) {
                    ydata8.push(data9[i]["PARM"]);
                }
            }
            ydata10 = [];
            if (data10 != null) {
                for (var i = 0; i < data10.length; i++) {
                    ydata8.push(data10[i]["PARM"]);
                }
            }

            item = data13;
            App.CuringChart.getBody().update("<iframe src='CuringPressTemp1.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager runat="server" ID="ResourceManager1" />
        <ext:Viewport runat="server" ID="Viewport1" Layout="BorderLayout">
            <Items>
                <ext:Panel runat="server" Region="Center" AutoScroll="true" ID="CuringChart" Height="600">
                </ext:Panel>
                <ext:Hidden runat="server" ID="HiddBarcode"></ext:Hidden>
                <ext:Hidden runat="server" ID="HiddItem"></ext:Hidden>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
