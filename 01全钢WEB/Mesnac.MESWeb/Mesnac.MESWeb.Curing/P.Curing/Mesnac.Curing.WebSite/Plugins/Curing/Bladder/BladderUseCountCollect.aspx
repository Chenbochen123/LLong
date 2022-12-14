<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BladderUseCountCollect.aspx.cs" Inherits="Plugins_Curing_Bladder_BladderUseCountCollect" %>

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

        //-------部门-----查询带回弹出框--BEGIN
        //var McUI_SearchBox_SearchBoxCuringEquip_Request = function (record) {//返回值处理
        var McUI_SearchBox_SearchBoxCbeCuringEquip_Request = function (record) {
            if (!App.AddConfigWin.hidden) {
                //App.txt_add_equip.setValue(record.data.EQUIP_NAME);
                //App.hidden_add_equip_id.setValue(record.data.OBJID);
            }
            else {
                App.txt_equip.getTrigger(0).show();
                App.txt_equip.setValue(record.data.EQUIP_NAME);
                App.hidden_equip_id.setValue(record.data.OBJID);
            }
        }

        var SelectCuringEquip = function (field, trigger, index) {//查询
            switch (index) {
                case 0:
                    field.getTrigger(0).hide();
                    field.setValue('');
                    App.hidden_equip_id.setValue("");
                    field.getEl().down('input.x-form-text').setStyle('background', "white");
                    break;
                case 1:
                    App.McUI_SearchBox_SearchBoxCbeCuringEquip_Window.show();
                    break;
            }
        }

        var UpdateCuringEquip = function (field, trigger, index) {//查询
            App.McUI_SearchBox_SearchBoxCbeCuringEquip_Window.show();
        }
        Ext.create("Ext.window.Window", {//查询带回窗体
            id: "McUI_SearchBox_SearchBoxCbeCuringEquip_Window",
            height: 430,
            hidden: true,
            width: 360,
            html: "<iframe src='../../../McUI/SearchBox/SearchBoxCbeCuringEquip.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择机台",
            modal: true
        })
        //------------查询带回弹出框--END 

        var pnlListFresh = function () {
            if (App.txtBeginDate.getValue() > App.txtEndDate.getValue()) {
                Ext.Msg.alert('操作', '开始时间不能大于结束时间！');
                return false;
            }
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
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

        //点击修改按钮
        var commandcolumn_direct_edit = function (record) {
            var ObjId = record.data.OBJID;
            var Remark = record.data.REMARK;
            App.direct.commandcolumn_direct_edit(ObjId, Remark, {
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
                    //Ext.Msg.alert('操作', result);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }
    </script>
</head>
<body>    
    <form id="form1" runat="server">
        <ext:Hidden ID="hidden_update_objId" runat="server"></ext:Hidden>
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
        OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmQCRecord" runat="server" />
        <ext:Viewport ID="vpQCRecord" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnMEquipControl" runat="server" Region="North" Height="120">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbMEquipControl">
                            <Items>
                                <ext:ToolbarSeparator ID="ctl" />
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <Listeners>
                                        <Click Fn="pnlListFresh" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="ct2" />
                                <ext:Button runat="server" Icon="PageExcel" Text="导出" ID="btnExport">
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

                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="入库开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:FieldContainer runat="server" FieldLabel="入库结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txtBatch" Flex="1" FieldLabel="批次" runat="server" LabelAlign="Right">
                                        </ext:TextField>
                                        </Items>
                                </ext:Container>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxBuyType" runat="server" FieldLabel="采购类型" LabelAlign="Right" Editable="true" EnableKeyEvents="true">
                                        </ext:ComboBox>
                                        <ext:ComboBox ID="cbxBladderType" runat="server" FieldLabel="胶囊类型" LabelAlign="Right" Editable="true" EnableKeyEvents="true">
                                        </ext:ComboBox>
                                        <ext:ComboBox ID="cbxFactory" runat="server" FieldLabel="胶囊厂家" LabelAlign="Right" Editable="true" EnableKeyEvents="true">
                                        </ext:ComboBox>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxBladderSpec" runat="server" FieldLabel="胶囊规格" LabelAlign="Right" Editable="true" EnableKeyEvents="true">
                                        </ext:ComboBox>
                                        <ext:ComboBox ID="cbxChange" runat="server" FieldLabel="更换原因" LabelAlign="Right" Editable="true" EnableKeyEvents="true" >
                                        </ext:ComboBox>
                                        <ext:TriggerField ID="txt_equip" runat="server" FieldLabel="机台" LabelAlign="Right"
                                            Editable="false">
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                                <ext:FieldTrigger Icon="Search" />
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Fn="SelectCuringEquip" />
                                            </Listeners>
                                        </ext:TriggerField>
                                        <ext:Hidden ID="hidden_equip_id" runat="server" />
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container10" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtBladderNo" Flex="1" FieldLabel="胶囊编号" runat="server" LabelAlign="Right">
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

                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5" Title="胶囊信息">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <View><ext:GridView EnableTextSelection="true"></ext:GridView></View>
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="10">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">                                            
                                            <Fields>                                                
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="BLADDER_CODE" />
                                                <ext:ModelField Name="BUY_TYPE_NAME" />
                                                <ext:ModelField Name="TYPE_NEW_NAME" />
                                                <ext:ModelField Name="SPEC_NAME" />
                                                <ext:ModelField Name="BLADDER_BATCH" />
                                                <ext:ModelField Name="USER_NAME" />
                                                <ext:ModelField Name="RECORD_DATE" />
                                                <ext:ModelField Name="REMARK" />
                                                <ext:ModelField Name="DUMMY1" />
                                                <ext:ModelField Name="STATE" />
                                                <ext:ModelField Name="FACTORY_NAME" />
                                                <ext:ModelField Name="OBJID_FLAG" />
                                                <ext:ModelField Name="REASON_NAME" />
                                                <ext:ModelField Name="EQUIP_NAME" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">                              
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                                    <%--<ext:Column ID="OBJID" runat="server" Text="编号" DataIndex="OBJID" Width="100" Hidden="TRUE" />--%>
                                    <ext:Column ID="BLADDER_CODE" runat="server" Text="胶囊编号" Selectable="true" DataIndex="BLADDER_CODE" Width="120" />
                                    <ext:Column ID="BUY_TYPE_NAME" runat="server" Text="采购类型" Selectable="true" DataIndex="BUY_TYPE_NAME" Width="80" />
                                    <ext:Column ID="TYPE_NEW_NAME" runat="server" Text="胶囊类型" DataIndex="TYPE_NEW_NAME" Width="80" />
                                    <ext:Column ID="SPEC_NAME" runat="server" Text="胶囊规格" DataIndex="SPEC_NAME" Width="160" />
                                    <ext:Column ID="BLADDER_BATCH" runat="server" Text="批次" DataIndex="BLADDER_BATCH" Width="60"  />
                                    <ext:Column ID="FACTORY" runat="server" Text="厂家" DataIndex="FACTORY_NAME" Width="160"  />
                                    <ext:Column ID="DUMMY1" runat="server" Text="使用次数" DataIndex="DUMMY1" Width="80"  />
                                    <ext:Column ID="REASON_NAME" runat="server" Text="病疵" DataIndex="REASON_NAME" Width="80"  />
                                    <ext:Column ID="EQUIP_NAME" runat="server" Text="机台" DataIndex="EQUIP_NAME" Width="80"  />
                                    <ext:Column ID="STATE" runat="server" Text="状态" DataIndex="STATE" Width="80"  hidden="true"/>
                                    <ext:Column ID="OBJID_FLAG" runat="server" Text="更换记录编号" DataIndex="OBJID_FLAG" Width="80" hidden="true" />
                                    <%--<ext:Column ID="RECORD_USER_NAME" runat="server" Text="入库人" DataIndex="USER_NAME" Width="80" />
                                    <ext:DateColumn ID="RECORD_DATE" runat="server" Text="入库时间" DataIndex="RECORD_DATE" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="REMARK" runat="server" Text="备注" DataIndex="REMARK" Width="100" />--%>
                                    <%--<ext:CommandColumn ID="commandCol" runat="server" Width="120" Text="操作" Align="Center">
                                        <Commands>
                                            <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
                                                <ToolTip Text="修改本条数据" />
                                            </ext:GridCommand>
                                            <ext:CommandSeparator />
                                            <ext:GridCommand Icon="Delete" CommandName="Delete" Text="删除">
                                                <ToolTip Text="删除本条数据" />
                                            </ext:GridCommand>
                                            <ext:CommandSeparator />
                                        </Commands>
                                        <Listeners>
                                            <Command Handler="return commandcolumn_click(command, record);" />
                                        </Listeners>
                                    </ext:CommandColumn>--%>
                                </Columns>
                            </ColumnModel>
                            <BottomBar>
                                <ext:PagingToolbar ID="pageToolBar" runat="server">
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
        <ext:Window ID="AddConfigWin" runat="server" Icon="MonitorAdd" Closable="false" Title="添加胶囊入库信息"
            Width="580" Height="340" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
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
                        <ext:Container ID="Container4" runat="server" AutoHeight="true">
                            <Items>
                                <ext:FieldSet ID="FieldSet1" runat="server" Title="基本信息" Layout="AnchorLayout" DefaultAnchor="100%"
                                    Padding="5">
                                    <Items>
                                        <ext:Container ID="Container5" runat="server" Layout="HBoxLayout" MarginSpec="5 5 5 5">
                                            <Items>
                                                <ext:DateField ID="txtAddConfigDate" runat="server" Flex="1" Editable="false" Vtype="daterange"
                                                    FieldLabel="入库日期" LabelAlign="Right" EnableKeyEvents="true" Format="yyyy-MM-dd">
                                                </ext:DateField>
                                                <ext:TimeField ID="TimeField1" runat="server" Width="80" Editable="true" Hidden="true" />
                                                <ext:TimeField ID="TimeField2" runat="server" Width="80" Editable="true" Hidden="true" />
                                                <ext:TextField ID="txtAddBatch" Flex="1" FieldLabel="入库批次" AllowBlank="false" IndicatorText="*" IndicatorCls="red-text"
                                                    runat="server" LabelAlign="Right" EnforceMaxLength ="true" MaxLength="1">
                                                </ext:TextField>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="Container6" runat="server" Layout="HBoxLayout" MarginSpec="5 5 5 5">
                                            <Items>
                                                <ext:ComboBox ID="cboAddBuy" AllowBlank="false" IndicatorText="*" IndicatorCls="red-text"
                                                    runat="server" Flex="1" Editable="false" FieldLabel="采购类型" LabelAlign="Right">
                                                </ext:ComboBox>
                                                <ext:ComboBox ID="cboAddType" AllowBlank="false" IndicatorText="*" IndicatorCls="red-text"
                                                    runat="server" Flex="1" Editable="false" FieldLabel="胶囊类型" LabelAlign="Right">
                                                </ext:ComboBox>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="Container7" runat="server" Layout="HBoxLayout" MarginSpec="5 5 5 5">
                                            <Items>
                                                <ext:ComboBox ID="cboAddSpec" AllowBlank="false" IndicatorText="*" IndicatorCls="red-text"
                                                    runat="server" Flex="1" Editable="false" FieldLabel="胶囊规格" LabelAlign="Right">
                                                </ext:ComboBox>
                                                <ext:TextField ID="txtStorageNum" Flex="1" FieldLabel="入库个数" AllowBlank="false" IndicatorText="*" IndicatorCls="red-text"
                                                    runat="server" LabelAlign="Right">
                                                </ext:TextField>
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:FieldSet>
                                <ext:FieldSet ID="FieldSet3" runat="server" Title="备注" Layout="AnchorLayout" DefaultAnchor="100%"
                                    Padding="5">
                                    <Items>
                                        <ext:Container ID="Container9" runat="server" Layout="HBoxLayout" MarginSpec="5 5 5 5">
                                            <Items>
                                                <ext:TextArea ID="txtMemNote" runat="server" Flex="1">
                                                </ext:TextArea>
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:FieldSet>
                            </Items>
                        </ext:Container>
                    </Items>
                    <Listeners>
                        <ValidityChange Handler="#{btnAddSave}.setDisabled(!valid);" />
                    </Listeners>
                </ext:FormPanel>
            </Items>
            <Buttons>
                <ext:Button ID="btnAddSave" runat="server" Text="确定" Icon="Accept" Disabled="true">
                    <DirectEvents>
                        <Click OnEvent="BtnAddSave_Click">
                            <EventMask ShowMask="true" Msg="Saving..." MinDelay="50" />
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
                <Show Handler="for(var i=0;i<#{Viewport1}.items.length;i++){#{Viewport1}.getComponent(i).disable(true);}" />
                <Hide Handler="for(var i=0;i<#{Viewport1}.items.length;i++){#{Viewport1}.getComponent(i).enable(true);}" />
            </Listeners>
        </ext:Window>
        <ext:Window ID="ModifyConfigWin" runat="server" Closable="false" Icon="Add" Title="修改胶囊入库信息"
            Width="350" Height="180" Hidden="true" Modal="false">
            <Items>
                <ext:FormPanel ID="FormPanel1" runat="server" BodyPadding="5">
                    <FieldDefaults>
                        <CustomConfig>
                            <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                            <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                        </CustomConfig>
                    </FieldDefaults>
                    <Items>
                        <ext:Container ID="Container14" runat="server" AutoHeight="true">
                            <Items>
                                <ext:FieldSet ID="FieldSet2" runat="server" Title="备注" Layout="AnchorLayout" DefaultAnchor="100%"
                                    Padding="5">
                                    <Items>
                                        <ext:Container ID="Container8" runat="server" Layout="HBoxLayout" MarginSpec="5 5 5 5">
                                            <Items>
                                                <ext:TextArea ID="txtModifyRemark" runat="server" Flex="1">
                                                </ext:TextArea>
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:FieldSet>
                            </Items>
                        </ext:Container>
                    </Items>
                    <Listeners>
                        <ValidityChange Handler="#{btnModifySave}.setDisabled(!valid);" />
                    </Listeners>
                </ext:FormPanel>
            </Items>
            <Buttons>
                <ext:Button ID="btnModifySave" runat="server" Text="确定" Icon="Accept" Disabled="true">
                    <DirectEvents>
                        <Click OnEvent="BtnModifySave_Click">
                            <EventMask ShowMask="true" Msg="Saving..." MinDelay="50" />
                        </Click>
                    </DirectEvents>
                </ext:Button>
                <ext:Button ID="btnModifyCancel" runat="server" Text="取消" Icon="Cancel">
                    <DirectEvents>
                        <Click OnEvent="BtnModifyCancel_Click">
                        </Click>
                    </DirectEvents>
                </ext:Button>
            </Buttons>
            <Listeners>
                <Show Handler="for(var i=0;i<#{Viewport1}.items.length;i++){#{Viewport1}.getComponent(i).disable(true);}" />
                <Hide Handler="for(var i=0;i<#{Viewport1}.items.length;i++){#{Viewport1}.getComponent(i).enable(true);}" />
            </Listeners>
        </ext:Window>
    </form>
</body>
</html>
