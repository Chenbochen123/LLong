<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CuringPressTemp2.aspx.cs" Inherits="Tracing_Back_CuringPressTemp2" %>

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

        var refreshChart = function () {
            App.direct.chartMainBindData2({
                success: function (result) {
                    refreshData(eval(result))
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

        var refreshData = function (data) {

            xdata0 = [];

            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["SHOW_TIME"]);
            }
            xdata1 = [];
            for (var i = 0; i < data.length; i++) {
                xdata1.push(data[i]["LEFT_TYRE_NO"] );
            }
            xdata2 = [];
            for (var i = 0; i < data.length; i++) {
                xdata2.push(data[i]["RIGHT_TYRE_NO"]);

            }
            ydata1 = []; 

            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["LEFT_INNER_TEMP"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["RIGHT_INNER_TEMP"]);
            }
            ydata3 = [];
            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["LEFT_INNER_PRESS"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["RIGHT_INNER_PRESS"]);
            }
            ydata5 = [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["LEFT_PLATE_TEMP"]);
            }
            ydata6 = [];
            for (var i = 0; i < data.length; i++) {
                ydata6.push(data[i]["RIGHT_PLATE_TEMP"]);
            }
            ydata7 = [];
            for (var i = 0; i < data.length; i++) {
                ydata7.push(data[i]["LEFT_MODEL_TEMP"]);
            }
            ydata8 = [];
            for (var i = 0; i < data.length; i++) {
                ydata8.push(data[i]["RIGHT_MODEL_TEMP"]);
            }
            App.CuringChart.getBody().update("<iframe src='CuringPressTemp.html' width=100% height=100% frameborder=0></iframe>");
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager runat="server" ID="ResourceManager1" />
        <ext:Viewport runat="server" ID="Viewport1" Layout="BorderLayout">
            <Items>
                <ext:Panel runat="server" Region="Center" ID="CuringChart">
                </ext:Panel>
                <ext:Hidden runat="server" ID="HiddBarcode"></ext:Hidden>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
