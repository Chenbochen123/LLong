<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SparePartIn.aspx.cs" Inherits="Plugins_Equip_Storage_SparePartIn" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>备件入库管理</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js" ></script>
    <script type="text/javascript">
        //点击修改按钮
        var commandcolumn_direct_edit = function (record) {
            var ObjID =String(record.data.OBJID);
            var sparePartsName = String(record.data.SPAREPARTS_NAME);
            var sparePartsCode = String(record.data.SPAREPARTS_CODE);
            var sparePartsId = String(record.data.SPAREPARTS_ID); 
            var userId = String(record.data.REC_USER_ID);
            var userName = String(record.data.USER_NAME);
            var amount = String(record.data.IN_AMOUNT);
            var remark = String(record.data.REMARK);
            var inDate = String(record.data.IN_DATE);
            SparePartIn.commandcolumn_direct_edit(ObjID, sparePartsName, sparePartsCode,sparePartsId, userId,userName, amount,inDate,remark,

                {
                success: function (result) {
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }

        //点击恢复按钮
        var commandcolumn_direct_recover = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var objID = record.data.OBJID;
            SparePartIn.commandcolumn_direct_recover(objID, {
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
            var ObjID = record.data.OBJID;
            SparePartIn.commandcolumn_direct_delete(ObjID, {
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
            debugger;
            if (command.toLowerCase() == "edit") {
                commandcolumn_direct_edit(record);
            }
            if (command.toLowerCase() == "delete") {
                Ext.Msg.confirm("提示", '您确定需要删除此条信息？', function (btn) { commandcolumn_direct_delete(btn, record) });
            }
            if (command.toLowerCase() == "recover") {
                Ext.Msg.confirm("提示", '您确定需要恢复此条信息？', function (btn) { commandcolumn_direct_recover(btn, record) });
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
                    return;
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
        //历史查询按钮点击列表刷新数据重载方法
        var pnlHistoryListFresh = function () {
            App.hidden_delete_flag.setValue("1");
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }

        //历史查询根据DeleteFlag的值进行样式绑定
        var SetRowClass = function (record, rowIndex, rowParams, store) {
            if (record.get("DELETE_FLAG") == "1") {
                return "x-grid-row-deleted";
            }
        }
        //历史查询的每行按钮准备加载
        var prepareToolbar = function (grid, toolbar, rowIndex, record) {
            if (record.get("DELETE_FLAG") == "1") {
                toolbar.items.getAt(0).hide();
                toolbar.items.getAt(1).hide();
                toolbar.items.getAt(2).hide();
            } else {
                toolbar.items.getAt(3).hide();
            }
        };
    </script>
    <script type="text/javascript">
        //-------领用人-----查询带回弹出框--BEGIN
        var Plugins_Equip_BasicInfo_QueryBasUser_Request = function (record) {//领用人返回值处理
            if (!App.winAdd.hidden) {
                App.add_receive_user.setValue(record.data.USER_NAME);
                App.add_receive_user.getTrigger(0).show();
                App.hidden_receive_user.setValue(record.data.OBJID);
            }
            else if (!App.winModify.hidden) {
                App.modify_receive_user.setValue(record.data.USER_NAME);
                App.add_receive_user.getTrigger(0).show();
                App.hidden_receive_user.setValue(record.data.OBJID);
            }
        }

        var SelectUserInfo = function (field, trigger, index) {
            switch (index) {
                case 0:
                    field.getTrigger(0).hide();
                    field.setValue('');
                    App.hidden_receive_user.setValue("");
                    field.getEl().down('input.x-form-text').setStyle('background', "white");
                    break;
                case 1:
                    App.Plugins_Equip_BasicInfo_QueryBasUser_Window.show();
                    break;
            }
        }

        Ext.create("Ext.window.Window", {//领用人查询带回窗体
            id: "Plugins_Equip_BasicInfo_QueryBasUser_Window",
            height: 460,
            hidden: true,
            width: 360,
            html: "<iframe src='../BasicInfo/QueryBasUser.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
            bodyStyle: "background-color: #fff;",
            closable: true,
            title: "请选择接收人",
            modal: true
        })
        //------------查询带回弹出框--END 
    </script>
     <script type="text/javascript">
         //-------备件代码-----查询带回弹出框--BEGIN
         var Plugins_Equip_BasicInfo_QuerySparePart_Request = function (record) {//备件代码返回值处理
             if (!App.winAdd.hidden) {
                 App.add_sparepart_code.setValue(record.data.SPAREPARTS_NAME);
                 App.add_sparepart_code.getTrigger(0).show();
                 App.hidden_sparepart_code.setValue(record.data.SPAREPARTS_CODE);
                 App.hidden_sparepart_id.setValue(record.data.OBJID);
             }
             else if (!App.winModify.hidden) {
                 App.modify_sparepart_name.setValue(record.data.SPAREPARTS_NAME);
                 App.modify_sparepart_name.getTrigger(0).show();
                 App.hidden_sparepart_code.setValue(record.data.SPAREPARTS_CODE);
                 App.hidden_sparepart_id.setValue(record.data.OBJID);
             } else {
                 App.txt_sparepart_code.setValue(record.data.SPAREPARTS_CODE);
                 App.txt_sparepart_code.getTrigger(0).show();
                 App.hidden_select_sparepart_code.setValue(record.data.SPAREPARTS_CODE);
                 App.hidden_sparepart_id.setValue(record.data.OBJID);
             }
         }

         var SelectSparePartInfo = function (field, trigger, index) {
             switch (index) {
                 case 0:
                     field.getTrigger(0).hide();
                     field.setValue('');
                     App.hidden_sparepart_code.setValue("");
                     App.hidden_select_sparepart_code.setValue("");
                     field.getEl().down('input.x-form-text').setStyle('background', "white");
                     break;
                 case 1:
                     App.Plugins_Equip_BasicInfo_QuerySparePart_Window.show();
                     break;
             }
         }

         Ext.create("Ext.window.Window", {//备件代码查询带回窗体
             id: "Plugins_Equip_BasicInfo_QuerySparePart_Window",
             height: 460,
             hidden: true,
             width: 360,
             html: "<iframe src='../BasicInfo/QuerySparePart.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>",
             bodyStyle: "background-color: #fff;",
             closable: true,
             title: "请选择备件名称",
             modal: true
         })
         //------------查询带回弹出框--END 
    </script>
</head>
<body>
    <form id="fmUnit" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display:none" runat="server" Text="Button" OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmUnit" runat="server" DirectMethodNamespace="SparePartIn" />
        <ext:Viewport ID="vwUnit" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnlUnitTitle" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="barUnit">
                            <Items>
                                <ext:Button runat="server" Icon="Add" Text="添加" ID="btn_add">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttAdd" runat="server" Html="点击进行添加" />
                                    </ToolTips>
                                    <DirectEvents>
                                        <Click OnEvent="btn_add_Click">
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_begin" />
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btn_search">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="点击进行查询" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="pnlListFresh"></Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle_2" />
                                 <ext:Button runat="server" Icon="Note" Text="历史查询" ID="btn_history_search">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip1" runat="server" Html="点击进行历史查询" />
                                    </ToolTips>
                                     <Listeners>
                                        <Click Fn="pnlHistoryListFresh"></Click>
                                    </Listeners>
                                </ext:Button>
                                 <ext:ToolbarSeparator ID="toolbarSeparator_middle_1" />
                                 <ext:Button runat="server" Icon="PageWhiteExcel" Text="导出" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();"></Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" />
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:Panel ID="pnlUnitQuery" runat="server" AutoHeight="true">
                            <Items>
                                <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container ID="container_1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:TextField ID="sap_code" runat="server" FieldLabel="SAP单号" LabelAlign="Left" />
                                                <ext:TextField ID="lyd_code" runat="server" FieldLabel="领用单号" LabelAlign="Left" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:DateField ID="txt_begin_receive_date" runat="server" FieldLabel="开始入库时间" LabelAlign="Right" Editable="false" />
                                                <ext:TriggerField ID="txt_sparepart_code" runat="server" FieldLabel="备件名称" LabelAlign="Right" Editable="false" >
                                                        <Triggers>
                                                            <ext:FieldTrigger Icon="Clear" HideTrigger="true">
                                                                </ext:FieldTrigger>
                                                            <ext:FieldTrigger Icon="Search" />
                                                        </Triggers>
                                                        <Listeners>
                                                            <TriggerClick Fn="SelectSparePartInfo" />
                                                        </Listeners>
                                                    </ext:TriggerField>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_3" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:DateField ID="txt_end_receive_date" runat="server" FieldLabel="结束入库时间" LabelAlign="Right" Editable="false" />
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:FormPanel>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>

                <ext:GridPanel ID="pnlList" runat="server" Region="Center" Frame="true">
                     <Store>
                        <ext:Store ID="store" runat="server" PageSize="10">
                            <Proxy>
                                <ext:PageProxy DirectFn="SparePartIn.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="SAP_CODE" />
                                        <ext:ModelField Name="LYD_CODE" />
                                        <ext:ModelField Name="IN_DATE"/>
                                        <ext:ModelField Name="SPAREPARTS_NAME" />
                                        <ext:ModelField Name="SPAREPARTS_CODE" />
                                        <ext:ModelField Name="SPAREPARTS_ID" />
                                        <ext:ModelField Name="IN_AMOUNT" />
                                        <ext:ModelField Name="USER_NAME" />
                                        <ext:ModelField Name="REC_USER_ID" />
                                        <ext:ModelField Name="DELETE_FLAG" />
                                        <ext:ModelField Name="REMARK" />
                                    </Fields>
                               </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                            <ext:Column ID="objid" runat="server" Text="编号" DataIndex="OBJID" Width="100"  Hidden="true" />
                            <ext:Column ID="receive_no" runat="server" Text="SAP单号" DataIndex="SAP_CODE" Width="110"  />
                            <ext:Column ID="lyd_no" runat="server" Text="领用单号" DataIndex="LYD_CODE" Width="110"  />
                            <ext:DateColumn Format="yyyy-MM-dd" ID="receive_date" runat="server" Text="入库日期" DataIndex="IN_DATE" Width="120"  />
                            <ext:Column ID="sparepart_name" runat="server" Text="备件名称" DataIndex="SPAREPARTS_NAME" Width="120"  />
                            <ext:Column ID="sparepart_code" runat="server" Text="备件代号" DataIndex="SPAREPARTS_CODE" Width="80"  />
                            <ext:Column ID="store_in_num" runat="server" Text="入库数量" DataIndex="IN_AMOUNT" Width="60"  />
                            <ext:Column ID="delete_flag" runat="server" Text="删除标志" DataIndex="DELETE_FLAG" Width="80"  Hidden="true" />
                            <ext:Column ID="receive_user" runat="server" Text="接收人" DataIndex="USER_NAME" Width="100"  />
                            <ext:Column ID="remark" runat="server" Text="备注" DataIndex="REMARK" Width="150"  />
                            <ext:CommandColumn ID="commandCol" runat="server" Width="120" Text="操作" Align="Center">
                                <Commands>
                                    <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
                                        <ToolTip Text="修改本条数据" />
                                    </ext:GridCommand>
                                    <ext:CommandSeparator />
                                    <ext:GridCommand Icon="Delete" CommandName="Delete" Text="删除">
                                        <ToolTip Text="删除本条数据" />
                                    </ext:GridCommand>
                                    <ext:GridCommand Icon="Accept" CommandName="Recover" Text="恢复">
                                        <ToolTip Text="恢复本条数据" />
                                    </ext:GridCommand>
                                </Commands>
                                <PrepareToolbar Fn="prepareToolbar" />
                                <Listeners>
                                    <Command Handler="return commandcolumn_click(command, record);" />
                                </Listeners>
                            </ext:CommandColumn>
                        </Columns>
                    </ColumnModel>
                    <View>
                        <ext:GridView ID="gvRows" runat="server" LoadMask="false" EnableTextSelection="true">
                            <GetRowClass Fn="SetRowClass" />
                        </ext:GridView>
                    </View>
                    <BottomBar>
                        <ext:PagingToolbar ID="pageToolBar" runat="server">
                            <Plugins>
                                <ext:ProgressBarPager ID="ProgressBarPager" runat="server" />
                            </Plugins>
                        </ext:PagingToolbar>
                    </BottomBar>
                </ext:GridPanel>

                <ext:Window ID="winModify" runat="server" Icon="MonitorEdit" Closable="false" Title="修改备件入库信息"
                    Width="500" Height="250" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
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
                               <ext:Container ID="Container1" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container ID="Container3" runat="server" Layout="FormLayout" ColumnWidth=".5" Padding="5">
                                            <Items>
                                                <ext:TextField ID="modify_obj_id" runat="server" FieldLabel="编号" LabelAlign="Left" Hidden="true"/>
                                               <%-- <ext:TextField ID="modify_sap_no" runat="server" FieldLabel="入库单号" LabelAlign="Left" ReadOnly="true"/>--%>
                                                <ext:DateField ID="modify_receive_date" runat="server" Type="Date" FieldLabel="入库日期" LabelAlign="Left" Editable="false"/>
                                                <ext:TriggerField ID="modify_sparepart_name" runat="server" FieldLabel="备件名称" LabelAlign="Left" Editable="false" AllowBlank="false">
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Fn="SelectSparePartInfo" />
                                                    </Listeners>
                                                </ext:TriggerField>
                                                <ext:TextField ID="modify_remark" runat="server" FieldLabel="备注" LabelAlign="Left"/>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="Container4" runat="server" Layout="FormLayout" ColumnWidth=".5" Padding="5">
                                            <Items>
                                                <ext:NumberField ID="modify_number" runat="server" FieldLabel="入库数量"  LabelAlign="Left"/>
                                                <ext:TriggerField ID="modify_receive_user" runat="server" FieldLabel="接收人" LabelAlign="Left" Editable="false"  AllowBlank="false">
                                                     <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Fn="SelectUserInfo" />
                                                    </Listeners>
                                                </ext:TriggerField>
                                                
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:Container>
                            </Items>
                             <Listeners>
                                <ValidityChange Handler="#{btnModifySave}.setDisabled(!valid);" />
                            </Listeners>
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

                <ext:Window ID="winAdd" runat="server" Icon="MonitorAdd" Closable="false" Title="添加备件入库信息"
                    Width="500" Height="250" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
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
                                <ext:Container ID="Container2" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container runat="server" Layout="FormLayout" ColumnWidth=".5" Padding="5">
                                            <Items>
                                                <ext:DateField ID="add_receive_date" runat="server" Type="Date" FieldLabel="入库日期" LabelAlign="Left" Editable="false"/>
                                                 <ext:TextField ID="add_sap_code" runat="server" FieldLabel="SAP单号 " LabelAlign="Left" AllowBlank="false"/>
                                                <ext:TextField ID="add_lyd_code" runat="server" FieldLabel="领用单号 " LabelAlign="Left" AllowBlank="false"/>
                                                <ext:TriggerField ID="add_sparepart_code" runat="server" FieldLabel="备件名称" LabelAlign="Left" Editable="false" AllowBlank="false" >
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Fn="SelectSparePartInfo" />
                                                    </Listeners>
                                                </ext:TriggerField>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container runat="server" Layout="FormLayout" ColumnWidth=".5" Padding="5">
                                            <Items>
                                                <ext:NumberField ID="add_number" runat="server" FieldLabel="入库数量" LabelAlign="Left" AllowBlank="false"/>
                                                <ext:TriggerField ID="add_receive_user" runat="server" FieldLabel="接收人" LabelAlign="Left" Editable="false" AllowBlank="false" >
                                                     <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners >
                                                        <TriggerClick Fn="SelectUserInfo" />
                                                    </Listeners>
                                                </ext:TriggerField>
                                                <ext:TextField ID="add_remark" runat="server" FieldLabel="备注" LabelAlign="Left"/>
                                            </Items>
                                        </ext:Container>
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
                        <Show Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).disable(true);}" />
                        <Hide Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).enable(true);}" />
                    </Listeners>
                </ext:Window>
                <ext:Hidden ID="hidden_receive_user"  runat="server"></ext:Hidden>
                <ext:Hidden ID="hidden_sparepart_code"  runat="server">
                </ext:Hidden>
                <ext:Hidden ID="hidden_sparepart_id"  runat="server" />
                <ext:Hidden ID="hidden_select_sparepart_code"  runat="server" />
                <ext:Hidden ID="hidden_select_sparepart_id"  runat="server" />
                <ext:Hidden ID="hidden_delete_flag"  runat="server" Text="0"></ext:Hidden>
            </Items>
        </ext:Viewport>
        </form>
</body>
</html>