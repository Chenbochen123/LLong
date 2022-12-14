<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MaterialTimeStand.aspx.cs" Inherits="Plugins_Molding_MaterialTimeStand" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>物料基础信息</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>

    <script type="text/javascript">

        Ext.apply(Ext.form.VTypes, {
            integer: function (val, field) {
                if (!val) {
                    return true;
                }
                try {
                    if (/^[\d]+\.?[\d]*$/.test(val)) {
                        return true;
                    }
                    else {
                        return false;
                    }
                }
                catch (e) {
                    return false;
                }
            },
            integerText: "此填入项为数字格式！"

        });


        //列表刷新数据重载方法
        var pnlListFresh = function () {
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }
    </script>
    <script type="text/javascript">
        //树形结构点击刷新右侧方法
        var loadPage = function (record) {

            App.hidden_minor_type_id.setValue(record.getId());
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
        };

        var setStockCondition = function (cb, tf) {
            var flag = cb.getValue();
            if (flag == true) {
                tf.setDisabled(false);
            } else {
                tf.setDisabled(true);
            }
        };
    </script>

</head>
<body>
    <form id="fmRubber" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmRubber" runat="server" />
        <ext:Viewport ID="vwUnit" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="Panel1" runat="server" Region="West" Width="200" Layout="BorderLayout">
                    <Items>
                        <ext:TreePanel ID="treeDept" runat="server" Title="物料分类" Region="Center" Icon="FolderGo"
                            AutoHeight="true" RootVisible="false">
                            <Store>
                                <ext:TreeStore ID="treeDeptStore" runat="server">
                                    <Proxy>
                                        <ext:PageProxy>
                                            <RequestConfig Method="GET" Type="Load" />
                                        </ext:PageProxy>
                                    </Proxy>
                                    <Root>
                                        <ext:Node NodeID="root" Expanded="true" />
                                    </Root>
                                </ext:TreeStore>
                            </Store>
                            <Listeners>
                                <ItemClick Handler="loadPage(record)" />
                            </Listeners>
                        </ext:TreePanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="pnlRubberTitle" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="barRubber">
                            <Items>
                                <ext:ToolbarSeparator ID="toolbarSeparator_begin" />
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="点击进行查询" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="pnlListFresh">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle" />
                                <ext:Button runat="server" Icon="Bell" Text="批量设置有效期" ID="btn_set_stock">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip4" runat="server" Html="点击批量设置有效期" />
                                    </ToolTips>
                                    <DirectEvents>
                                        <Click OnEvent="btn_set_stock_Click">
                                            <ExtraParams>
                                                <ext:Parameter Name="StockValues" Value="Ext.encode(#{pnlList}.getRowsValues({selectedOnly:true}))" Mode="Raw" />
                                            </ExtraParams>
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" />
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:Panel ID="pnlRubberQuery" runat="server" AutoHeight="true">
                            <Items>
                                <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container ID="container_1" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                            Padding="5">
                                            <Items>
                                                <ext:TextField ID="txt_material_code" Vtype="integer" runat="server" FieldLabel="物料代码"
                                                    LabelAlign="Right" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                            Padding="5">
                                            <Items>
                                                <ext:TextField ID="txt_material_name" runat="server" FieldLabel="物料名称" LabelAlign="Right" />
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:FormPanel>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:GridPanel ID="pnlList" runat="server" Region="Center">
                    <Store>
                        <ext:Store ID="store" runat="server" PageSize="30">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server">
                                    <Fields>
                                        <ext:ModelField Name="MATERIAL_ID" />
                                        <ext:ModelField Name="MATERIAL_CODE" />
                                        <ext:ModelField Name="MATERIAL_NAME" />
                                        <ext:ModelField Name="MIN_TIME" />
                                        <ext:ModelField Name="VALID_TIME" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="45" />
                            <ext:Column ID="material_code" runat="server" Text="物料代码" DataIndex="MATERIAL_CODE"
                                Width="400" />
                            <ext:Column ID="material_name" runat="server" Text="物料名称" DataIndex="MATERIAL_NAME"
                                Width="400" />
                             <ext:Column ID="min_park_time" runat="server" Text="最小停放时间" DataIndex="MIN_TIME"
                                Width="80" />
                            <ext:Column ID="max_park_time" runat="server" Text="有效期" DataIndex="VALID_TIME"
                                Width="80" />
                        </Columns>
                    </ColumnModel>
                    <%--<SelectionModel>
                        <ext:CheckboxSelectionModel ID="RowSelectionModel1" runat="server" Mode="Simple" />
                    </SelectionModel>--%>
                    <BottomBar>
                        <ext:PagingToolbar ID="pageToolBar" runat="server">
                            <Items>
                                <ext:Label ID="Label2" runat="server" Text="每页条数:" />
                                <ext:ToolbarSpacer ID="ToolbarSpacer2" runat="server" Width="10" />
                                <ext:ComboBox ID="ComboBox2" runat="server" Width="80" Editable="false">
                                    <Items>
                                        <ext:ListItem Text="15" />
                                        <ext:ListItem Text="50" />
                                        <ext:ListItem Text="200" />
                                        <ext:ListItem Text="500" />
                                    </Items>
                                    <SelectedItems>
                                        <ext:ListItem Value="10" />
                                    </SelectedItems>
                                    <Listeners>
                                        <Select Handler="#{pnlList}.store.pageSize = parseInt(this.getValue(), 10); #{pageToolBar}.doRefresh(); return false;" />
                                    </Listeners>
                                </ext:ComboBox>
                            </Items>
                            <Plugins>
                                <ext:ProgressBarPager ID="ProgressBarPager" runat="server" />
                            </Plugins>
                        </ext:PagingToolbar>
                    </BottomBar>

                </ext:GridPanel>
                <ext:Window ID="winSetStock" runat="server" Icon="Bell" Closable="false" Title="设定停放时间"
                    Height="500" Width="1000" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
                    BodyPadding="5" Layout="BorderLayout">
                    <Items>
                        <ext:FormPanel ID="stockFrmPnl" runat="server" BodyPadding="5" Region="North" Layout="ColumnLayout">
                            <Items>
                                <ext:Container ID="container6" runat="server" Layout="ColumnLayout" ColumnWidth=".33" Padding="5">
                                    <Items>
                                        <ext:NumberField ID="set_max_part_time" runat="server" FieldLabel="有效期" LabelAlign="Right" ColumnWidth=".85">
                                        </ext:NumberField>
                                        <ext:Checkbox ID="cb_set_max_part_time" runat="server" ColumnWidth=".10" Checked="false">
                                            <Listeners>
                                                <Change Handler="setStockCondition(#{cb_set_max_part_time},#{set_max_part_time})"></Change>
                                            </Listeners>
                                        </ext:Checkbox>
                                    </Items>
                                </ext:Container>
                              <%--  <ext:Container ID="container9" runat="server" Layout="ColumnLayout" ColumnWidth=".33" Padding="5">
                                    <Items>
                                        <ext:NumberField ID="set_min_part_time" runat="server" FieldLabel="最小停放时间" LabelAlign="Right" ColumnWidth=".85"></ext:NumberField>
                                        <ext:Checkbox ID="cb_set_min_part_time" runat="server" ColumnWidth=".10" Checked="false">
                                            <Listeners>
                                                <Change Handler="setStockCondition(#{cb_set_min_part_time},#{set_min_part_time})"></Change>
                                            </Listeners>
                                        </ext:Checkbox>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container1" runat="server" Layout="ColumnLayout" ColumnWidth=".33"
                                    Padding="5">
                                    <Items>
                                        <ext:DateField ID="txtSetTime" runat="server" Format="yyyy-MM-dd" FormatControlForValue="yyyy-MM-dd" Editable="false" AllowBlank="false"
                                            FieldLabel="恢复时间" LabelAlign="Right" />
                                        <ext:Checkbox ID="Checkbox1" runat="server" ColumnWidth=".10" Checked="false">
                                            <Listeners>
                                                <Change Handler="setStockCondition(#{Checkbox1},#{txtSetTime})"></Change>
                                            </Listeners>
                                        </ext:Checkbox>
                                    </Items>
                                </ext:Container>--%>
                            </Items>
                        </ext:FormPanel>
                        <ext:GridPanel ID="stockPnl" Collapsible="true" runat="server" Region="Center" Title="所选物料">
                            <Store>
                                <ext:Store ID="stockStore" runat="server" PageSize="-1">
                                    <Model>
                                        <ext:Model ID="model5" runat="server" IDProperty="Dummy1">
                                            <Fields>
                                                <ext:ModelField Name="Dummy1" />
                                                <ext:ModelField Name="Dummy2" />
                                                <ext:ModelField Name="ValidTime" />
                                                <ext:ModelField Name="MinTime" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModel2" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="RowNumbererColumn2" runat="server" Width="50" />
                                    <ext:Column ID="Column1" runat="server" Text="物料名称" DataIndex="Dummy2" Flex="1" />
                                    <ext:Column ID="Column2" runat="server" Text="物料代码" DataIndex="Dummy1" Flex="1" />
                                    <ext:Column ID="Column3" runat="server" Text="有效期" DataIndex="ValidTime" Flex="1" />
                                    <ext:Column ID="Column4" runat="server" Text="最小停放时间" DataIndex="MinTime" Flex="1" />
                                </Columns>
                            </ColumnModel>
                        </ext:GridPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="btn_set_stock_save" runat="server" Text="确定" Icon="Accept">
                            <DirectEvents>
                                <Click OnEvent="BtnSetStockSave_Click">
                                    <EventMask ShowMask="true" Msg="Saving..." MinDelay="50" />
                                    <ExtraParams>
                                        <ext:Parameter Name="data" Value="#{stockStore}.getChangedData({skipIdForNewRecords : false})" Mode="Raw" Encode="true" />
                                    </ExtraParams>
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button ID="btn_set_stock_cancel" runat="server" Text="取消" Icon="Cancel">
                            <DirectEvents>
                                <Click OnEvent="BtnSetStockCancel_Click">
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                </ext:Window>
                <ext:Hidden Hidden="true" ID="hidden_minor_type_id" runat="server">
                </ext:Hidden>
                <ext:Hidden ID="hidden_set_Stock" runat="server">
                </ext:Hidden>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
