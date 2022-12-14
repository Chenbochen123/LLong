<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OutStoreTyreNo.aspx.cs" Inherits="Plugins_Settlement_Settlement_OutStore_OutStoreTyreNo" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>/resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>/resources/css/main.css" />
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
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Button  ID="btnExportSubmit" runat="server" Text="Button" Style="display:none" OnClick="btnExportSubmit_Click"/>
        <ext:ResourceManager ID="rmOutStoreTyreNo" runat="server"></ext:ResourceManager>
        <ext:Viewport ID="vpOutStoreTyreNo" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnOutStoreTyreNo" runat="server"  Region="North" Height="120">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbOutStoreTyreNo" >
                            <Items>
                                <ext:Button ID="btnSearch" runat="server" Icon="Find" Text="查询">
                                    <Listeners>
                                        <Click Fn="pnlListFresh"></Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator></ext:ToolbarSeparator>
                                <ext:Button ID="btnExport" runat="server" Icon="PageExcel" Text="导出EXCEL">
                                    <ToolTips>
                                        <ext:ToolTip ID="tooltip1" runat="server" Html="点击将结果导出到EXCEL中"></ext:ToolTip>
                                    </ToolTips>  
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();"></Click>
                                    </Listeners>
                                </ext:Button>
                                <%--<ext:Hidden ID="hiddenMaterialName" runat="server"></ext:Hidden>--%>
                                <ext:ToolbarSpacer ID="tspacerEnd"></ext:ToolbarSpacer>
                                <ext:ToolbarFill ID="tfEnd"></ext:ToolbarFill>
                              </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="开始日期" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" ></ext:DateField>
                                            </Items>
                                        </ext:FieldContainer>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="结束日期" Layout="HBoxLayout" LabelAlign="Right">
                                                <Items>
                                                    <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                </Items>
                                        </ext:FieldContainer>
                                        
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtCustomerName" runat="server" FieldLabel="客户名称" LabelAlign="Right" Editable="true" EnableKeyEvents="true">
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container5" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtMaterialName" runat="server" FieldLabel="出库规格" LabelAlign="Right" Flex="1">
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>
                            </Items>
                            <Listeners>
                                <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                        <ext:FormPanel ID="FormPanel1" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth="1"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtTyreNo" runat="server" FieldLabel="胎号" Flex="1" LabelAlign="Right" Editable="false">
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
                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5" Title="胎号信息">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="100">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData"></ext:PageProxy>
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" >
                                            <Fields>
                                                <ext:ModelField Name="TYRE_NO" />
                                                <ext:ModelField Name="S_N_NO" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="OUT_DATE" Type="Date"/>
                                                <ext:ModelField Name="CUSTOMER_NAME" />
                                                <ext:ModelField Name="P_MATERIAL_NAME" />
                                                <ext:ModelField Name="BEGIN_TIME" Type="Date"/>
                                                <ext:ModelField Name="SAP_CODE"  />
                                                <ext:ModelField Name="P_SAP_CODE" />
                                                <ext:ModelField Name="REMARK" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                                    <ext:Column ID="S_N_NO" runat="server" Text="出库单号" DataIndex="S_N_NO" Width="100" />
                                    <ext:Column ID="TYRE_NO" runat="server" Text="条码号" DataIndex="TYRE_NO" Width="100" />
                                    <ext:Column ID="MATERIAL_NAME" runat="server" Text="出库规格" DataIndex="MATERIAL_NAME" Width="200" />
                                    <ext:DateColumn ID="OUT_DATE" runat="server" Text="出库确认时间" DataIndex="OUT_DATE" Width="100" Flex="1" Format="yyyy-MM-dd HH:mm:ss"/>
                                    <ext:Column ID="CUSTOMER_NAME" runat="server" Text="客户名称" DataIndex="CUSTOMER_NAME" Width="120" />
                                    <ext:Column ID="P_MATERIAL_NAME" runat="server" Text="生产规格" DataIndex="P_MATERIAL_NAME" Width="200" />
                                    <ext:DateColumn ID="BEGIN_TIME" runat="server" Text="生产时间" DataIndex="BEGIN_TIME" Width="100" Flex="1" Format="yyyy-MM-dd HH:mm:ss"/>
                                    <ext:Column ID="SAP_CODE" runat="server" Text="出库品号" DataIndex="SAP_CODE" Width="100" />
                                    <ext:Column ID="P_SAP_CODE" runat="server" Text="生产品号" DataIndex="P_SAP_CODE" Width="100" />
                                    <ext:Column ID="REMARK" runat="server" Text="备注" DataIndex="REMARK" Width="100" />
                                </Columns>
                            </ColumnModel>
                            <Plugins>
                                <ext:CellEditing ID="cellEditing1" runat="server" ClicksToEdit="1">
                                </ext:CellEditing>
                            </Plugins>
                            <%--<SelectionModel>
                                <ext:RowSelectionModel ID="rowSelectMuti" runat="server" Mode="Single">
                                    <Listeners>
                                        <Select Handler="#{storeDetail}.reload();" Buffer="250" />
                                    </Listeners>
                                </ext:RowSelectionModel>
                            </SelectionModel>--%>
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
                                                <Select Handler="#{pnlList}.storeData.pageSize = parseInt(this.getValue(), 10); #{pageToolBar}.doRefresh(); return false;" />
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
