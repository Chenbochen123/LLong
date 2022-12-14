<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SemisTechXc15.aspx.cs" Inherits="Tracing_Back_SemisTechXc15" %>


<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>15度斜裁曲线查询</title>
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

        var refreshChart = function () {
            App.direct.chartMainBindData({
                success: function (result) {
                    if (result != '') {
                        if (HiddenTypeid.value == 0) {
                            refreshData0(eval(result));
                        }
                        else if (HiddenTypeid.value == 1) {
                            refreshData1(eval(result));
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

            App.SemisTech15Xc.getBody().update("<iframe src='SemisTechXc15Width.html' width=100% height=100%  frameborder=0></iframe>");
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

            App.SemisTech15Xc.getBody().update("<iframe src='SemisTechXc15WidthCpk.html' width=100% height=100%  frameborder=0></iframe>");
        }
        
    </script>
</head>

<body>
    <form id="form1" runat="server">
        <ext:ResourceManager runat="server" ID="ResourceManager1" />
        <ext:Viewport runat="server" ID="Viewport1" Layout="BorderLayout">
            <Items>
                <ext:Panel runat="server" Region="Center" AutoScroll="true" ID="SemisTech15Xc">
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

