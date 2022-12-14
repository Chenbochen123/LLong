<%@ Page Language="C#" AutoEventWireup="true" CodeFile="BbeEquipControl.aspx.cs" Inherits="Plugins_Molding_BbeEquipControl" %>

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

        //var pnListSave = function () {
        //    Ext.Msg.confirm("提示", '您确定要保存修改的内容吗？', function (btn) {
        //        if (btn != "yes") { return; }

        //        var arr = new Array();
        //        var store = App.store;
        //        if (store.type == "store") {
        //            Ext.each(store.data.items, function (record) {
        //                arr.push(record.data);
        //            });
        //        }
        //        var str = Ext.encode(arr);
        //        App.direct.commandcolumn_direct_saveStandard(str, {
        //            success: function (result) {
        //                Ext.Msg.alert('提示', result);
        //            },

        //            failure: function (errorMsg) {
        //                Ext.Msg.alert('提示', errorMsg);
        //            }
        //        });
        //    });
        //}

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
                                <%--<ext:Button runat="server" Icon="PageSave" Text="保存" ID="btnSave">
                                    <Listeners>
                                        <Click Fn="pnListSave" />
                                    </Listeners>
                                </ext:Button>--%>
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
                                        <ext:ComboBox ID="cbxEquip" runat="server" FieldLabel="机台名称" LabelAlign="Right" Editable="true" EnableKeyEvents="true">
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

                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5" Title="成型机台控制设置">
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
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="EQUIP_CODE" />
                                                <ext:ModelField Name="RECORD_TIME" />
                                                <ext:ModelField Name="IS_CONTROL" />
                                                <ext:ModelField Name="C_SHOULDERWEDGE" />
                                                <ext:ModelField Name="C_BELT1" />
                                                <ext:ModelField Name="C_BELT2" />
                                                <ext:ModelField Name="C_BELT3" />
                                                <ext:ModelField Name="C_TREAD" />
                                                <ext:ModelField Name="C_INSIDELINE" />
                                                <ext:ModelField Name="C_LSIDEWALL" />
                                                <ext:ModelField Name="C_RSIDEWALL" />
                                                <ext:ModelField Name="C_BEAD" />
                                                <ext:ModelField Name="C_LWIRECOVERING" />
                                                <ext:ModelField Name="C_RWIRECOVERING" />
                                                <ext:ModelField Name="C_ISOLATIN" />
                                                <ext:ModelField Name="C_BELT0" />
                                                <ext:ModelField Name="C_CARCASS" />
                                                <ext:ModelField Name="C_NYLONC" />
                                                <ext:ModelField Name="BAKUP_FLAG" />
                                                <ext:ModelField Name="WORKSHOP_ID" />
                                                <ext:ModelField Name="WORKSHOP_ID_TIME" />
                                                <ext:ModelField Name="WORKSHOP_ID_DATE" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                                    <ext:Column ID="OBJID" runat="server" Text="编号" DataIndex="OBJID" Flex="1" Hidden="true" />
                                    <ext:Column ID="EQUIP_CODE" runat="server" Text="机台代码" DataIndex="EQUIP_CODE" Width="60" />
                                    <ext:Column ID="EQUIP_NAME" runat="server" Text="机台名称" DataIndex="EQUIP_NAME" Width="100" />
                                    <ext:Column ID="IS_CONTROL" runat="server" Text="卸胎" DataIndex="IS_CONTROL" Editable="true" Width="50">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="C_CC" runat="server" Text="超产" DataIndex="BAKUP_FLAG" Editable="true" Width="50">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="C_SHOULDERWEDGE" runat="server" Text="垫胶投入工位" DataIndex="C_SHOULDERWEDGE" Editable="true" Width="50">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column2" runat="server" Text="1#带束层投入工位" DataIndex="C_BELT1" Editable="true" Width="50">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column3" runat="server" Text="2#带束层投入工位" DataIndex="C_BELT2" Editable="true" Width="50">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column4" runat="server" Text="3#带束层投入工位" DataIndex="C_BELT3" Editable="true" Width="50">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column5" runat="server" Text="胎面投入工位" DataIndex="C_TREAD" Editable="true" Width="50">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column15" runat="server" Text="内衬层投入工位" DataIndex="C_INSIDELINE" Editable="true" Width="50">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column6" runat="server" Text="左胎侧投入工位" DataIndex="C_LSIDEWALL" Editable="true" Width="50">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column7" runat="server" Text="右胎侧投入工位" DataIndex="C_RSIDEWALL" Editable="true" Width="50">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column8" runat="server" Text="胎圈投入工位" DataIndex="C_BEAD" Editable="true" Width="50">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column9" runat="server" Text="左侧钢丝包布投入工位" DataIndex="C_LWIRECOVERING" Editable="true" Width="50">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column10" runat="server" Text="右侧钢丝包布投入工位" DataIndex="C_RWIRECOVERING" Editable="true" Width="50">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column11" runat="server" Text="隔离胶片投入工位" DataIndex="C_ISOLATIN" Editable="true" Width="50">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column12" runat="server" Text="0度投入工位" DataIndex="C_BELT0" Editable="true" Width="50">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column13" runat="server" Text="胎体投入工位" DataIndex="C_CARCASS" Editable="true" Width="50">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column14" runat="server" Text="尼龙包布投入工位" DataIndex="C_NYLONC" Editable="true" Width="50">
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column1" runat="server" Text="称重" DataIndex="WORKSHOP_ID" Editable="true" Width="50">
                                         <Renderer Fn="change" />
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
                    Height="520" Width="900" Hidden="true" BodyStyle="background-color:#fff;"
                    BodyPadding="5" >
                    <Items>
                        <ext:FormPanel ID="formPanelAdd" runat="server" MonitorValid="true" Flex="1" BodyPadding="5" Layout="ColumnLayout">
                            <FieldDefaults>
                                <CustomConfig>
                                    <ext:ConfigItem Name="LabelWidth" Value="200" Mode="Raw" />
                                    <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                                </CustomConfig>
                            </FieldDefaults>
                            <Items> 
                                <ext:Container ID="Container1" runat="server" Layout="FormLayout" ColumnWidth=".33" Padding="5">
                                    <Items>
                                        <ext:Checkbox ID="modify_is_control" runat="server" FieldLabel="控制:卸胎" Editable="true">
                                        </ext:Checkbox>
                                        <ext:TextField ID="modify_is_control_time" runat="server" FieldLabel="解控时间(h):卸胎" Editable="true">
                                        </ext:TextField>
                                        <ext:Checkbox ID="modify_belt1" runat="server" FieldLabel="控制:1#带束层投入工位" Editable="true">
                                        </ext:Checkbox>
                                        <ext:TextField ID="modify_belt1_time" runat="server" FieldLabel="解控时间(h):1#带束层投入工位" Editable="true">
                                        </ext:TextField>
                                        <ext:Checkbox ID="modify_belt3" runat="server" FieldLabel="控制:3#带束层投入工位" Editable="true">
                                        </ext:Checkbox>
                                        <ext:TextField ID="modify_belt3_time" runat="server" FieldLabel="解控时间(h):3#带束层投入工位" Editable="true">
                                        </ext:TextField>
                                        <ext:Checkbox ID="modify_lsidewall" runat="server" FieldLabel="控制:左胎侧投入工位" Editable="true">
                                        </ext:Checkbox>
                                        <ext:TextField ID="modify_lsidewall_time" runat="server" FieldLabel="解控时间(h):左胎侧投入工位" Editable="true">
                                        </ext:TextField>
                                        <ext:Checkbox ID="modify_bead" runat="server" FieldLabel="控制:胎圈投入工位" Editable="true">
                                        </ext:Checkbox>
                                        <ext:TextField ID="modify_bead_time" runat="server" FieldLabel="解控时间(h):胎圈投入工位" Editable="true">
                                        </ext:TextField>
                                        <ext:Checkbox ID="modify_insideline" runat="server" FieldLabel="控制:内衬层投入工位" Editable="true">
                                        </ext:Checkbox>
                                        <ext:TextField ID="modify_insideline_time" runat="server" FieldLabel="解控时间(h):内衬层投入工位" Editable="true">
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="Container2" runat="server" Layout="FormLayout" ColumnWidth=".33" Padding="5">
                                    <Items>
                                        <ext:Checkbox ID="modify_lwirecovering" runat="server" FieldLabel="控制:左侧钢丝包布投入工位" Editable="true">
                                        </ext:Checkbox>
                                        <ext:TextField ID="modify_lwirecovering_time" runat="server" FieldLabel="解控时间(h):左侧钢丝包布投入工位" Editable="true">
                                        </ext:TextField>
                                        <ext:Checkbox ID="modify_belt0" runat="server" FieldLabel="控制:0度投入工位" Editable="true">
                                        </ext:Checkbox>
                                        <ext:TextField ID="modify_belt0_time" runat="server" FieldLabel="解控时间(h):0度投入工位" Editable="true">
                                        </ext:TextField>
                                        <ext:Checkbox ID="modify_nylonc" runat="server" FieldLabel="控制:尼龙包布投入工位" Editable="true">
                                        </ext:Checkbox>
                                        <ext:TextField ID="modify_nylonc_time" runat="server" FieldLabel="解控时间(h):尼龙包布投入工位" Editable="true">
                                        </ext:TextField>
                                        <ext:Checkbox ID="modify_cc" runat="server" FieldLabel="控制:超产" Editable="true">
                                        </ext:Checkbox>
                                        <ext:TextField ID="modify_cc_time" runat="server" FieldLabel="解控时间(h):超产" Editable="true">
                                        </ext:TextField>
                                        <ext:Checkbox ID="modify_shoulderwedge" runat="server" FieldLabel="控制:垫胶投入工位" Editable="true">
                                        </ext:Checkbox>
                                        <ext:TextField ID="modify_shoulderwedge_time" runat="server" FieldLabel="解控时间(h):垫胶投入工位" Editable="true">
                                        </ext:TextField>
                                        <ext:Checkbox ID="modify_belt2" runat="server" FieldLabel="控制:2#带束层投入工位" Editable="true">
                                        </ext:Checkbox>
                                        <ext:TextField ID="modify_belt2_time" runat="server" FieldLabel="解控时间(h):2#带束层投入工位" Editable="true">
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>

                                <ext:Container ID="Container4" runat="server" Layout="FormLayout" ColumnWidth=".33" Padding="5">
                                    <Items>
                                        <ext:Checkbox ID="modify_rsidewall" runat="server" FieldLabel="控制:右胎侧投入工位" Editable="true">
                                        </ext:Checkbox>
                                        <ext:TextField ID="modify_rsidewall_time" runat="server" FieldLabel="解控时间(h):右胎侧投入工位" Editable="true">
                                        </ext:TextField>
                                        <ext:Checkbox ID="modify_isolatin" runat="server" FieldLabel="控制:隔离胶片投入工位" Editable="true">
                                        </ext:Checkbox>
                                        <ext:TextField ID="modify_isolatin_time" runat="server" FieldLabel="解控时间(h):隔离胶片投入工位" Editable="true">
                                        </ext:TextField>
                                        <ext:Checkbox ID="modify_rwirecovering" runat="server" FieldLabel="控制:右侧钢丝包布投入工位" Editable="true">
                                        </ext:Checkbox>
                                        <ext:TextField ID="modify_rwirecovering_time" runat="server" FieldLabel="解控时间(h):右侧钢丝包布投入工位" Editable="true">
                                        </ext:TextField>
                                        <ext:Checkbox ID="modify_carcass" runat="server" FieldLabel="控制:胎体投入工位" Editable="true">
                                        </ext:Checkbox>
                                        <ext:TextField ID="modify_carcass_time" runat="server" FieldLabel="解控时间(h):胎体投入工位" Editable="true">
                                        </ext:TextField>
                                        <ext:Checkbox ID="modify_tread" runat="server" FieldLabel="控制:胎面投入工位" Editable="true">
                                        </ext:Checkbox>
                                        <ext:TextField ID="modify_tread_time" runat="server" FieldLabel="解控时间(h):胎面投入工位" Editable="true">
                                        </ext:TextField>
                                        <ext:Checkbox ID="modify_weight" runat="server" FieldLabel="控制:称重" Editable="true">
                                        </ext:Checkbox>
                                        <ext:TextField ID="modify_weight_time" runat="server" FieldLabel="解控时间(h):称重" Editable="true">
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>
                            </Items>

                            <Listeners>
                                <ValidityChange Handler="#{btnModifySave}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                        <ext:FormPanel ID="pnlAdd" runat="server" BodyPadding="5" Layout="FormLayout">
                            <FieldDefaults>
                                <CustomConfig>
                                    <ext:ConfigItem Name="LabelWidth" Value="200" Mode="Raw" />
                                    <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                                </CustomConfig>
                            </FieldDefaults>
                            <Items> 
                                <ext:ComboBox ID="cbxDecontrolReason" runat="server" FieldLabel="解控原因" LabelAlign="Right" Width="800"  Editable="true" EnableKeyEvents="true">
                                </ext:ComboBox>
                                <ext:TextField ID="txtbeizhu" runat="server" FieldLabel="说明" Editable="true" AllowBlank="false" Width="800" LabelAlign="Right">
                                </ext:TextField>
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
