<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BqcPercent.aspx.cs" Inherits="Plugins_Molding_Quality_BqcPercent" %>
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
            if (App.txtBeginDate.getValue() > App.txtEndDate.getValue()) {
                Ext.Msg.alert('操作', '开始时间不能大于结束时间！');
                return false;
            }
            //else {
            //    if (App.txtBeginTime.getValue() > App.txtEndTime.getValue()) {
            //        Ext.Msg.alert('操作', '开始时间不能大于结束时间！');
            //        return false;
            //    }
           // }
            App.store1.currentPage = 1;
            App.pageToolbar1.doRefresh();
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
    <ext:ResourceManager ID="rmQCPercentInfo" runat="server" />
    <ext:Viewport ID="vpQCPercentInfo" runat="server" Layout="border">
        <Items>
            <ext:Panel ID="pnQCPercentInfo" runat="server" Region="North" Height="90">
                <TopBar>
                    <ext:Toolbar runat="server" ID="tbQCPercentInfo">
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
                            <ext:Hidden runat="server" ID="hiddenMaterialName" Text=""></ext:Hidden>
                            <ext:ToolbarSeparator ID="tsEnd" />
                            <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                            <ext:ToolbarFill ID="tfEnd" />
                        </Items>
                    </ext:Toolbar>
                </TopBar>
                <Items>
                    <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                        <Items>
                            <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                Padding="5">
                                <Items>
                                      <ext:FieldContainer runat="server" FieldLabel="生产开始日期" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                           <%--     <ext:TimeField ID="txtBeginTime" runat="server" width="80" Editable="true" />--%>
                                            </Items>
                                        </ext:FieldContainer>
                                    <%--<ext:TextField ID="txtTyreNo" runat="server" FieldLabel="胎号" LabelAlign="Right" />--%>
                                     <ext:TextField ID="txtMaterialName" runat="server" FieldLabel="规格" LabelAlign="Right" Editable="false"></ext:TextField>
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                Padding="5">
                                <Items>
                                    <ext:FieldContainer runat="server" FieldLabel="生产结束日期" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                               <%-- <ext:TimeField ID="txtEndTime" runat="server" width="80" Editable="true" />--%>
                                            </Items>
                                    </ext:FieldContainer>
                                   <ext:ComboBox ID="cbxEquip" runat="server" FieldLabel="成型机台" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                Padding="5">
                                <Items>
                                    <ext:ComboBox ID="cbxShift" runat="server" FieldLabel="成型班次" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                    <ext:ComboBox ID="cbxClass" runat="server" FieldLabel="成型班组" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                </Items>
                            </ext:Container>
                        </Items>
                        <Listeners>
                            <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                        </Listeners>
                    </ext:FormPanel>
                </Items>
            </ext:Panel>
                <ext:Panel ID="Panel1" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5">
                    <Items>
                        <ext:GridPanel ID="pnlRatioList" runat="server">
                            <View><ext:GridView EnableTextSelection="true"></ext:GridView></View>
                            <Store>
                                <ext:Store ID="store1" runat="server" PageSize="15">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model1" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="MATERIAL_CODE" />
                                                <ext:ModelField Name="MATERIAL_ID" />
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
                                    <ext:Column ID="MATERIAL_CODE" runat="server" Text="胎胚规格" DataIndex="MATERIAL_CODE" Flex="1" />
                                    <ext:Column ID="TOTAL_COUNT" runat="server" Text="生产数量" DataIndex="TOTAL_COUNT" Flex="1" />
                                    <ext:Column ID="QUALIFY_COUNT" runat="server" Text="合格数" DataIndex="QUALIFY_COUNT" Flex="1" />
                                    <ext:Column ID="RATIO" runat="server" Text="合格率" DataIndex="RATIO" Flex="1" />
                                </Columns>
                            </ColumnModel>
                            <SelectionModel>
                                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server" Mode="Single">
                                    <Listeners>
                                        <Select Handler="#{storeDetail}.reload();" Buffer="250" />
                                    </Listeners>
                                </ext:RowSelectionModel>
                            </SelectionModel>
                            <View>
                            <%--    <ext:GridView ID="GridView1" runat="server">
                                    <GetRowClass Fn="SetRowClass" />
                                </ext:GridView>--%>
                            </View>
                               <BottomBar>
                                <ext:PagingToolbar ID="pageToolbar1" runat="server">
                                    <Items>
                                        <ext:Label ID="Label2" runat="server" Text="每页条数:" Hidden="true"/>
                                        <ext:ToolbarSpacer ID="ToolbarSpacer2" runat="server" Width="10" />
                                        <ext:ComboBox ID="ComboBox2" runat="server" Width="80" Hidden="true">
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
                                                <Select Handler="#{pnlRatioList}.store1.pageSize = parseInt(this.getValue(), 10); #{pageToolbar1}.doRefresh(); return false;" />
                                            </Listeners>
                                        </ext:ComboBox>
                                    </Items>
                                    <Plugins>
                                        <ext:ProgressBarPager ID="ProgressBarPager1" runat="server" />
                                    </Plugins>
                                </ext:PagingToolbar>
                            </BottomBar>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="pnlDetail" runat="server" Region="South" Title="检验明细数据" Height="200" Icon="Basket" Layout="Fit" Collapsible="true" 
                Split="true" MarginsSummary="0 5 5 5">
                    <Items>
                        <ext:GridPanel ID="pnlDetailList" runat="server" MarginsSummary="0 5 5 5">
                            <View><ext:GridView EnableTextSelection="true"></ext:GridView></View>
                            <Store>
                                <ext:Store ID="storeDetail" runat="server" PageSize="10"  OnReadData="storeDetail_ReadData">
                                    <Model>
                                        <ext:Model ID="modelDetail" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="TYREID" />
                                                <ext:ModelField Name="MATERIAL_CODE" />
                                                <ext:ModelField Name="MATERIAL_ID" />
                                                <ext:ModelField Name="GRADE_NAME" />
                                                <ext:ModelField Name="DEFECT_NAME" />
                                                <ext:ModelField Name="RECORD_TIME" Type="Date"/>
                                                <ext:ModelField Name="USER_NAME" />
                                                <ext:ModelField Name="EMP1_NAME" />
                                                <ext:ModelField Name="SHIFT_NAME" />
                                                <ext:ModelField Name="CLASS_NAME" />
                                                <ext:ModelField Name="EQUIP_NAME" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                    <Parameters>
                                        <ext:StoreParameter Name="MATERIAL_ID" Mode="Raw" Value="#{pnlRatioList}.getSelectionModel().hasSelection() ? #{pnlRatioList}.getSelectionModel().getSelection()[0].data.MATERIAL_ID : -1" />
                                    </Parameters>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModelDetail" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="TYREID" runat="server" Text="胎胚号" DataIndex="TYREID" Flex="1" />
                                    <ext:Column ID="MATERIAL_CODE_DETAIL" runat="server" Text="规格" DataIndex="MATERIAL_CODE" Flex="1"/>
                                    <ext:Column ID="GRADE_NAME" runat="server" Text="品级" DataIndex="GRADE_NAME" Flex="1" />
                                    <ext:Column ID="DEFECTNAME" runat="server" Text="病疵" DataIndex="DEFECT_NAME" Flex="1" />
                                    <ext:Column ID="USER_NAME" runat="server" Text="质检人" DataIndex="USER_NAME" Flex="1" />
                                    <ext:Column ID="EMP1_NAME" runat="server" Text="主机手" DataIndex="EMP1_NAME" Flex="1" />
                                    <ext:Column ID="SHIFT_NAME" runat="server" Text="生产班次" DataIndex="SHIFT_NAME"  Flex="1" />
                                    <ext:Column ID="CLASS_NAME" runat="server" Text="生产班组" DataIndex="CLASS_NAME"  Flex="1" />
                                    <ext:Column ID="EQUIP_NAME" runat="server" Text="成型机台" DataIndex="EQUIP_NAME"  Flex="1" />
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
