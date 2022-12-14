<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EquipRepairProtectPlan.aspx.cs" Inherits="Manager_Equip_EquipRepairProtectPlan_EquipRepairProtectPlan" %>
<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>设备维护保养计划</title>                 
    
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js" ></script>
    <script type="text/javascript" src="EquipRepairProtectPlan.js" ></script>
    <link rel="Stylesheet" type="text/css" href="EquipRepairProtectPlan.css" />
</head>
<body>
    <form id="fmUser" runat="server">
        <asp:Button ID="btnExportSubmit" Style="display:none" runat="server" Text="Button" OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmUser" runat="server" />
        <ext:Viewport ID="vwUnit" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnlUserTitle" runat="server" Region="North" AutoHeight="true" Collapsible ="true">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="barUser">
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
                                <ext:Button runat="server" Icon="ArrowDown" Text="审批" ID="btn_finish">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip1" runat="server" Html="点击进行计划完成确认" />
                                    </ToolTips>
                                    <DirectEvents>
                                        <Click OnEvent="btn_finish_Click">
                                            <ExtraParams>
                                                <ext:Parameter Name="Values" Value="Ext.encode(#{pnlList}.getRowsValues({selectedOnly:true}))"
                                                    Mode="Raw" />
                                            </ExtraParams>
                                        </Click>
                                    </DirectEvents>
                                </ext:Button> 
                                <ext:ToolbarSeparator ID="toolbarSeparator1" />
                                <%--<ext:Button runat="server" Icon="PageWhiteExcel" Text="导出" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();"></Click>
                                    </Listeners>
                                </ext:Button>--%>
                                <ext:ToolbarSeparator ID="toolbarSeparator_end" />
                                <ext:ToolbarSpacer runat="server" ID="toolbarSpacer_end" />
                                <ext:ToolbarFill ID="toolbarFill_end" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:Panel ID="pnlUserQuery" runat="server" AutoHeight="true">
                            <Items>
                                <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container ID="container_1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:TriggerField ID="txt_response_user" runat="server" FieldLabel="责任人" LabelAlign="Right" Editable="false" >
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="SelectUserCode(this, trigger, index , 1 , 'hidden_txt_response_user')" />
                                                    </Listeners>
                                                </ext:TriggerField>
                                                <ext:DateField ID="txt_start_repair_date" runat="server" FieldLabel="开始检修时间" LabelAlign="Right" Editable="false" />
                                                <ext:DateField ID="txt_end_repair_date" runat="server" FieldLabel="结束检修时间" LabelAlign="Right" Editable="false"  />
                                                <ext:TriggerField ID="txt_equip_code" runat="server" FieldLabel="设备名称" LabelAlign="Right" Editable="false" >
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Fn="SelectEquipInfo" />
                                                    </Listeners>
                                                </ext:TriggerField>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:TriggerField ID="txt_finish_user"  runat="server" FieldLabel="完成人" LabelAlign="Right" Editable="false" >
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="SelectUserCode(this, trigger, index , 2 , 'hidden_txt_finish_user')" />
                                                    </Listeners>
                                                </ext:TriggerField>
                                                <ext:DateField ID="txt_start_finish_date" runat="server" FieldLabel="开始完成时间" LabelAlign="Right" Editable="false"  />
                                                <ext:DateField ID="txt_end_finish_date" runat="server" FieldLabel="结束完成时间" LabelAlign="Right" Editable="false"  />
                                                <ext:ComboBox ID="txt_plan_name" runat="server" FieldLabel="计划名称" LabelAlign="Right" Editable="false" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container_3" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:TriggerField ID="txt_confirm_user"  runat="server" FieldLabel="确认人" LabelAlign="Right" Editable="false" >
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="SelectUserCode(this, trigger, index , 3 , 'hidden_txt_confirm_user')" />
                                                    </Listeners>
                                                </ext:TriggerField>
                                                <ext:DateField ID="txt_start_confirm_date" runat="server" FieldLabel="开始确认时间" LabelAlign="Right" Editable="false"  />
                                                <ext:DateField ID="txt_end_confirm_date" runat="server" FieldLabel="结束确认时间" LabelAlign="Right" Editable="false"  />
                                                <ext:ComboBox ID="cbxIsDelete" runat="server" FieldLabel="是否关闭" LabelAlign="Right" Editable="false" Hidden="true" >
                                                <Items>
                                                    <ext:ListItem Text="全部" Value="all"></ext:ListItem>
                                                    <ext:ListItem Text="否" Value="0"></ext:ListItem>
                                                    <ext:ListItem Text="是" Value="1"></ext:ListItem>
                                                </Items>
                                            </ext:ComboBox>
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
                        <ext:Store ID="store" runat="server" PageSize="15" GroupField="GroupName">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" AutoDataBind="false" />
                            </Proxy>
                            <Sorters>
                                <ext:DataSorter Property="RepairDate" Direction="DESC" />
                            </Sorters>
                            <Model>
                                <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                    <Fields>
                                        <ext:ModelField Name="OBJID" />
                                        <ext:ModelField Name="GroupName" />
                                        <ext:ModelField Name="BILL_NO"  />
                                        <ext:ModelField Name="EQUIP_NAME"  />
                                        <ext:ModelField Name="PLAN_REPAIRCONTENT"  />
                                        <ext:ModelField Name="REPAIR_TIME" />
                                        <ext:ModelField Name="REPAIR_DATE" />
                                        <ext:ModelField Name="RESPONSE_USER_NAME"  />
                                        <ext:ModelField Name="NEED_STOPTIME"  />
                                        <ext:ModelField Name="PLAN_STOPTIME_TEXT"  />
                                        <ext:ModelField Name="PLAN_STOPTIME"  />
                                        <ext:ModelField Name="FINISH_CONDITION"  />
                                        <ext:ModelField Name="FINISH_DATE" Type="Date" />
                                        <ext:ModelField Name="FINISH_USER_NAME"  />
                                        <ext:ModelField Name="VERIFICATION"  />
                                        <ext:ModelField Name="CONFIRM_USER_NAME"  />
                                        <ext:ModelField Name="CONFIRM_DATE" Type="Date" />
                                        <ext:ModelField Name="DELETE_FLAG"  />
                                        <ext:ModelField Name="Remark"  /> 
                                        <ext:ModelField Name="PlanName"  /> 
                                        <ext:ModelField Name="PLAN_STOPDATE" /> 
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <SelectionModel>
                        <ext:CheckboxSelectionModel ID="CheckboxSelectionModel1" runat="server" Mode="Single" />
                    </SelectionModel>
                    <ColumnModel ID="colModel" runat="server">
                        <Columns>
                            <ext:RowNumbererColumn ID="rowNumCol" Width="45" runat="server" />
                            <ext:SummaryColumn  runat="server" Text="维护单" DataIndex="BILL_NO" Width="120"  />
                            <ext:SummaryColumn  runat="server" Text="设备名称" DataIndex="EQUIP_NAME" Width="80"  />
                            <ext:SummaryColumn SummaryType="Count" runat="server" Text="检修日期" DataIndex="REPAIR_DATE" Width="90"  >
                                <Renderer Format="Date" FormatArgs="'Y-m-d'" />
                                <SummaryRenderer Handler="return ((value === 0 || value > 1) ? '(' + value +' Tasks)' : '(1 Task)');" />      
                            </ext:SummaryColumn>
                            <ext:SummaryColumn SummaryType="Sum" runat="server" Text="检修时间" DataIndex="REPAIR_TIME" Width="60"  >
                                <Renderer Handler="return value +' hours';" />
                                <SummaryRenderer Handler="return value +' hours';" />
                            </ext:SummaryColumn>
                            <ext:SummaryColumn  runat="server" Text="责任人" DataIndex="RESPONSE_USER_NAME" Width="80"  />
                            <ext:SummaryColumn  runat="server" Text="计划内容" DataIndex="PLAN_REPAIRCONTENT" Width="100"  />
                            <ext:SummaryColumn SummaryType="Sum"  runat="server" Text="需要停车时间" DataIndex="NEED_STOPTIME" Width="100"  >
                                <Renderer Handler="return value +' hours';" />
                                <SummaryRenderer Handler="return value +' hours';" />
                            </ext:SummaryColumn>
                            <ext:SummaryColumn  runat="server" Text="计划停车日期" DataIndex="PLAN_STOPTIME_TEXT" Width="100"  />
                            <ext:SummaryColumn  runat="server" Text="计划停车日期" DataIndex="PLAN_STOPTIME" Width="100" Hidden="true" />
                            <ext:SummaryColumn  Format="yyyy-MM-dd" ID="finish_date" runat="server" Text="完成日期" DataIndex="FINISH_DATE" Width="80"  >
                                <Renderer Format="Date" FormatArgs="'Y-m-d'" />
                            </ext:SummaryColumn>
                            <ext:SummaryColumn  runat="server" Text="完成人" DataIndex="FINISH_USER_NAME" Width="80"  />
                            <ext:SummaryColumn  runat="server" Text="完成情况" DataIndex="FINISH_CONDITION" Width="100"  />
                            <ext:SummaryColumn  Format="yyyy-MM-dd" runat="server" Text="确认日期" DataIndex="CONFIRM_DATE" Width="80" >
                                <Renderer Format="Date" FormatArgs="'Y-m-d'" />
                            </ext:SummaryColumn>
                            <ext:SummaryColumn  runat="server" Text="确认人" DataIndex="CONFIRM_USER_NAME" Width="80"  />
                            <ext:SummaryColumn  runat="server" Text="效果验证" DataIndex="VERIFICATION" Width="150" />
                            <ext:SummaryColumn  runat="server" Text="是否关闭" DataIndex="DELETE_FLAG" Width="80" Hidden="true" />
                            <ext:SummaryColumn  runat="server" Text="备注" DataIndex="Remark" Width="80"  Hidden="true" />
                            <ext:CommandColumn  runat="server" Width="120" Text="操作" Align="Center">
                                <Commands>
                                    <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
                                        <ToolTip Text="修改本条数据" />
                                    </ext:GridCommand>
                                    <ext:CommandSeparator/>
                                    <ext:GridCommand Icon="Delete" CommandName="Delete" Text="删除">
                                        <ToolTip Text="删除本条数据" />
                                    </ext:GridCommand> 
                                    <ext:CommandSeparator />
                                </Commands>
                                <PrepareToolbar Fn="prepareToolbar" />
                                <Listeners>
                                    <Command Handler="return commandcolumn_click(command, record);" />
                                </Listeners>
                            </ext:CommandColumn>
                        </Columns>
                    </ColumnModel>
                     <View>
                        <ext:GridView ID="gvRows" runat="server">
                            <GetRowClass Fn="SetRowClass" />
                        </ext:GridView>
                    </View>
                    <TopBar>
                        <ext:Toolbar ID="Toolbar1" runat="server">
                            <Items>
                                <ext:Button ID="Button1" runat="server" Text="折叠汇总" ToolTip="展开或者关闭汇总信息">
                                    <Listeners>
                                        <Click Handler="#{Group1}.toggleSummaryRow(!#{Group1}.showSummaryRow);#{Group1}.view.refresh();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarFill />
                                <ext:Label ID="planState" Html="(颜色状态说明:<span style='color:#E3170D;padding-right:10px;padding-left:10px;font-weight: bold;'>待审核</span><span style='color:#00FF00;padding-right:10px;font-weight: bold;'>已审核</span>)"
                                    runat="server" ColumnWidth=".7">
                                </ext:Label>
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <BottomBar>
                        <ext:PagingToolbar ID="pageToolBar" runat="server">
                            <Plugins>
                                <ext:ProgressBarPager ID="ProgressBarPager" runat="server" />
                            </Plugins>
                        </ext:PagingToolbar>
                    </BottomBar>
                    <Features>
                        <ext:GroupingSummary ID="Group1" runat="server" GroupHeaderTplString="{name}" HideGroupedHeader="true" EnableGroupingMenu="false">
                        </ext:GroupingSummary>
                    </Features>
                </ext:GridPanel>
                <ext:Window ID="winModify" runat="server" Icon="MonitorEdit" Closable="false" Title="修改维护保养计划信息"
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
                                                <ext:ComboBox       ID="modify_plan_name"  runat="server"  FieldLabel="计划名称"  LabelAlign="Right"  AllowBlank="false" Editable="false" />
                                                <ext:TriggerField   ID="modify_equip_name" runat="server" FieldLabel="设备名称" LabelAlign="Right" AllowBlank="false" Editable="false" >
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Fn="SelectEquipInfo" />
                                                    </Listeners>
                                                </ext:TriggerField>
                                                <ext:DateField    ID="modify_repair_date"     runat="server" FieldLabel="检修日期"      LabelAlign="Right"   AllowBlank="false" Editable="false" />
                                                <ext:NumberField    ID="modify_repair_time"     runat="server" FieldLabel="检修时间(h)" MinValue="0"       LabelAlign="Right"   AllowBlank="false" Editable="false" />
                                                <ext:NumberField    ID="modify_need_stop_time"  runat="server" FieldLabel="需停机时间(h)" MinValue="0"   LabelAlign="Right"   AllowBlank="false" Editable="false" />
                                                <ext:ComboBox      ID="modify_plan_stop_time" ValueField="modify_plan_stop_id"  runat="server" FieldLabel="计划停机日期"  LabelAlign="Right"   AllowBlank="false" Editable="false" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="Container3"  runat="server" Layout="FormLayout" ColumnWidth=".5"
                                            Padding="5">
                                            <Items>
                                                
                                                <ext:DateField      ID="modify_plan_month" Format="yyyy-MM" runat="server" FieldLabel="计划月份"  LabelAlign="Right"  AllowBlank="false" Editable="false" />
                                                <ext:TriggerField   ID="modify_response_user"   runat="server" FieldLabel="责任人"        LabelAlign="Right"   AllowBlank="false" Editable="false"  >
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="SelectUserCode(this, trigger, index , 1 , 'hidden_modify_response_user')" />
                                                    </Listeners>
                                                </ext:TriggerField>
                                                <ext:TextArea       ID="modify_repair_protect_plan_content"   runat="server"   FieldLabel="计划内容"   LabelAlign="Right"  AllowBlank="false" Editable="false" Height="100" />
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
                <ext:Window ID="winAdd" runat="server" Icon="MonitorAdd" Closable="false" Title="添加维护保养计划信息"
                    Width="700" Height="280" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
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
                                        <ext:Container ID="Container5"  runat="server" Layout="FormLayout" ColumnWidth=".5"
                                            Padding="5">
                                            <Items> 
                                                <ext:ComboBox ID="add_plan_name"  runat="server"  FieldLabel="计划名称"  LabelAlign="Right"  AllowBlank="false" Editable="false" >
                                                    <DirectEvents>
                                                        <Change OnEvent="GetNeedStopTime" />
                                                    </DirectEvents>
                                                </ext:ComboBox>
                                                <ext:ComboBox ID="add_equip_major" runat="server" FieldLabel="设备大类" LabelAlign="Right" Editable="false"
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
                                                    </Listeners>
                                                </ext:ComboBox>
                                                <ext:TriggerField ID="add_equip_name" runat="server" FieldLabel="设备名称" LabelAlign="Right" Editable="false" >
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Fn="SelectEquipInfo" />
                                                    </Listeners>
                                                     <DirectEvents>
                                                        <Change OnEvent="GetNeedStopTime" />
                                                    </DirectEvents>
                                                </ext:TriggerField>
                                                <ext:DateField      ID="add_repair_date"     runat="server" FieldLabel="检修日期"      LabelAlign="Right"   AllowBlank="false" Editable="false" />
                                                <ext:NumberField   ID="add_repair_time"     runat="server"  FieldLabel="检修时间(h)" MinValue="0" LabelAlign="Right"  AllowBlank="false" Editable="false" />
                                                <ext:NumberField    ID="add_need_stop_time"  runat="server"  FieldLabel="需停车时间(h)" MinValue="0"   LabelAlign="Right"  AllowBlank="false" Editable="false" />
                                                <ext:ComboBox       ID="add_plan_stop_time"  runat="server"  FieldLabel="计划停车时间"  LabelAlign="Right"  AllowBlank="false" Editable="false" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="Container6"  runat="server" Layout="FormLayout" ColumnWidth=".5"
                                            Padding="5">
                                            <Items>
                                                <ext:DateField ID="add_plan_month" Format="yyyy-MM" runat="server" FieldLabel="计划月份"  LabelAlign="Right"  AllowBlank="false" Editable="false" >
                                                     <DirectEvents>
                                                        <Change OnEvent="GetNeedStopTime" />
                                                    </DirectEvents>
                                                </ext:DateField>
                                                <ext:TriggerField   ID="add_response_user"   runat="server"  FieldLabel="责任人"        LabelAlign="Right"  AllowBlank="false" Editable="false"  >
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="SelectUserCode(this, trigger, index , 1 , 'hidden_add_response_user')" />
                                                    </Listeners>
                                                </ext:TriggerField> 
                                                <ext:TextArea  ID="add_repair_protect_plan_content"   runat="server"   FieldLabel="计划内容"   LabelAlign="Right"  AllowBlank="false" Editable="false" Height="100" />
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
                <ext:Window ID="winDetail" runat="server" Icon="MonitorEdit" Title="维修保养计划信息详细"
                    Width="900" Height="330" Resizable="false" Closable="true" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
                    BodyPadding="5" Layout="Form">
                    <Items> 
                        <ext:FormPanel ID="FormPanel1" runat="server" Flex="1" BodyPadding="5">
                            <FieldDefaults>
                                <CustomConfig>
                                    <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                                    <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                                </CustomConfig>
                            </FieldDefaults>
                            <Items>
                                <ext:Container ID="Container9" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container ID="Container10"  runat="server" Layout="FormLayout" ColumnWidth=".3"
                                            Padding="5">
                                            <Items>
                                                <ext:TextField      ID="detail_plan_name"     runat="server" FieldLabel="计划名称"      LabelAlign="Right"   AllowBlank="false" Editable="false" />
                                                <ext:TextField      ID="detail_plan_month"     runat="server" FieldLabel="计划月份"      LabelAlign="Right"   AllowBlank="false" Editable="false" />
                                                <ext:TextField      ID="detail_equip_code"   runat="server"   FieldLabel="设备名称"   LabelAlign="Right"  ReadOnly="true"    />
                                                <ext:TextField      ID="detail_repair_date"     runat="server" FieldLabel="检修日期"      LabelAlign="Right"   AllowBlank="false" Editable="false" />
                                                <ext:TextField      ID="detail_repair_time"    runat="server" FieldLabel="检修时间(h)"   LabelAlign="Right" ReadOnly="true" />
                                                <ext:TextField      ID="detail_response_user"    runat="server" FieldLabel="责任人"     LabelAlign="Right" ReadOnly="true" />
                                                <ext:TextArea       ID="detail_repair_protect_plan_content"    runat="server"   FieldLabel="计划内容" Height="87"   LabelAlign="Right" ReadOnly="true"   />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="Container11"  runat="server" Layout="FormLayout" ColumnWidth=".3"
                                            Padding="5">
                                            <Items>
                                                <ext:TextField   ID="detail_need_stop_time"  runat="server"   FieldLabel="需停机时间(h)"   LabelAlign="Right"  ReadOnly="true" />
                                                <ext:TextField   ID="detail_plan_stop_time" runat="server"   FieldLabel="计划停机时间"   LabelAlign="Right"  ReadOnly="true"  />
                                                <ext:TextField  ID="detail_finish_date"  runat="server"   FieldLabel="完成日期"   LabelAlign="Right" ReadOnly="true"   />
                                                <ext:TextField  ID="detail_finish_user"  runat="server"   FieldLabel="完成人"     LabelAlign="Right" ReadOnly="true" />
                                                <ext:TextArea   ID="detail_finish_condition" runat="server"   FieldLabel="完成情况"   LabelAlign="Right" ReadOnly="true"   />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="Container12"  runat="server" Layout="FormLayout" ColumnWidth=".3"
                                            Padding="5">
                                            <Items>
                                                <ext:TextField  ID="detail_confirm_date"    runat="server"   FieldLabel="确认日期"   LabelAlign="Right" ReadOnly="true"  />
                                                <ext:TextField  ID="detail_confirm_user"    runat="server"   FieldLabel="确认人"     LabelAlign="Right" ReadOnly="true" />
                                                <ext:TextArea   ID="detail_verification"    runat="server"   FieldLabel="效果验证"   LabelAlign="Right" ReadOnly="true" Height="87"  />
                                                <ext:TextField  ID="detail_remark"          runat="server"   FieldLabel="备注"       LabelAlign="Right" ReadOnly="true" />
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                </ext:Window>
                <ext:Window ID="winFinish" runat="server" Icon="MonitorEdit" Closable="false" Title="审批维护保养计划信息"
                    Width="600" Height="390" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
                    BodyPadding="5" Layout="Form">
                    <Items> 
                        <ext:FormPanel ID="FormPanel2" runat="server" Flex="1" BodyPadding="5">
                            <FieldDefaults>
                                <CustomConfig>
                                    <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                                    <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                                </CustomConfig>
                            </FieldDefaults>
                            <Items>
                                <ext:Container ID="Container8" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items> 
                                        <ext:Container ID="Container15"  runat="server" Layout="FormLayout" ColumnWidth=".5"
                                            Padding="5">
                                            <Items> 
                                                <ext:TextField  ID="finish_obj_id" runat="server" Hidden="true" />
                                                 <ext:TextField ID="finish_plan_name"  runat="server"  FieldLabel="计划名称"  LabelAlign="Right"  ReadOnly="true" > </ext:TextField>
                                                <ext:TextField  ID="finish_equip_code"      runat="server"  FieldLabel="设备名称" LabelAlign="Right"         ReadOnly="true" />
                                                <ext:TextField  ID="finish_repair_date"     runat="server"  FieldLabel="检修日期"   LabelAlign="Right"       ReadOnly="true" />
                                                <ext:TextField  ID="finish_repair_time"     runat="server"  FieldLabel="检修时间(h)"   LabelAlign="Right"       ReadOnly="true" />
                                                <ext:TextField  ID="finish_need_stop_time"  runat="server"  FieldLabel="需停车时间(h)"   LabelAlign="Right" ReadOnly="true" />
                                                <ext:TextField  ID="finish_plan_stop_time"  runat="server"  FieldLabel="计划停车时间"   LabelAlign="Right"   ReadOnly="true" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="Container16"  runat="server" Layout="FormLayout" ColumnWidth=".5"
                                            Padding="5">
                                            <Items>
                                                <ext:TextField  ID="finish_plan_month"      runat="server"   FieldLabel="计划月份" LabelAlign="Right"         ReadOnly="true" />
                                                <ext:TextField  ID="finish_response_user"   runat="server"  FieldLabel="责任人"     LabelAlign="Right"       ReadOnly="true"  />
                                                <ext:TextArea  ID="finish_repair_protect_plan_content"   runat="server"   FieldLabel="计划内容"   LabelAlign="Right"  AllowBlank="false"  ReadOnly="true" Height="100" />
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="Container7" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container ID="Container13"  runat="server" Layout="FormLayout" ColumnWidth=".5"
                                            Padding="5">
                                            <Items>
                                                <ext:DateField     ID="modify_finish_date"  runat="server"   FieldLabel="完成时间"   LabelAlign="Right"  AllowBlank="false" Editable="false" />
                                                <ext:TriggerField  ID="modify_finish_user"  runat="server"   FieldLabel="完成人"     LabelAlign="Right"  AllowBlank="false" Editable="false"   >
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" />
                                                        <ext:FieldTrigger Icon="Search" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="SelectUserCode(this, trigger, index , 2 , 'hidden_modify_finish_user')" />
                                                    </Listeners>
                                                </ext:TriggerField>
                                                <ext:TextArea  ID="modify_finish_condition" runat="server"   FieldLabel="完成情况"   LabelAlign="Right"  AllowBlank="false" Editable="false" />
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="Container14"  runat="server" Layout="FormLayout" ColumnWidth=".5"
                                            Padding="5">
                                            <Items>
                                                <ext:TextArea ID="modify_verification" runat="server"   FieldLabel="效果验证"   LabelAlign="Right"  AllowBlank="false" Editable="false" />
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:Container>
                            </Items>
                             <Listeners>
                                <ValidityChange Handler="#{btnFinishSave}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="btnFinishSave" runat="server" Text="确定" Icon="Accept">
                            <DirectEvents>
                                <Click OnEvent="BtnFinishSave_Click">
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button ID="btnFinishCancel" runat="server" Text="取消" Icon="Cancel">
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
                <ext:Hidden ID="hidden_user_type" runat="server" />
                <ext:Hidden ID="hidden_txt_response_user" runat="server" />
                <ext:Hidden ID="hidden_txt_finish_user" runat="server" />
                <ext:Hidden ID="hidden_txt_confirm_user" runat="server" />
                
                <ext:Hidden ID="hidden_add_response_user" runat="server" />
                <ext:Hidden ID="hidden_add_finish_user" runat="server" />
                <ext:Hidden ID="hidden_add_confirm_user" runat="server" />
                
                <ext:Hidden ID="hidden_modify_response_user" runat="server" />
                <ext:Hidden ID="hidden_modify_finish_user" runat="server" />
                <ext:Hidden ID="hidden_modify_confirm_user" runat="server" />
                <ext:Hidden ID="hidden_modify_plan_stop_time" runat="server" />
                <ext:Hidden runat="server" ID="hidden_select_equip_code" />
                <ext:Hidden runat="server" ID="hidden_equip_code" />
            </Items>
        </ext:Viewport>
        </form>
</body>
</html>
