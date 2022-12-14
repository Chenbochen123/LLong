<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Search_forward.aspx.cs" Inherits="Tracing_Forward_Search_forward" ViewStateMode="Enabled" EnableViewStateMac="true" EnableViewState="true" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="head" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>条码冻结</title>
    <!--通用-->
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script src="<%= Page.ResolveUrl("./") %>Search_forward.js?_dc=<%= DateTime.Now.ToString("yyyyMMddHHmmss") %>"></script>
    <script type="text/javascript">
    </script>
    <script>

    </script>
</head>
<body>
    <form id="form" runat="server">
        <ext:ResourceManager ID="resourceManager" runat="server" />
        <ext:Viewport ID="viewport" runat="server" Layout="BorderLayout">
            <Items>
                <ext:Panel ID="northPanel" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="northToolbar">
                            <Items>
                                <ext:TextField ID="txtBarcode" runat="server" FieldLabel="条码号" />
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="点击进行查询" />
                                    </ToolTips>
                                    <DirectEvents>
                                        <Click OnEvent="btnSearch_Click" Timeout="300000">
                                            <EventMask ShowMask="true" Msg="查询中..." />
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" />
                                <ext:Button runat="server" Icon="TagRed" Text="冻结" ID="btnFreeze">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip1" runat="server" Html="点击进行冻结" />
                                    </ToolTips>
                                    <DirectEvents>
                                        <Click OnEvent="btnFreeze_Click">
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>

                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                </ext:Panel>
                <ext:Panel ID="panel2" runat="server" Region="North" Height="60" Layout="BorderLayout">
                    <Items>
                        <ext:GridPanel ID="srcPanel" runat="server" Region="Center">
                            <Store>
                                <ext:Store runat="server" ID="Store1" PageSize="1">
                                    <Model>
                                        <ext:Model ID="model4" runat="server" IDProperty="BARCODE">
                                            <Fields>
                                                <ext:ModelField Name="BARCODE" />
                                                <ext:ModelField Name="MATERIALCODE" />
                                                <ext:ModelField Name="MATERIALNAME" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="columnModel5" runat="server">
                                <Columns>
                                    <ext:Column ID="Column7" runat="server" Text="条码号" Width="200" DataIndex="BARCODE" />
                                    <ext:Column ID="Column8" runat="server" Text="物料编码" Width="200" DataIndex="MATERIALCODE" />
                                    <ext:Column ID="Column9" runat="server" Text="物料名称" Width="300" DataIndex="MATERIALNAME" />
                                </Columns>
                            </ColumnModel>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="Panel1" runat="server" Region="Center" AutoHeight="true" Layout="BorderLayout">
                    <Items>
                        <ext:TabPanel runat="server" ID="tabPanel" Region="Center" Plain="true" ActiveIndex="0">
                            <Items>
                                <ext:Panel runat="server" ID="mixTab" Title="密炼信息" Flex="1" BodyPadding="6" AutoScroll="true" Region="Center">
                                    <Items>
                                        <ext:GridPanel runat="server" ID="mixPanel" Region="Center">
                                            <Store>
                                                <ext:Store runat="server" ID="mixStore" PageSize="30">
                                                    <Model>
                                                        <ext:Model ID="model" runat="server" IDProperty="BARCODE">
                                                            <Fields>
                                                                <ext:ModelField Name="BARCODE" />
                                                                <ext:ModelField Name="F_materCode" />
                                                                <ext:ModelField Name="MaterialName" />
                                                                <ext:ModelField Name="EquipCode" />
                                                                <ext:ModelField Name="prodDate" Type="Date" />
                                                                <ext:ModelField Name="RealWeight" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                            <ColumnModel ID="columnModel2" runat="server">
                                                <Columns>
                                                    <ext:RowNumbererColumn runat="server" Width="50" />
                                                    <ext:Column ID="Column1" runat="server" Text="条码号" Width="200" DataIndex="BARCODE" />
                                                    <ext:Column ID="Column29" runat="server" Text="物料编码" Width="200" DataIndex="F_materCode" />
                                                    <ext:Column ID="DateColumn5" runat="server" Text="物料名称" Width="100" DataIndex="MaterialName" />
                                                    <ext:Column ID="Column39" runat="server" Text="机台" Width="150" DataIndex="EquipCode" />
                                                    <ext:DateColumn ID="DateColumn4" runat="server" Text="生产日期" Width="200" DataIndex="prodDate" Format="yyyy-MM-dd HH:mm:ss" />
                                                    <ext:Column ID="Column43" runat="server" Text="数量" Width="80" DataIndex="RealWeight" />
                                                </Columns>
                                            </ColumnModel>
                                            <SelectionModel>
                                                <ext:CheckboxSelectionModel AllowDeselect="true" IgnoreRightMouseSelection="true" Mode="Multi" />
                                            </SelectionModel>
                                            <%--  <Listeners>
                                                <CellDblClick Fn="mixPanelCellDblClick" />
                                            </Listeners>--%>
                                        </ext:GridPanel>
                                    </Items>
                                    <%--    <Listeners>
                                        <Activate Fn="LoadMixProduction"></Activate>
                                    </Listeners>--%>
                                </ext:Panel>
                                <ext:Panel runat="server" ID="semisTab" Title="半制品信息" Flex="1" BodyPadding="6" AutoScroll="true" Region="Center">
                                    <Items>
                                        <ext:GridPanel runat="server" ID="semisPanel" RootVisible="false" FolderSort="true" UseArrows="false" SingleExpand="false" Region="Center">
                                            <Store>
                                                <ext:Store runat="server" ID="semisStore" PageSize="30">
                                                    <Model>
                                                        <ext:Model ID="model1" runat="server" IDProperty="BARCODE">
                                                            <Fields>
                                                                <ext:ModelField Name="BARCODE" />
                                                                <ext:ModelField Name="MATERIAL_FULL_NAME" />
                                                                <ext:ModelField Name="MINOR_TYPE_NAME" />
                                                                <ext:ModelField Name="EQUIP_NAME" />
                                                                <ext:ModelField Name="RECORD_TIME" />
                                                                <ext:ModelField Name="LEFT_QTY" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                    <%--  <Listeners>
                                                        <BeforeLoad Fn="SemisNodeLoad" />
                                                    </Listeners>--%>
                                                </ext:Store>
                                            </Store>
                                            <ColumnModel ID="columnModel1" runat="server">
                                                <Columns>
                                                    <%--  <ext:CheckColumn runat="server" Text="" DataIndex="done" Width="40" Editable="true" StopSelection="false">
                                                        <Listeners>
                                                            <CheckChange Fn="semisCheckChange" />
                                                        </Listeners>
                                                    </ext:CheckColumn>--%>
                                                    <ext:RowNumbererColumn runat="server" Width="50" />
                                                    <ext:Column ID="SemisTreeCol" runat="server" Text="卡片号" Width="200" DataIndex="BARCODE" />
                                                    <ext:Column ID="Column30" runat="server" Text="规格" Width="150" Flex="1" DataIndex="MATERIAL_FULL_NAME" />
                                                    <ext:Column ID="Column32" runat="server" Text="物料类型" Width="60" DataIndex="MINOR_TYPE_NAME" />
                                                    <ext:Column ID="Column31" runat="server" Text="机台" Width="50" DataIndex="EQUIP_NAME" />
                                                    <ext:DateColumn ID="DateColumn1" runat="server" Text="生产时间" Width="100" DataIndex="RECORD_TIME" Format="yyyy-MM-dd HH:mm:ss" />
                                                    <ext:Column ID="Column36" runat="server" Text="数量" Width="50" DataIndex="LEFT_QTY" />
                                                </Columns>
                                            </ColumnModel>
                                            <SelectionModel>
                                                <ext:CheckboxSelectionModel AllowDeselect="true" IgnoreRightMouseSelection="true" Mode="Multi" />
                                            </SelectionModel>
                                            <%-- <Listeners>-
                                                <CellDblClick Fn="semisPanelCellDblClick" />
                                            </Listeners>--%>
                                        </ext:GridPanel>
                                    </Items>
                                    <%--       <Listeners>
                                        <Activate Fn="LoadSemisProduction"></Activate>
                                    </Listeners>--%>
                                    <DirectEvents>
                                        <Activate OnEvent="LoadSemisProduction" Timeout="300000">
                                            <EventMask ShowMask="true" Msg="查询中..."></EventMask>
                                        </Activate>

                                    </DirectEvents>

                                </ext:Panel>
                                <ext:Panel runat="server" ID="moldingTab" Title="成型信息" Flex="1" BodyPadding="6" AutoScroll="true" Region="Center">
                                    <Items>
                                        <ext:GridPanel runat="server" ID="moldingPanel" Region="Center">
                                            <Store>
                                                <ext:Store runat="server" ID="moldingStore" PageSize="30">
                                                    <Model>
                                                        <ext:Model ID="model2" runat="server" IDProperty="BARCODE">
                                                            <Fields>
                                                                <ext:ModelField Name="BARCODE" />
                                                                <ext:ModelField Name="MATERIAL_FULL_NAME" />
                                                                <ext:ModelField Name="EQUIP_NAME" />
                                                                <ext:ModelField Name="BEGIN_TIME" Type="Date" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                            <ColumnModel ID="columnModel3" runat="server">
                                                <Columns>
                                                    <ext:RowNumbererColumn runat="server" Width="50" />
                                                    <ext:Column ID="Column2" runat="server" Text="成型号" Width="100" DataIndex="BARCODE" />
                                                    <ext:Column ID="Column15" runat="server" Text="规格" Flex="1" DataIndex="MATERIAL_FULL_NAME" />
                                                    <ext:Column ID="Column16" runat="server" Text="机台" Width="100" DataIndex="EQUIP_NAME" />
                                                    <ext:DateColumn ID="Column17" runat="server" Text="生产时间" Width="100" DataIndex="BEGIN_TIME" Format="yyyy-MM-dd HH:mm:ss" />
                                                </Columns>
                                            </ColumnModel>
                                            <SelectionModel>
                                                <ext:CheckboxSelectionModel AllowDeselect="true" IgnoreRightMouseSelection="true" Mode="Multi" />
                                            </SelectionModel>
                                            <%--   <Listeners>
                                                <CellDblClick Fn="moldingPanelCellDblClick" />
                                            </Listeners>--%>
                                            <%--  <SelectionModel>
                                                <ext:CheckboxSelectionModel ID="CheckboxSelection_Molding" runat="server" Mode="Multi" />
                                            </SelectionModel>--%>
                                        </ext:GridPanel>
                                    </Items>
                                    <DirectEvents>
                                        <Activate OnEvent="LoadMoldingProduction" Timeout="300000">
                                            <EventMask ShowMask="true" Msg="查询中..."></EventMask>
                                        </Activate>

                                    </DirectEvents>
                                </ext:Panel>
                                <ext:Panel runat="server" ID="curingTab" Flex="1" Title="硫化信息" BodyPadding="6" AutoScroll="true" Region="Center">
                                    <Items>
                                        <ext:GridPanel runat="server" ID="curingPanel" Region="Center">
                                            <Store>
                                                <ext:Store runat="server" ID="curingStore" PageSize="30">
                                                    <Model>
                                                        <ext:Model ID="model3" runat="server" IDProperty="BARCODE">
                                                            <Fields>
                                                                <ext:ModelField Name="BARCODE" />
                                                                <ext:ModelField Name="GREEN_TYRE_NO" />
                                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                                <ext:ModelField Name="EQUIP_NAME" />
                                                                <ext:ModelField Name="BEGIN_TIME" Type="Date" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                            <ColumnModel ID="columnModel4" runat="server">
                                                <Columns>
                                                    <ext:RowNumbererColumn runat="server" Width="50" />
                                                    <ext:Column ID="Column3" runat="server" Text="硫化号" Width="100" DataIndex="BARCODE" />
                                                    <ext:Column ID="Column4" runat="server" Text="成型号" Width="100" DataIndex="GREEN_TYRE_NO" />
                                                    <ext:Column ID="Column5" runat="server" Text="规格" Width="200" DataIndex="MATERIAL_NAME" />
                                                    <ext:Column ID="Column6" runat="server" Text="机台" Width="50" DataIndex="EQUIP_NAME" />
                                                    <ext:DateColumn ID="Column11" runat="server" Text="硫化时间" Width="100" DataIndex="BEGIN_TIME" Format="yyyy-MM-dd HH:mm:ss" />
                                                </Columns>
                                            </ColumnModel>
                                            <SelectionModel>
                                                <ext:CheckboxSelectionModel AllowDeselect="true" IgnoreRightMouseSelection="true" Mode="Multi" />
                                            </SelectionModel>
                                            <%--   <Listeners>
                                                <CellDblClick Fn="curingPanelCellDblClick" />
                                            </Listeners>--%>
                                        </ext:GridPanel>
                                    </Items>
                                    <DirectEvents>
                                        <Activate OnEvent="LoadCuringProduction" Timeout="300000">
                                            <EventMask ShowMask="true" Msg="查询中..."></EventMask>
                                        </Activate>

                                    </DirectEvents>
                                </ext:Panel>
                            </Items>
                        </ext:TabPanel>
                    </Items>
                </ext:Panel>
                <ext:Hidden runat="server" ID="hiddenSourceProcessId"></ext:Hidden>
                <ext:Hidden runat="server" ID="hiddenTargetProcessId"></ext:Hidden>
                <ext:Hidden runat="server" ID="hiddenBarcode"></ext:Hidden>
            </Items>
        </ext:Viewport>
        <ext:Window ID="winReason" runat="server" Icon="MonitorEdit" Closable="false" Title="冻结原因"
            Width="350" Height="300" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
            BodyPadding="5" Layout="Form">
            <Items>
                <ext:FormPanel ID="pnlEdit" runat="server" Flex="1" BodyPadding="5">
                    <Items>
                        <ext:ComboBox ID="cbxReason" runat="server" FieldLabel="冻结原因" LabelAlign="Left" ReadOnly="false" />
                    </Items>
                </ext:FormPanel>
            </Items>
            <Buttons>
                <ext:Button ID="btnModifySave" runat="server" Text="确定" Icon="Accept">
                    <DirectEvents>
                        <Click OnEvent="BtnModifySave_Click" Timeout="300000">
                            <EventMask ShowMask="true" Msg="冻结中..." />
                            <ExtraParams>
                                <ext:Parameter Name="values" Mode="Raw" Encode="false" Value="App.tabPanel.getActiveTab().items.getAt(0).store.data.items.map(item=>item.data.BARCODE)"></ext:Parameter>
                            </ExtraParams>
                        </Click>
                    </DirectEvents>
                </ext:Button>
                <ext:Button ID="btnModifyCancel" runat="server" Text="取消" Icon="Cancel">
                    <DirectEvents>
                        <Click OnEvent="BtnCancel_Click">
                        </Click>
                    </DirectEvents>
                </ext:Button>
            </Buttons>
        </ext:Window>
    </form>
</body>
</html>
