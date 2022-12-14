<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReportBsmMoldingFirstInspect.aspx.cs"
    Inherits="Plugins_Molding_ReportBsmMoldingFirstInspect" %>

<%@ Register Assembly="FastReport.Web" Namespace="FastReport.Web" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>成型首检参数查询</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js" ></script>
    <script type="text/javascript" language="javascript">
        var setRowClass = function (record, index, rowParams, store) {
            if (record.get('AutoCheckResult') == '0') {
                return 'x-grid-row-deleted';
            }
        };

        var GridViewCenterMaster_GetRowClass = function (record, index, rowParams, store) {
            if (record.get("RecordStat") == "1") {
                return "x-grid-row-summary";
            }
            return "";
        };

        var ColumnCenterMasterRecordStatDes_Renderer = function (value, metadata, record, rowIndex, colIndex, store, view) {
            if (record.get("RecordStat") == "1") {
                return "<span style='background-color: lightgreen'>" + value + "</span>";
            }
            else if (record.get("RecordStat") == "0") {
                return "<span style='background-color: yellow'>" + value + "</span>";
            }
            return value;
        };

        var ColumnCenterMasterCheckResultDes_Renderer = function (value, metadata, record, rowIndex, colIndex, store, view) {
            if (record.get("CheckResult") == "0") {
                return "<span style='background-color: red'>" + value + "</span>";
            }
            return value;
        };
    </script>
    <script type="text/javascript">
        //-------人员绑定-----查询带回弹出框--BEGIN
        var Manager_BasicInfo_CommonPage_QueryQmcUser_Request = function (record) {//人员绑定
            var command = App.txtHiddenSelectCommand.getValue();
            switch (command) {
                case "former":
                    {
                        if (!App.windowExportSetting.hidden) {
                            App.trfFormerName.setValue(record.data.UserName);
                        }
                    }
                    break;
                case "confirmer":
                    {
                        if (!App.windowExportSetting.hidden) {
                            App.trfConfirmerName.setValue(record.data.UserName);
                        }
                    }
                    break;
                case "handler":
                    {
                        if (!App.windowGenerateLedger.hidden) {
                            App.trfGenerateLedgerHandlerName.setValue(record.data.UserName);
                            App.txtGenerateLedgerHandlerId.setValue(record.data.HRCode);
                        }
                        if (!App.windowExportSetting.hidden) {
                            App.trfExportHandlerName.setValue(record.data.UserName);
                            App.txtExportHandlerId.setValue(record.data.HRCode);
                        }
                    }
                default:
                    break;
            }
        }
        var SelectFormer = function () {//制表人绑定查询
            App.txtHiddenSelectCommand.setValue("former");
            App.Manager_BasicInfo_CommonPage_QueryQmcUser_Window.show();
        }
        var SelectConfirmer = function () {//审核人绑定查询
            App.txtHiddenSelectCommand.setValue("confirmer");
            App.Manager_BasicInfo_CommonPage_QueryQmcUser_Window.show();
        }
        var SelectHandler = function () {//处置人绑定查询
            App.txtHiddenSelectCommand.setValue("handler");
            App.Manager_BasicInfo_CommonPage_QueryQmcUser_Window.show();
        }
        Ext.create("Ext.window.Window", {//人员绑定查询带回窗体
            id: "Manager_BasicInfo_CommonPage_QueryQmcUser_Window",
            height: 460,
            hidden: true,
            width: 360,
            html: "<iframe src='../BasicInfo/CommonPage/QueryQmcUser.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择人员",
            modal: true
        });
        //------------查询带回弹出框--END 
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <ext:ResourceManager runat="server" ID="rmMaterialCheckReport" />
    <ext:Viewport runat="server" ID="vwUnit" Layout="BorderLayout">
        <Items>
            <ext:Panel runat="server" ID="pnlNorth" Region="North" AutoHeight="true">
                <TopBar>
                    <ext:Toolbar runat="server" ID="barUnit1">
                        <Items>
                            <ext:Button runat="server" ID="btnSearch" Icon="Find" Text="查询">
                                <ToolTips>
                                    <ext:ToolTip ID="ttSearch" runat="server" Html="" />
                                </ToolTips>
                                <DirectEvents>
                                    <Click OnEvent="btnSearch_Click">
                                        <EventMask ShowMask="true" Target="Page" />
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                            <ext:ToolbarSeparator ID="toolbarSeparator1" />
                           
                            <ext:ToolbarSeparator ID="toolbarSeparator2" />
                            <ext:Button runat="server" ID="btnExportPhysical" Text="导出" Icon="PageExcel">
                                <DirectEvents>
                                    <Click OnEvent="btnExport_Click" IsUpload="true">
                                        <ExtraParams>
                                            <ext:Parameter Name="reportType" Value="physical" />
                                        </ExtraParams>
                                    </Click>
                                </DirectEvents>
                            </ext:Button>
                        </Items>
                    </ext:Toolbar>
                </TopBar>
                <Items>
                    <ext:FormPanel runat="server" ID="pnlForm" Layout="AnchorLayout" AutoHeight="true">
                        <Items>
                            <ext:Container ID="container2" runat="server" Layout="HBoxLayout" Padding="5" >
                                <Items>
                                    <ext:TextField runat="server" ID="TextFielMaterial" FieldLabel="本次规格" LabelAlign="Right" InputWidth="181" >
                                    </ext:TextField>
                                    <ext:DateField runat="server" ID="CheckDateBegin" FieldLabel="检验开始日期" LabelAlign="Right"
                                        Format="yyyy-MM-dd" Editable="false" />
                                        <ext:DateField runat="server" ID="CheckDateEnd" FieldLabel="检验结束日期" LabelAlign="Right"
                                        Format="yyyy-MM-dd" Editable="false" >
                                        <Triggers>
                                            <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                        </Triggers>
                                        <Listeners>
                                            <TriggerClick Handler="this.setValue('');" />
                                        </Listeners>
                                    </ext:DateField>
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:FormPanel>
                </Items>
            </ext:Panel>
            <ext:Panel runat="server" ID="pnlCenter" Region="Center" Layout="BorderLayout">
                <Items>
                   <ext:GridPanel runat="server" ID="GridPanelCenterMaster" Region="Center">
                        <Store>
                            <ext:Store runat="server" ID="StoreCenterMaster" PageSize="10">
                                <Model>
                                    <ext:Model runat="server" ID="ModelCenterMaster" IDProperty="OBJID">
                                        <Fields>
                                            <ext:ModelField Name="OBJID" />
                                            <ext:ModelField Name="CheckId" />
                                            <ext:ModelField Name="BillNo" />
                                            <ext:ModelField Name="TOOLING_BARCODE" />
                                            <ext:ModelField Name="EQUIP_NAME" />
                                            <ext:ModelField Name="RecordTime" Type="Date" />
                                            <ext:ModelField Name="LastModifierId" />
                                            <ext:ModelField Name="LastModifyTime" Type="Date" />
                                            <ext:ModelField Name="CheckResultDes" />
                                            <ext:ModelField Name="MaterName" />
                                            <ext:ModelField Name="LASTMATERIALNAME" />
                                            <ext:ModelField Name="ProductFacName" />
                                            <ext:ModelField Name="RecorderName" />
                                            <ext:ModelField Name="LastModifierName" />
                                            <ext:ModelField Name="RecordStat" />
                                            <ext:ModelField Name="RecordStatDes" />
                                            <ext:ModelField Name="ExtractorName" />
                                            <ext:ModelField Name="ReceiverName" />
                                            <ext:ModelField Name="FetcherName" />
                                            <ext:ModelField Name="HandlerName" />
                                            <ext:ModelField Name="INSERTTIME" Type="Date" />
                                            <ext:ModelField Name="SendDate" Type="Date" />
                                            <ext:ModelField Name="ReturnDate" Type="Date" />
                                            <ext:ModelField Name="HandleDate" Type="Date" />
                                            <ext:ModelField Name="CURRENTMATERIALNAME" />
                                        </Fields>
                                    </ext:Model>
                                </Model>
                                <Parameters>
                                    <ext:StoreParameter Name="CheckId" Mode="Raw" Value="#{GridPanelCenterMaster}.getSelectionModel().hasSelection() ? #{GridPanelCenterMaster}.getSelectionModel().getSelection()[0].data.CheckId : -1" />
                                </Parameters>
                            </ext:Store>
                        </Store>
                        <ColumnModel ID="colModel1" runat="server">
                            <Columns>
                                <ext:RowNumbererColumn ID="rowNumCol1" runat="server" />
                                <ext:Column runat="server" ID="OBJID" DataIndex="OBJID" Text="OBJID" Visible="false" />
                                <ext:Column runat="server" ID="ColumnCenterMasterBatchCode" DataIndex="EQUIP_NAME" Text="设备名称" />
                                <ext:DateColumn runat="server" ID="DateColumn1" DataIndex="INSERTTIME"
                                    Text="首检时间" Format="Y-m-d H:i:s " Width="150"/>
                                <ext:Column runat="server" ID="ColumnCenterMasterMaterSpecName" DataIndex="CURRENTMATERIALNAME"
                                    Text="本次规格"  Width="200"/>
                                <ext:Column runat="server" ID="ColumnCenterMasterSupplyFacName" DataIndex="LASTMATERIALNAME"
                                    Text="上次规格" Width="200" />
                                
                            </Columns>
                        </ColumnModel>
                        <SelectionModel>
                            <ext:CheckboxSelectionModel runat="server" ID="CheckboxSelectionModelCenterMaster"
                                Mode="Simple" ShowHeaderCheckbox="true">
                                <DirectEvents>
                                    <Select OnEvent="CheckboxSelectionModelCenterMaster_SelectionChange">
                                        <ExtraParams>
                                            <ext:Parameter Mode="Raw" Name="CheckId" Value="record.get('CheckId')" />
                                        </ExtraParams>
                                    </Select>
                                </DirectEvents>
                            </ext:CheckboxSelectionModel>
                        </SelectionModel>
                        <View>
                            <ext:GridView runat="server" ID="GridViewCenterMaster" EnableTextSelection="true">
                                <GetRowClass Fn="GridViewCenterMaster_GetRowClass" />
                            </ext:GridView>
                        </View>
                        <BottomBar>
                            <ext:PagingToolbar runat="server" ID="PagingToolbarCenterMaster" HideRefresh="true" />
                        </BottomBar>
                    </ext:GridPanel>
                </Items>
            </ext:Panel>
            <%--<ext:Panel ID="pnlSouth" runat="server" Region="South" Title="质检数据" Height="200" Icon="Basket" Layout="Fit" Collapsible="true" Split="true" MarginsSummary="0 5 5 5">
                <TopBar><ext:Toolbar ID="Toolbar1" runat="server" Height="1"></ext:Toolbar></TopBar>
                <Items>
                     <ext:GridPanel runat="server" ID="GridPanelCenterDeail" Region="South" AutoScroll="true"
                        Height="150" Padding="2">
                        <Store>
                            <ext:Store runat="server" ID="StoreCenterDetail">
                                <Model>
                                    <ext:Model runat="server" ID="ModelCenterDetail">
                                        <Fields>
                                            <ext:ModelField Name="ItemName" />
                                            <ext:ModelField Name="GoodMinValue" />
                                            <ext:ModelField Name="GoodOperator" />
                                            <ext:ModelField Name="GoodMaxValue" />
                                            <ext:ModelField Name="CheckMethod" />
                                            <ext:ModelField Name="GoodTextValue" />
                                            <ext:ModelField Name="Remark" />
                                            <ext:ModelField Name="CheckValue" />
                                            <ext:ModelField Name="GoodDisplayValue" />
                                            <ext:ModelField Name="Frequency" />
                                            <ext:ModelField Name="PrimeDisplayValue" />
                                            <ext:ModelField Name="AutoCheckResult" />
                                            <ext:ModelField Name="TextCheckResult" />
                                            <ext:ModelField Name="IsPrime" />
                                            <ext:ModelField Name="TextIsPrime" />
                                        </Fields>
                                    </ext:Model>
                                </Model>
                            </ext:Store>
                        </Store>
                        <ColumnModel>
                            <Columns>
                                <ext:Column runat="server" ID="ColumnCenterDetailItemName" DataIndex="Actuallpar32000001" Text="检验项目"
                                    Width="200" />
                                <ext:Column runat="server" ID="CheckColumnCenterDetailAutoCheckResult" DataIndex="Actuallpar32000002"
                                    Text="是否合格" Hidden="true"/>
                                <ext:Column runat="server" ID="CheckColumnCenterDetailAutoIsPrime" DataIndex="Actuallpar32000003"
                                    Text="是否一级品" Hidden="true"/>
                                <ext:Column runat="server" ID="ColumnCenterDetailCheckRange" DataIndex="GoodDisplayValue"
                                    Text="合格品指标值" Width="150"/>
                                <ext:Column runat="server" ID="ColumnCenterDetailCheckValue" DataIndex="CheckValue"
                                    Text="检验值" />
                                <ext:Column runat="server" ID="CheckColumnCenterDetailTextCheckResult" DataIndex="TextCheckResult"
                                    Text="是否合格" />
                                <ext:Column runat="server" ID="CheckColumnCenterDetailTextIsPrime" DataIndex="TextIsPrime"
                                    Text="是否一级品" />
                                <ext:Column runat="server" ID="ColumnCenterDetailAutoPrimeCheckRange" DataIndex="PrimeDisplayValue"
                                    Text="一级品指标值" Width="150"/>
                                <ext:Column runat="server" ID="ColumnCenterDetailFrequency" DataIndex="Frequency"
                                    Text="频次" />
                                <ext:Column runat="server" ID="ColumnCenterDetailCheckMethod" DataIndex="CheckMethod"
                                    Text="检验方法" Width="200" />
                            </Columns>
                        </ColumnModel>
                         <View>
                            <ext:GridView runat="server" ID="GridViewCenterDetail" StripeRows="true" TrackOver="true">
                                <GetRowClass Fn="setRowClass" />
                            </ext:GridView>
                         </View>
                    </ext:GridPanel>
                </Items>
            </ext:Panel>--%>
            <ext:Hidden ID="txtHiddenCheckId" runat="server" />
            <ext:Hidden ID="txtHiddenSelectCommand" runat="server" />
        </Items>
    </ext:Viewport>
    </form>
</body>
</html>
