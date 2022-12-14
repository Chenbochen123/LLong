<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BladderStorageIn.aspx.cs" Inherits="Plugins_Curing_Bladder_BladderStorageIn" %>

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
            App.direct.commandcolumn_direct_edit(ObjId,Remark, {
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
                                <ext:Button runat="server" Icon="Add" Text="新增" ID="btnAdd">
                                <DirectEvents>
                                    <Click OnEvent="btnAdd_Click">
                                    </Click>
                                </DirectEvents>
                                <ToolTips>
                                    <ext:ToolTip runat="server" Html="新增" ID="ctl350" />
                                </ToolTips>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="ct3" />
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
                                        </Items>
                                </ext:Container>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxBuyType" runat="server" FieldLabel="采购类型" LabelAlign="Right" Editable="true" EnableKeyEvents="true">
                                        </ext:ComboBox>
                                        <ext:ComboBox ID="cbxBladderType" runat="server" FieldLabel="胶囊类型" LabelAlign="Right" Editable="true" EnableKeyEvents="true">
                                        </ext:ComboBox>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxBladderSpec" runat="server" FieldLabel="胶囊规格" LabelAlign="Right" Editable="true" EnableKeyEvents="true">
                                        </ext:ComboBox>
                                        <ext:ComboBox ID="cbxFactory" runat="server" FieldLabel="胶囊厂家" LabelAlign="Right" Editable="true" EnableKeyEvents="true">
                                        </ext:ComboBox>
                                        <ext:ComboBox ID="cbxChange" runat="server" FieldLabel="更换原因" LabelAlign="Right" Editable="true" EnableKeyEvents="true" Hidden ="true">
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

                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5" Title="胶囊信息">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <View><ext:GridView EnableTextSelection="true"></ext:GridView></View>
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="30">
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
                                                <ext:ModelField Name="BLADDER_SPEC" />
                                                <ext:ModelField Name="BLADDER_BATCH" />
                                                <ext:ModelField Name="USER_NAME" />
                                                <ext:ModelField Name="RECORD_DATE" />
                                                <ext:ModelField Name="REMARK" />
                                                <ext:ModelField Name="DUMMY1" />
                                                <ext:ModelField Name="STATE" />
                                                <ext:ModelField Name="FACTORY_NAME" />
                                                <ext:ModelField Name="DUMMY5" />
                                                <ext:ModelField Name="YJ_NUM" />
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
                                    <ext:Column ID="BLADDER_SPEC" runat="server" Text="规格代码" DataIndex="BLADDER_SPEC" Width="120" />
                                    <ext:Column ID="BLADDER_BATCH" runat="server" Text="批次" DataIndex="BLADDER_BATCH" Width="60"  />
                                    <ext:Column ID="DUMMY1" runat="server" Text="使用次数" DataIndex="DUMMY1" Width="70"  />
                                    <ext:Column ID="YJ_NUM" runat="server" Text="预警次数" DataIndex="YJ_NUM" Width="100"  />
                                    <ext:Column ID="STATE" runat="server" Text="状态" DataIndex="STATE" Width="50"  />
                                    <ext:Column ID="FACTORY_NAME" runat="server" Text="厂家" DataIndex="FACTORY_NAME" Width="50"  />
                                    <ext:Column ID="RECORD_USER_NAME" runat="server" Text="入库人" DataIndex="USER_NAME" Width="80" />
                                    <ext:DateColumn ID="RECORD_DATE" runat="server" Text="入库时间" DataIndex="RECORD_DATE" Width="140" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="REMARK" runat="server" Text="备注" DataIndex="REMARK" Width="100" />
                                    <ext:CommandColumn ID="commandCol" runat="server" Width="120" Text="操作" Align="Center">
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
                            <Features>
                                <ext:Summary runat="server"></ext:Summary>
                            </Features>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>
        <ext:Window ID="AddConfigWin" runat="server" Icon="MonitorAdd" Closable="false" Title="添加胶囊入库信息"
            Width="580" Height="360" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
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
                                        <ext:Container ID="Container10" runat="server" Layout="HBoxLayout" MarginSpec="5 5 5 5">
                                            <Items>
                                                <ext:ComboBox ID="cboAddFactory" AllowBlank="false" IndicatorText="*" IndicatorCls="red-text"
                                                    runat="server" Editable="false" FieldLabel="胶囊厂家" LabelAlign="Right" Width="262px" >
                                                </ext:ComboBox>
                                                <ext:TextField ID="txtMaxNum" Flex="1" FieldLabel="最大使用次数" AllowBlank="false" IndicatorText="*" IndicatorCls="red-text"
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
            Width="580" Height="360" Hidden="true" Modal="false">
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
                                <ext:FieldSet ID="FieldSet4" runat="server" Title="基本信息" Layout="AnchorLayout" DefaultAnchor="100%"
                                    Padding="5">
                                    <Items>
                                        <ext:Container ID="Container12" runat="server" Layout="HBoxLayout" MarginSpec="5 5 5 5">
                                            <Items>
                                                <ext:ComboBox ID="cboModifyBuy" AllowBlank="false" IndicatorText="*" IndicatorCls="red-text"
                                                    runat="server" Flex="1" Editable="false" FieldLabel="采购类型" LabelAlign="Right">
                                                </ext:ComboBox>
                                                <ext:ComboBox ID="cboModifyType" AllowBlank="false" IndicatorText="*" IndicatorCls="red-text"
                                                    runat="server" Flex="1" Editable="false" FieldLabel="胶囊类型" LabelAlign="Right">
                                                </ext:ComboBox>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="Container13" runat="server" Layout="HBoxLayout" MarginSpec="5 5 5 5">
                                            <Items>
                                                <ext:ComboBox ID="cboModifySpec" AllowBlank="false" IndicatorText="*" IndicatorCls="red-text"
                                                    runat="server" Flex="1" Editable="false" FieldLabel="胶囊规格" LabelAlign="Right">
                                                </ext:ComboBox>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="Container15" runat="server" Layout="HBoxLayout" MarginSpec="5 5 5 5">
                                            <Items>
                                                <ext:ComboBox ID="cboModifyFactory" AllowBlank="false" IndicatorText="*" IndicatorCls="red-text"
                                                    runat="server" Editable="false" FieldLabel="胶囊厂家" LabelAlign="Right" Width="262px" >
                                                </ext:ComboBox>
                                                <ext:TextField ID="txtModifyMaxNum" Flex="1" FieldLabel="最大使用次数" AllowBlank="false" IndicatorText="*" IndicatorCls="red-text"
                                                    runat="server" LabelAlign="Right">
                                                </ext:TextField>
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:FieldSet>
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
