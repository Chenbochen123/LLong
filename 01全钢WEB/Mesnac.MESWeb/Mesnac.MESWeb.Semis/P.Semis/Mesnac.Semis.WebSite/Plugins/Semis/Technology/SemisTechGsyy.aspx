<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SemisTechGsyy.aspx.cs" Inherits="Plugins_Semis_Technology_SemisTechGsyy" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>钢丝压延曲线查询</title>
    <script src="../../../resources/js/jquery-1.7.1.js" type="text/javascript"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript">
        var btnSearch_Click = function () {
            if (App.ComboBox0.getValue() == '' || App.ComboBox0.getValue() == null) {
                Ext.Msg.alert("错误", "请选择机台");
                return false;
            }

            if (timSearchBeginTime == null) {
                Ext.Msg.alert("错误", "请选择时间");
                return false;
            }
            return true;
        };

    </script>

    <script>
        var xdata0;
        var legendData;
        var serialData;
        var ydata0;

        var refreshChart = function () {
            debugger;

            if (App.ComboBox0.getValue() == '' || App.ComboBox0.getValue() == null) {
                Ext.Msg.alert("错误", "请选择机台");
                return false;
            }

            if (App.ComboBox1.getValue() == '' || App.ComboBox1.getValue() == null) {
                Ext.Msg.alert("错误", "请选择要查询的曲线");
                return false;
            }

            if (App.ComboBox1.value.length > 10) {
                Ext.Msg.alert("错误", "曲线最多选择10项");
                return false;
            }

            App.direct.chartMainBindData(App.ComboBox1.value.toString(), {
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

            legendData = App.selectType.getText().split(',');

            let selectLines = App.ComboBox1.value;

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
            

            App.SemisTechGsyy.getBody().update("<iframe src='SemisTechGsyy.html' width=100% height=100% scrolling=no  frameborder=0></iframe>");
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
                        <ext:Panel runat="server" Border="false">
                            <Items>
                                <ext:FieldSet runat="server" Layout="ColumnLayout" ColumnWidth="1" Title="曲线">
                                    <Items>
                                        <ext:ComboBox runat="server" ID="ComboBox0"
                                            Editable="false"
                                            QueryMode="Local"
                                            TriggerAction="All"
                                            EmptyText="" ValueField="OBJID" DisplayField="EQUIP_NAME">
                                            <Store>
                                                <ext:Store runat="server">
                                                    <Model>
                                                        <ext:Model runat="server">
                                                            <Fields>
                                                                <ext:ModelField Name="OBJID" />
                                                                <ext:ModelField Name="EQUIP_NAME" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                        </ext:ComboBox>
                                        <ext:ComboBox runat="server" ID="ComboBox1" Editable="false" EmptyText="选择查询类型" DisplayField="name"
                                            ValueField="id" ValueNotFoundText="Loading..." MultiSelect="true" Width="300">
                                            <Store>
                                                <ext:Store
                                                    runat="server"
                                                    ID="CitiesStore">
                                                    <Model>
                                                        <ext:Model runat="server" IDProperty="Id">
                                                            <Fields>
                                                                <ext:ModelField Name="id" Type="String" ServerMapping="Id" />
                                                                <ext:ModelField Name="name" Type="String" ServerMapping="Name" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" />
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Handler="this.clearValue();" />
                                                <Change Handler="App.selectType.setText(App.ComboBox1.rawValue.replace(/\s/g,''));" />
                                            </Listeners>
                                        </ext:ComboBox>

                                        <ext:Hidden runat="server" ID="hdnSearchPressTempLine" />
                                        <ext:DateField runat="server" ID="datSearchBeginDate" LabelAlign="Right" FieldLabel="时间" Format="yyyy-MM-dd" Editable="false"
                                            LabelWidth="80" InputWidth="90" />
                                        <ext:TimeField runat="server" ID="timSearchBeginTime" HideLabel="true" Format="HH:mm:ss"
                                            InputWidth="90" OnDirectChange="timSearchTime_DirectChange" />
                                        <ext:Label runat="server" Text="~" />
                                        <ext:TimeField runat="server" ID="timSearchEndTime" HideLabel="true" Format="HH:mm:ss" 
                                            InputWidth="90" OnDirectChange="timSearchTime_DirectChange" />

                                        <ext:Label ID="selectType" runat="server" Text="" />
                                    </Items>
                                </ext:FieldSet>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:Panel runat="server" Region="Center" AutoScroll="true" ID="SemisTechGsyy">
                </ext:Panel>
                 <ext:Panel ID="Panel2" runat="server" Region="Center" AutoScroll="true" Title="厚度" Hidden="true">
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
                                                <ext:ModelField Name="GAGE3_PRO" />
                                                <ext:ModelField Name="GAGE3_AVG" />
                                                <ext:ModelField Name="GAGE3_TARGET" />
                                                <ext:ModelField Name="GAGE3_MAX" />
                                                <ext:ModelField Name="GAGE3_MIN" />
                                                <ext:ModelField Name="GAGE3_HIGH_ALARM" />
                                                <ext:ModelField Name="GAGE3_HIGH_ALERT" />
                                                <ext:ModelField Name="GAGE3_LOW_ALARM" />
                                                <ext:ModelField Name="GAGE3_LOW_ALERT" />
                                                <ext:ModelField Name="GAGE3_MAXCW" />
                                                <ext:ModelField Name="GAGE3_MINCW" />
                                                <ext:ModelField Name="GAGE3_MINVALIDCW" />
                                                <ext:ModelField Name="CLIENTS" />
                                                <ext:ModelField Name="CAST_PROF_TO_TARGET" />
                                                <ext:ModelField Name="OFFLINE_RECIPE_NAME" />
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
                                    <ext:Column ID="Column18" runat="server" Text="总厚度测量值" DataIndex="GAGE3_PRO" Width="100" />
                                    <ext:Column ID="Column19" runat="server" Text="总厚度平均值" DataIndex="GAGE3_AVG" Width="100" />
                                    <ext:Column ID="Column20" runat="server" Text="总厚度目标值" DataIndex="GAGE3_TARGET" Width="100" />
                                    <ext:Column ID="Column21" runat="server" Text="总厚度最大值" DataIndex="GAGE3_MAX" Width="100" />
                                    <ext:Column ID="Column22" runat="server" Text="总厚度最小值" DataIndex="GAGE3_MIN" Width="100" />
                                    <ext:Column ID="Column23" runat="server" Text="上报警" DataIndex="GAGE3_HIGH_ALARM" Width="100" />
                                    <ext:Column ID="Column24" runat="server" Text="上警戒" DataIndex="GAGE3_HIGH_ALERT" Width="100" />
                                    <ext:Column ID="Column25" runat="server" Text="下报警" DataIndex="GAGE3_LOW_ALARM" Width="100" />
                                    <ext:Column ID="Column26" runat="server" Text="下警戒" DataIndex="GAGE3_LOW_ALERT" Width="100" />
                                    <ext:Column ID="Column27" runat="server" Text="MaxCW" DataIndex="GAGE3_MAXCW" Width="100" />
                                    <ext:Column ID="Column28" runat="server" Text="MinCW" DataIndex="GAGE3_MINCW" Width="100" />
                                    <ext:Column ID="Column29" runat="server" Text="MinValidCW" DataIndex="GAGE3_MINVALIDCW" Width="100" />
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

