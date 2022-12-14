<%@ page language="C#" autoeventwireup="true" inherits="Plugins_Semis_SemisPlan_SemisPlanMonitor, Mesnac.Semis.WebSite" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>生产计划监控</title>
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell {
            background-color: #B0FFBA !important;
        }
    </style>

    <script type="text/javascript">
        var onProgressProcentChange = function (progress, progressbar, record, idx, panel, fn) {
            var data = record.data[progressbar.column.column.dataIndex];
            if (data) {
                progressbar.updateProgress(data / 100, data + "%");
            } else {
                progressbar.updateProgress(0, "");
            }
        };

        //-------设备类别-----查询带回弹出框--BEGIN
        var Manager_BasicInfo_CommonPage_EqmEquipInfo_Request = function (record) {
            App.txtEquipID.getTrigger(0).show();
            App.txtEquipID.setValue(record.data.EquipName);
            App.hidden_EquipID.setValue(record.data.ObjID);
        }

        var querySelectEquipInfo = function (field, trigger, index) {//设备查询
            switch (index) {
                case 0:
                    field.getTrigger(0).hide();
                    field.setValue('');
                    App.hidden_EquipID.setValue("");
                    field.getEl().down('input.x-form-text').setStyle('background', "white");
                    break;
                case 1:
                    App.Manager_BasicInfo_CommonPage_EqmEquipInfo_Window.show();
                    break;
            }
        }

        Ext.create("Ext.window.Window", {//设备查询带回窗体
            id: "Manager_BasicInfo_CommonPage_EqmEquipInfo_Window",
            height: 460,
            hidden: true,
            width: 360,
            html: "<iframe src='../../SearchBox/EqmEquipInfo.aspx?EquipTypeID=2' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择设备",
            modal: true
        })
        //------------查询带回弹出框--END 
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="rmProductMoniter" runat="server" />
        <ext:Viewport ID="vpProductMoniter" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnProductMoniter" runat="server" Region="North">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbProductMoniter">
                            <Items>
                                <ext:ToolbarSeparator ID="tsBegin" />
                                <ext:Button runat="server" Icon="Find" Text="查询实时计划信息" ID="btnSearch">
                                    <DirectEvents>
                                        <Click OnEvent="RefreshStore">
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="tsMiddle" />
                                <ext:Label runat="server" Text="" ID="lblRefreshTime">
                                </ext:Label>
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:DateField ID="txtBeginTime" runat="server" FieldLabel="时间" LabelAlign="Right" />
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtEquipCode" runat="server" FieldLabel="机台" LabelAlign="Right" />
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtMaterialCode" runat="server" FieldLabel="物料名称" LabelAlign="Right" />
                                        <ext:TriggerField ID="txtEquipID" runat="server" Hidden="true" FieldLabel="机台" LabelAlign="Right"
                                            Editable="false">
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                                <ext:FieldTrigger Icon="Search" />
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Fn="querySelectEquipInfo" />
                                            </Listeners>
                                        </ext:TriggerField>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container5" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="txt_procedure" runat="server" FieldLabel="工序" LabelAlign="Right" Editable="false"
                                            ValueField="value" DisplayField="text">
                                        </ext:ComboBox>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5" Hidden="true">
                                    <Items>
                                        <ext:TextField ID="txtMCode" runat="server" FieldLabel="物料别名" LabelAlign="Right" Hidden="true" />

                                    </Items>
                                </ext:Container>
                            </Items>
                            <Listeners>
                                <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server" Width="600" Height="350">
                            <Store>
                                <ext:Store ID="store" runat="server">
                                    <Model>
                                        <ext:Model ID="model" runat="server">
                                            <Fields>
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="MATERIAL_NAME_1" />
                                                <ext:ModelField Name="PLAN_AMOUNT_1" />
                                                <ext:ModelField Name="REAL_AMOUNT_1" />
                                                <ext:ModelField Name="COMPLETE_RATE_1" />
                                                <ext:ModelField Name="MATERIAL_NAME_2" />
                                                <ext:ModelField Name="PLAN_AMOUNT_2" />
                                                <ext:ModelField Name="REAL_AMOUNT_2" />
                                                <ext:ModelField Name="COMPLETE_RATE_2" />
                                                <ext:ModelField Name="MATERIAL_NAME_3" />
                                                <ext:ModelField Name="PLAN_AMOUNT_3" />
                                                <ext:ModelField Name="REAL_AMOUNT_3" />
                                                <ext:ModelField Name="COMPLETE_RATE_3" />
                                                <ext:ModelField Name="UNIT_NAME" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:Column ID="machinename" runat="server" Text="机台" DataIndex="EQUIP_NAME" Width="100"
                                        Locked="true" Sortable="false" />
                                    <ext:Column ID="Column1" runat="server" Text="物料单位" DataIndex="UNIT_NAME" Width="60"
                                        Locked="true" Sortable="false" />
                                    <ext:ComponentColumn runat="server" ID="Component" Text="早班" Align="Center" Lockable="false">
                                        <Columns>
                                            <ext:Column ID="zaomtname" runat="server" Text="物料" DataIndex="MATERIAL_NAME_1" Align="Center"
                                                Width="160" />
                                            <ext:Column ID="zaoplanamount" runat="server" Text="计划数" DataIndex="PLAN_AMOUNT_1"
                                                Align="Center" Width="60" />
                                            <ext:Column ID="zaorealamount" runat="server" Text="实际数" DataIndex="REAL_AMOUNT_1"
                                                Align="Center" Width="60" />
                                            <ext:ComponentColumn ID="zaoprogress" DataIndex="COMPLETE_RATE_1" runat="server" Text="计划监控"
                                                Align="Center" Width="100">
                                                <Component>
                                                    <ext:ProgressBar ID="ProgressBar1" runat="server" Text="">
                                                    </ext:ProgressBar>
                                                </Component>
                                                <Listeners>
                                                    <Bind Fn="onProgressProcentChange">
                                                    </Bind>
                                                </Listeners>
                                            </ext:ComponentColumn>
                                        </Columns>
                                    </ext:ComponentColumn>
                                    <ext:ComponentColumn runat="server" ID="ComponentColumn1" Text="中班" Align="Center">
                                        <Columns>
                                            <ext:Column ID="zhongmtname" runat="server" Text="物料" DataIndex="MATERIAL_NAME_2" Align="Center"
                                                Width="160" />
                                            <ext:Column ID="zhongplanamount" runat="server" Text="计划数" DataIndex="PLAN_AMOUNT_2"
                                                Align="Center" Width="60" />
                                            <ext:Column ID="zhongrealamount" runat="server" Text="实际数" DataIndex="REAL_AMOUNT_2"
                                                Align="Center" Width="60" />
                                            <ext:ComponentColumn ID="zhongprogress" DataIndex="COMPLETE_RATE_2" runat="server" Text="计划监控"
                                                Align="Center" Width="100">
                                                <Component>
                                                    <ext:ProgressBar ID="ProgressBar2" runat="server" Text="">
                                                    </ext:ProgressBar>
                                                </Component>
                                                <Listeners>
                                                    <Bind Fn="onProgressProcentChange">
                                                    </Bind>
                                                </Listeners>
                                            </ext:ComponentColumn>
                                        </Columns>
                                    </ext:ComponentColumn>
                                    <ext:ComponentColumn runat="server" ID="ComponentColumn2" Text="夜班" Align="Center">
                                        <Columns>
                                            <ext:Column ID="yemtname" runat="server" Text="物料" DataIndex="MATERIAL_NAME_3" Align="Center"
                                                Width="160" />
                                            <ext:Column ID="yeplanamount" runat="server" Text="计划数" DataIndex="PLAN_AMOUNT_3"
                                                Align="Center" Width="60" />
                                            <ext:Column ID="yerealamount" runat="server" Text="实际数" DataIndex="REAL_AMOUNT_3"
                                                Align="Center" Width="60" />
                                            <ext:ComponentColumn ID="yeprogress" DataIndex="COMPLETE_RATE_3" runat="server" Text="计划监控"
                                                Align="Center" Width="100">
                                                <Component>
                                                    <ext:ProgressBar ID="ProgressBar3" runat="server" Text="">
                                                    </ext:ProgressBar>
                                                </Component>
                                                <Listeners>
                                                    <Bind Fn="onProgressProcentChange">
                                                    </Bind>
                                                </Listeners>
                                            </ext:ComponentColumn>
                                        </Columns>
                                    </ext:ComponentColumn>
                                </Columns>
                            </ColumnModel>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
                <%--隐藏控件存储值--%>
                <ext:Hidden ID="hidden_EquipID" runat="server">
                </ext:Hidden>
            </Items>
        </ext:Viewport>
        <ext:TaskManager ID="TaskManager1" runat="server">
            <Tasks>
                <ext:Task TaskID="servertime" Interval="60000">
                    <DirectEvents>
                        <Update OnEvent="RefreshStore">
                        </Update>
                    </DirectEvents>
                </ext:Task>
            </Tasks>
        </ext:TaskManager>
    </form>
</body>
</html>
