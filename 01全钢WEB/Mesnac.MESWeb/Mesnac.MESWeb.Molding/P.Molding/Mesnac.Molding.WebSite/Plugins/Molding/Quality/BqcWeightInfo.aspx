<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BqcWeightInfo.aspx.cs" Inherits="Plugins_MoldingBG_Quality_BqcWeightInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell {
            background-color: #B0FFBA !important;
        }
    </style>
    <script type="text/javascript">

        var pnlListFresh = function () {
            //if (App.txtBeginDate.getValue() > App.txtEndDate.getValue()) {
            //    Ext.Msg.alert('操作', '开始时间不能大于结束时间！');
            //    return false;
            //}
            //else {
            //    if (App.txtBeginTime.getValue() > App.txtEndTime.getValue()) {
            //        Ext.Msg.alert('操作', '开始时间不能大于结束时间！');
            //        return false;
            //    }
            //}
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            setTimeout: 300000;
            return false;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmQCRepair" runat="server" />
        <ext:Viewport ID="vpQCRepair" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnMQCRepair" runat="server" Region="North" Height="90">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbQCRepair">
                            <Items>

                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <Listeners>
                                        <Click Fn="pnlListFresh" />
                                    </Listeners>
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
                                <ext:ToolbarSeparator ID="tsBegin" />
                                <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                                <ext:ToolbarFill ID="tfEnd" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txtGreenTyreNo" runat="server" FieldLabel="胎胚号" Flex="1" LabelAlign="Right" Editable="false">
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txtMaterialName" runat="server" FieldLabel="胎胚物料名称" LabelAlign="Right" Flex="1">
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxhege" runat="server" FieldLabel="胎胚合格" LabelAlign="Right"
                                            Editable="false">
                                            <Items>
                                                <ext:ListItem Text="合格" Value="1">
                                                </ext:ListItem>
                                                <ext:ListItem Text="A0" Value="2">
                                                </ext:ListItem>
                                                <ext:ListItem Text="次品" Value="3">
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
                                        <ext:ComBoBox ID="cbxequip" runat="server" FieldLabel="成型机台" LabelAlign="Right" Flex="1">
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" Qtip="清空">
                                                </ext:FieldTrigger>
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Handler="this.setValue('');" />
                                            </Listeners>
                                        </ext:ComBoBox>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:ComBoBox ID="cbxshift" runat="server" FieldLabel="班次" LabelAlign="Right" Flex="1">
                                            <Items>
                                                <ext:ListItem Text="早" Value="1">
                                                </ext:ListItem>
                                                <ext:ListItem Text="中" Value="2">
                                                </ext:ListItem>
                                                <ext:ListItem Text="晚" Value="3">
                                                </ext:ListItem>
                                            </Items>
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" Qtip="清空">
                                                </ext:FieldTrigger>
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Handler="this.setValue('');" />
                                            </Listeners>
                                        </ext:ComBoBox>
                                        <ext:ComBoBox ID="cbxgaipan" runat="server" FieldLabel="是否改判" LabelAlign="Right" Flex="1">
                                            <Items>
                                                <ext:ListItem Text="全部" Value="0">
                                                </ext:ListItem>
                                                <ext:ListItem Text="是" Value="1">
                                                </ext:ListItem>
                                                <ext:ListItem Text="否" Value="2">
                                                </ext:ListItem>
                                            </Items>
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" Qtip="清空">
                                                </ext:FieldTrigger>
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Handler="this.setValue('');" />
                                            </Listeners>
                                        </ext:ComBoBox>
                                    </Items>
                                </ext:Container>
                            </Items>
                            <Listeners>
                                <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>

                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5" Title="胎胚称重记录">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="15">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="TYRE_NO" />
                                                <ext:ModelField Name="CURING_MATER_NAME" />
                                                <ext:ModelField Name="CURING_MATER_CODE" />
                                                <ext:ModelField Name="GREEN_TYRE_NO" />
                                                <ext:ModelField Name="GREEN_MATER_NAME" />
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="SHIFT_DATE" Type="Date" />
                                                <ext:ModelField Name="SHIFT_NAME" />
                                                <ext:ModelField Name="CLASS_NAME" />
                                                <ext:ModelField Name="WEIGHT" />
                                                <ext:ModelField Name="WEIGHT_NORMAL" />
                                                <ext:ModelField Name="QUALITY" />
                                                <ext:ModelField Name="HGWC" />
                                                <ext:ModelField Name="BHGWC" />
                                                <ext:ModelField Name="EMP1" />
                                                <ext:ModelField Name="EMP2" />
                                                <ext:ModelField Name="EMP3" />
                                                <ext:ModelField Name="CURING_GRADE" />
                                                <ext:ModelField Name="UPDATE_TIME" Type="Date" />
                                                <ext:ModelField Name="UPDATE_USER" />
                                                <ext:ModelField Name="BEGIN_TIME" />
                                                <ext:ModelField Name="END_TIME" />
                                                <ext:ModelField Name="OLD_WEIGHT" />
                                                <ext:ModelField Name="REASON" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                                    <ext:Column ID="TYRE_NO" runat="server" Text="硫化号" DataIndex="TYRE_NO" Width="100" />
                                    <ext:Column ID="CURING_MATER_NAME" runat="server" Text="硫化物料名称" DataIndex="CURING_MATER_NAME" Width="200" />
                                    <ext:Column ID="CURING_MATER_CODE" runat="server" Text="硫化物料CODE" DataIndex="CURING_MATER_CODE" Width="200" />
                                    <ext:Column ID="CURING_GRADE" runat="server" Text="外胎品级" DataIndex="CURING_GRADE" Width="100" />
                                    <ext:Column ID="GREEN_TYRE_NO" runat="server" Text="胎胚号" DataIndex="GREEN_TYRE_NO" Width="100" />
                                    <ext:Column ID="GREEN_MATER_NAME" runat="server" Text="胎胚物料名称" DataIndex="GREEN_MATER_NAME" Width="150" />
                                    <ext:Column ID="Column3" runat="server" Text="成型开始时间" DataIndex="BEGIN_TIME" Width="100" />
                                    <ext:Column ID="Column4" runat="server" Text="成型结束时间" DataIndex="END_TIME" Width="100" />
                                    <ext:Column ID="EQUIP_NAME" runat="server" Text="成型机台" DataIndex="EQUIP_NAME" Width="100" />
                                    <ext:DateColumn ID="SHIFT_DATE" runat="server" Text="接班日期" DataIndex="SHIFT_DATE" Width="80" Format="yyyy-MM-dd" />
                                    <ext:Column ID="SHIFT_NAME" runat="server" Text="接班班次" DataIndex="SHIFT_NAME" Width="80" />
                                    <ext:Column ID="CLASS_NAME" runat="server" Text="接班班组" DataIndex="CLASS_NAME" Width="80" />
                                    <ext:Column ID="WEIGHT" runat="server" Text="胎胚重量" DataIndex="WEIGHT" Width="100" />
                                    <ext:Column ID="WEIGHT_NORMAL" runat="server" Text="胎胚标准重量" DataIndex="WEIGHT_NORMAL" Width="100" />
                                    <ext:Column ID="QUALITY" runat="server" Text="胎胚合格" DataIndex="QUALITY" Width="100" />
                                    <ext:Column ID="HGWC" runat="server" Text="胎胚称重时合格误差" DataIndex="HGWC" Width="100" Hidden="true"/>
                                    <ext:Column ID="BHGWC" runat="server" Text="胎胚称重时不合格误差" DataIndex="BHGWC" Width="100" Hidden="true"/>
                                    <ext:Column ID="EMP1" runat="server" Text="成型主机" DataIndex="EMP1" Width="100" />
                                    <ext:Column ID="EMP2" runat="server" Text="成型副机" DataIndex="EMP2" Width="100" />
                                    <ext:Column ID="EMP3" runat="server" Text="成型帮车" DataIndex="EMP3" Width="100" />
                                    <ext:Column ID="Column5" runat="server" Text="原重量" DataIndex="OLD_WEIGHT" Width="100" />
                                    <ext:Column ID="Column6" runat="server" Text="改判原因" DataIndex="REASON" Width="120" />
                                    <ext:DateColumn ID="Column1" runat="server" Text="改判时间" DataIndex="UPDATE_TIME" Width="180" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="Column2" runat="server" Text="改判人" DataIndex="UPDATE_USER" Width="80" />
                                </Columns>
                            </ColumnModel>
                            <Plugins>
                                <ext:CellEditing ID="cellEditing1" runat="server" ClicksToEdit="1">
                                </ext:CellEditing>
                            </Plugins>

                            <SelectionModel>
                                <ext:RowSelectionModel ID="rowSelectMuti" runat="server" Mode="Single">
                                    <Listeners>
                                        <Select Handler="#{storeDetail}.reload();" Buffer="250" />
                                    </Listeners>
                                </ext:RowSelectionModel>
                            </SelectionModel>
                            <BottomBar>
                                <ext:PagingToolbar ID="pageToolBar" runat="server">
                                    <Items>
                                        <ext:ToolbarSpacer ID="ToolbarSpacer1" runat="server" Width="10" />
                                        <ext:ComboBox ID="ComboBox1" runat="server" Width="80" Hidden="true">
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
    </form>
</body>
</html>
