<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FqfFcheckDefectPercent.aspx.cs" Inherits="Plugins_Quality_Fcheck_FqfFcheckDefectPercent" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell
        {
        	background-color: #B0FFBA !important;
        }
    </style>
    <script type="text/javascript">

        var pnlListFresh = function () {
           
            App.storeDetail.currentPage = 1;
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
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
        OnClick="btnExportSubmit_Click" />
    <ext:ResourceManager ID="rmFcheckInfo" runat="server" />
    <ext:Viewport ID="vpFcheckInfo" runat="server" Layout="border">
        <Items>
            <ext:Panel ID="pnFcheckInfo" runat="server" Region="North" Height="90">
                <TopBar>
                    <ext:Toolbar runat="server" ID="tbFcheckInfo">
                        <Items>
                            <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                <DirectEvents>
                                    <Click OnEvent="btnQuary_Click" Timeout="300000">
                                        <EventMask ShowMask="true" Msg="查询中..." />
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
                            <ext:Hidden runat="server" ID="HiddenDefectName" Text=""></ext:Hidden>
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
                                    <%--<ext:TextField ID="txtTyreNo" runat="server" FieldLabel="胎号" LabelAlign="Right" />--%>
                                     <ext:TextField ID="txtMaterialName" runat="server" FieldLabel="规格" LabelAlign="Right" Editable="false"></ext:TextField>
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
                                    <ext:ComboBox ID="cbxGrade" runat="server" FieldLabel="质检品级" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                </Items>
                            </ext:Container>
                             <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                Padding="5">
                                <Items>
                                     <ext:ComboBox ID="cbxDefect" runat="server" FieldLabel="病疵" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25" Hidden="true"
                                Padding="5">
                                <Items>
                                    <ext:ComboBox ID="cbxShift" runat="server" FieldLabel="质检班次" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                    <ext:ComboBox ID="cbxClass" runat="server" FieldLabel="质检班组" LabelAlign="Right" Editable="false">
                                    </ext:ComboBox>
                                </Items>
                            </ext:Container>
                        </Items>
                        <Listeners>
                            <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                        </Listeners>
                    </ext:FormPanel>
                </Items>
            </ext:Panel>

                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit"  Height="180" MarginsSummary="0 5 0 5">
                    <Items>
                        <ext:GridPanel ID="pnlDefectList" runat="server">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="10">
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="DEFECTNAME" />
                                                <ext:ModelField Name="DEFECT_COUNT" />
                                                <ext:ModelField Name="RATIO" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:Column ID="DEFECT" runat="server" Text="病疵" DataIndex="DEFECTNAME" Width="300" />
                                    <ext:Column ID="DEFECTCOUNT" runat="server" Text="数量" DataIndex="DEFECT_COUNT" Width="120" />
                                    <ext:Column ID="DEFECTRATIO" runat="server" Text="病疵比率" DataIndex="RATIO" Width="120" />
                                </Columns>
                            </ColumnModel>
                            <SelectionModel>
                                <ext:RowSelectionModel ID="rowSelectMuti" runat="server" Mode="Single">
                                    <Listeners>
                                        <Select Handler="#{storeDetail}.reload();" Buffer="250" />
                                    </Listeners>
                                </ext:RowSelectionModel>
                            </SelectionModel>
                            <View>
                          <%--      <ext:GridView ID="gvRows" runat="server">
                                    <GetRowClass Fn="SetRowClass" />
                                </ext:GridView>--%>
                            </View>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="pnlDetail" runat="server" Region="South" Title="检验明细数据" Height="200" Icon="Basket" Layout="Fit" Collapsible="true" 
                Split="true" MarginsSummary="0 5 5 5">
                    <Items>
                        <ext:GridPanel ID="pnlDetailList" runat="server" MarginsSummary="0 5 5 5">
                            <Store>
                                <ext:Store ID="storeDetail" runat="server" PageSize="10"  OnReadData="storeDetail_ReadData">
                                    <Model>
                                        <ext:Model ID="modelDetail" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="TYREID" />
                                                <ext:ModelField Name="TYRE_NO" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="GRADENAME" />
                                                <ext:ModelField Name="DEFECTNAME" />
                                                <ext:ModelField Name="RECORD_TIME" Type="Date"/>
                                                <ext:ModelField Name="USER_NAME" />
                                                <ext:ModelField Name="SHIFT_NAME" />
                                                <ext:ModelField Name="CLASS_NAME" />
                                                <ext:ModelField Name="CPP_EQUIP" />
                                                <ext:ModelField Name="LR_FLAG" />
                                                <ext:ModelField Name="CPP_SHIFT" />
                                                <ext:ModelField Name="CPP_NAME" />
                                                <ext:ModelField Name="BPM_EQUIP" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                    <Parameters>
                                        <ext:StoreParameter Name="DEFECTNAME" Mode="Raw" Value="#{pnlDefectList}.getSelectionModel().hasSelection() ? #{pnlDefectList}.getSelectionModel().getSelection()[0].data.DEFECTNAME : -1" />
                                    </Parameters>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModelDetail" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="TYREID" runat="server" Text="胎胚号" DataIndex="TYREID" Flex="1" />
                                    <ext:Column ID="TYRE_NO" runat="server" Text="硫化号" DataIndex="TYRE_NO" Flex="1" />
                                    <ext:Column ID="MATERIAL_NAME_DETAIL" runat="server" Text="规格" DataIndex="MATERIAL_NAME" Flex="1"/>
                                    <ext:Column ID="GRADENAME" runat="server" Text="品级" DataIndex="GRADENAME" Flex="1" />
                                    <ext:Column ID="DEFECTNAME" runat="server" Text="病疵" DataIndex="DEFECTNAME" Flex="1" />
                                    <ext:Column ID="USER_NAME" runat="server" Text="质检员" DataIndex="USER_NAME" Flex="1" />
                                    <ext:Column ID="Column2" runat="server" Text="硫化机台" DataIndex="CPP_EQUIP" Flex="1" />
                                    <ext:Column ID="Column3" runat="server" Text="硫化左右模" DataIndex="LR_FLAG" Flex="1" />
                                    <ext:Column ID="Column4" runat="server" Text="硫化班次" DataIndex="CPP_SHIFT" Flex="1" />
                                    <ext:Column ID="Column5" runat="server" Text="硫化工" DataIndex="CPP_NAME" Flex="1" />
                                    <ext:Column ID="Column1" runat="server" Text="成型机台" DataIndex="BPM_EQUIP" Flex="1" />
                                    <ext:Column ID="SHIFT_NAME" runat="server" Text="班次" DataIndex="SHIFT_NAME" Hidden="true" Flex="1" />
                                    <ext:Column ID="CLASS_NAME" runat="server" Text="班组" DataIndex="CLASS_NAME" Hidden="true" Flex="1" />
                                    <ext:DateColumn ID="F_RECORD_TIME" runat="server" Text="质检时间" DataIndex="RECORD_TIME" Flex="1" Format="yyyy-MM-dd HH:mm:ss"/>
                                </Columns>
                            </ColumnModel>
                          <%--  <SelectionModel>
                                <ext:RowSelectionModel ID="rowSelectMutiDetail" runat="server" Mode="Single" />
                            </SelectionModel>--%>
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
                                                <Select Handler="#{pnlDetailList}.storeDetail.pageSize = parseInt(this.getValue(), 10); #{pageToolBar}.doRefresh(); return false;" />
                                            </Listeners>
                                        </ext:ComboBox>
                                    </Items>
                                    <Items>
                                        <ext:TextField ID="txtTotalNum" runat="server" LabelAlign="Right" ReadOnly="true" />
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
