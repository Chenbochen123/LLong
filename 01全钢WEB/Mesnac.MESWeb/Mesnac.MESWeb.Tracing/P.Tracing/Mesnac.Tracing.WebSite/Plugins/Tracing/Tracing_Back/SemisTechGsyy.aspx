<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SemisTechGsyy.aspx.cs" Inherits="Tracing_Back_SemisTechGsyy" %>

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
        var legendData;
        var serialData;
        var ydata0;

        var refreshChart = function () {
            App.direct.chartMainBindData( {
                success: function (result) {
                    if (result != '') {
                        refreshData(eval(result));
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
        var refreshData = function (data) {
            debugger;
            xdata0 = [];
            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata0 = [];
            for (var i = 0; i < data.length; i++) {
                ydata0.push(data[i]["MATERIAL_NAME"]);
            }

            legendData = HiddenTypeid2.value.split(',');

            var selectLines = HiddenTypeid.value.split(',');

            serialData = [];

            for (var j = 0; j < selectLines.length; j++) {
                let ydata = [];
                for (var i = 0; i < data.length; i++) {
                    ydata.push(data[i][selectLines[j]]-0);
                }
                let serial = {
                    name: legendData[j],
                    type: 'line',
                    yAxisIndex: 0,
                    data: ydata
                };
                serialData.push(serial);
            }
            

            App.SemisTechGsyy.getBody().update("<iframe src='SemisTechGsyy.html' width=100% height=100% frameborder=0></iframe>");
        }

    </script>
</head>

<body>
    <form id="form1" runat="server">
        <ext:ResourceManager runat="server" ID="ResourceManager1" />
        <ext:Viewport runat="server" ID="Viewport1" Layout="BorderLayout">
            <Items>
                <ext:Panel runat="server" Region="Center" AutoScroll="true" ID="SemisTechGsyy">
                </ext:Panel>
                <ext:Hidden runat="server" ID="HiddenEquipId"></ext:Hidden>
                <ext:Hidden runat="server" ID="HiddenTypeid"></ext:Hidden>
                <ext:Hidden runat="server" ID="HiddenTypeid2"></ext:Hidden>
                <ext:Hidden runat="server" ID="HiddenBeginTime"></ext:Hidden>
                <ext:Hidden runat="server" ID="HiddenEndTime"></ext:Hidden>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>

