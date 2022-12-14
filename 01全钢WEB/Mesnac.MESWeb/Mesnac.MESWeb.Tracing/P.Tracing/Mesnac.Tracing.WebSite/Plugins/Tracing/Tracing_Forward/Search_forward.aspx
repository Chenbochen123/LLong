<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Search_forward.aspx.cs" Inherits="Tracing_Forward_Search_forward" ViewStateMode="Enabled" EnableViewStateMac="true" EnableViewState="true" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="head" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>条码正向追溯</title>
    <!--通用-->
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script src="<%= Page.ResolveUrl("./") %>Search_forward.js?_dc=<%= DateTime.Now.ToString("yyyyMMddHHmmss") %>"></script>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <script type="text/javascript">
    </script>
    <%-- <script type="text/javascript">
        var basicInfoLoad = function (barcode) {
            App.direct.BasicInfoLoad(barcode, {
                success: function (result) {
                },
                failure: function (errorMsg) {
                    Ext.Msg.alert('提示', errorMsg);
                }
            });
        }
    </script>--%>
</head>
<body>
    <form id="form" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="resourceManager" runat="server" />
        <ext:Viewport ID="viewport" runat="server" Layout="BorderLayout">
            <Items>
                <ext:Panel ID="northPanel" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="northToolbar">
                            <Items>
                                <ext:ComboBox ID="cbxBarcodeType" runat="server" FieldLabel="条码类型(工序)" LabelAlign="Right">
                                    <Items>
                                        <%--<ext:ListItem Text="原材料条码" Value="1" />--%>
                                        <ext:ListItem Text="胶料原材料条码" Value="2" />
                                        <ext:ListItem Text="半制品条码" Value="3" />
                                        <ext:ListItem Text="成型号" Value="4" />
                                    </Items>
                                    <Listeners>
                                        <Change Fn="cbxBarcodeType_Change" />
                                    </Listeners>
                                </ext:ComboBox>
                                <ext:TextField ID="txtBarcode" runat="server" FieldLabel="条码号" />
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="点击进行查询" />
                                    </ToolTips>
                                    <DirectEvents>
                                        <Click OnEvent="btnSearch_Click"></Click>
                                    </DirectEvents>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" />
                                        <ext:Button runat="server" Icon="PageExcel" Text="导出" ID="btnExport">
                                            <ToolTips>
                                                <ext:ToolTip ID="ttbtnExport" runat="server" Html="导出条码相关追溯信息" />
                                            </ToolTips>
                                            <Listeners>
                                                <Click Handler="$('#btnExportSubmit').click();">
                                                </Click>
                                            </Listeners>
                                        </ext:Button>
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
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
                                                        <ext:Model ID="model" runat="server" IDProperty="条码号">
                                                            <Fields>
                                                                <ext:ModelField Name="条码号" />
                                                                <ext:ModelField Name="规格" />
                                                                <ext:ModelField Name="机台" />
                                                                <ext:ModelField Name="生产日期" Type="Date" />
                                                                <ext:ModelField Name="最小停放时间" />
                                                                <ext:ModelField Name="最大停放时间" />
                                                                <ext:ModelField Name="操作人" />
                                                                <ext:ModelField Name="数量" />
                                                                <ext:ModelField Name="单位" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                            <ColumnModel ID="columnModel2" runat="server">
                                                <Columns>
                                                    <ext:RowNumbererColumn runat="server" />
                                                    <ext:Column ID="Column1" runat="server" Text="条码号" Width="200" DataIndex="条码号" />
                                                    <ext:Column ID="Column29" runat="server" Text="规格" Width="200" DataIndex="规格" />
                                                    <ext:Column ID="Column39" runat="server" Text="机台" Width="150" DataIndex="机台" />
                                                    <ext:DateColumn ID="DateColumn4" runat="server" Text="生产日期" Width="200" DataIndex="生产日期" Format="yyyy-MM-dd HH:mm:ss" />
                                                    <ext:Column ID="DateColumn5" runat="server" Text="最小停放时间" Width="100" DataIndex="最小停放时间" />
                                                    <ext:Column ID="DateColumn6" runat="server" Text="最大停放时间" Width="100" DataIndex="最大停放时间" />
                                                    <ext:Column ID="Column42" runat="server" Text="操作人" Width="50" DataIndex="操作人" />
                                                    <ext:Column ID="Column43" runat="server" Text="数量" Width="80" DataIndex="数量" />
                                                    <ext:Column ID="Column44" runat="server" Text="单位" Width="80" DataIndex="单位" />
                                                </Columns>
                                            </ColumnModel>
                                            <Listeners>
                                                <CellDblClick Fn="mixPanelCellDblClick" />
                                            </Listeners>
                                        </ext:GridPanel>
                                    </Items>
                                    <Listeners>
                                        <Activate Fn="LoadMixProduction"></Activate>
                                    </Listeners>
                                </ext:Panel>
                                <ext:Panel runat="server" ID="semisTab" Title="半制品信息" Flex="1" BodyPadding="6" AutoScroll="true" Region="Center">
                                    <Items>
                                        <ext:TreePanel runat="server" ID="semisPanel" RootVisible="false" FolderSort="true" UseArrows="false" SingleExpand="false" Region="Center">
                                            <Store>
                                                <ext:TreeStore ID="TreeStore1" runat="server">
                                                    <Model>
                                                        <ext:Model ID="model1" runat="server">
                                                            <Fields>
                                                                <ext:ModelField Name="CARD_NO" />
                                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                                <ext:ModelField Name="EQUIP_NAME" />
                                                                <ext:ModelField Name="MATERIAL_MINOR_NAME" />
                                                                <ext:ModelField Name="SHIFT_DATE" />
                                                                <ext:ModelField Name="SHIFT_NAME" />
                                                                <ext:ModelField Name="CLASS_NAME" />
                                                                <ext:ModelField Name="BEGIN_TIME" />
                                                                <ext:ModelField Name="END_TIME"/>
                                                                <ext:ModelField Name="RECORD_USER_NAME" />
                                                                <ext:ModelField Name="QTY" />
                                                                <ext:ModelField Name="UNIT_NAME" />
                                                                <ext:ModelField Name="SHELF_NO" />
                                                                <ext:ModelField Name="SHELF_NO" />
                                                                <ext:ModelField Name="REMARK" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                      <Listeners>
                                                        <BeforeLoad Fn="SemisNodeLoad" />
                                                    </Listeners>
                                                </ext:TreeStore>
                                            </Store>
                                            <ColumnModel ID="columnModel1" runat="server">
                                                <Columns>
                                                     <ext:CheckColumn runat="server" Text="" DataIndex="done" Width="40" Editable="true" StopSelection="false" >
                                                         <Listeners>
                                                             <CheckChange Fn="semisCheckChange"/>
                                                         </Listeners>
                                                     </ext:CheckColumn>
                                                    <ext:TreeColumn ID="SemisTreeCol" runat="server" Text="卡片号" Width="200" DataIndex="CARD_NO" />
                                                    <ext:Column ID="Column30" runat="server" Text="规格" Width="200" Flex="1" DataIndex="MATERIAL_NAME" />
                                                    <ext:Column ID="Column31" runat="server" Text="机台" Width="50" DataIndex="EQUIP_NAME" />
                                                    <ext:Column ID="Column32" runat="server" Text="物料类型" Width="60" DataIndex="MATERIAL_MINOR_NAME" />
                                                    <ext:DateColumn ID="DateColumn1" runat="server" Text="生产日期" Width="100" DataIndex="SHIFT_DATE" Format="yyyy-MM-dd" />
                                                    <ext:Column ID="Column33" runat="server" Text="班次" Width="50" DataIndex="SHIFT_NAME" />
                                                    <ext:Column ID="Column34" runat="server" Text="班组" Width="50" DataIndex="CLASS_NAME" />
                                                    <ext:DateColumn ID="DateColumn2" runat="server" Text="生产开始时间" Width="100" DataIndex="BEGIN_TIME" Format="yyyy-MM-dd HH:mm:ss" />
                                                    <ext:DateColumn ID="DateColumn3" runat="server" Text="生产结束时间" Width="100" DataIndex="END_TIME" Format="yyyy-MM-dd HH:mm:ss" />
                                                    <ext:Column ID="Column35" runat="server" Text="操作人" Width="80" DataIndex="RECORD_USER_NAME" />
                                                    <ext:Column ID="Column36" runat="server" Text="数量" Width="50" DataIndex="QTY" />
                                                    <ext:Column ID="Column37" runat="server" Text="单位" Width="50" DataIndex="UNIT_NAME" />
                                                    <ext:Column ID="Column38" runat="server" Text="工装号" Width="80" DataIndex="SHELF_NO" />
                                                    <ext:Column ID="Column40" runat="server" Text="备注" Width="80" DataIndex="REMARK" />
                                                    <ext:ActionColumn runat="server"
                                                        Text="查看明细"
                                                        Width="60"
                                                        MenuDisabled="true"
                                                        Align="Center">
                                                        <Items>
                                                            <ext:ActionItem Tooltip="查看物料明细信息" Icon="Zoom" Handler="SemisHandler">
                                                                <IsDisabled Handler="return !record.data.leaf;" />
                                                            </ext:ActionItem>
                                                        </Items>
                                                    </ext:ActionColumn>
                                                </Columns>
                                            </ColumnModel>
                                            <%-- <Listeners>
                                                <CellDblClick Fn="semisPanelCellDblClick" />
                                            </Listeners>--%>
                                        </ext:TreePanel>
                                    </Items>
                                    <Listeners>
                                        <Activate Fn="LoadSemisProduction"></Activate>
                                    </Listeners>
                                    
                                </ext:Panel>
                                <ext:Panel runat="server" ID="moldingTab" Title="成型信息" Flex="1" BodyPadding="6" AutoScroll="true" Region="Center">
                                    <Items>
                                        <ext:GridPanel runat="server" ID="moldingPanel" Region="Center">
                                            <Store>
                                                <ext:Store runat="server" ID="moldingStore" PageSize="30">
                                                    <Model>
                                                        <ext:Model ID="model2" runat="server" IDProperty="成型号">
                                                            <Fields>
                                                                <ext:ModelField Name="成型号" />
                                                                <ext:ModelField Name="规格" />
                                                                <ext:ModelField Name="机台" />
                                                                <ext:ModelField Name="生产日期" Type="Date" />
                                                                <ext:ModelField Name="班次" />
                                                                <ext:ModelField Name="班组" />
                                                                <ext:ModelField Name="生产开始时间" Type="Date" />
                                                                <ext:ModelField Name="生产结束时间" Type="Date" />
                                                                <ext:ModelField Name="是否首件胎" />
                                                                <ext:ModelField Name="主机" />
                                                                <ext:ModelField Name="副机" />
                                                                <ext:ModelField Name="帮车" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                            <ColumnModel ID="columnModel3" runat="server">
                                                <Columns>
                                                    <ext:RowNumbererColumn runat="server" />
                                                    <ext:Column ID="Column2" runat="server" Text="成型号" Width="100" DataIndex="成型号" />
                                                    <ext:Column ID="Column15" runat="server" Text="规格" Flex="1" DataIndex="规格" />
                                                    <ext:Column ID="Column16" runat="server" Text="机台" Width="100" DataIndex="机台" />
                                                    <ext:DateColumn ID="Column17" runat="server" Text="生产日期" Width="100" DataIndex="生产日期" Format="yyyy-MM-dd" />
                                                    <ext:Column ID="Column18" runat="server" Text="班次" Width="50" DataIndex="班次" />
                                                    <ext:Column ID="Column19" runat="server" Text="班组" Width="50" DataIndex="班组" />
                                                    <ext:DateColumn ID="Column20" runat="server" Text="生产开始时间" Width="100" DataIndex="生产开始时间" Format="yyyy-MM-dd HH:mm:ss" />
                                                    <ext:DateColumn ID="Column21" runat="server" Text="生产结束时间" Width="100" DataIndex="生产结束时间" Format="yyyy-MM-dd HH:mm:ss" />
                                                    <ext:Column ID="Column22" runat="server" Text="是否首件胎" Width="50" DataIndex="是否首件胎" />
                                                    <ext:Column ID="Column23" runat="server" Text="主机" Width="80" DataIndex="主机" />
                                                    <ext:Column ID="Column24" runat="server" Text="副机" Width="80" DataIndex="副机" />
                                                    <ext:Column ID="Column25" runat="server" Text="帮车" Width="80" DataIndex="帮车" />
                                                </Columns>
                                            </ColumnModel>
                                            <Listeners>
                                                <CellDblClick Fn="moldingPanelCellDblClick" />
                                            </Listeners>
                                            <SelectionModel>
                                                <ext:CheckboxSelectionModel ID="CheckboxSelection_Molding" runat="server" Mode="Multi" />
                                            </SelectionModel>
                                        </ext:GridPanel>
                                    </Items>
                                    <Listeners>
                                        <Activate Fn="LoadMoldingProduction"></Activate>
                                    </Listeners>
                                </ext:Panel>
                                <ext:Panel runat="server" ID="curingTab" Flex="1" Title="硫化信息" BodyPadding="6" AutoScroll="true" Region="Center">
                                    <Items>
                                        <ext:GridPanel runat="server" ID="curingPanel" Region="Center">
                                            <Store>
                                                <ext:Store runat="server" ID="curingStore" PageSize="30">
                                                    <Model>
                                                        <ext:Model ID="model3" runat="server">
                                                            <Fields>
                                                                <ext:ModelField Name="TYRE_NO" />
                                                                <ext:ModelField Name="GREEN_TYRE_NO" />
                                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                                <ext:ModelField Name="EQUIP_NAME" />
                                                                <ext:ModelField Name="EQUIP_POSITION" />
                                                                <ext:ModelField Name="SHIFT_DATE" Type="Date" />
                                                                <ext:ModelField Name="SHIFT_NAME" />
                                                                <ext:ModelField Name="CLASS_NAME" />
                                                                <ext:ModelField Name="BEGIN_TIME" Type="Date" />
                                                                <ext:ModelField Name="END_TIME" Type="Date" />
                                                                <ext:ModelField Name="USER_NAME" />
                                                                <ext:ModelField Name="MOLD_CODE" />
                                                                <ext:ModelField Name="MOLD_USE_AMOUNT" />
                                                                <ext:ModelField Name="BLADDER_USER_AMOUNT" />
                                                                <ext:ModelField Name="IS_FIRST" />
                                                            </Fields>
                                                        </ext:Model>
                                                    </Model>
                                                </ext:Store>
                                            </Store>
                                            <ColumnModel ID="columnModel4" runat="server">
                                                <Columns>
                                                    <ext:RowNumbererColumn runat="server" />
                                                    <ext:Column ID="Column3" runat="server" Text="硫化号" Width="100" DataIndex="TYRE_NO" />
                                                    <ext:Column ID="Column4" runat="server" Text="成型号" Width="100" DataIndex="GREEN_TYRE_NO" />
                                                    <ext:Column ID="Column5" runat="server" Text="规格" Width="200" DataIndex="MATERIAL_NAME" />
                                                    <ext:Column ID="Column6" runat="server" Text="机台" Width="50" DataIndex="EQUIP_NAME" />
                                                    <ext:Column ID="Column7" runat="server" Text="左右模" Width="50" DataIndex="EQUIP_POSITION" />
                                                    <ext:DateColumn ID="Column8" runat="server" Text="生产日期" Width="100" DataIndex="SHIFT_DATE" Format="yyyy-MM-dd" />
                                                    <ext:Column ID="Column9" runat="server" Text="班次" Width="50" DataIndex="SHIFT_NAME" />
                                                    <ext:Column ID="Column10" runat="server" Text="班组" Width="50" DataIndex="CLASS_NAME" />
                                                    <ext:DateColumn ID="Column11" runat="server" Text="硫化开始时间" Width="100" DataIndex="BEGIN_TIME" Format="yyyy-MM-dd HH:mm:ss" />
                                                    <ext:DateColumn ID="Column14" runat="server" Text="硫化结束时间" Width="100" DataIndex="END_TIME" Format="yyyy-MM-dd HH:mm:ss" />
                                                    <ext:Column ID="Column13" runat="server" Text="操作人" Width="80" DataIndex="USER_NAME" />
                                                    <ext:Column ID="Column12" runat="server" Text="模具号" Width="100" DataIndex="MOLD_CODE" />
                                                    <ext:Column ID="Column26" runat="server" Text="模具使用次数" Width="80" DataIndex="MOLD_USE_AMOUNT" />
                                                    <ext:Column ID="Column27" runat="server" Text="胶囊使用次数" Width="80" DataIndex="BLADDER_USER_AMOUNT" />
                                                    <ext:Column ID="Column28" runat="server" Text="是否首件胎" Width="50" DataIndex="IS_FIRST" Flex="1" />
                                                </Columns>
                                            </ColumnModel>
                                            <Listeners>
                                                <CellDblClick Fn="curingPanelCellDblClick" />
                                            </Listeners>
                                        </ext:GridPanel>
                                    </Items>
                                    <Listeners>
                                        <Activate Fn="LoadCuringProduction"></Activate>
                                    </Listeners>
                                </ext:Panel>
                            </Items>
                        </ext:TabPanel>
                    </Items>
                </ext:Panel>
                <ext:Hidden runat="server" ID="refreshHidden" />
                <ext:Hidden runat="server" ID="hiddenMaterialMajorType"></ext:Hidden>
                <ext:Hidden runat="server" ID="hiddenSourceProcessId"></ext:Hidden>
                <ext:Hidden runat="server" ID="hiddenTargetProcessId"></ext:Hidden>
                <ext:Hidden runat="server" ID="hiddenSemisTrackBarcode"></ext:Hidden>
                 <ext:Hidden runat="server" ID="hiddenSemisTrackRoot"></ext:Hidden>
                <ext:Hidden runat="server" ID="hiddenShelfBarcode"></ext:Hidden>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
