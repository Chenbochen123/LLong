<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MouldSelect.aspx.cs" Inherits="MouldSelect" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head2" runat="server">
    <title>模具标识卡信息选择</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js" ></script>

    
    <script type="text/javascript">
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
            } else {
                toolbar.items.getAt(2).hide();
            }
        };
        //根据按钮类别进行删除和编辑操作
        var commandcolumn_click = function (command, record) {
            commandcolumn_click_confirm(command, record);
            return false;
        };
        //区分删除操作，并进行二次确认操作
        var commandcolumn_click_confirm = function (command, record) {

            if (command.toLowerCase() == "edit") {
                commandcolumn_direct_edit(record);
            }
            if (command.toLowerCase() == "delete") {
                Ext.Msg.confirm("提示", '您确定需要关闭此条信息？', function (btn) { commandcolumn_direct_delete(btn, record) });
            }
            if (command.toLowerCase() == "recover") {
                Ext.Msg.confirm("提示", '您确定需要恢复此条信息？', function (btn) { commandcolumn_direct_recover(btn, record) });
            }
            return false;
        };
        //点击修改按钮
        var commandcolumn_direct_edit = function (record) {
            var ObjID = record.data.OBJID;
            var Dummy1 = record.data.DUMMY_1;
            var Dummy2 = record.data.DUMMY_2;
            var BrandId = record.data.BRAND_ID;
            var PatternName = record.data.PATTERN_NAME;
            var LoadIndexId = record.data.LOAD_INDEX_ID;
            var SizeName = record.data.SIZE_NAME;
            var SecPatternName = record.data.SEC_PATTERN;
            var PlyratingId = record.data.PLYRATING_ID;
            var Product = record.data.PRODUCT;
            var Remark = record.data.REMARK;
            var UserName = record.data.USER_NAME;
            var RecordTime = record.data.RECORD_TIME;
            App.direct.commandcolumn_direct_edit(ObjID, Dummy1, Dummy2, BrandId, PatternName, SecPatternName, LoadIndexId, PlyratingId, SizeName,Product,UserName,RecordTime, Remark, {
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
            App.direct.commandcolumn_direct_delete(ObjID, {
                success: function (result) {
                    Ext.Msg.alert('操作', result);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }
        //点击恢复按钮
        var commandcolumn_direct_recover = function (btn,record) {
            if (btn != "yes") {
                return;
            }
            var objID = record.data.OBJID;
            App.direct.commandcolumn_direct_recover(objID, {
                success: function (result) {
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }
     
     </script>

    <script type="text/javascript">
     //-------拆模人-----查询带回弹出框--BEGIN
        var Plugins_Equip_BasicInfo_QueryBasUser_Request = function (record) {//领用人返回值处理
            debugger;
             if (!App.winModify.hidden) {
             debugger;
             App.modify_MouldUser.setValue(record.data.USER_NAME);
             App.modify_MouldUser.getTrigger(0).show();
             App.modify_MouldUserId.setValue(record.data.OBJID);
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
      
        var gridPanelRefresh = function () {
            App.store.currentPage = 1;
            App.pageToolbar.doRefresh();
            return false;
        }
    </script>
</head>
<body>
    <form id="fmUnit" runat="server">
        <ext:ResourceManager ID="rmUnit" runat="server" />
        <ext:Viewport ID="vwUnit" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnlUnitTitle" runat="server" Region="North" AutoHeight="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="barUnit">
                            <Items>
                                <ext:ToolbarSeparator ID="toolbarSeparator_begin" />
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
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
                                
                                <ext:Button runat="server" Icon="Printer" Text="打印预览" ID="btnShowRptPmtLotInfo">
                                    
                                    <DirectEvents>
                                        <Click OnEvent="Button1_Click" IsUpload="true"></Click>
                                    </DirectEvents>
                                    
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
                                                 <ext:ComboBox ID="txtSizeName" runat="server" FieldLabel="规格名称" LabelAlign="Right"  Editable="false" >
                                                    <Listeners>
                                                        <Select Fn="gridPanelRefresh"></Select>
                                                    </Listeners>
                                                    <Triggers>
                                                       <ext:FieldTrigger Icon="Clear" QTip="Remove selected" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.removeByValue(this.getValue());this.clearValue();" />
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

                <ext:GridPanel ID="pnlList" runat="server" Region="Center" >
                    <Store>
                        <ext:Store ID="store" runat="server" PageSize="15">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" AutoDataBind="false" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="DELETE_FLAG" />
                                        <ext:ModelField Name="PATTERN_NAME" />
                                        <ext:ModelField Name="SEC_PATTERN" />
                                        <ext:ModelField Name="SEC_PATTERN_NAME" />
                                        <ext:ModelField Name="BRAND_ID" />
                                        <ext:ModelField Name="BRAND_NAME" />
                                        <ext:ModelField Name="LOAD_INDEX_NAME" />
                                        <ext:ModelField Name="LOAD_INDEX_ID" />
                                        <ext:ModelField Name="PLYRATING_NAME" />
                                        <ext:ModelField Name="PLYRATING_ID" />
                                        <ext:ModelField Name="SIZE_NAME" />
                                        <ext:ModelField Name="USER_NAME" />
                                        <ext:ModelField Name="PRODUCT" />
                                        <ext:ModelField Name="DUMMY_1" />
                                        <ext:ModelField Name="DUMMY_2" />
                                        <ext:ModelField Name="REMARK" />
                                        <ext:ModelField Name="RECORD_TIME" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:Column ID="ObjID" runat="server" Text="ObjID" DataIndex="OBJID"  Hidden="true" />
                            <ext:Column ID="MouldBarcord" runat="server" Text="模具条码" DataIndex="DUMMY_1" />
                            <ext:Column ID="Column2" runat="server" Text="模具名称" DataIndex="DUMMY_2" />
                            <ext:Column ID="clEquip" runat="server" Text="规格" DataIndex="SIZE_NAME" Width="100"/>
                            <ext:Column ID="Column1" runat="server" Text="花纹" DataIndex="PATTERN_NAME" Width="80" />
                            <ext:Column ID="Column4" runat="server" Text="当前花纹" DataIndex="SEC_PATTERN_NAME" Width="100" />
                            <ext:Column ID="Column6" runat="server" Text="商标" DataIndex="BRAND_NAME" Width="80"/>
                            <ext:Column ID="Column8" runat="server" Text="负荷" DataIndex="LOAD_INDEX_NAME" Width="80"/>
                            <ext:Column ID="Column5" runat="server" Text="层级" DataIndex="PLYRATING_NAME" Width="80"/>
                            <ext:Column ID="Column3" runat="server" Text="人员" DataIndex="USER_NAME" Width="120"/>
                            <ext:Column ID="Column7" runat="server" Text="产地" DataIndex="PRODUCT" Width="120"/>
                            <ext:Column ID="Column10" runat="server" Text="拆模时间" DataIndex="RECORD_TIME" Width="120"/>
                            <ext:Column ID="Column12" runat="server" Text="备注" DataIndex="REMARK" Width="120"/>
                            <ext:CommandColumn ID="cmdCol" runat="server" Align="Center" Text="操作" Width="185">
                                <Commands>
                                    <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改"/>
                                    <ext:GridCommand Icon="TableDelete" CommandName="Delete" Text="删除"/>
                                    <ext:GridCommand Icon="Accept" CommandName="Recover" Text="恢复">
                                        <ToolTip Text="恢复本条数据" />
                                    </ext:GridCommand>
                                </Commands>
                                <PrepareToolbar Fn="prepareToolbar" />
                                <Listeners>
                                    <Command Handler="commandcolumn_click(command, record);" />
                                </Listeners>
                            </ext:CommandColumn>
                        </Columns>
                    </ColumnModel>
                    <View>
                        <ext:GridView ID="GridView1" runat="server" LoadMask="false" EnableTextSelection="true">
                            <GetRowClass Fn="SetRowClass" />
                        </ext:GridView>
                    </View>
                   
                    <BottomBar>
                        <ext:PagingToolbar ID="pageToolBar" runat="server">
                            <Plugins>
                                <ext:ProgressBarPager ID="ProgressBarPager" runat="server"/>
                            </Plugins>
                        </ext:PagingToolbar>
                    </BottomBar>
                     <SelectionModel>
                        <ext:CheckboxSelectionModel runat="server" Mode="Multi" />
                    </SelectionModel>
                </ext:GridPanel>

                <ext:Window ID="winModify" runat="server" Icon="MonitorEdit" Closable="false" Title="修改模具标识卡信息"
                    Width="600" Height="270" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
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
                                        <ext:Container ID="Container2"  runat="server" Layout="FormLayout" ColumnWidth=".5"
                                            Padding="5">
                                            <Items> 
                                                
                                                <ext:TextField  ID="modify_obj_id" runat="server" Hidden="true" />
                                                <ext:TextField ID="modify_MouldName" runat="server" FieldLabel="模具名称" LabelAlign="Right" ReadOnly="true" />  
                                                <ext:TextField ID="modify_MouldBarcode" runat="server" FieldLabel="模具条码" LabelAlign="Right"   ReadOnly="true" />  
                                                <ext:TextField ID="modify_SizeName" runat="server" FieldLabel="规格" LabelAlign="Right" AllowBlank="false"  ReadOnly="true"  />                                               
                                                <ext:TextField ID="modify_PatternName" runat="server" FieldLabel="主花纹" LabelAlign="Right" AllowBlank="false"  ReadOnly="true"  />
                                                <ext:TextField ID="modify_Product" runat="server" FieldLabel="产地" LabelAlign="Right"   />
                                                <ext:TriggerField ID="modify_MouldUser" runat="server" FieldLabel="拆模人" LabelAlign="Right" Editable="false" AllowBlank="false" >
                                                     <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" HideTrigger="true" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners >
                                                        <TriggerClick Fn="SelectUserInfo" />
                                                    </Listeners>
                                                </ext:TriggerField>                                           
                                                
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="Container3"  runat="server" Layout="FormLayout" ColumnWidth=".5"
                                            Padding="5">
                                            <Items>
                                                <ext:ComboBox ID="modify_SecPatternName" runat="server" FieldLabel="当前花纹" LabelAlign="Right"  DisplayField=""
                                                     ValueField="OBJID" Editable="false" >
                                                    <Listeners>
                                                        <Select Fn="gridPanelRefresh"></Select>
                                                    </Listeners>
                                                    <Triggers>
                                                       <ext:FieldTrigger Icon="Clear" QTip="Remove selected" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.removeByValue(this.getValue());this.clearValue();" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox ID="modify_LoadIndex" runat="server" FieldLabel="负荷" LabelAlign="Right"  DisplayField=""
                                                     ValueField="OBJID" Editable="false" >
                                                    <Listeners>
                                                        <Select Fn="gridPanelRefresh"></Select>
                                                    </Listeners>
                                                    <Triggers>
                                                       <ext:FieldTrigger Icon="Clear" QTip="Remove selected" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.removeByValue(this.getValue());this.clearValue();" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox ID="modify_Plyrating" runat="server" FieldLabel="层级" LabelAlign="Right" DisplayField=""
                                                     ValueField="OBJID" Editable="false" >
                                                    <Listeners>
                                                        <Select Fn="gridPanelRefresh"></Select>
                                                    </Listeners>
                                                    <Triggers>
                                                       <ext:FieldTrigger Icon="Clear" QTip="Remove selected" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.removeByValue(this.getValue());this.clearValue();" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox ID="modify_Brand" runat="server" FieldLabel="商标" LabelAlign="Right" DisplayField="BRAND_NAME"
                                                     ValueField="OBJID" Editable="false" >
                                                    <Listeners>
                                                        <Select Fn="gridPanelRefresh"></Select>
                                                    </Listeners>
                                                    <Triggers>
                                                       <ext:FieldTrigger Icon="Clear" QTip="Remove selected" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.removeByValue(this.getValue());this.clearValue();" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:TextField ID="modify_Remark" runat="server" FieldLabel="备注" LabelAlign="Right"   />
                                            <ext:FieldContainer runat="server"  FieldLabel="时间"  LabelAlign="Right" Layout="HBoxLayout"  AllowBlank="false" Editable="false" >
                                                    <Items>
                                                         <ext:DateField   ID="modify_DateField"  Width="100"   runat="server" />
                                                    </Items>
                                                </ext:FieldContainer>     
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

                
                <ext:Hidden ID="modify_MouldUserId" runat="server" />
                <ext:Hidden ID="hidden_delete_flag" runat="server" />
                <ext:Hidden ID="hidden_txt_response_user" runat="server" />
                <ext:Hidden ID="hidden_txt_finish_user" runat="server" />
                <ext:Hidden ID="hidden_txt_confirm_user" runat="server" />
                
                <ext:Hidden ID="hidden_add_equip_id" runat="server" />
                <ext:Hidden ID="hidden_add_stop_type" runat="server" />
                <ext:Hidden ID="hidden_add_stop_reason" runat="server" />
                
                <ext:Hidden ID="hidden_modify_stop_reason" runat="server" />
                <ext:Hidden ID="hidden_modify_finish_user" runat="server" />
                <ext:Hidden ID="hidden_modify_confirm_user" runat="server" />
                <ext:Hidden ID="hidden_modify_plan_stop_time" runat="server" />
                <ext:Hidden ID="hidden_modify_equip_id" runat="server"></ext:Hidden>
                <ext:Hidden ID="hidden_modify_stop_type" runat="server" />
                <ext:Hidden runat="server" ID="hidden_select_equip_id" />
            </Items>
        </ext:Viewport>

         <ext:Window ID="Manager_ReportCenter_CommonReportView_CommonReportView_Window" runat="server" Maximized="true" Title="车报表详细信息" Modal="true" Closable="true" Hidden="true" Html="<iframe src='Default.aspx' width=100% height=100% scrolling=no  frameborder=0></iframe>">
        </ext:Window>
        </form>
</body>
</html>