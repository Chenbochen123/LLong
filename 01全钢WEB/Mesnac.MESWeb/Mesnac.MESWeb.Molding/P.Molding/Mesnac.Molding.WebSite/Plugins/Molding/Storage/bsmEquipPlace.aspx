<%@ Page Language="C#" AutoEventWireup="true" CodeFile="bsmEquipPlace.aspx.cs" Inherits="Plugins_Molding_Storage_bsmEquipPlace" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell {
            background-color: #FF8C69 !important;
        }

        .x-grid-record-green table {
            color: green;
        }
    </style>
    <script type="text/javascript">
        var thisDirUrl = "<%= Page.ResolveUrl("./") %>";
        var thisRootUrl = "<%= Page.ResolveUrl("~/") %>";
        var pnlListFresh = function () {
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }

        var tgrSearchMaterialCode_Click = function (item, trigger, index) {//胎胚规格查询
            if (index == 0) {
                item.setValue('');
                App.hdnSearchMaterialId.setValue('');
            }
            else if (index == 1) {
                App.McUI_SearchBox_SearchBoxSbmMaterialMolding_Window.show();
            }
        }
        var McUI_SearchBox_SearchBoxSbmMaterialMolding_Request = function (record) {
            App.tgrAddMaterialCode.setValue(record.data.MATERIAL_NAME);
            App.hdnSearchMaterialId.setValue(record.data.OBJID);
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
            debugger;
            var ObjID = record.data.STORE_PLACE_ID;
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
            return Ext.String.format(template, (value == "1") ? "red" : "green", value = (value == 1 ? "是" : "否"));
            //  value = (value == 1 ? "是" : "否");

        };

        Ext.create("Ext.window.Window", {//物料查询带回窗体
            id: "McUI_SearchBox_SearchBoxSbmMaterialMolding_Window",
            height: 430,
            hidden: true,
            width: 360,
            html: "<iframe src='" + thisRootUrl + "McUI/SearchBox/SearchBoxSbmMaterialMolding.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "选择物料",
            modal: true
        })
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

                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5" Title="成型产出库位设置">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="15">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="STORE_PLACE_ID">
                                            <Fields>
                                                <ext:ModelField Name="STORE_PLACE_ID" />
                                                <ext:ModelField Name="STORE_PLACE_NAME" />
                                                <ext:ModelField Name="MATERIAL_ID" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="01成型机" />
                                                <ext:ModelField Name="02成型机" />
                                                <ext:ModelField Name="03成型机" />
                                                <ext:ModelField Name="04成型机" />
                                                <ext:ModelField Name="05成型机" />
                                                <ext:ModelField Name="06成型机" />
                                                <ext:ModelField Name="07成型机" />
                                                <ext:ModelField Name="08成型机" />
                                                <ext:ModelField Name="09成型机" />
                                                <ext:ModelField Name="10成型机" />
                                                <ext:ModelField Name="11成型机" />
                                                <ext:ModelField Name="12成型机" />
                                                <ext:ModelField Name="13成型机" />
                                                <ext:ModelField Name="14成型机" />
                                                <ext:ModelField Name="15成型机" />
                                                <ext:ModelField Name="16成型机" />
                                                <ext:ModelField Name="17成型机" />
                                                <ext:ModelField Name="18成型机" />
                                                <ext:ModelField Name="19成型机" />
                                                <ext:ModelField Name="20成型机" />
                                                <ext:ModelField Name="21成型机" />
                                                <ext:ModelField Name="22成型机" />
                                                <ext:ModelField Name="23成型机" />
                                                <ext:ModelField Name="24成型机" />
                                                <ext:ModelField Name="25成型机" />
                                                <ext:ModelField Name="26成型机" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                                    <ext:Column ID="STORE_PLACE_ID" runat="server" Text="编号" DataIndex="STORE_PLACE_ID" Flex="1" Hidden="true" />
                                    <ext:Column ID="STORE_PLACE_NAME" runat="server" Text="库位名称" DataIndex="STORE_PLACE_NAME" Width="60" />
                                    <ext:Column ID="Column24" runat="server" Text="库位规格" DataIndex="MATERIAL_NAME" Width="60" />
                                    <ext:Column ID="EQUIP_NAME" runat="server" Text="01#成型机" DataIndex="01成型机" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="IS_CONTROL" runat="server" Text="02#成型机" DataIndex="02成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="C_SHOULDERWEDGE" runat="server" Text="03#成型机" DataIndex="03成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column2" runat="server" Text="04#成型机" DataIndex="04成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column3" runat="server" Text="05#成型机" DataIndex="05成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column4" runat="server" Text="06#成型机" DataIndex="06成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column5" runat="server" Text="07#成型机" DataIndex="07成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column15" runat="server" Text="08#成型机" DataIndex="08成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column6" runat="server" Text="09#成型机" DataIndex="09成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column7" runat="server" Text="10#成型机" DataIndex="10成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column8" runat="server" Text="11#成型机" DataIndex="11成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column9" runat="server" Text="12#成型机" DataIndex="12成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column10" runat="server" Text="13#成型机" DataIndex="13成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column11" runat="server" Text="14#成型机" DataIndex="14成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column12" runat="server" Text="15#成型机" DataIndex="15成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column13" runat="server" Text="16#成型机" DataIndex="16成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column14" runat="server" Text="17#成型机" DataIndex="17成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column1" runat="server" Text="18#成型机" DataIndex="18成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column16" runat="server" Text="19#成型机" DataIndex="19成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column17" runat="server" Text="20#成型机" DataIndex="20成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column18" runat="server" Text="21#成型机" DataIndex="21成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column19" runat="server" Text="22#成型机" DataIndex="22成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column20" runat="server" Text="23#成型机" DataIndex="23成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column21" runat="server" Text="24#成型机" DataIndex="24成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column22" runat="server" Text="25#成型机" DataIndex="25成型机" Editable="true" Width="80">
                                        <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column23" runat="server" Text="26#成型机" DataIndex="26成型机" Editable="true" Width="80">
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

                <ext:Window ID="winModify" runat="server" Icon="MonitorEdit" Closable="false" Layout="Form" Modal="true" Title="更改库位信息"
                    Height="300" Width="600" Hidden="true" BodyStyle="background-color:#fff;"
                    BodyPadding="5">
                    <Items>
                        <ext:FormPanel ID="formPanelAdd" runat="server" MonitorValid="true" Flex="1" BodyPadding="5" Layout="ColumnLayout">
                            <FieldDefaults>
                                <CustomConfig>
                                    <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                                    <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                                </CustomConfig>
                            </FieldDefaults>
                            <Items>
                                <ext:Container ID="Container1" runat="server" Layout="FormLayout" ColumnWidth=".25" Padding="5">
                                    <Items>
                                        <ext:Checkbox ID="cb01" runat="server" FieldLabel="1#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <ext:Checkbox ID="cb02" runat="server" FieldLabel="2#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <ext:Checkbox ID="cb03" runat="server" FieldLabel="3#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <ext:Checkbox ID="cb04" runat="server" FieldLabel="4#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <ext:Checkbox ID="cb05" runat="server" FieldLabel="5#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <ext:Checkbox ID="cb06" runat="server" FieldLabel="6#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <ext:Checkbox ID="cb07" runat="server" FieldLabel="7#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <ext:Checkbox ID="cb08" runat="server" FieldLabel="8#成型机" Editable="true">
                                        </ext:Checkbox>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="Container2" runat="server" Layout="FormLayout" ColumnWidth=".25" Padding="5">
                                    <Items>
                                        <ext:Checkbox ID="cb09" runat="server" FieldLabel="9#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <ext:Checkbox ID="cb10" runat="server" FieldLabel="10#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <ext:Checkbox ID="cb11" runat="server" FieldLabel="11#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <ext:Checkbox ID="cb12" runat="server" FieldLabel="12#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <ext:Checkbox ID="cb13" runat="server" FieldLabel="13#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <ext:Checkbox ID="cb14" runat="server" FieldLabel="14#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <ext:Checkbox ID="cb15" runat="server" FieldLabel="15#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <ext:Checkbox ID="cb16" runat="server" FieldLabel="16#成型机" Editable="true">
                                        </ext:Checkbox>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="Container4" runat="server" Layout="FormLayout" ColumnWidth=".25" Padding="5">
                                    <Items>
                                        <ext:Checkbox ID="cb17" runat="server" FieldLabel="17#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <ext:Checkbox ID="cb18" runat="server" FieldLabel="18#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <ext:Checkbox ID="cb19" runat="server" FieldLabel="19#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <ext:Checkbox ID="cb20" runat="server" FieldLabel="20#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <ext:Checkbox ID="cb21" runat="server" FieldLabel="21#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <ext:Checkbox ID="cb22" runat="server" FieldLabel="22#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <ext:Checkbox ID="cb23" runat="server" FieldLabel="23#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <ext:Checkbox ID="cb24" runat="server" FieldLabel="24#成型机" Editable="true">
                                        </ext:Checkbox>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="Container5" runat="server" Layout="FormLayout" ColumnWidth=".25" Padding="5">
                                    <Items>
                                        <ext:Checkbox ID="cb25" runat="server" FieldLabel="25#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <ext:Checkbox ID="cb26" runat="server" FieldLabel="26#成型机" Editable="true">
                                        </ext:Checkbox>
                                        <%--    <ext:Checkbox ID="Checkbox1" runat="server" FieldLabel="是否绑定" Editable="true">
                                        </ext:Checkbox>--%>
                                    </Items>
                                </ext:Container>
                            </Items>
                            <Listeners>
                                <ValidityChange Handler="#{btnModifySave}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                           <ext:TriggerField runat="server" ID="tgrAddMaterialCode" FieldLabel=" 物料规格" Editable="false" LabelAlign="Left">
                                    <Triggers>
                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                        <ext:FieldTrigger Icon="Search" Qtip="查找" />
                                    </Triggers>
                                    <Listeners>
                                        <TriggerClick Handler="return tgrSearchMaterialCode_Click(item,trigger,index);" />
                                    </Listeners>
                                </ext:TriggerField>
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
                <ext:Hidden ID="hidden_equip" runat="server"></ext:Hidden>
                <ext:Hidden runat="server" ID="hdnSearchMaterialId" />
                <ext:Hidden runat="server" ID="hiddenMaterialName" />
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
