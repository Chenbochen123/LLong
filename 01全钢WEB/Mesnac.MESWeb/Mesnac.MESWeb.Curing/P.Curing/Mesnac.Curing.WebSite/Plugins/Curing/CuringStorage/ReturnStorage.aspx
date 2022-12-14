<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ReturnStorage.aspx.cs" Inherits="Plugins_Curing_CuringStorage_ReturnStorage" %>

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
                <ext:Panel ID="pnMEquipControl" runat="server" Region="North" Height="100">
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
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        </Items>
                                </ext:Container>
                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                       <Items>
                                        <ext:TextField ID="txtGreenTyreNo" runat="server" FieldLabel="胎胚号" Flex="1" LabelAlign="Right" Editable="false">
                                        </ext:TextField>      
                                        <ext:TextField ID="txtUser" runat="server" FieldLabel="退库人" Flex="1" LabelAlign="Right" Editable="false">
                                        </ext:TextField>                        
                                       </Items>
                                </ext:Container>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                       <ext:TextField ID="TextField1" runat="server" FieldLabel="胎胚车号" Flex="1" LabelAlign="Right" Editable="false">
                                       </ext:TextField>                            
                                    </Items>
                                </ext:Container>

                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtMaterialName" runat="server" FieldLabel="规格" LabelAlign="Right" Flex="1">
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>
                            </Items>
                            <Listeners>
                                <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>

                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5" Title="胎胚退库信息">
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
                                                <ext:ModelField Name="TOOLING_BARCODE" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="CURING_STORE_NAME" />
                                                <ext:ModelField Name="CURING_STORE_PLACE_NAME"   />
                                                <ext:ModelField Name="MOLDING_STORE_NAME" />
                                                <ext:ModelField Name="MOLDING_STORE_PLACE_NAME" />
                                                <ext:ModelField Name="OPER_TIME"  />
                                                <ext:ModelField Name="USER_NAME"  />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">                              
                                
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                                    <ext:Column ID="OBJID" runat="server" Text="" DataIndex="OBJID" Width="100" Hidden="TRUE" />
                                    <ext:Column ID="GREEN_TYRE_NO" runat="server" Text="胎胚号" Selectable="true" DataIndex="GREEN_TYRE_NO" Width="150" Align="Center" />
                                    <ext:Column ID="TOOLING_BARCODE" runat="server" Text="胎胚车号" DataIndex="TOOLING_BARCODE" Width="100" Align="Center"/>
                                    <ext:Column ID="MATERIAL_NAME" runat="server" Text="物料名" DataIndex="MATERIAL_NAME" Width="200" Align="Center" />
                                    <ext:Column ID="CURING_STORE_NAME" runat="server" Text="硫化库" DataIndex="CURING_STORE_NAME"  Align="Center"/>
                                    <ext:Column ID="CURING_STORE_PLACE_NAME" runat="server" Text="硫化库位" DataIndex="CURING_STORE_PLACE_NAME"  Align="Center"/>
                                    <ext:Column ID="MOLDING_STORE_NAME" runat="server" Text="成型库" DataIndex="MOLDING_STORE_NAME" Align="Center" />
                                    <ext:Column ID="MOLDING_STORE_PLACE_NAME" runat="server" Text="成型库位" DataIndex="MOLDING_STORE_PLACE_NAME"  Align="Center"/>
                                    <ext:Column ID="OPER_TIME" runat="server" Text="退库时间" DataIndex="OPER_TIME"  Width="200" Align="Center"/>
                                    <ext:Column ID="USER_NAME" runat="server" Text="退库人" DataIndex="USER_NAME" Align="Center"/>
                                    <ext:CommandColumn ID="commandCol" runat="server" Width="200" Text="操作" >
                                      <Commands >
                                            <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改" >
                                            </ext:GridCommand>
                                            <ext:CommandSeparator />
                                            <ext:GridCommand Icon="Delete" CommandName="Delete" Text="删除">
                                            </ext:GridCommand>
                                      </Commands>
                              <%--  <PrepareToolbar Fn="prepareToolbar" />
                                <Listeners>
                                    <Command Handler="return commandcolumn_click(command, record);" />
                                </Listeners>--%>
                            </ext:CommandColumn>
                                
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
