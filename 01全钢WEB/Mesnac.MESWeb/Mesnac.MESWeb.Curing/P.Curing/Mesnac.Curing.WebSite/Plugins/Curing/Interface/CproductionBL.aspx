<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CproductionBL.aspx.cs" Inherits="Plugins_Curing_Interface_CproductionBL" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>SAP补录报产信息查询</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .redcs {
            color: #ff0000;
        }
    </style>
    <script type="text/javascript">
        var thisDirUrl = "<%= Page.ResolveUrl("./") %>";
        var thisRootUrl = "<%= Page.ResolveUrl("~/") %>";
    </script>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <script type="text/javascript">

        //列表刷新数据重载方法
        var pnlListFresh = function () {
            App.pnlList.store.reload();
            return false;
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
             <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        <ext:Viewport ID="Viewport1" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnlQueryTitle" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="barUser">
                            <Items>
                                <ext:ToolbarSeparator ID="toolbarSeparator_begin" />
                                <ext:DateField runat="server" ID="txtShiftDate" Text="生产日期">
                                </ext:DateField>
                                <ext:ComboBox runat="server" ID="cbxShift" Text="班次">
                                </ext:ComboBox>
                                <ext:TextField ID="txtSAPMaterial" runat="server" FieldLabel="sap物料号">
                                </ext:TextField>

                                <ext:ToolbarSeparator />
                                <ext:Button runat="server" Icon="Find" Text="查询" Enabled="false" ID="btnSearch">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="查询MES产量" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="pnlListFresh" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator />

                                   <ext:Button runat="server" Icon="PageWhiteExcel" Text="导出" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip3" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>

                                <ext:Hidden runat="server" ID="hdnSearchMaterialId" />
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle_2" />
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                </ext:Panel>
                <ext:GridPanel ID="pnlList" runat="server" Region="Center">
                    <View>
                        <ext:GridView EnableTextSelection="true" />
                    </View>
                    <Store>
                        <ext:Store ID="store" runat="server" PageSize="100">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server" IDProperty="PRODUCTINFO">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="PRODUCTINFO" />
                                        <ext:ModelField Name="SUCCESS_FLAG" />
                                        <ext:ModelField Name="POST_DATE" />
                                        <ext:ModelField Name="DOC_DATE" />
                                        <ext:ModelField Name="MATERIAL_NAME" />
                                        <ext:ModelField Name="MATERIAL_ID" />
                                        <ext:ModelField Name="PROVERSION" />
                                        <ext:ModelField Name="QTY" />
                                        <ext:ModelField Name="MES_QTY" />
                                        <ext:ModelField Name="SAP_QTY" />
                                        <ext:ModelField Name="REJECT_QTY" />
                                        <ext:ModelField Name="MES_REJECT_QTY" />
                                        <ext:ModelField Name="SAP_REJECT_QTY" />
                                        <ext:ModelField Name="SHIFT_NAME" />
                                        <ext:ModelField Name="SHIFT_DATE" />
                                        <ext:ModelField Name="SAP_CODE" />
                                        <ext:ModelField Name="RETURN_MSG" />
                                         <ext:ModelField Name="REMARK" />
                                         <ext:ModelField Name="STATE_FLAG" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn runat="server" Width="30"/>
                            <ext:Column ID="OBJID" runat="server" Hidden="true" ></ext:Column>
                            <ext:Column ID="SUCCESS_FLAG" runat="server" Text="状态" DataIndex="SUCCESS_FLAG" Width="60" />
                            <ext:Column ID="STATE_FLAG" runat="server" Text="数据来源" DataIndex="STATE_FLAG" Width="60" />
                            <ext:DateColumn ID="SHIFT_DATE" runat="server" Text="生产日期" DataIndex="SHIFT_DATE" Format="yyyy-MM-dd" Width="80" />
                            <ext:Column ID="POSTDATE" runat="server" Text="过账日期" DataIndex="POST_DATE" Width="80" />
                            <ext:Column ID="DOCDATE" runat="server" Text="凭证日期" DataIndex="DOC_DATE" Width="80" />
                            <ext:Column ID="SHIFT_NAME" runat="server" Text="生产班次" DataIndex="SHIFT_NAME" Width="80" />
                            <ext:Column ID="SAPCODE" runat="server" Text="SAP物料号" Selectable="true" DataIndex="SAP_CODE" Width="80" />
                            <ext:Column ID="PROVERSION" runat="server" Text="BOM版本" Selectable="true" DataIndex="PROVERSION" Width="80" />
                            <ext:Column ID="MATERIALNAME" runat="server" Text="轮胎规格" DataIndex="MATERIAL_NAME" Width="300" />
                               <ext:Column ID="QTY" runat="server" Text="上报产量" DataIndex="QTY" Width="80" />
                            <ext:Column ID="MESQTY" runat="server" Text="MES产量" DataIndex="MES_QTY" Width="80" />
                            <ext:Column ID="SAPQTY" runat="server" Text="已上报产量" Hidden="true" DataIndex="SAP_QTY" Width="80" />
                            <ext:Column ID="MESREJECTQTY" runat="server" Text="MES废品数量" DataIndex="MES_REJECT_QTY" Width="80" />
                            <ext:Column ID="SAPREJECTQTY" runat="server" Text="已上报废品数量" Hidden="true" DataIndex="SAP_REJECT_QTY" Width="80" />
                            <ext:Column ID="REJECTQTY" runat="server" Text="废品数量" DataIndex="REJECT_QTY" Width="80" />
                             <ext:Column ID="REMARK" runat="server" Text="凭证抬头文本" DataIndex="REMARK" Width="80" />
                            <ext:Column ID="RETURN_MSG" runat="server" Text="SAP返回消息" Hidden="false" DataIndex="RETURN_MSG" Width="220" />
                        </Columns>
                    </ColumnModel>
                    <BottomBar>
                        <ext:PagingToolbar ID="pageToolbar1" runat="server">
                            <Items>
                                <ext:Label ID="Label2" runat="server" Text="每页条数:" Hidden="true" />
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
                                        <Select Handler="#{pnlList}.store.pageSize = parseInt(this.getValue(), 10); #{pageToolbar1}.doRefresh(); return false;" />
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
        </ext:Viewport>
    </form>
</body>
</html>
