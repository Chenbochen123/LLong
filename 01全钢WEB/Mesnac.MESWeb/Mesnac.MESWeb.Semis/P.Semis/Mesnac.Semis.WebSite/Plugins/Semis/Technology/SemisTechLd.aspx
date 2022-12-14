<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SemisTechLd.aspx.cs" Inherits="Plugins_Semis_Technology_SemisTechLd" %>

<%@ Register assembly="Ext.Net" namespace="Ext.Net" tagprefix="ext" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script src="../../../resources/js/jquery-1.7.1.js" type="text/javascript"></script>
    <script type="text/javascript">
        var btnSearch_Click = function () {
            if ( timSearchBeginTime==null)
            {
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

        var refreshChart = function () {
            debugger;
            App.direct.chartMainBindData({
                success: function (result) {
                    debugger;
                    if (result[0] == 'T') {
                        result = result.slice(3);
                        refreshData(eval(result));
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
                ydata1.push(data[i]["JCJLGTEMP"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["JCJSHTEMP"]);
            }
            ydata3 = [];
            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["JCJJCTEMP"]);
            }
            ydata4 = [];
            for (var i = 0; i < data.length; i++) {
                ydata4.push(data[i]["JCJHEADTEMP"]);
            }
            ydata5 = [];
            for (var i = 0; i < data.length; i++) {
                ydata5.push(data[i]["PJTEMP"]);
            }
            ydata6 = [];
            for (var i = 0; i < data.length; i++) {
                ydata6.push(data[i]["JQTEMP"]);
            }
            ydata7 = [];
            for (var i = 0; i < data.length; i++) {
                ydata7.push(data[i]["MATERIAL_NAME"]);
            }
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechLDTmp.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
        }
        //其他
        var refreshData1 = function (data) {
            debugger;
            xdata0 = [];
            for (var i = 0; i < data.length; i++) {
                xdata0.push(data[i]["RECORD_TIME"]);
            }

            ydata1 = [];
            for (var i = 0; i < data.length; i++) {
                ydata1.push(data[i]["WINDPRESSURE"]);
            }
            ydata2 = [];
            for (var i = 0; i < data.length; i++) {
                ydata2.push(data[i]["LINESPEED"]);
            }
            ydata3 = [];
            for (var i = 0; i < data.length; i++) {
                ydata3.push(data[i]["MATERIAL_NAME"]);
            }
            App.SemisTechFhx.getBody().update("<iframe src='SemisTechLDOther.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
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
                        <ext:Panel runat="server" Width="900" Border="false">
                            <Items>
                                <ext:FieldSet runat="server" Layout="ColumnLayout" ColumnWidth="1" Title="曲线"  >
                                    <Items>
                                        <ext:ComboBox runat="server" ID="ComboBox0" 
                                            Editable="false"
                                            QueryMode="Local"
                                            TriggerAction="All"
                                             EmptyText="零度线" >
                                            <Items>
                                                <ext:ListItem Text="零度一线" Value="LD1"  />
                                                <ext:ListItem Text="零度二线" Value="LD2" />
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
                                                <ext:ListItem Text="温度" Value="LDTemp"  />
                                                <ext:ListItem Text="其他" Value="LDqita"  />
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

                                        <ext:Hidden runat="server" ID="hdnSearchPressTempLine" />
                                         <ext:DateField runat="server" ID="datSearchBeginDate" LabelAlign="Right" FieldLabel="时间" Format="yyyy-MM-dd" Editable="false"
                                            LabelWidth="80" InputWidth="90" />
                                        <ext:TimeField runat="server" ID="timSearchBeginTime" HideLabel="true" Format="HH:mm:ss"
                                            InputWidth="90" OnDirectChange="timSearchTime_DirectChange" />
                                        <ext:Label runat="server" Text="~" />
                                        <ext:TimeField runat="server" ID="timSearchEndTime" HideLabel="true" Format="HH:mm:ss" 
                                            InputWidth="90" OnDirectChange="timSearchTime_DirectChange" />
                                       
                                    </Items>
                                </ext:FieldSet>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:Panel runat="server" Region="Center" AutoScroll="true" ID="SemisTechFhx">
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

