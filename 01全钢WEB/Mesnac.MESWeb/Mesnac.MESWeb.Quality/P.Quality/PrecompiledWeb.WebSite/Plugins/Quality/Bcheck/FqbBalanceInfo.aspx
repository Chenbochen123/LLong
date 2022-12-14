<%@ page language="C#" autoeventwireup="true" inherits="Plugins_Quality_Bcheck_FqbBalanceInfo, Mesnac.Quality.WebSite" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

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
            App.storeData.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }
        var prepareToolbar = function (grid, toolbar, rowIndex, record) {
            if (record.get("FiledFlag") == "1") {
                toolbar.items.getAt(0).hide();
                toolbar.items.getAt(1).hide();
            }
            else if (record.get("LockedFlag") == "1") {
                toolbar.items.getAt(0).hide();
                toolbar.items.getAt(1).hide();
            }
        };

        var startTrack = function () {
            this.checkboxes = [];
            var cb;

            Ext.select(".x-form-item", false).each(function (checkEl) {
                cb = Ext.getCmp(checkEl.dom.id.selected);
                cb.setValue(false);
                this.rowselect.push(cb);
            }, this);
        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmFcheckInfo" runat="server" />
        <ext:Viewport ID="vpFcheckInfo" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnFcheckInfo" runat="server" Region="North" Height="120">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbFcheckInfo">
                            <Items>
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <DirectEvents>
                                        <Click OnEvent="btnQuary_Click" Timeout="120000">
                                            <EventMask ShowMask="true" Msg="查询中..."></EventMask>
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
                                <ext:Hidden  runat="server" ID="hiddenMaterialName" Text=" "></ext:Hidden>
                                <ext:ToolbarSeparator ID="tsEnd" />
                                <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                                <ext:ToolbarFill ID="tfEnd" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txtTyreNo" runat="server" FieldLabel="硫化号" LabelAlign="Right" />
                                        <ext:ComboBox ID="cbxEquipMolding" runat="server" FieldLabel="成型机台" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                       <ext:TextField ID="txtGreenTyreNo" runat="server" FieldLabel="胎胚号" LabelAlign="Right" />
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxGrade" runat="server" FieldLabel="质检品级" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                        <ext:TextField ID="txtMaterialName" runat="server" FieldLabel="规格" LabelAlign="Right" Editable="false"></ext:TextField>
                                    </Items>
                                </ext:Container>
                                 <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxEquip" runat="server" FieldLabel="机台" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                    </Items>
                                     <Items>
                                        <ext:ComboBox ID="cbxEquipCuring" runat="server" FieldLabel="硫化机台" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                    </Items>
                                </ext:Container>
                                
                            </Items>
                            <Listeners>
                                <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="Panel1" runat="server" Region="Center" Height="300" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5">
                    <Items>
                        <ext:GridPanel ID="pnlRatioList" runat="server">
                            <Store>
                                <ext:Store ID="storeRatio" runat="server" PageSize="10">
                                    <Model>
                                        <ext:Model ID="model1" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="TOTAL_COUNT" />
                                                <ext:ModelField Name="QUALIFY_COUNT" />
                                                <ext:ModelField Name="RATIO" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModel1" runat="server">
                                <Columns>
                                    <ext:Column ID="MATERIAL_NAME" runat="server" Text="轮胎规格" DataIndex="MATERIAL_NAME" Flex="1" />
                                    <ext:Column ID="TOTAL_COUNT" runat="server" Text="检测数量" DataIndex="TOTAL_COUNT" Flex="1" />
                                    <ext:Column ID="QUALIFY_COUNT" runat="server" Text="合格数" DataIndex="QUALIFY_COUNT" Flex="1" />
                                    <ext:Column ID="RATIO" runat="server" Text="合格率" DataIndex="RATIO" Flex="1" />
                                </Columns>
                            </ColumnModel>
                              <SelectionModel>
                                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" Mode="Single">
                                    <Listeners>
                                        <Select Handler="#{storeData}.reload();" Buffer="250" />
                                    </Listeners>
                                </ext:RowSelectionModel>
                            </SelectionModel>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="pnlDetail" runat="server" Region="South" Title="检验数据" Height="250" Width="600" Icon="Basket" Layout="Fit" Collapsible="true"
                    Split="true" MarginsSummary="0 5 5 5" AutoScroll="true">
                    <Items>
                        <ext:GridPanel ID="pnlDetailList" runat="server" MarginsSummary="0 5 5 5">
                            <Store>
                                <ext:Store ID="storeData" runat="server" PageSize="10" OnReadData="storeDetail_ReadData">
                                  <%--  <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>--%>
                                    <Model>
                                        <ext:Model ID="modelDetail" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="TYRE_ID" />
                                                <ext:ModelField Name="GREEN_TYRE_NO" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="M_EQUIP_NAME" />
                                                <ext:ModelField Name="M_CLASS_NAME" />
                                                <ext:ModelField Name="C_EQUIP_NAME" />
                                                <ext:ModelField Name="C_CLASS_NAME" />
                                                <ext:ModelField Name="GRADENAME" />
                                                <ext:ModelField Name="RECORD_TIME" Type="Date" />
                                                <ext:ModelField Name="UP_AMOUNT" />
                                                <ext:ModelField Name="LOWER_AMOUNT" />
                                                <ext:ModelField Name="UPLOWER_AMOUNT" />
                                                <ext:ModelField Name="STATIC_AMOUNT" />
                                                <ext:ModelField Name="COUPLE_AMOUNT" />
                                                <ext:ModelField Name="RCOA_AMOUNT" />
                                                <ext:ModelField Name="UPRANK" />
                                                <ext:ModelField Name="LOWERRANK" />
                                                <ext:ModelField Name="UPLOWERRANK" />
                                                <ext:ModelField Name="STATICRANK" />
                                                <ext:ModelField Name="COUPLERANK" />
                                                <ext:ModelField Name="RCOARANK" />
                                                <ext:ModelField Name="STANDARD" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                    <Parameters>
                                        <ext:StoreParameter Name="MATERIAL_NAME" Mode="Raw" Value="#{pnlRatioList}.getSelectionModel().hasSelection() ? #{pnlRatioList}.getSelectionModel().getSelection()[0].data.MATERIAL_NAME : -1" />
                                    </Parameters>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModelDetail" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="TYRE_ID" runat="server" Text="硫化号" DataIndex="TYRE_ID" Width="100" />
                                    <ext:Column ID="GREEN_TYRE_NO" runat="server" Text="胎胚号" DataIndex="GREEN_TYRE_NO" Width="100" />
                                    <ext:Column ID="MATERIAL_NAME_DETAIL" runat="server" Text="规格" DataIndex="MATERIAL_NAME" Width="250" />
                                    <ext:Column ID="EQUIP_NAME" runat="server" Text="检测机台" DataIndex="EQUIP_NAME" Width="100" />
                                    <ext:Column ID="M_EQUIP_NAME" runat="server" Text="成型机台" DataIndex="M_EQUIP_NAME" Width="100" />
                                    <ext:Column ID="M_CLASS_NAME" runat="server" Text="成型班组" DataIndex="M_CLASS_NAME" Width="60" />
                                    <ext:Column ID="C_EQUIP_NAME" runat="server" Text="硫化机台" DataIndex="C_EQUIP_NAME" Width="100" />
                                    <ext:Column ID="C_CLASS_NAME" runat="server" Text="硫化班组" DataIndex="C_CLASS_NAME" Width="60" />
                                    <ext:Column ID="UFRANK" runat="server" Text="品级" DataIndex="GRADENAME" Width="100" />
                                    <ext:DateColumn ID="F_RECORD_TIME" runat="server" Text="检测时间" DataIndex="RECORD_TIME" Width="200" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="UP_AMOUNT" runat="server" Text="上动平衡量" DataIndex="UP_AMOUNT" Width="100" />
                                    <ext:Column ID="UPRANK" runat="server" Text="上动平衡等级" DataIndex="UPRANK" Width="100" />
                                    <ext:Column ID="LOWER_AMOUNT" runat="server" Text="下动平衡量" DataIndex="LOWER_AMOUNT" Width="100" />
                                    <ext:Column ID="LOWERRANK" runat="server" Text="下动平衡等级" DataIndex="LOWERRANK" Width="100" />
                                    <ext:Column ID="UPLOWER_AMOUNT" runat="server" Text="上下动平衡量" DataIndex="UPLOWER_AMOUNT" Width="100" />
                                    <ext:Column ID="UPLOWERRANK" runat="server" Text="上下动平衡等级" DataIndex="UPLOWERRANK" Width="100" />
                                    <ext:Column ID="STATIC_AMOUNT" runat="server" Text="静合成量值" DataIndex="STATIC_AMOUNT" Width="100" />
                                    <ext:Column ID="STATICRANK" runat="server" Text="静合成等级" DataIndex="STATICRANK" Width="100" />
                                    <ext:Column ID="COUPLE_AMOUNT" runat="server" Text="偶合成量值" DataIndex="COUPLE_AMOUNT" Width="100" />
                                    <ext:Column ID="COUPLERANK" runat="server" Text="偶合成等级" DataIndex="COUPLERANK" Width="100" />
                                    <ext:Column ID="RCOA_AMOUNT" runat="server" Text="径向跳动" DataIndex="RCOA_AMOUNT" Width="100" />
                                    <ext:Column ID="RCOARANK" runat="server" Text="径向跳动等级" DataIndex="RCOARANK" Width="100" />
                                    <ext:Column ID="STANDARD" runat="server" Text="判级标准" DataIndex="STANDARD" Width="100" />
                                </Columns>
                            </ColumnModel>
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
                                        <ext:Label ID="Label1" runat="server" Text="每页条数:" Hidden="true"/>
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
