<%@ page language="C#" autoeventwireup="true" inherits="Plugins_Storage_Manage_PrintOutStockBill, Mesnac.Storage.WebSite" %>

<%@ Register Assembly="FastReport.Web" Namespace="FastReport.Web" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>出库随车单</title>
    <script type="text/javascript">
        // 列表刷新数据重载方法
        var gridPanelMainRefresh = function () {
            App.gridPanelMainStore.currentPage = 1;
            App.gridPanelMainPagingToolbar.doRefresh();
            return false;
        }

        // 点击查询按钮
        var btnSearch_Click = function () {
            gridPanelMainRefresh();
            return true;
        }

        // 获取选择的记录
        var getSelectedRecord = function () {
            var selectRows = App.gridPanelMainCheckboxSelectionModel.getSelection();
            if (selectRows.length == 0) {
                return null;
            }
            return selectRows[0];
        };

        // 点击打印按钮
        var btnPrint_Click = function () {
            var record = getSelectedRecord();
            if (record == null) {
                X.Msg.alert("操作", "请选择要打印的数据");
                return false;
            }
            command_direct_print(record);
            return true;
        };

        // 点击打印按钮
        var btnExcel_Click = function () {
            var record = getSelectedRecord();
            if (record == null) {
                X.Msg.alert("操作", "请选择要导出的数据");
                return false;
            }
            command_direct_excel(record);
            return true;
        };

        // 点击打印按钮
        var command_direct_print = function (record) {
            var objId = record.data.OBJID;
            App.direct.command_direct_print(objId, {
                success: function (result) {
                },
                failure: function (errorMsg) {
                    Ext.Msg.alert("操作", errorMsg);
                }
            });
        };

        // 点击导出按钮
        var command_direct_excel = function (record) {
            var objId = record.data.OBJID;
            var snNo = record.data.S_N_NO;
            App.direct.command_direct_print(objId, {
                success: function (result) {
                },
                failure: function (errorMsg) {
                    Ext.Msg.alert("操作", errorMsg);
                }
            });
        };

        // 点击撤消提交按钮
        var btnCancelSubmit_Click = function () {
            var record = getSelectedRecord();
            if (record == null) {
                X.Msg.alert("操作", "请选择要撤消提交的数据");
                return false;
            }
            command_direct_cancelsubmit(record);
            return true;
        };

        // 点击撤消提交按钮
        var command_direct_cancelsubmit = function (record) {
            Ext.MessageBox.confirm('提示', '您确定要撤消该单据的提交信息？', command_direct_cancelsubmit_confirm);
        };

        var command_direct_cancelsubmit_confirm = function(btn)
        {
            if (btn == 'yes')
            {
                var record = getSelectedRecord();
                var objId = record.data.OBJID;

                App.direct.command_direct_cancelsubmit(objId, {
                    success: function (result) {
                        gridPanelMainRefresh();
                    },
                    failure: function (errorMsg) {
                        Ext.Msg.alert("操作", errorMsg);
                    }
                });
            }
        }


    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager runat="server" />
        <ext:Viewport runat="server" Layout="BorderLayout">
            <Items>
                <ext:Panel runat="server" Region="North" Layout="FitLayout">
                    <TopBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:Button runat="server" ID="btnSearch" Text="查询">
                                    <Listeners>
                                        <Click Handler="return btnSearch_Click();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" ID="btnPrint" Text="打印随车单">
                                    <Listeners>
                                        <Click Handler="return btnPrint_Click();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" ID="btnCancelSubmit" Text="撤消提交">
                                    <Listeners>
                                        <Click Handler="return btnCancelSubmit_Click();" />
                                    </Listeners>
                                </ext:Button>                              
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:Panel runat="server" Layout="ColumnLayout">
                            <Items>
                                <ext:TextField runat="server" ID="txtSNNo" LabelAlign="Right" FieldLabel="出货单号"></ext:TextField>
                                <ext:DateField runat="server" ID="txtDocDate" LabelAlign="Right" FieldLabel="记账日期"></ext:DateField>
                                <ext:TextField runat="server" ID="txtCustomerName" LabelAlign="Right" FieldLabel="客户名称"></ext:TextField>
                                <ext:TextField runat="server" ID="txtTyreNo" LabelAlign="Right" FieldLabel="硫化条码号"></ext:TextField>
                                <ext:TextField runat="server" ID="txtGreenTyreNo" LabelAlign="Right" FieldLabel="成型条码号"></ext:TextField>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:Panel runat="server" Region="Center" Layout="FitLayout">
                    <Items>
                        <ext:GridPanel runat="server" ID="gridPanelMain">
                            <Store>
                                <ext:Store runat="server" ID="gridPanelMainStore" AutoLoad="false">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model runat="server" ID="gridPanelMainModel">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="S_N_NO" />
                                                <ext:ModelField Name="DOC_DATE" />
                                                <ext:ModelField Name="OUT_DATE" />
                                                <ext:ModelField Name="CUSTOMER_ID" />
                                                <ext:ModelField Name="CUSTOMER_NAME" />
                                                <ext:ModelField Name="BILL_STATE_CAPTION" />
                                                <ext:ModelField Name="RECORD_TIME" />
                                                <ext:ModelField Name="AFFIRM_USER_NAME" />
                                                <ext:ModelField Name="AFFIRM_TIME" />
                                                <ext:ModelField Name="PLAN_AMOUNT" />
                                                <ext:ModelField Name="OUT_AMOUNT" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel>
                                <Columns>
                                    <ext:Column DataIndex="S_N_NO" Text="出货单号" />
                                    <ext:Column DataIndex="DOC_DATE" Text="凭证日期" />
                                    <ext:Column DataIndex="OUT_DATE" Text="出货日期" />
                                    <ext:Column DataIndex="CUSTOMER_ID" Text="客户编号" />
                                    <ext:Column DataIndex="CUSTOMER_NAME" Text="客户名称" />
                                    <ext:Column DataIndex="PLAN_AMOUNT" Text="计划数量" />
                                    <ext:Column DataIndex="OUT_AMOUNT" Text="发货数量" />
                                    <ext:Column DataIndex="BILL_STATE_CAPTION" Text="单据状态" />
                                    <ext:DateColumn DataIndex="RECORD_TIME" Text="创建时间" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column DataIndex="AFFIRM_USER_NAME" Text="确认人" />
                                    <ext:Column DataIndex="AFFIRM_TIME" Text="确认时间" />
                                </Columns>
                            </ColumnModel>
                            <SelectionModel>
                                <ext:CheckboxSelectionModel runat="server" ID="gridPanelMainCheckboxSelectionModel" Mode="Single" />
                            </SelectionModel>
                            <BottomBar>
                                <ext:PagingToolbar ID="gridPanelMainPagingToolbar" runat="server">
                                </ext:PagingToolbar>
                            </BottomBar>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
        <ext:Window runat="server" ID="windowPrint" Layout="FitLayout" Width="750" Height="450" Hidden="true" Modal="true">            
             <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                                <ext:Button runat="server" ID="btnReportExcel" Text="导出Excel" Icon="PageExcel" Visible="true">
                                    <DirectEvents>
                                        <Click IsUpload="true" OnEvent="btnReportExcel_Click" />
                                    </DirectEvents>
                                    <Listeners>
                                        <%--<Click Handler="return btnExcel_Click();" />--%>
                                    </Listeners>
                                </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
           
            <Items>
                <ext:Panel runat="server" AutoScroll="true">
                    <Content>
                        <cc1:WebReport ID="WebReport1" runat="server" BackColor="White" Font-Bold="False"
                            Width="100%" Height="100%" Zoom="1" Padding="3, 3, 3, 3" ToolbarColor="Lavender"
                            PrintInPdf="true" Layers="false" PdfEmbeddingFonts="false" ShowExports="false"
                            ShowPrint="true"
                            ShowRefreshButton="false" />
                    </Content>
                </ext:Panel>
            </Items>
        </ext:Window>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
