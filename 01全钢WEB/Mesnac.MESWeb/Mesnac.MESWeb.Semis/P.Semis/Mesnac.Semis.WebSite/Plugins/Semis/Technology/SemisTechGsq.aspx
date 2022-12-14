<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SemisTechGsq.aspx.cs" Inherits="Plugins_Semis_Technology_SemisTechGsq" %>

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
        //温度
        var refreshData1 = function (data) {
            debugger;
            xdata0 = [];
            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["JCJTEMP1"]);
            }

            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["JCJTEMP2"]);
            }

            ydata3 = [];
            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["JCJTEMP3"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["MATERIAL_NAME"]);
            }
            App.SemisTechNcc.getBody().update("<iframe src='SemisTechGsqTmp.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        //内径
        var refreshData2 = function (data) {
            debugger;
            xdata0 = [];

            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["INNERDIAMETER"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["INNERDIAMETERCPK"]);

            }
            ydata3 = [];

            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["DIACORRECTION"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["MATERIAL_NAME"]);
            }
           
            App.SemisTechNcc.getBody().update("<iframe src='SemisTechGsqNJ.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        //压力
        var refreshData3 = function (data) {
            debugger;
            xdata0 = [];

            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["JCJPRE"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["LETOFFTENSION"]);

            }
            ydata3 = [];
            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["MATERIAL_NAME"]);
            }
            App.SemisTechNcc.getBody().update("<iframe src='SemisTechGsqYL.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }

        //速度
        var refreshData4 = function (data) {
            debugger;
            xdata0 = [];
            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }
            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["SCREWSPEED"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["LINESPEED"]);
            }
            ydata3 = [];
            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["MATERIAL_NAME"]);
            }
         
            App.SemisTechNcc.getBody().update("<iframe src='SemisTechGsqSpeed.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
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
                        <ext:Panel runat="server" Width="1000" Border="false">
                            <Items>
                                <ext:FieldSet runat="server" Layout="ColumnLayout" ColumnWidth="1" Title="曲线">
                                    <Items>
                                        <ext:ComboBox ID="cbxequip" runat="server" FieldLabel="机台" LabelAlign="left"
                                            Editable="false">
                                            <Items>
                                                <ext:ListItem Text="钢丝圈一线" Value="279">
                                                </ext:ListItem>
                                                <ext:ListItem Text="钢丝圈二线" Value="280">
                                                </ext:ListItem>
                                                <ext:ListItem Text="钢丝圈三线" Value="281">
                                                </ext:ListItem>
                                                <ext:ListItem Text="钢丝圈四线" Value="282">
                                                </ext:ListItem>
                                            </Items>
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" Qtip="清空">
                                                </ext:FieldTrigger>
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Handler="this.setValue('');" />
                                            </Listeners>
                                        </ext:ComboBox>

                                        <ext:ComboBox runat="server" ID="ComboBox1"
                                            Editable="false"
                                            QueryMode="Local"
                                            TriggerAction="All"
                                            EmptyText="选择查询类型">
                                            <Listeners>
                                                <Select Handler="#{ComboBox2}.clearValue(); #{CitiesStore}.reload();" />
                                            </Listeners>
                                            <Items>
                                                <ext:ListItem Text="挤出温度" Value="GSQTemp" />
                                                <ext:ListItem Text="内径" Value="GSQDIA" />
                                                <ext:ListItem Text="压力" Value="GSQPress" />
                                                <ext:ListItem Text="速度" Value="GSQSpeed" />
                                              
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

                                        <ext:Hidden runat="server" ID="hdnSearchPressTempLine" />
                                        <ext:DateField runat="server" ID="datSearchBeginDate" LabelAlign="Right" FieldLabel="时间" Format="yyyy-MM-dd" Editable="false"
                                            LabelWidth="80" InputWidth="90" />
                                        <ext:TimeField runat="server" ID="timSearchBeginTime" HideLabel="true" Format="HH:mm:ss"
                                            InputWidth="90" />
                                        <ext:Label runat="server" Text="~" />
                                        <ext:TimeField runat="server" ID="timSearchEndTime" HideLabel="true" Format="HH:mm:ss" InputWidth="90" />

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
