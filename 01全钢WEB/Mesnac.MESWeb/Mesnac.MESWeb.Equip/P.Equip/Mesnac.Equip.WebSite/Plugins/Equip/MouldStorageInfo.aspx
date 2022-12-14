<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MouldStorageInfo.aspx.cs" Inherits="Plugins_Equip_MouldStorageInfo" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>模具库存台账</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript">
        var thisDirUrl = "<%= Page.ResolveUrl("./") %>";
        var thisRootUrl = "<%= Page.ResolveUrl("~/") %>";
    </script>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <script type="text/javascript">

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
            App.hidden_delete_flag.setValue("0");
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }

    </script>
</head>
<body>
    <form id="fmUser" runat="server">
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
                                <ext:Hidden ID="hidden_delete_flag" runat="server" Text="0" />
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
                                        <ext:Container ID="container_1" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                            Padding="5">
                                            <Items>
                                                <ext:TextField ID="txtMouldName" runat="server" FieldLabel="模具名称"
                                                    LabelAlign="Right" />
                                                <ext:TextField ID="txtmouldcode" runat="server" FieldLabel="模具编号"
                                                    LabelAlign="Right" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                            Padding="5">
                                            <Items>
                                                <ext:ComboBox runat="server" ID="txt_STORE_NAME" FieldLabel="库房" LabelAlign="Right" Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                    <%--<DirectEvents>
                                                        <Change OnEvent="StoreChange_Event"></Change>
                                                    </DirectEvents>--%>
                                                </ext:ComboBox>
                                                <ext:TextField ID="txtsize" runat="server" FieldLabel="规格"
                                                    LabelAlign="Right" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                            Padding="5">
                                            <Items>
                                                <ext:ComboBox runat="server" ID="txt_STORE_PLACE_NAME" FieldLabel="库位" LabelAlign="Right" Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                    <%--<DirectEvents>
                                                        <Change OnEvent="StorePlaceChange_Event"></Change>
                                                    </DirectEvents>--%>
                                                </ext:ComboBox>
                                                <ext:TextField ID="txtpattern" runat="server" FieldLabel="花纹"
                                                    LabelAlign="Right" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_4" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                            Padding="5">
                                            <Items>
                                                <ext:ComboBox runat="server" ID="txt_SUB_STORE_PLACE_NAME" FieldLabel="子库位" LabelAlign="Right" Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox runat="server" ID="cbxType" FieldLabel="类型" LabelAlign="Right" Editable="false">
                                                    <Items>
                                                        <ext:ListItem Text="普通模具" Value="普通模具" />
                                                        <ext:ListItem Text="弹簧模具" Value="弹簧模具" />
                                                    </Items>
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
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
                        <ext:Store ID="store" runat="server" PageSize="15">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="MOULD_NAME" />
                                        <ext:ModelField Name="MOULD_CODE" />
                                        <ext:ModelField Name="SIZE_NAME" />
                                        <ext:ModelField Name="PATTERN_NAME" />
                                        <ext:ModelField Name="BRAND_NAME" />
                                        <ext:ModelField Name="PLYRATING_NAME" />
                                        <ext:ModelField Name="LOAD_INDEX_NAME"/>
                                        <ext:ModelField Name="SPEED_LEVEL_NAME"/>
                                        <ext:ModelField Name="SEC_BRAND"/>
                                        <ext:ModelField Name="SEC_PATTERN"/>
                                        <ext:ModelField Name="IN_TYPE"/>
                                        <ext:ModelField Name="STORE_NAME" />
                                        <ext:ModelField Name="STORE_PLACE_NAME" />
                                        <ext:ModelField Name="SUB_STORE_PLACE_NAME" />
                                        <ext:ModelField Name="STOCK_STATE" />
                                        <ext:ModelField Name="USER_NAME" />
                                        <ext:ModelField Name="RECORD_TIME" Type="Date"/>
                                        <ext:ModelField Name="REMARK" />
                                        <ext:ModelField Name="DUMMY_4" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn ID="rowNumCol" Width="45" runat="server" />
                            <ext:Column ID="OBJID" runat="server" Text="编号" DataIndex="OBJID" Width="60"  Hidden="true"/>
                            <ext:Column ID="Column1" runat="server" Text="模具编号" DataIndex="MOULD_CODE" Width="80" />
                            <ext:Column ID="MOULD_NAME" runat="server" Text="模具名称" DataIndex="MOULD_NAME" Width="80" />
                            <ext:Column ID="SIZE_NAME" runat="server" Text="规格" DataIndex="SIZE_NAME" Width="100" />
                            <ext:Column ID="PATTERN_NAME" runat="server" Text="花纹" DataIndex="PATTERN_NAME" Width="70" />
                            <ext:Column ID="BRAND_NAME" runat="server" Text="商标" DataIndex="BRAND_NAME" Width="60" />
                            <ext:Column ID="PLYRATING_NAME" runat="server" Text="层级" DataIndex="PLYRATING_NAME" Width="60" />
                            <ext:Column ID="Column2" runat="server" Text="SAP品号" DataIndex="DUMMY_4" Width="90" />
                            <ext:Column ID="LOAD_INDEX_NAME" runat="server" Text="负荷" DataIndex="LOAD_INDEX_NAME" Width="70" />
                            <ext:Column ID="SPEED_LEVEL_NAME" runat="server" Text="速度级别" DataIndex="SPEED_LEVEL_NAME" Width="60" />
                            <ext:Column ID="SEC_BRAND" runat="server" Text="其余商标活块" DataIndex="SEC_BRAND" Width="80" />
                            <ext:Column ID="SEC_PATTERN" runat="server" Text="其余花纹活块" DataIndex="SEC_PATTERN" Width="100" />
                            <ext:Column ID="IN_TYPE" runat="server" Text="类型" DataIndex="IN_TYPE" Width="60" />
                            <ext:Column ID="STORE_NAME" runat="server" Text="库房" DataIndex="STORE_NAME" Width="60" />
                            <ext:Column ID="STORE_PLACE_NAME" runat="server" Text="库位" DataIndex="STORE_PLACE_NAME" Width="80" />
                            <ext:Column ID="SUB_STORE_PLACE_NAME" runat="server" Text="子库位" DataIndex="SUB_STORE_PLACE_NAME" Width="120" />
                            <ext:Column ID="STOCK_STATE" runat="server" Text="库存状态" DataIndex="STOCK_STATE" Width="80" />
                            <ext:Column ID="USER_NAME" runat="server" Text="记录人" DataIndex="USER_NAME" Width="70" />
                            <ext:DateColumn ID="RECORD_TIME" runat="server" Text="记录时间" DataIndex="RECORD_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss"/>
                            <ext:Column ID="REMARK" runat="server" Text="备注" DataIndex="REMARK" Width="120" />
                            <ext:CommandColumn ID="commandCol" runat="server" Width="120" Text="操作" Align="Center">
                                <Commands>
                                    <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
                                        <ToolTip Text="修改本条数据" />
                                    </ext:GridCommand>
                                    <ext:CommandSeparator />
                                    <ext:GridCommand Icon="Delete" CommandName="Delete" Text="删除">
                                        <ToolTip Text="删除本条数据" />
                                    </ext:GridCommand>
                                </Commands>
                                <%--<PrepareToolbar Fn="prepareToolbar" />--%>
                                <Listeners>
                                    <Command Handler="return commandcolumn_click(command, record);" />
                                </Listeners>
                            </ext:CommandColumn>
                        </Columns>
                    </ColumnModel>
                    <%--<View>
                        <ext:GridView ID="gvRows" runat="server">
                            <GetRowClass Fn="SetRowClass" />
                        </ext:GridView>
                    </View>--%>
                    <BottomBar>
                        <ext:PagingToolbar ID="pageToolBar" runat="server">
                            <Plugins>
                                <ext:ProgressBarPager ID="ProgressBarPager" runat="server" />
                            </Plugins>
                        </ext:PagingToolbar>
                    </BottomBar>
                </ext:GridPanel>
                
                <ext:Window ID="winModify" runat="server" Icon="MonitorEdit" Closable="false" Title="修改模具信息"
                    Width="360" Height="470" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
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
                                                <ext:TextField ID="modify_MOULD_CODE" runat="server" FieldLabel="模具编号" LabelAlign="Left"  ReadOnly="true" />
                                                <ext:TextField ID="modify_MOULD_NAME" runat="server" FieldLabel="模具名称" LabelAlign="Left"  ReadOnly="true"/>
                                                <ext:ComboBox runat="server" ID="modify_SIZE_NAME" FieldLabel="规格" LabelAlign="Left" >
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox runat="server" ID="modify_PATTERN_NAME" FieldLabel="花纹" LabelAlign="Left" >
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox runat="server" ID="modify_BRAND_NAME" FieldLabel="商标" LabelAlign="Left" Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox runat="server" ID="modify_PLYRATING_NAME" FieldLabel="层级" LabelAlign="Left" Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox runat="server" ID="modify_LOAD_INDEX_NAME" FieldLabel="负荷" LabelAlign="Left" Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox runat="server" ID="modify_SPEED_LEVEL_NAME" FieldLabel="速度级别" LabelAlign="Left" Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:TextField ID="modify_SEC_BRAND" runat="server" FieldLabel="其余商标活块" LabelAlign="Left" />
                                                <ext:TextField ID="modify_SEC_PATTERN" runat="server" FieldLabel="其余花纹活块" LabelAlign="Left" />
                                                <ext:ComboBox runat="server" ID="modify_IN_TYPE" FieldLabel="类型" LabelAlign="Left" Editable="false">
                                                    <Items>
                                                        <ext:ListItem Text="普通模具" Value="普通模具" />
                                                        <ext:ListItem Text="弹簧模具" Value="弹簧模具" />
                                                    </Items>
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox runat="server" ID="modify_STORE_NAME" FieldLabel="库房" LabelAlign="Left" Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                    <%--<DirectEvents>
                                                        <Change OnEvent="Modify_StoreChange_Event"></Change>
                                                    </DirectEvents>--%>
                                                </ext:ComboBox>
                                                <ext:ComboBox runat="server" ID="modify_STORE_PLACE_NAME" FieldLabel="库位" LabelAlign="Left" Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                    <%--<DirectEvents>
                                                        <Change OnEvent="Modify_StorePlaceChange_Event"></Change>
                                                    </DirectEvents>--%>
                                                </ext:ComboBox>
                                                <ext:ComboBox runat="server" ID="modify_SUB_STORE_PLACE_NAME" FieldLabel="子库位" LabelAlign="Left" Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:TextField ID="modify_REMARK" runat="server" FieldLabel="备注" LabelAlign="Left" />
                                                <ext:Hidden ID="hidden_modify_objid" runat="server" />
                                                <ext:Hidden ID="hidden_Size" runat="server" />
                                                <ext:Hidden ID="hidden_Pattern" runat="server" />
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
                    <Listeners>
                        <Show Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).disable(true);}" />
                        <Hide Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).enable(true);}" />
                    </Listeners>
                </ext:Window>
                <ext:Window ID="winAdd" runat="server" Icon="MonitorAdd" Closable="false" Title="添加模具信息"
                    Width="360" Height="470" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
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
                                                <ext:TextField ID="add_MOULD_CODE" runat="server" FieldLabel="模具编号" LabelAlign="Left" />
                                                <ext:TextField ID="add_MOULD_NAME" runat="server" FieldLabel="模具名称" LabelAlign="Left" />
                                                <ext:ComboBox runat="server" ID="add_SIZE_NAME" FieldLabel="规格" LabelAlign="Left" >
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox runat="server" ID="add_PATTERN_NAME" FieldLabel="花纹" LabelAlign="Left"  >
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox runat="server" ID="add_BRAND_NAME" FieldLabel="商标" LabelAlign="Left" >
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox runat="server" ID="add_PLYRATING_NAME" FieldLabel="层级" LabelAlign="Left" >
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox runat="server" ID="add_LOAD_INDEX_NAME" FieldLabel="负荷" LabelAlign="Left" >
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox runat="server" ID="add_SPEED_LEVEL_NAME" FieldLabel="速度级别" LabelAlign="Left" >
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:TextField ID="add_SEC_BRAND" runat="server" FieldLabel="其余商标活块" LabelAlign="Left" />
                                                <ext:TextField ID="add_SEC_PATTERN" runat="server" FieldLabel="其余花纹活块" LabelAlign="Left" />
                                                <ext:ComboBox runat="server" ID="add_IN_TYPE" FieldLabel="类型" LabelAlign="Left" Editable="false">
                                                    <Items>
                                                        <ext:ListItem Text="普通模具" Value="普通模具" />
                                                        <ext:ListItem Text="弹簧模具" Value="弹簧模具" />
                                                    </Items>
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox runat="server" ID="add_STORE_NAME" FieldLabel="库房" LabelAlign="Left" Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                    <%--<DirectEvents>
                                                        <Change OnEvent="Add_StoreChange_Event"></Change>
                                                    </DirectEvents>--%>
                                                </ext:ComboBox>
                                                <ext:ComboBox runat="server" ID="add_STORE_PLACE_NAME" FieldLabel="库位" LabelAlign="Left" Editable="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                    <DirectEvents>
                                                        <Change OnEvent="Add_StorePlaceChange_Event"></Change>
                                                    </DirectEvents>
                                                </ext:ComboBox>
                                                <ext:ComboBox ID="add_SUB_STORE_PLACE_NAME" runat="server" FieldLabel="子库位" LabelAlign="Left">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:TextField ID="add_REMARK" runat="server" FieldLabel="备注" LabelAlign="Left" />
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
                    <Listeners>
                        <Show Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).disable(true);}" />
                        <Hide Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).enable(true);}" />
                    </Listeners>
                </ext:Window>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
