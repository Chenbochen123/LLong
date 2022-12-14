<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HbeEquipControl.aspx.cs" Inherits="Plugins_Semis_HbeEquipControl" %>

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
            //var Type = record.data.ColumnName;
            debugger;
            App.hidden_objid.setValue(ObjID);
            //App.hidden_objid.setValue(Type);
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
            if (value != null)
            {
                return Ext.String.format(template, (value == "1") ? "red" : "green", value = (value == 1 ? "是" : "否"));
                //  value = (value == 1 ? "是" : "否");
            }
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
                                                <ext:ModelField Name="产出" />
                                                <ext:ModelField Name="超产" />
                                                <ext:ModelField Name="混炼胶" />
                                                <ext:ModelField Name="隔离胶片" />
                                                <ext:ModelField Name="填充胶片" />
                                                <ext:ModelField Name="胶芯" />
                                                <ext:ModelField Name="成品钢丝圈" />
                                                <ext:ModelField Name="钢丝帘线" />
                                                <ext:ModelField Name="钢丝圈" />
                                                <ext:ModelField Name="钢丝圈包布" />
                                                <ext:ModelField Name="全钢压延胶片" />
                                                <ext:ModelField Name="覆胶帘子线" />
                                                <ext:ModelField Name="刚压大卷" />
                                                <ext:ModelField Name="覆胶帘子布" />
                                                <ext:ModelField Name="包边胶片" />
                                                <ext:ModelField Name="钢丝" />
                                                <ext:ModelField Name="口型板" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                                    <ext:Column ID="OBJID" runat="server" Text="编号" DataIndex="OBJID" Flex="1" Hidden="true" />
                                    <ext:Column ID="txtEquipName" runat="server" Text="机台名称" DataIndex="EQUIP_NAME" Width="100" />
                                    <ext:Column ID="Column0" runat="server" Text="产出" DataIndex="产出" Editable="true" Width="80" >
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column00" runat="server" Text="超产" DataIndex="超产" Editable="true" Width="80" >
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column1" runat="server" Text="混炼胶" DataIndex="混炼胶" Editable="true" Width="80" >
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column2" runat="server" Text="隔离胶片" DataIndex="隔离胶片" Editable="true" Width="80" >
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column3" runat="server" Text="填充胶片" DataIndex="填充胶片" Editable="true" Width="80" >
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column4" runat="server" Text="胶芯" DataIndex="胶芯" Editable="true" Width="80" >
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column5" runat="server" Text="成品钢丝圈" DataIndex="成品钢丝圈" Editable="true" Width="80" >
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column6" runat="server" Text="钢丝帘线" DataIndex="钢丝帘线" Editable="true" Width="80" >
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column7" runat="server" Text="钢丝圈" DataIndex="钢丝圈" Editable="true" Width="80" >
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column8" runat="server" Text="钢丝圈包布" DataIndex="钢丝圈包布" Editable="true" Width="80" >
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column9" runat="server" Text="全钢压延胶片" DataIndex="全钢压延胶片" Editable="true" Width="80" >
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column10" runat="server" Text="覆胶帘子线" DataIndex="覆胶帘子线" Editable="true" Width="80" >
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column11" runat="server" Text="刚压大卷" DataIndex="刚压大卷" Editable="true" Width="80" >
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column12" runat="server" Text="覆胶帘子布" DataIndex="覆胶帘子布" Editable="true" Width="80" >
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column13" runat="server" Text="包边胶片" DataIndex="包边胶片" Editable="true" Width="80"  >
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column14" runat="server" Text="钢丝" DataIndex="钢丝" Editable="true" Width="80"  >
                                         <Renderer Fn="change" />
                                    </ext:Column>
                                    <ext:Column ID="Column15" runat="server" Text="口型板" DataIndex="口型板" Editable="true" Width="80"  >
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
                    Height="500" Width="650" Hidden="true" BodyStyle="background-color:#fff;"
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
                              <ext:Container ID="Container1" runat="server" Layout="FormLayout" ColumnWidth=".5" Padding="5">
                                 <Items>
                                <ext:Checkbox ID="A0" runat="server" FieldLabel="产出"  Editable="true" >
                                    </ext:Checkbox>
                                <ext:TextField ID="A0_TIME" runat="server" FieldLabel="解控时长:产出"  Editable="true" >
                                    </ext:TextField>
                                 <ext:Checkbox ID="A00" runat="server" FieldLabel="超产"  Editable="true" >
                                    </ext:Checkbox>
                                <ext:TextField ID="A00_TIME" runat="server" FieldLabel="解控时长:超产"  Editable="true" >
                                    </ext:TextField>
                                 <ext:Checkbox ID="A1" runat="server" FieldLabel="混炼胶"  Editable="true" >
                                 </ext:Checkbox>
                                <ext:TextField ID="A1_TIME" runat="server" FieldLabel="解控时长:混炼胶"  Editable="true" >
                                    </ext:TextField>
                                <ext:Checkbox ID="A2" runat="server" FieldLabel="隔离胶片"  Editable="true" >
                                    </ext:Checkbox>
                                <ext:TextField ID="A2_TIME" runat="server" FieldLabel="解控时长:隔离胶片"  Editable="true" >
                                    </ext:TextField>
                                <ext:Checkbox ID="A3" runat="server" FieldLabel="填充胶片"  Editable="true" >
                                    </ext:Checkbox>
                                <ext:TextField ID="A3_TIME" runat="server" FieldLabel="解控时长:填充胶片"  Editable="true" >
                                    </ext:TextField>
                                <ext:Checkbox ID="A4" runat="server" FieldLabel="胶芯"  Editable="true" >
                                    </ext:Checkbox>
                                <ext:TextField ID="A4_TIME" runat="server" FieldLabel="解控时长:胶芯"  Editable="true" >
                                    </ext:TextField>
                                <ext:Checkbox ID="A5" runat="server" FieldLabel="成品钢丝圈"  Editable="true" >
                                    </ext:Checkbox>
                                <ext:TextField ID="A5_TIME" runat="server" FieldLabel="解控时长:成品钢丝圈"  Editable="true" >
                                    </ext:TextField>
                                <ext:Checkbox ID="A6" runat="server" FieldLabel="钢丝帘线"  Editable="true" >
                                    </ext:Checkbox>
                                <ext:TextField ID="A6_TIME" runat="server" FieldLabel="解控时长:钢丝帘线"  Editable="true" >
                                    </ext:TextField>
                                  </Items>
                              </ext:Container>
                              <ext:Container ID="Container2" runat="server" Layout="FormLayout" ColumnWidth=".5" Padding="5">
                                 <Items>
                                <ext:Checkbox ID="A7" runat="server" FieldLabel="钢丝圈"  Editable="true" >
                                    </ext:Checkbox>
                                <ext:TextField ID="A7_TIME" runat="server" FieldLabel="解控时长:钢丝圈"  Editable="true" >
                                    </ext:TextField>
                                <ext:Checkbox ID="A8" runat="server" FieldLabel="钢丝圈包布"  Editable="true" >
                                    </ext:Checkbox>
                                <ext:TextField ID="A8_TIME" runat="server" FieldLabel="解控时长:钢丝圈包布"  Editable="true" >
                                    </ext:TextField>
                                     <ext:Checkbox ID="A9" runat="server" FieldLabel="全钢压延胶片"  Editable="true" >
                                    </ext:Checkbox>
                                <ext:TextField ID="A9_TIME" runat="server" FieldLabel="解控时长:全钢压延胶片"  Editable="true" >
                                    </ext:TextField>
                                
                                <ext:Checkbox ID="A10" runat="server" FieldLabel="覆胶帘子线"  Editable="true" >
                                    </ext:Checkbox>
                                <ext:TextField ID="A10_TIME" runat="server" FieldLabel="解控时长:覆胶帘子线"  Editable="true" >
                                    </ext:TextField>
                                <ext:Checkbox ID="A11" runat="server" FieldLabel="刚压大卷"  Editable="true" >
                                    </ext:Checkbox>
                                <ext:TextField ID="A11_TIME" runat="server" FieldLabel="解控时长:刚压大卷"  Editable="true" >
                                    </ext:TextField>
                                <ext:Checkbox ID="A12" runat="server" FieldLabel="覆胶帘子布"  Editable="true" >
                                    </ext:Checkbox>
                                <ext:TextField ID="A12_TIME" runat="server" FieldLabel="解控时长:覆胶帘子布"  Editable="true" >
                                    </ext:TextField>
                               <ext:Checkbox ID="A13" runat="server" FieldLabel="包边胶片"  Editable="true" >
                                    </ext:Checkbox>
                                <ext:TextField ID="A13_TIME" runat="server" FieldLabel="解控时长:包边胶片"  Editable="true" >
                                    </ext:TextField>
                                <ext:Checkbox ID="A14" runat="server" FieldLabel="钢丝"  Editable="true" >
                                    </ext:Checkbox>
                                <ext:TextField ID="A14_TIME" runat="server" FieldLabel="解控时长:钢丝"  Editable="true" >
                                    </ext:TextField>
                                <ext:Checkbox ID="A15" runat="server" FieldLabel="口型板"  Editable="true" >
                                    </ext:Checkbox>
                                <ext:TextField ID="A15_TIME" runat="server" FieldLabel="解控时长:口型板"  Editable="true" >
                                    </ext:TextField>
                                <ext:Checkbox ID="B1" runat="server" FieldLabel="上投料口"  Editable="true" >
                                    </ext:Checkbox>
                                <ext:Checkbox ID="B2" runat="server" FieldLabel="中投料口"  Editable="true" >
                                    </ext:Checkbox>
                                <ext:Checkbox ID="B3" runat="server" FieldLabel="下投料口"  Editable="true" >
                                    </ext:Checkbox>
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
                                    <ext:ConfigItem Name="LabelWidth" Value="60" Mode="Raw" />
                                    <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                                </CustomConfig>
                            </FieldDefaults>
                            <Items> 
                                <ext:ComboBox ID="cbxDecontrolReason" runat="server" FieldLabel="解控原因" Width="550" LabelAlign="Left" Editable="true" EnableKeyEvents="true">
                                </ext:ComboBox>
                                <ext:TextField ID="txtbeuzhu" runat="server" FieldLabel="说明" Editable="true" LabelAlign="Left" AllowBlank="false" Width="550">
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
