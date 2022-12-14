<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EquipCheckBomConfig2.aspx.cs" Inherits="Plugins_Curing_BaseData_EquipCheckBomConfig2" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
         .x-grid-row-collapsed .x-grid-cell {
            background-color: #FF8C69 !important;
        }
        .x-grid-record-green table{ color: green; }
    </style>
    <script type="text/javascript">

        var pnlListFresh = function () {
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }


        //区分删除操作，并进行二次确认操作
        var commandcolumn_click_confirm = function (command, record) {
            if (command.toLowerCase() == "edit") {
                commandcolumn_direct_edit(record);
            }
            return false;
        };

        //根据按钮类别进行删除和编辑操作
        var commandcolumn_click = function (command, record) {
            commandcolumn_click_confirm(command, record);
            return false;
        };
        var commandcolumn_direct_edit = function (record) {
            var ObjID = record.data.OBJID;
            debugger;
            App.hidden_objid.setValue(ObjID);
            App.direct.commandcolumn_direct_edit(ObjID, {
                success: function (result) {
                },
                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        var template = '<span style="color:{0};">{1}</span>';
        var change = function (value) {
            return Ext.String.format(template, (value == "1") ? "red" : "green", value = (value == 1 ? "控制" : "否"));
            //  value = (value == 1 ? "是" : "否");

        };
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager ID="rmMEquipControl" runat="server" />
        <ext:Viewport ID="vpMEquipControl" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnMEquipControl" runat="server" Region="North" Height="90">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbMEquipControl">
                            <Items>

                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <Listeners>
                                        <Click Fn="pnlListFresh" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="tsBegin" />
                                <ext:ToolbarSeparator ID="tsEnd" />
                                <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                                <ext:ToolbarFill ID="tfEnd" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".34"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="textequip" runat="server" FieldLabel="机台名称" LabelAlign="Right" Editable="true" EnableKeyEvents="true">
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

                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5" Title="硫化机台控制设置">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="15">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="EQUIP_CODE" />
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="IS_CHECKBOM" />
                                                <ext:ModelField Name="IS_CHECKCONTROL" />
                                                <ext:ModelField Name="IS_CHECKMATER" />
                                                <ext:ModelField Name="RECORD_TIME" />
                                                <ext:ModelField Name="IS_CHECKBOM_TIME" />
                                                <ext:ModelField Name="IS_CHECKCONTROL_TIME" />
                                                <ext:ModelField Name="IS_CHECKMATER_TIME" />
                                                <ext:ModelField Name="REMARK" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />

                                    <ext:Column runat="server" Text="设备编码" DataIndex="EQUIP_CODE" Width="70" />
                                    <ext:Column runat="server" Text="设备名称" DataIndex="EQUIP_NAME" Width="60" />
                                    <ext:Column ID="Column11" runat="server" Text="是否验证BOM" DataIndex="IS_CHECKBOM" Editable="true" Width="100">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column3" runat="server" Text="解控时长：BOM" DataIndex="IS_CHECKBOM_TIME" Editable="true" Width="50" Hidden="true">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column8" runat="server" Text="是否验证人员" DataIndex="IS_CHECKCONTROL" Editable="true" Width="100">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column9" runat="server" Text="解控时长：人员" DataIndex="IS_CHECKCONTROL_TIME" Editable="true" Width="50" Hidden="true">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column10" runat="server" Text="是否验证物料" DataIndex="IS_CHECKMATER" Editable="true" Width="100">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column12" runat="server" Text="解控时长：物料" DataIndex="IS_CHECKMATER_TIME" Editable="true" Width="50" Hidden="true">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column13" runat="server" Text="修改时间" DataIndex="RECORD_TIME" Editable="true" Width="50" Hidden="true">
                                    </ext:Column>
                                    <ext:CommandColumn ID="commandCol" runat="server" Width="60" Text="操作" Align="Center">
                                        <Commands>
                                            <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
                                                <ToolTip Text="修改本条数据" />
                                            </ext:GridCommand>
                                        </Commands>
                                        <Listeners>
                                            <Command Handler="return commandcolumn_click(command, record);" />
                                        </Listeners>
                                    </ext:CommandColumn>
                                </Columns>
                            </ColumnModel>
                            <View>
                                <ext:GridView ID="gvRows" runat="server" EnableTextSelection="true">
                                </ext:GridView>
                            </View>
                            <Plugins>
                                <ext:CellEditing ID="cellEditing1" runat="server" ClicksToEdit="1">
                                </ext:CellEditing>
                            </Plugins>
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
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>

                <ext:Window ID="winModify" runat="server" Icon="MonitorEdit" Closable="false" Layout="Form" Modal="true" Title="更改控制信息"
                    Height="400" Width="600" Hidden="true" BodyStyle="background-color:#fff;"
                    BodyPadding="5" >
                    <Items>
                        <ext:FormPanel ID="pnlAdd" runat="server" BodyPadding="5" Layout="FormLayout">
                            <FieldDefaults>
                                <CustomConfig>
                                    <ext:ConfigItem Name="LabelWidth" Value="200" Mode="Raw" />
                                    <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                                </CustomConfig>
                            </FieldDefaults>
                            <Items> 
                                <ext:FieldSet runat="server" Title="更改控制信息" Layout="AnchorLayout" DefaultAnchor="100%">
                                    <Items>
                                        <ext:FieldContainer ID="FieldContainer3" runat="server" Layout="HBoxLayout" AnchorHorizontal="100%">
                                            <Items>
                                                <ext:Checkbox ID="checkbom" runat="server" FieldLabel="是否验证BOM" Editable="true">
                                                </ext:Checkbox>
                                                <ext:TextField ID="txtbom" runat="server" FieldLabel="解控时间(h):BOM" Editable="true" Width="150" AllowBlank="false">
                                                </ext:TextField>
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:FieldContainer ID="FieldContainer1" runat="server" Layout="HBoxLayout" AnchorHorizontal="100%">
                                            <Items>
                                                <ext:Checkbox ID="checkuser" runat="server" FieldLabel="是否验证人员" Editable="true">
                                                </ext:Checkbox>
                                                <ext:TextField ID="txtuser" runat="server" FieldLabel="解控时间(h):人员" Editable="true"  Width="150" AllowBlank="false">
                                                </ext:TextField>
                                            </Items>
                                        </ext:FieldContainer>
                                    <ext:FieldContainer ID="FieldContainer2" runat="server" Layout="HBoxLayout" AnchorHorizontal="100%">
                                        <Items>
                                            <ext:Checkbox ID="checkmater" runat="server" FieldLabel="是否验证物料" Editable="true">
                                            </ext:Checkbox>
                                            <ext:TextField ID="txtmater" runat="server" FieldLabel="解控时间(h):物料" Editable="true" Width="150" AllowBlank="false">
                                            </ext:TextField>
                                        </Items>
                                    </ext:FieldContainer>
                                    <ext:FieldContainer ID="FieldContainer4" runat="server" Layout="HBoxLayout" AnchorHorizontal="100%">
                                        <Items>
                                            <ext:ComboBox ID="cbxDecontrolReason" runat="server" FieldLabel="解控原因" Width="500" LabelAlign="Left" Editable="true" EnableKeyEvents="true">
                                            </ext:ComboBox>
                                        </Items>
                                    </ext:FieldContainer>
                                    <ext:FieldContainer ID="FieldContainer5" runat="server" Layout="HBoxLayout" AnchorHorizontal="100%">
                                        <Items>
                                            <ext:TextField ID="txtbeizhu" runat="server" FieldLabel="说明" Editable="true" AllowBlank="false" Width="500">
                                            </ext:TextField>
                                        </Items>
                                    </ext:FieldContainer>
                                    </Items>
                                </ext:FieldSet>
                            </Items>

                            <Listeners>
                                <ValidityChange Handler="#{btnModifySave}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="btnAddSave" runat="server" Text="确定" Icon="Accept">
                            <DirectEvents>
                                <Click OnEvent="btnAddSave_Click">
                                    <EventMask ShowMask="true" Msg="保存中..." MinDelay="50" />
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button ID="btnAddCancel" runat="server" Text="取消" Icon="Cancel">
                            <DirectEvents>
                                <Click OnEvent="btnCancel_Click">
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                    </Buttons>
                </ext:Window>
                <ext:Hidden ID="hidden_objid" runat="server"></ext:Hidden>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
