<%@ Page Language="C#" AutoEventWireup="true" CodeFile="XJContent.aspx.cs" Inherits="Plugins_Equip_Record_XJContent" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>设备巡检项目维护</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>

    <script type="text/javascript">
        //列表刷新数据重载方法
        var pnlListFresh = function () {
            App.hidden_delete_flag.setValue("0");
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }
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
            return false;
        };
        //点击修改按钮
        var commandcolumn_direct_edit = function (record) {
            debugger;
            var Objid = record.data.OBJID;
            var MajorTypeID = record.data.EQUIP_MAJOR_TYPE_ID;
            var MinorTypeID = record.data.EQUIP_MINOR_TYPE_ID;
            var TypeID = record.data.INSPECTION_TYPE_ID;
            var Content = record.data.INSPECTION_CONTENT;
            var Standard = record.data.INSPECTION_STANDARD;
            var Method = record.data.INSPECTION_METHOD;
            var MajorName = record.data.MAJOR_TYPE_NAME;
            var MinorName = record.data.MINOR_TYPE_NAME;
            var SeqIndex = record.data.SEQ_INDEX
            debugger;
            App.direct.commandcolumn_direct_edit(Objid, MajorTypeID, MinorTypeID, TypeID, Content, Standard, Method,MajorName,MinorName,SeqIndex, {
                success: function (result) {
                },
                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }
        //点击删除按钮
        var commandcolumn_direct_delete = function (btn, record) {
            debugger;
            if (btn != "yes") {
                return;
            }
            var ObjID = record.data.OBJID;
            debugger;
            App.direct.commandcolumn_direct_delete(ObjID, {
                success: function (result) {
                    Ext.Msg.alert('操作', result);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }
        
    </script>
 
</head>
<body>
    <form id="fmUnit" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button" OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmUnit" runat="server" />
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
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <ToolTips>
                                        <ext:ToolTip ID="ttSearch" runat="server" Html="点击进行查询" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="pnlListFresh"></Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="toolbarSeparator_middle_2" />
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
                                                <ext:ComboBox ID="txt_equip_major" runat="server" FieldLabel="设备大类" LabelAlign="Right" Editable="false"
                                                    ValueField="value" DisplayField="text" >
                                                    <Store>
                                                        <ext:Store ID="equip_store" runat="server">
                                                            <Model>
                                                                <ext:Model ID="Model1" runat="server">
                                                                    <Fields>
                                                                        <ext:ModelField Name="value" Mapping="OBJID" />
                                                                        <ext:ModelField Name="text" Mapping="V" />
                                                                    </Fields>
                                                                </ext:Model>
                                                            </Model>
                                                        </ext:Store>
                                                    </Store>
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.clearValue();" />
                                                        <Select Handler="#{txt_equip_minor}.clearValue(); #{MinorStore}.reload();" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox ID="txt_equip_minor" runat="server" DisplayField="MINOR_TYPE_NAME"
                                                    ValueField="OBJID" FieldLabel="设备细类" LabelAlign="Right" Editable="false">
                                                    <Store>
                                                        <ext:Store
                                                            runat="server"
                                                            ID="MinorStore"
                                                            AutoLoad="false"
                                                            OnReadData="MinorRefresh">
                                                            <Model>
                                                                <ext:Model runat="server" IDProperty="OBJID">
                                                                    <Fields>
                                                                        <ext:ModelField Name="OBJID" Type="String" Mapping="OBJID" />
                                                                        <ext:ModelField Name="MINOR_TYPE_NAME" Type="String" Mapping="MINOR_TYPE_NAME" />
                                                                    </Fields>
                                                                </ext:Model>
                                                            </Model>
                                                            <Listeners>
                                                                <Load Handler="#{txt_equip_minor}.setValue(#{txt_equip_minor}.store.getAt(0).get('OBJID'));" />
                                                            </Listeners>
                                                        </ext:Store>
                                                    </Store>
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.clearValue();" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:TextField ID="txt_content" runat="server" FieldLabel="巡检内容" LabelAlign="Right" />
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
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" AutoDataBind="false" />
                            </Proxy>
                            <Model>
                                <ext:Model ID="model" runat="server">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="MAJOR_TYPE_NAME" />
                                        <ext:ModelField Name="MINOR_TYPE_NAME" />
                                        <ext:ModelField Name="INSPECTION_TYPE_NAME" />
                                        <ext:ModelField Name="INSPECTION_CONTENT" />
                                        <ext:ModelField Name="INSPECTION_STANDARD" />
                                        <ext:ModelField Name="INSPECTION_METHOD" />
                                        <ext:ModelField Name="USER_NAME" />
                                        <ext:ModelField Name="RECORD_TIME" />
                                        <ext:ModelField Name="EQUIP_MAJOR_TYPE_ID" />
                                        <ext:ModelField Name="EQUIP_MINOR_TYPE_ID" />
                                        <ext:ModelField Name="INSPECTION_TYPE_ID" />
                                        <ext:ModelField Name="SEQ_INDEX" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                            <ext:Column ID="OBJID" runat="server" Text="OBJID" DataIndex="OBJID" Hidden="true" />
                            <ext:Column ID="MAJOR_TYPE_NAME" runat="server" Text="设备大类" DataIndex="MAJOR_TYPE_NAME" Width="60" />
                            <ext:Column ID="MINOR_TYPE_NAME" runat="server" Text="设备细类" DataIndex="MINOR_TYPE_NAME" Width="100" />
                            <ext:Column ID="INSPECTION_TYPE_NAME" runat="server" Text="巡检项目类别" DataIndex="INSPECTION_TYPE_NAME" Width="100" />
                            <ext:Column ID="SEQ_INDEX" runat="server" Text="序号" DataIndex="SEQ_INDEX" Width="50" />
                            <ext:Column ID="INSPECTION_CONTENT" runat="server" Text="巡检内容" DataIndex="INSPECTION_CONTENT" Width="300" />
                            <ext:Column ID="INSPECTION_STANDARD" runat="server" Text="巡检标准" DataIndex="INSPECTION_STANDARD" Width="160" />
                            <ext:Column ID="INSPECTION_METHOD" runat="server" Text="点检方法" DataIndex="INSPECTION_METHOD" Width="120" />
                            <ext:Column ID="USER_NAME" runat="server" Text="记录人" DataIndex="USER_NAME" Width="70" />
                            <ext:DateColumn ID="RECORD_TIME" runat="server" Text="记录时间" DataIndex="RECORD_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                            <ext:CommandColumn ID="cmdCol" runat="server" Align="Center" Text="操作" Width="120">
                                <Commands>
                                    <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改" />
                                    <ext:GridCommand Icon="TableDelete" CommandName="Delete" Text="删除" />
                                </Commands>
                                <Listeners>
                                    <Command Handler="commandcolumn_click(command, record);" />
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

                <ext:Window ID="winAdd" runat="server" Icon="MonitorAdd" Closable="false" Title="添加设备巡检项目"
                    Width="500" Height="320" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
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
                                <ext:Container ID="Container4" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container ID="Container5" runat="server" Layout="FormLayout" ColumnWidth="1"
                                            Padding="5">
                                            <Items>
                                                <ext:ComboBox ID="add_equip_major" runat="server" FieldLabel="设备大类" LabelAlign="Right" Editable="false"
                                                    ValueField="value" DisplayField="text" >
                                                    <Store>
                                                        <ext:Store ID="add_equip_store" runat="server">
                                                            <Model>
                                                                <ext:Model ID="Model2" runat="server">
                                                                    <Fields>
                                                                        <ext:ModelField Name="value" Mapping="OBJID" />
                                                                        <ext:ModelField Name="text" Mapping="V" />
                                                                    </Fields>
                                                                </ext:Model>
                                                            </Model>
                                                        </ext:Store>
                                                    </Store>
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.clearValue();" />
                                                        <Select Handler="#{add_equip_minor}.clearValue(); #{add_MinorStore}.reload();" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox ID="add_equip_minor" runat="server" DisplayField="MINOR_TYPE_NAME"
                                                    ValueField="OBJID" FieldLabel="设备细类" LabelAlign="Right" Editable="false">
                                                    <Store>
                                                        <ext:Store
                                                            runat="server"
                                                            ID="add_MinorStore"
                                                            AutoLoad="false"
                                                            OnReadData="AddMinorRefresh">
                                                            <Model>
                                                                <ext:Model runat="server" IDProperty="OBJID">
                                                                    <Fields>
                                                                        <ext:ModelField Name="OBJID" Type="String" Mapping="OBJID" />
                                                                        <ext:ModelField Name="MINOR_TYPE_NAME" Type="String" Mapping="MINOR_TYPE_NAME" />
                                                                    </Fields>
                                                                </ext:Model>
                                                            </Model>
                                                            <Listeners>
                                                                <Load Handler="#{add_equip_minor}.setValue(#{add_equip_minor}.store.getAt(0).get('OBJID'));" />
                                                            </Listeners>
                                                        </ext:Store>
                                                    </Store>
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.clearValue();" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox ID="add_type_name" runat="server" FieldLabel="巡检项目类别" LabelAlign="Right" Editable="false">
                                                    <Items>
                                                        <ext:ListItem Text="电气点检项目" Value="1" />
                                                        <ext:ListItem Text="机械点检项目" Value="2" />
                                                    </Items>
                                                </ext:ComboBox>
                                                <ext:TextField ID="add_index" runat="server" FieldLabel="序号" LabelAlign="Right" />
                                                <ext:TextArea ID="add_content" runat="server" FieldLabel="巡检内容" LabelAlign="Right"  >
                                                </ext:TextArea>
                                                <ext:TextField ID="add_standard" runat="server" FieldLabel="巡检标准" LabelAlign="Right" />
                                                <ext:TextField ID="add_method" runat="server" FieldLabel="点检方法" LabelAlign="Right" />
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
                </ext:Window>

                <ext:Window ID="winModify" runat="server" Icon="MonitorEdit" Closable="false" Title="修改设备巡检项目"
                    Width="500" Height="320" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
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
                                        <ext:Container ID="Container2" runat="server" Layout="FormLayout" ColumnWidth="1"
                                            Padding="5">
                                            <Items>
                                                <ext:TextField ID="modify_obj_id" runat="server" Hidden="true" />
                                                <ext:ComboBox ID="modify_equip_major" runat="server" FieldLabel="设备大类" LabelAlign="Right" Editable="false"
                                                    ValueField="value" DisplayField="text" Disabled="true">
                                                    <Store>
                                                        <ext:Store ID="modify_equip_store" runat="server">
                                                            <Model>
                                                                <ext:Model ID="Model3" runat="server">
                                                                    <Fields>
                                                                        <ext:ModelField Name="value" Mapping="OBJID" />
                                                                        <ext:ModelField Name="text" Mapping="V" />
                                                                    </Fields>
                                                                </ext:Model>
                                                            </Model>
                                                        </ext:Store>
                                                    </Store>
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.clearValue();" />
                                                        <Select Handler="#{modify_equip_minor}.clearValue(); #{modify_MinorStore}.reload();" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox ID="modify_equip_minor" runat="server" DisplayField="MINOR_TYPE_NAME"
                                                    ValueField="OBJID" FieldLabel="设备细类" LabelAlign="Right" Editable="false"  Disabled="true">
                                                    <Store>
                                                        <ext:Store
                                                            runat="server"
                                                            ID="modify_MinorStore"
                                                            AutoLoad="false"
                                                            OnReadData="ModifyMinorRefresh">
                                                            <Model>
                                                                <ext:Model runat="server" IDProperty="OBJID">
                                                                    <Fields>
                                                                        <ext:ModelField Name="OBJID" Type="String" Mapping="OBJID" />
                                                                        <ext:ModelField Name="MINOR_TYPE_NAME" Type="String" Mapping="MINOR_TYPE_NAME" />
                                                                    </Fields>
                                                                </ext:Model>
                                                            </Model>
                                                            <Listeners>
                                                                <Load Handler="#{modify_equip_minor}.setValue(#{modify_equip_minor}.store.getAt(0).get('OBJID'));" />
                                                            </Listeners>
                                                        </ext:Store>
                                                    </Store>
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.clearValue();" />
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:ComboBox ID="modify_type_name" runat="server" FieldLabel="巡检项目类别" LabelAlign="Right" Editable="false">
                                                    <Items>
                                                        <ext:ListItem Text="电气点检项目" Value="1" />
                                                        <ext:ListItem Text="机械点检项目" Value="2" />
                                                    </Items>
                                                </ext:ComboBox>
                                                <ext:TextField ID="modify_index" runat="server" FieldLabel="序号" LabelAlign="Right" />
                                                <ext:TextArea ID="modify_content" runat="server" FieldLabel="巡检内容" LabelAlign="Right"  >
                                                </ext:TextArea>
                                                <ext:TextField ID="modify_standard" runat="server" FieldLabel="巡检标准" LabelAlign="Right" />
                                                <ext:TextField ID="modify_method" runat="server" FieldLabel="点检方法" LabelAlign="Right" />
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

                <ext:Hidden ID="hidden_user_type" runat="server" />
                <ext:Hidden ID="hidden_delete_flag" runat="server" />
                <ext:Hidden ID="hidden_txt_response_user" runat="server" />
                <ext:Hidden ID="hidden_add_equip_id" runat="server" />
                <ext:Hidden ID="hidden_select_equip_id" runat="server" />
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
