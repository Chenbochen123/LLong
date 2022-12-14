<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OutStoreBill.aspx.cs" Inherits="Plugins_Settlement_Settlement_OutStore_OutStoreBill" %>

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
        <asp:Button  ID="btnExportSubmit" runat="server" Text="Button" Style="display:none" OnClick="btnExportSubmit_Click"/>
        <ext:ResourceManager ID="rmOutStoreBill" runat="server"></ext:ResourceManager>
        <ext:Viewport ID="vpOutStoreBill" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnOutStoreBill" runat="server"  Region="North" Height="90">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbOutStoreBill" >
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
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxSearchType" runat="server" FieldLabel="查询类型" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                        <ext:ComboBox ID="cbxBillState" runat="server" FieldLabel="单据状态" LabelAlign="Right" Editable="false"></ext:ComboBox>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="开始日期" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" ></ext:DateField>
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txtBillNo" runat="server" FieldLabel="出货单号" LabelAlign="Right" Editable="false"></ext:TextField>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="结束日期" Layout="HBoxLayout" LabelAlign="Right">
                                                <Items>
                                                    <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                </Items>
                                        </ext:FieldContainer>
                                       <ext:TextField ID="txtCustomerName" runat="server" FieldLabel="客户名称" LabelAlign="Right" Editable="false"></ext:TextField>
                                    </Items>
                                </ext:Container>
                            </Items>
                            <Listeners>
                                    <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                                </Listeners>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="Panel1" runat="server" Region="Center" Frame="True" Layout="Fit" MarginsSummary="0 5 0 5">
                    <Items>
                        <ext:GridPanel ID="pnlRatioList" runat="server">
                            <Store>
                                <ext:Store ID="store1" runat="server" PageSize="500">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData"></ext:PageProxy>
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model1" runat="server" >
                                            <Fields>
                                                <ext:ModelField Name="S_N_NO" />
                                                <ext:ModelField Name="DOC_DATE_SHOW" Type="Date"/>
                                                <ext:ModelField Name="OUT_DATE" Type="Date"/>
                                                <ext:ModelField Name="CUSTOMER_ID" />
                                                <ext:ModelField Name="CUSTOMER_NAME" />
                                                <ext:ModelField Name="PLAN_AMOUNT" />
                                                <ext:ModelField Name="OUT_AMOUNT" />
                                                <ext:ModelField Name="RECORD_TIME" Type="Date"/>
                                                <ext:ModelField Name="RECORD_USER_NAME" />
                                                <ext:ModelField Name="BILL_STATE_CAPTION" />
                                                <ext:ModelField Name="AFFIRM_TIME" Type="Date"/>
                                                <ext:ModelField Name="AFFIRM_USER_NAME" />
                                                <ext:ModelField Name="UPDATE_TIME" Type="Date"/>
                                                <ext:ModelField Name="UPDATE_USER_NAME" />
                                                <ext:ModelField Name="REMARK" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModel1" runat="server">
                                <Columns>
                                    <ext:Column ID="S_N_NO" runat="server" Text="出货单号" DataIndex="S_N_NO" Width="100"></ext:Column>
                                    <ext:DateColumn ID="DOC_DATE_SHOW" runat="server" Text="凭证日期" DataIndex="DOC_DATE_SHOW" Width="100" Format="yyyy-MM-dd"/>
                                    <ext:Column ID="CUSTOMER_ID" runat="server" Text="客户编号" DataIndex="CUSTOMER_ID" Width="200" />
                                    <ext:Column ID="CUSTOMER_NAME" runat="server" Text="客户名称" DataIndex="CUSTOMER_NAME" Width="200"></ext:Column>
                                    <ext:Column ID="PLAN_AMOUNT" runat="server" Text="计划数量" DataIndex="PLAN_AMOUNT" Width="100" />
                                    <ext:Column ID="OUT_AMOUNT" runat="server" Text="实发数量" DataIndex="OUT_AMOUNT" Width="100" />
                                    <ext:DateColumn ID="RECORD_TIME" runat="server" Text="创建时间" DataIndex="RECORD_TIME" Width="200" Format="yyyy-MM-dd HH:mm:ss"></ext:DateColumn>
                                    <ext:Column ID="BILL_STATE_CAPTION" runat="server" Text="单据状态" DataIndex="BILL_STATE_CAPTION" Width="100" />
                                    <ext:DateColumn ID="AFFIRM_TIME" runat="server" Text="确认时间" DataIndex="AFFIRM_TIME" Width="200" Format="yyyy-MM-dd HH:mm:ss"/>
                                    <ext:Column ID="AFFIRM_USER_NAME" runat="server" Text="确认人" DataIndex="AFFIRM_USER_NAME" Width="100" />
                                </Columns>
                            </ColumnModel>
                            <SelectionModel>
                                <ext:RowSelectionModel ID="RowSelectionModel1" runat="server"  Mode="Single">
                                    <Listeners>
                                        <Select Handler="#{storeDetail}.reload();" Buffer="250"></Select>
                                    </Listeners>
                                </ext:RowSelectionModel>
                            </SelectionModel>
                            <BottomBar>
                                <ext:PagingToolbar ID="pageToolbar1" runat="server">
                                    <Items> 
                                        <ext:Label ID="Label2" runat="server" Text="每页条数:" Hidden="true"></ext:Label>
                                        <ext:ToolbarSeparator ID="ToolbarSpacer2" runat="server" Width="10"></ext:ToolbarSeparator>
                                        <ext:ComboBox ID="ComboBox2" runat="server" width="80" Hidden="true">
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
                                         <ext:ProgressBarPager ID="ProgressBarPager1" runat="server"></ext:ProgressBarPager>
                                     </Plugins>
                                </ext:PagingToolbar>
                            </BottomBar>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="pnlDetail" runat="server" Region="South" Height="200" Title="明细数据" Layout="Fit" Icon="Basket"   Split="True" MarginsSummary="0 5 5 5">
                    <Items>
                        <ext:GridPanel ID="pnlDetailList" runat="server" MarginsSummary="0 5 5 5">
                            <Store>
                                <ext:Store ID="storeDetail" runat="server" PageSize="100"  OnReadData="storeDetail_ReadData">
                                    <Model>
                                        <ext:Model ID="modelDetail" runat="server">
                                            <Fields>
                                                <ext:ModelField Name="TYRE_NO" />
                                                <ext:ModelField Name="S_N_NO" />
                                                <ext:ModelField Name="DOC_DATE_SHOW" Type="Date"/>
                                                <ext:ModelField Name="CUSTOMER_ID" />
                                                <ext:ModelField Name="CUSTOMER_NAME" />
                                                <ext:ModelField Name="LINE_ITEM_NO" />
                                                <ext:ModelField Name="STORAGE_LOC" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="CHECK_GRADE_NAME" />
                                                <ext:ModelField Name="PLAN_AMOUNT" />
                                                <ext:ModelField Name="OUT_AMOUNT" />
                                                <ext:ModelField Name="RECORD_TIME" Type="Date"/>
                                                <ext:ModelField Name="DETAIL_STATE_CAPTION" />
                                                <ext:ModelField Name="AFFIRM_TIME" Type="Date"/>
                                                <ext:ModelField Name="AFFIRM_USER_NAME" />
                                                <ext:ModelField Name="RECORD_USER_NAME" />
                                                <ext:ModelField Name="UPDATE_TIME" Type="Date" />
                                                <ext:ModelField Name="UPDATE_USER_NAME" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                    <Parameters>
                                        <ext:StoreParameter Name="S_N_NO" Mode="Raw" Value="#{pnlRatioList}.getSelectionModel().hasSelection() ? #{pnlRatioList}.getSelectionModel().getSelection()[0].data.S_N_NO : -1" />
                                    </Parameters>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModelDetail" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="TYRE_NO" runat="server" Text="硫化条码" DataIndex="TYRE_NO" Flex="1" />
                                    <ext:Column ID="DT_S_N_NO" runat="server" Text="出货单号" DataIndex="S_N_NO" Width="100"/>
                                    <ext:DateColumn ID="DT_DOC_DATE_SHOW" runat="server" Text="凭证日期" DataIndex="DOC_DATE_SHOW"  Flex="1" Format="yyyy-MM-dd"/>
                                    <ext:Column ID="DT_CUSTOMER_ID" runat="server" Text="客户编号" DataIndex="CUSTOMER_ID"  Flex="1" />
                                    <ext:Column ID="DT_CUSTOMER_NAME" runat="server" Text="客户名称" DataIndex="CUSTOMER_NAME"  Flex="1" />
                                    <ext:Column ID="LINE_ITEM_NO" runat="server" Text="行项目编号" DataIndex="LINE_ITEM_NO" Flex="1" />
                                    <ext:Column ID="STORAGE_LOC" runat="server" Text="出货库区" DataIndex="STORAGE_LOC" Flex="1" />
                                    <ext:Column ID="MATERIAL_NAME" runat="server" Text="物料规格" DataIndex="MATERIAL_NAME" Flex="1" />
                                    <ext:Column ID="CHECK_GRADE_NAME" runat="server" Text="品级" DataIndex="CHECK_GRADE_NAME"  Flex="1" />
                                    <ext:Column ID="DT_PLAN_AMOUNT" runat="server" Text="计划数量" DataIndex="PLAN_AMOUNT" Flex="1" />
                                    <ext:Column ID="DT_OUT_AMOUNT" runat="server" Text="实发数量" DataIndex="OUT_AMOUNT" Flex="1" />
                                    <ext:DateColumn ID="DT_RECORD_TIME" runat="server" Text="创建时间" DataIndex="RECORD_TIME" Flex="1" Format="yyyy-MM-dd HH:mm:ss"/>
                                    <ext:Column ID="DETAIL_STATE_CAPTION" runat="server" Text="状态" DataIndex="DETAIL_STATE_CAPTION" Flex="1" />
                                    <ext:DateColumn ID="DT_AFFIRM_TIME" runat="server" Text="确认时间" DataIndex="AFFIRM_TIME" Flex="1" Format="yyyy-MM-dd HH:mm:ss"/>
                                    <ext:Column ID="DT_AFFIRM_USER_NAME" runat="server" Text="确认人" DataIndex="AFFIRM_USER_NAME" Flex="1" />
                                </Columns>
                            </ColumnModel>
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
