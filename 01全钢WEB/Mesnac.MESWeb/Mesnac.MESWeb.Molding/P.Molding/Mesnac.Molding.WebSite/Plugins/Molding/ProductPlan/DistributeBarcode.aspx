<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DistributeBarcode.aspx.cs" Inherits="Plugins_Molding_ProductPlan_DistributeBarcode" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>条码分发</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript">
        var thisDirUrl = "<%= Page.ResolveUrl("./") %>";
        var thisRootUrl = "<%= Page.ResolveUrl("~/") %>";
    </script>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <script type="text/javascript">
        //------------查询带回弹出框--END 
    </script>
    <script type="text/javascript">

        var ChangeNum = function () {
            App.direct.ChangeNumChe({
                success:function(result){},
                failure:function(errorMsg){}
            })
        }

        //点击修改按钮
        var commandcolumn_direct_edit = function (record) {
            var ObjId = record.data.OBJID;
            App.direct.commandcolumn_direct_edit(ObjId, {
                success: function (result) {
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        //点击明细按钮
        var commandcolumn_direct_detail = function (record) {
            var ObjId = record.data.OBJID;
            App.direct.commandcolumn_direct_detail(ObjId, {
                success: function (result) {
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        //点击删除按钮
        var commandcolumn_direct_delete = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var ObjId = record.data.OBJID;
            App.direct.commandcolumn_direct_delete(ObjId, {
                success: function (result) {
                    Ext.Msg.alert('操作', result);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        //区分删除操作，并进行二次确认操作
        var commandcolumn_click_confirm = function (command, record) {
            if (command.toLowerCase() == "search") {
                commandcolumn_direct_detail(record);
            }
            if (command.toLowerCase() == "edit") {
                commandcolumn_direct_edit(record);
            }
            if (command.toLowerCase() == "delete") {
                Ext.Msg.confirm("提示", '您确定需要删除此条信息？', function (btn) { commandcolumn_direct_delete(btn, record) });
            }
            return false;
        };

        //根据按钮类别进行删除和编辑操作
        var commandcolumn_click = function (command, record) {
            commandcolumn_click_confirm(command, record);
            return false;
        };

        Ext.apply(Ext.form.VTypes, {
            integer: function (val, field) {
                if (!val) {
                    return true;
                }
                try {
                    if (/^[\d]+$/.test(val)) {
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
            integerText: "此填入项格式为正整数"
        });


        //列表刷新数据重载方法
        var pnlListFresh = function () {
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }
    </script>
</head>
<body>
    <form id="fmBarcode" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="ResourceManager1" runat="server" />
        <ext:Viewport ID="Viewport1" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnlQueryTitle" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="barUser">
                            <Items>
                                <ext:Button runat="server" Icon="Add" Text="添加" ID="btnAdd">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttAdd" runat="server" Html="点击进行添加" />
                                    </ToolTips>
                                    <DirectEvents>
                                        <Click OnEvent="btnAdd_Click">
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
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
                                <ext:Button runat="server" Icon="PageWhiteExcel" Text="导出" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" />
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:Panel ID="pnlQuery" runat="server" AutoHeight="true">
                            <Items>
                                <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container ID="container_1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:TextField ID="txt_Barcode" runat="server" FieldLabel="条码号"
                                                    LabelAlign="Right" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <%--<ext:TextField ID="txt_User" runat="server" FieldLabel="工号" LabelAlign="Right"
                                                    Editable="false">
                                                </ext:TextField>--%>
                                                <ext:ComboBox ID="cbxEquip" runat="server" FieldLabel="机台名称" LabelAlign="Right" Editable="true" EnableKeyEvents="true">
                                                </ext:ComboBox>
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
                        <ext:Store ID="store" runat="server" PageSize="10">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="EQUIP_NAME" />
                                        <ext:ModelField Name="EQUIP_ID" />
                                        <ext:ModelField Name="BEGIN_BARCODE" />
                                        <ext:ModelField Name="END_BARCODE" />
                                        <ext:ModelField Name="USER_NAME" />
                                        <ext:ModelField Name="RECORD_TIME" />
                                        <ext:ModelField Name="REMARK" />
                                        <ext:ModelField Name="MATERIAL_NAME" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn ID="rowNumCol" Width="45" runat="server" />
                            <ext:Column ID="EQUIP_NAME" runat="server" Text="成型机台" DataIndex="EQUIP_NAME" Width="80" />
                            <ext:Column ID="EQUIP_ID" runat="server" Text="成型机台ID" DataIndex="EQUIP_ID" Width="80" Hidden="true" />
                            <ext:Column ID="Column1" runat="server" Text="物料规格" DataIndex="MATERIAL_NAME" Width="300"/>
                            <ext:Column ID="BEGIN_BARCODE" runat="server" Text="起始条码" DataIndex="BEGIN_BARCODE" Width="100"/>
                            <ext:Column ID="END_BARCODE" runat="server" Text="截止条码" DataIndex="END_BARCODE" Width="100"/>
                            <ext:Column ID="USER_NAME" runat="server" Text="记录人" DataIndex="USER_NAME" Width="100" />
                            <ext:DateColumn ID="RECORD_TIME" runat="server" Text="记录时间" DataIndex="RECORD_TIME" Width="180" Format="yyyy-MM-dd HH:mm:ss" />
                            <ext:Column ID="REMARK" runat="server" Text="备注" DataIndex="REMARK" Width="60" />
                            <ext:CommandColumn ID="commandCol" runat="server" Width="180" Text="操作" Align="Center">
                                <Commands>
                                    <ext:GridCommand Icon="TableEdit" CommandName="Search" Text="明细">
                                        <ToolTip Text="查询明细数据" />
                                    </ext:GridCommand>
                                    <ext:CommandSeparator />
                                    <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
                                        <ToolTip Text="修改本条数据" />
                                    </ext:GridCommand>
                                    <ext:CommandSeparator />
                                    <ext:GridCommand Icon="Delete" CommandName="Delete" Text="删除">
                                        <ToolTip Text="删除本条数据" />
                                    </ext:GridCommand>
                                </Commands>
                             <%--   <PrepareToolbar Fn="prepareToolbar" />--%>
                                <Listeners>
                                    <Command Handler="return commandcolumn_click(command, record);" />
                                </Listeners>
                            </ext:CommandColumn>
                        </Columns>
                    </ColumnModel>
                    <BottomBar>
                        <ext:PagingToolbar ID="pageToolBar" runat="server">
                            <Plugins>
                                <ext:ProgressBarPager ID="ProgressBarPager" runat="server" />
                            </Plugins>
                        </ext:PagingToolbar>
                    </BottomBar>
                </ext:GridPanel>
                <ext:Window ID="winModify" runat="server" Icon="MonitorEdit" Closable="false" Title="修改条码分发信息"
                    Width="360" Height="280" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
                    BodyPadding="5" Layout="Form">
                    <Items>
                        <ext:FormPanel ID="pnlEdit" runat="server" Flex="1" BodyPadding="5">
                            <FieldDefaults>
                                <CustomConfig>
                                    <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                                    <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                                </CustomConfig>
                            </FieldDefaults>
                            <Items>
                                <ext:Container runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container runat="server" Layout="FormLayout" ColumnWidth="1" Padding="5">
                                            <Items>
                                                <%--<ext:TextField ID="modify_User" runat="server" FieldLabel="工号" LabelAlign="Left"/>--%>
                                                <ext:ComboBox ID="modify_cbxEquip" runat="server" FieldLabel="机台名称" LabelAlign="Left" Editable="true" EnableKeyEvents="true">
                                                </ext:ComboBox>
                                                <ext:ComboBox ID="modify_mater" runat="server" FieldLabel="物料规格" LabelAlign="Left" Editable="true" EnableKeyEvents="true" ReadOnly="true">
                                                </ext:ComboBox>
                                                <ext:TextField ID="modify_Begin_barcode" runat="server" FieldLabel="起始条码" LabelAlign="Left"  ReadOnly="false"/>
                                                <ext:TextField ID="modify_End_barcode" runat="server" FieldLabel="截止条码" LabelAlign="Left"  ReadOnly="false"/>
                                                <ext:TextField ID="modify_REMARK" runat="server" FieldLabel="备注" LabelAlign="Left" />
                                                <ext:Hidden ID="hidden_modify_objid" runat="server" />
                                           </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="btnModifySave" runat="server" Text="确定" Icon="Accept">
                            <DirectEvents>
                                <Click OnEvent="BtnModifySave_Click">
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button ID="btnModifyCancel" runat="server" Text="取消" Icon="Cancel">
                            <DirectEvents>
                                <Click OnEvent="BtnCancel_Click">
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                </ext:Window>
                <ext:Window ID="winAdd" runat="server" Icon="MonitorAdd" Closable="false" Title="添加条码分发信息"
                    Width="360" Height="280" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
                    BodyPadding="5" Layout="Form">
                    <Items>
                        <ext:FormPanel ID="pnlAdd" runat="server" BodyPadding="5">
                            <FieldDefaults>
                                <CustomConfig>
                                    <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                                    <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                                </CustomConfig>
                            </FieldDefaults>
                            <Items>
                                <ext:Container runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container runat="server" Layout="FormLayout" ColumnWidth="1" Padding="5">
                                            <Items>
                                                <%--<ext:TextField ID="add_User" runat="server" FieldLabel="工号" LabelAlign="Right" />--%>
                                                <ext:ComboBox ID="add_cbxEquip" runat="server" FieldLabel="机台名称" LabelAlign="Right" Editable="true" EnableKeyEvents="true">
                                                </ext:ComboBox>
                                                <ext:TextField ID="add_Begin_Barcode" runat="server" FieldLabel="起始条码" LabelAlign="Right">
                                                    <Listeners>
                                                        <Change Fn="ChangeNum" />
                                                    </Listeners>
                                                </ext:TextField>
                                                <ext:TextField ID="add_End_Barcode" runat="server" FieldLabel="截止条码" LabelAlign="Right" />
                                                <ext:ComboBox ID="add_mater" runat="server" FieldLabel="物料规格" LabelAlign="Right" Editable="true" EnableKeyEvents="true">
                                                </ext:ComboBox>
                                                <ext:TextField ID="add_REMARK" runat="server" FieldLabel="备注" LabelAlign="Right" />
                                                <ext:Hidden ID="hidden1" runat="server" />
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="btnAddSave" runat="server" Text="确定" Icon="Accept">
                            <DirectEvents>
                                <Click OnEvent="BtnAddSave_Click">
                                    <EventMask ShowMask="true" Msg="保存中..." MinDelay="50" />
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button ID="btnAddCancel" runat="server" Text="取消" Icon="Cancel">
                            <DirectEvents>
                                <Click OnEvent="BtnCancel_Click">
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                </ext:Window>
                  <ext:Window ID="winSplit" runat="server" Icon="ArrowDivide" Closable="false" Title="拆分条码分发信息"
                    Width="360" Height="280" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
                    BodyPadding="5" Layout="Form">
                    <Items>
                        <ext:FormPanel ID="FormPanel1" runat="server" BodyPadding="5">
                            <FieldDefaults>
                                <CustomConfig>
                                    <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                                    <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                                </CustomConfig>
                            </FieldDefaults>
                            <Items>
                                <ext:Container runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container runat="server" Layout="FormLayout" ColumnWidth="1" Padding="5">
                                            <Items>
                                                <ext:TextField ID="sp_source" runat="server" FieldLabel="原机台" LabelAlign="Right" />
                                                <ext:TextField ID="sp_target" runat="server" FieldLabel="目的机台" LabelAlign="Right" />
                                                <ext:DateField ID="sp_split_barcode" runat="server" FieldLabel="起始条码" LabelAlign="Right" />
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="BtnSplitSave" runat="server" Text="确定" Icon="Accept">
                            <DirectEvents>
                                <Click OnEvent="BtnSplitSave_Click">
                                    <EventMask ShowMask="true" Msg="保存中..." MinDelay="50" />
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button ID="btnSplitCancel" runat="server" Text="取消" Icon="Cancel">
                            <DirectEvents>
                                <Click OnEvent="BtnCancel_Click">
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                </ext:Window>

                <ext:Window ID="winDetail" runat="server" Icon="MonitorEdit" Closable="false" Title="条码使用情况"
                    Width="620" Height="550" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
                    BodyPadding="5" Layout="Form">
                    <Items>
                        <ext:GridPanel ID="pnlDetailList" runat="server" MarginsSummary="0 5 5 5">
                            <Store>
                                <ext:Store ID="storeData" runat="server" PageSize="15">
                                    <Model>
                                        <ext:Model ID="modelDetail" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="GREEN_TYRE_NO" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="BEGIN_TIME" Type="Date" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModelDetail" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="GREEN_TYRE_NO" runat="server" Text="胎胚号" DataIndex="GREEN_TYRE_NO" Width="120" />
                                    <ext:Column ID="MATERIAL_NAME" runat="server" Text="规格" DataIndex="MATERIAL_NAME" Width="261" />
                                    <ext:DateColumn ID="BEGIN_TIME" runat="server" Text="使用时间" DataIndex="BEGIN_TIME" Width="180" Format="yyyy-MM-dd HH:mm:ss" />
                                </Columns>
                            </ColumnModel>
                            <BottomBar>
                                <ext:PagingToolbar ID="PagingToolbar1" runat="server">
                                    <Items>
                                        <ext:Label ID="Label1" runat="server" Text="每页条数:" Hidden="true" />
                                        <ext:ToolbarSpacer ID="ToolbarSpacer1" runat="server" Width="10" />
                                        <ext:ComboBox ID="ComboBox1" runat="server" Width="80" Hidden="true">
                                            <Items>
                                                <ext:ListItem Text="15" />
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
                                        <ext:ProgressBarPager ID="ProgressBarPager1" runat="server" />
                                    </Plugins>
                                </ext:PagingToolbar>
                            </BottomBar>
                        </ext:GridPanel>
                    </Items>
                    <Buttons>
                        <%--<ext:Button ID="Button1" runat="server" Text="确定" Icon="Accept">
                            <DirectEvents>
                                <Click OnEvent="BtnModifySave_Click">
                                </Click>
                            </DirectEvents>
                        </ext:Button>--%>
                        <ext:Button ID="Button2" runat="server" Text="取消" Icon="Cancel">
                            <DirectEvents>
                                <Click OnEvent="BtnCancel_Click">
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                </ext:Window>


            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
