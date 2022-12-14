<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BqcRecord.aspx.cs" Inherits="Plugins_Curing_Quality_CqcRecord" %>

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
            if (App.txtBeginDate.getValue() > App.txtEndDate.getValue()) {
                Ext.Msg.alert('操作', '开始时间不能大于结束时间！');
                return false;
            }
            ////else 
            //if(App.txtBeginDate.getValue() + App.txtBeginTime.getValue() > App.txtEndDate.getValue() + App.txtEndTime.getValue()) {
            //        Ext.Msg.alert('操作', '开始时间不能大于结束时间！');
            //        return false;
            //}
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }
    </script>
</head>
<body>    
    <form id="form1" runat="server">
       <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
        OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmQCRecord" runat="server" />
        <ext:Viewport ID="vpQCRecord" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnMEquipControl" runat="server" Region="North" Height="120">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbMEquipControl">
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
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1"   Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" Width="80" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txtGreenTyreNo" runat="server" FieldLabel="胎胚号" Flex="1" LabelAlign="Right" Editable="false">
                                        </ext:TextField>  
                                        <ext:TextField ID="txtCuringNo" runat="server" FieldLabel="硫化号" Flex="1" LabelAlign="Right" Editable="false">
                                        </ext:TextField>                             
                                        </Items>
                                </ext:Container>

                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1"   Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" Width="80" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txtMaterialName" runat="server" FieldLabel="规格" LabelAlign="Right" Flex="1">
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>

                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxMoldingEquip" runat="server" FieldLabel="成型机台名称" LabelAlign="Right" Editable="true" EnableKeyEvents="true">
                                        </ext:ComboBox>
                                        <ext:ComboBox ID="cbxCuringEquip" runat="server" FieldLabel="硫化机台名称" LabelAlign="Right" Editable="true" EnableKeyEvents="true">
                                        </ext:ComboBox>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                       <ext:TextField ID="TxtField1" runat="server" FieldLabel="质检人" Flex="1" LabelAlign="Right" Editable="false">
                                        </ext:TextField>  
                                        <ext:ComboBox ID="cbxDelectNo" runat="server" FieldLabel="病疵" LabelAlign="Right" Editable="false" Hidden="true">
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

                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5" Title="胎胚质检信息">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <View><ext:GridView EnableTextSelection="true"></ext:GridView></View>
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="15">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">                                            
                                            <Fields>                                                
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="GREEN_TYRE_NO" />
                                                <ext:ModelField Name="TYREID" />
                                                <ext:ModelField Name="MATERIAL_CODE" />
                                                <ext:ModelField Name="C_NAME" />
                                                <ext:ModelField Name="CB_TIME" />
                                                <ext:ModelField Name="CE_TIME"   />
                                                <ext:ModelField Name="CU_NAME" />
                                                <ext:ModelField Name="M_NAME" />
                                                <ext:ModelField Name="MB_TIME" />
                                                <ext:ModelField Name="ME_TIME"  />
                                                <ext:ModelField Name="MU_NAME1" />
                                                <ext:ModelField Name="MU_NAME2" />
                                                <ext:ModelField Name="MU_NAME3" />
                                                <ext:ModelField Name="DEFECT_ID2" />
                                                <ext:ModelField Name="GRADENAME" />
                                                 <ext:ModelField Name="C_UESR_NAME" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>

                            <ColumnModel ID="colModel" runat="server">                              
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                                    <ext:Column ID="OBJID" runat="server" Text="" DataIndex="OBJID" Width="100" Hidden="TRUE" />
                                    <ext:Column ID="GREEN_TYRE_NO" runat="server" Text="胎胚号" Selectable="true" DataIndex="GREEN_TYRE_NO" Width="100" />
                                    <ext:Column ID="TYREID" runat="server" Text="硫化号" Selectable="true" DataIndex="TYREID" Width="100" />
                                    <ext:Column ID="MATERIAL_CODE" runat="server" Text="规格" DataIndex="MATERIAL_CODE" Width="300" />
                                    <ext:Column ID="C_NAME" runat="server" Text="硫化机台号" DataIndex="C_NAME" Width="80" />
                                    <ext:Column ID="CB_TIME" runat="server" Text="硫化开始时间" DataIndex="CB_TIME" Width="180" Format="yyyy-MM-dd "/>
                                    <ext:Column ID="CE_TIME" runat="server" Text="硫化结束时间" DataIndex="CE_TIME" Width="180" Format="yyyy-MM-dd " />
                                    <ext:Column ID="CU_NAME" runat="server" Text="硫化工" DataIndex="CU_NAME" Width="100" />
                                    <ext:Column ID="M_NAME" runat="server" Text="成型机台号" DataIndex="M_NAME" Width="100" />
                                    <ext:Column ID="MB_TIME" runat="server" Text="成型生产开始时间" DataIndex="MB_TIME" Width="180" Format="yyyy-MM-dd "  />
                                    <ext:Column ID="ME_TIME" runat="server" Text="成型生产结束时间" DataIndex="ME_TIME" Width="180" Format="yyyy-MM-dd "  />
                                    <ext:Column ID="MU_NAME1" runat="server" Text="成型主机手" DataIndex="MU_NAME1" Width="80" />
                                    <ext:Column ID="MU_NAME2" runat="server" Text="成型副机手" DataIndex="MU_NAME2" Width="80" />
                                    <ext:Column ID="MU_NAME3" runat="server" Text="帮车" DataIndex="MU_NAME3" Width="80" />
                                    <ext:Column ID="C_UESR_NAME" runat="server" Text="质检人" DataIndex="C_UESR_NAME" Width="120" />
                                    <ext:SummaryColumn ID="DEFECT_ID2" runat="server" Text="病疵" DataIndex="DEFECT_ID2" Width="250" SummaryType="Count">
                                         <SummaryRenderer Handler="return '当前页总计：共' + value + '条'"> </SummaryRenderer>
                                    </ext:SummaryColumn>
                                    
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
                            <Features>
                                <ext:Summary runat="server"></ext:Summary>
                            </Features>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
