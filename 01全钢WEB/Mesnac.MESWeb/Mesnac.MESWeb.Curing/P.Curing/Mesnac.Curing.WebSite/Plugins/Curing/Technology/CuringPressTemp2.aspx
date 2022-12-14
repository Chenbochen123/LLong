<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CuringPressTemp2.aspx.cs" Inherits="Plugins_Curing_Technology_CuringPressTemp2" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>

    <script type="text/javascript">
        var cboSearchShiftId_Change = function (newValue) {
            if (newValue == null || newValue == "") {
                return false;
            }
            App.direct.setSearchTime(newValue, {
                success: function (result) {
                    if (result != "") {
                        Ext.Msg.alert("提示", result);
                        return false;
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
            return true;
        };

        var cgpSearchPressTempLine_Change = function (item) {
            var selectValues = "";
            var chks = item.getChecked();
            for (var i = 0; i < chks.length; i++) {
                var auditUserId = chks[i].inputValue;
                if (selectValues == "") {
                    selectValues = auditUserId;
                }
                else {
                    selectValues = selectValues + "," + auditUserId;
                }
            }
            App.hdnSearchPressTempLine.setValue(selectValues);
        };

    </script>

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
                },
                timeout:300000
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
            ydata9 = [];
            for (var i = 0; i < data.length; i++) {
                ydata9.push(data[i]["CURRENTSTEP"]);
            }
            ydata10 = [];
            for (var i = 0; i < data.length; i++) {
                ydata10.push(data[i]["LCLOSEMOULD_PRESS"]);
            }
            ydata11 = [];
            for (var i = 0; i < data.length; i++) {
                ydata11.push(data[i]["RCLOSEMOULD_PRESS"]);
            }
            ydata12 = [];
            for (var i = 0; i < data.length; i++) {
                ydata12.push(data[i]["LEFT_MOLDSTATE"]);
            }
            ydata13 = [];
            for (var i = 0; i < data.length; i++) {
                ydata13.push(data[i]["RIGHT_MOLDSTATE"]);
            }
            App.CuringChart.getBody().update("<iframe src='CuringPressTemp.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
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
                                <ext:Button runat="server" ID="Button1" Icon="Find" Text="查看曲线图">
                                    <Listeners>
                                        <Click Handler="refreshChart(false); return false;" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" Icon="PageWhiteExcel" Text="导出" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                  <%--  <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>--%>
                                    <DirectEvents>
                                        <Click IsUpload="true" OnEvent="btnExportSubmit_Click"> 
                                            
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:Panel runat="server" Width="700" Border="false">
                            <Items>
                                <ext:FieldContainer runat="server" Layout="ColumnLayout" ColumnWidth="1">
                                    <Items>
                                        <ext:ComboBox runat="server" ID="cboSearchEquipId" LabelAlign="Right" FieldLabel="硫化机台"
                                            QueryMode="Local" ForceSelection="true" LabelWidth="80" InputWidth="70">
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" Qtip="清空" HideTrigger="true" />
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Handler="this.setValue('');" />
                                            </Listeners>
                                        </ext:ComboBox>
                                        <ext:ComboBox runat="server" ID="cboSearchShiftId" LabelAlign="Right" FieldLabel="班次" Editable="false"
                                            LabelWidth="80" InputWidth="70">
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" Qtip="清空" HideTrigger="true" />
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Handler="this.setValue('');" />
                                                <Change Handler="return cboSearchShiftId_Change(newValue);" />
                                            </Listeners>
                                        </ext:ComboBox>
                                        <ext:DateField runat="server" ID="datSearchBeginDate" LabelAlign="Right" FieldLabel="时间" Format="yyyy-MM-dd" Editable="false"
                                            LabelWidth="80" InputWidth="90" />
                                        <ext:TimeField runat="server" ID="timSearchBeginTime" HideLabel="true" Format="HH:mm:ss"
                                            InputWidth="90" />
                                        <ext:Label runat="server" Text="~" />
                                        <ext:TimeField runat="server" ID="timSearchEndTime" HideLabel="true" Format="HH:mm:ss" InputWidth="90" />

                                    </Items>
                                </ext:FieldContainer>
                                <ext:FieldContainer runat="server" Layout="ColumnLayout" ColumnWidth="1">
                                    <Items>
                                        <ext:TextField runat="server" ID="txtSearchTyreNo" LabelAlign="Right" FieldLabel="硫化号"
                                            LabelWidth="80" InputWidth="220" />
                                        <ext:ComboBox ID="cbxding" runat="server" FieldLabel="是否显示步序/合模力" LabelAlign="Right"
                                            Editable="false">
                                            <Items>
                                                <ext:ListItem Text="是" Value="1">
                                                </ext:ListItem>
                                                <ext:ListItem Text="否" Value="2">
                                                </ext:ListItem>
                                            </Items>
                                            <Listeners>
                                                <TriggerClick Handler="this.setValue('');" />
                                            </Listeners>
                                        </ext:ComboBox>
                                    </Items>
                                </ext:FieldContainer>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:Panel runat="server" Region="Center" AutoScroll="true" ID="CuringChart">
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
