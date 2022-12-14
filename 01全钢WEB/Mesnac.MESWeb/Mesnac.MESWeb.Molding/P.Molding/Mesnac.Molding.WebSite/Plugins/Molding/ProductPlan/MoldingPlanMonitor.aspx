<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MoldingPlanMonitor.aspx.cs" Inherits="Plugins_Molding_ProductPlan_MoldingPlanMonitor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>生产计划监控</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell
        {
            background-color: #B0FFBA !important;
        }
        .bk-green 
        {
            border-right-color: #30cb14 !important;
            border-top-color: #48e221 !important;
            background-color: #37e444 !important;
            background-image: -webkit-linear-gradient(top,#9cf5af,#57f163 50%,#59ef61 51%,#1be362) !important;
            height: 18px;
            overflow: hidden;
            position: absolute;
            border-radius: 0;
            border-right: 1px solid;
            border-top: 1px solid;
        }
        .bk-text-green 
        {
            color: #12ed09 !important;
        }
    </style>
    <script type="text/javascript">
        /** 
        * 合并单元格 
        * @param {} grid  要合并单元格的grid对象 
        * @param {} cols  要合并哪几列 [1,2,4] 
        */
        var mergeCells = function (grid, cols) {
            var arrayTr = document.getElementById(grid.getId() + "-body").firstChild.firstChild.firstChild.getElementsByTagName('tr');
            var trCount = arrayTr.length;
            var arrayTd;
            var td;
            var merge = function (rowspanObj, removeObjs) { //定义合并函数   
                if (rowspanObj.rowspan != 1) {
                    arrayTd = arrayTr[rowspanObj.tr].getElementsByTagName("td"); //合并行   
                    td = arrayTd[rowspanObj.td - 1];
                    td.rowSpan = rowspanObj.rowspan;
                    td.vAlign = "middle";
                    Ext.each(removeObjs, function (obj) { //隐身被合并的单元格   
                        arrayTd = arrayTr[obj.tr].getElementsByTagName("td");
                        arrayTd[obj.td - 1].style.display = 'none';
                    });
                }
            };
            var rowspanObj = {}; //要进行跨列操作的td对象{tr:1,td:2,rowspan:5}       
            var removeObjs = []; //要进行删除的td对象[{tr:2,td:2},{tr:3,td:2}]   
            var col;
            Ext.each(cols, function (colIndex) { //逐列去操作tr   
                var rowspan = 1;
                var divHtml = null; //单元格内的数值           
                for (var i = 1; i < trCount; i++) {  //i=0表示表头等没用的行   
                    arrayTd = arrayTr[i].getElementsByTagName("td");
                    var cold = 0;
                    //          Ext.each(arrayTd,function(Td){ //获取RowNumber列和check列   
                    //              if(Td.getAttribute("class").indexOf("x-grid-cell-special") != -1)   
                    //                  cold++;                                
                    //          });   
                    col = colIndex + cold; //跳过RowNumber列和check列   
                    if (!divHtml) {
                        divHtml = arrayTd[col - 1].innerHTML;
                        rowspanObj = { tr: i, td: col, rowspan: rowspan }
                    } else {
                        var cellText = arrayTd[col - 1].innerHTML;
                        var addf = function () {
                            rowspanObj["rowspan"] = rowspanObj["rowspan"] + 1;
                            removeObjs.push({ tr: i, td: col });
                            if (i == trCount - 1)
                                merge(rowspanObj, removeObjs); //执行合并函数   
                        };
                        var mergef = function () {
                            merge(rowspanObj, removeObjs); //执行合并函数   
                            divHtml = cellText;
                            rowspanObj = { tr: i, td: col, rowspan: rowspan }
                            removeObjs = [];
                        };
                        if (cellText == divHtml) {
                            if (colIndex != cols[0]) {
                                var leftDisplay = arrayTd[col - 2].style.display; //判断左边单元格值是否已display   
                                if (leftDisplay == 'none')
                                    addf();
                                else
                                    mergef();
                            } else
                                addf();
                        } else
                            mergef();
                    }
                }
            });
        };
    </script>
    <script type="text/javascript">
        var onProgressProcentChange = function (progress, progressbar, record, idx, panel, fn) {
            var data = record.data[progressbar.column.column.dataIndex];
            if (data) {
                progressbar.updateProgress(data / 100, data + "%");
            } else {
                progressbar.updateProgress(0, "");
            }
            switch (progressbar.column.column.dataIndex) {
                case "COMPLETE_RATE_1":
                    {
                        if (record.data["RUN_STATUS_1"] == 1) {
                            var dom = progressbar.bar.dom;
                            dom.className = 'bk-green';
                            dom.previousElementSibling.className = 'x-progress-text bk-text-green';
                        }
                        break;
                    }
                case "COMPLETE_RATE_2":
                    {
                        if (record.data["RUN_STATUS_2"] == 1) {
                            var dom = progressbar.bar.dom;
                            dom.className = 'bk-green';
                            dom.previousElementSibling.className = 'x-progress-text bk-text-green';
                        }
                        break;
                    }
                case "COMPLETE_RATE_3":
                    {
                        if (record.data["RUN_STATUS_3"] == 1) {
                            var dom = progressbar.bar.dom;
                            dom.className = 'bk-green';
                            dom.previousElementSibling.className = 'x-progress-text bk-text-green';
                        }
                        break;
                    }
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
    <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
        OnClick="btnExportSubmit_Click" />
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
                            <ext:Button runat="server" Icon="PageExcel" Text="导出Excel" ID="btnExport">
                                <ToolTips>
                                    <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                </ToolTips>
                                <Listeners>
                                    <Click Handler="$('#btnExportSubmit').click();">
                                    </Click>
                                </Listeners>
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
                             <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                Padding="5" Hidden="true">
                                <Items>
                                    <ext:TextField ID="txtMCode" runat="server" FieldLabel="物料别名" LabelAlign="Right" />
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
                                            <ext:ModelField Name="RUN_STATUS_1" />
                                            <ext:ModelField Name="RUN_STATUS_2" />
                                            <ext:ModelField Name="RUN_STATUS_3" />
                                        </Fields>
                                    </ext:Model>
                                </Model>
                            </ext:Store>
                        </Store>
                        <ColumnModel ID="colModel" runat="server">
                            <Columns>
                                <ext:ComponentColumn runat="server" Text="机台">
                                    <Columns>
                                        <ext:Column ID="machinename" runat="server" Text="" DataIndex="EQUIP_NAME" Width="100"
                                            Locked="true" Sortable="false" />
                                    </Columns>
                                </ext:ComponentColumn>
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
