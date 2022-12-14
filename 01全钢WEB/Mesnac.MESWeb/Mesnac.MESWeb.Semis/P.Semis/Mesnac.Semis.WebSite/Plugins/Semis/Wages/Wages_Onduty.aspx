<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Wages_Onduty.aspx.cs" Inherits="Plugins_Semis_Wages_Wages_Onduty" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>人员出勤管理</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
  <%--  <script type="text/javascript">
        var thisDirUrl = "<%= Page.ResolveUrl("./") %>";
        var thisRootUrl = "<%= Page.ResolveUrl("~/") %>";
    </script>--%>
    <script type="text/javascript">

        //刷新页面
        var pnlListFresh = function () {
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }
        //查询
        var search = function () {
            App.hiddenIsSearchAllInfo.setValue("0");
            pnlListFresh();
            return false;
        }
        //历史查询
        debugger;
        var searchAll = function () {
            App.hiddenIsSearchAllInfo.setValue("1");
            pnlListFresh();
            return false;
        }
        debugger;
        //历史查询根据DeleteFlag的值进行样式绑定
        var SetRowClass = function (record, rowIndex, rowParams, store) {
            if (record.get("DELETE_FLAG") == "1") {
                return "x-grid-row-deleted";
            }
        }
        debugger;
        //历史查询的每行按钮准备加载
        var prepareToolbar = function (grid, toolbar, rowIndex, record) {
            if (record.get("DELETE_FLAG") == "1") {
                toolbar.items.getAt(0).hide();
                toolbar.items.getAt(1).hide();
                //toolbar.items.getAt(2).hide();
            } else {
                toolbar.items.getAt(2).hide();
            }
        }

        var commandcolumn_click = function (command, record) {
            commandcolumn_click_confirm(command, record);
            return false;
        };

        //区分删除操作，并进行二次确认操作
        var commandcolumn_click_confirm = function (command, record) {
            if (command.toLowerCase() == "edit") {
                  commandcolumn_direct_editdefect(record);
            }
            if (command.toLowerCase() == "delete") {
                Ext.Msg.confirm("提示", '您确定要删除此条信息吗？', function (btn) { commandcolumn_direct_deletedefect(btn, record) });
            }
            debugger;
            if (command.toLowerCase() == "recover") {
                Ext.Msg.confirm("提示", '您确定需要恢复此条信息？', function (btn) { commandcolumn_direct_recover(btn, record) });
            }
            return false;
        };
        var commandcolumn_direct_editdefect = function (record) {
            var Objid = record.data.OBJID;
            App.direct.commandcolumn_direct_editdefect(Objid, {
                success: function (result) {
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
    
        }

        //点击删除按钮
        var commandcolumn_direct_deletedefect = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var id = record.data.OBJID;
            App.direct.commandcolumn_direct_deletedefect(id, {
                success: function (result) {
                    Ext.Msg.alert('操作', result);
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
            this.pnlListFresh();
        }

        //点击恢复按钮
        var commandcolumn_direct_recover = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var ObjId = record.data.OBJID;
            App.direct.commandcolumn_direct_recover(ObjId, {
                success: function (result) {
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
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
            OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmMoldingStorage" runat="server" />
        <ext:Viewport ID="vpMoldingStorage" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnMoldingStorage" runat="server" Region="North" Height="120">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbMoldingStorage">
                            <Items>
                               <ext:Button runat="server" Icon="Add" Text="添加" ID="btnAdd">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip3" runat="server" Html="点击进行信息添加" />
                                    </ToolTips>
                                    <DirectEvents>
                                        <Click OnEvent="btnAdd_Click">
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>

                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                     <Listeners>
                                       <Click Fn="search">
                                       </Click>
                                    </Listeners>
                                </ext:Button>

                                <ext:ToolbarSeparator ID="ToolbarSeparator1" />
                                <ext:Hidden runat="server" ID="hiddenIsSearchAllInfo" Text="0" />
                                <ext:Button runat="server" Icon="BasketDelete" Text="历史查询" ID="btnSearchAll">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip1" runat="server" Html="点击进行查询所有信息" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Fn="searchAll">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:Button runat="server" Icon="PageExcel" Text="导出Excel" ID="btnExport" >
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="tsEnd" />
                                <ext:Button runat="server" Icon="PageWhiteExcel" Text="导入" ID="btnImport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip4" runat="server" Html="点击将进入生产计划功能" />
                                    </ToolTips>
                                    <DirectEvents>
                                        <Click OnEvent="btnImport_Click">
                                        </Click>
                                    </DirectEvents>
                                </ext:Button>
                                <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                                <ext:ToolbarFill ID="tfEnd" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>

                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                        <ext:DateField ID="begindate" runat="server" FieldLabel="开始日期" LabelAlign="Right" Editable="true">
                                        </ext:DateField>
                                        <ext:TextField ID="txtWorkCode" runat="server" FieldLabel="岗位编号" LabelAlign="Right" Editable="false">
                                        </ext:TextField>
                                        <ext:ComboBox ID="cbxclass" runat="server" FieldLabel="班组" LabelAlign="Right"
                                            Editable="false">
                                            <Items>
                                                <ext:ListItem Text="甲" Value="甲">
                                                </ext:ListItem>
                                                <ext:ListItem Text="乙" Value="乙">
                                                </ext:ListItem>
                                                <ext:ListItem Text="丙" Value="丙">
                                                </ext:ListItem>
                                            </Items>
                                            <Triggers>
                                                <ext:FieldTrigger Icon="Clear" Qtip="清空">
                                                </ext:FieldTrigger>
                                            </Triggers>
                                            <Listeners>
                                                <TriggerClick Handler="this.setValue('');" />
                                            </Listeners>
                                        </ext:ComboBox>

                                    </Items>
                                </ext:Container>

                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                        <ext:DateField ID="enddate" runat="server" FieldLabel="结束日期" LabelAlign="Right" Editable="true">
                                        </ext:DateField>
                                      <ext:TextField ID="txtWorkName" runat="server" FieldLabel="岗位名称" LabelAlign="Right" Editable="false">
                                        </ext:TextField>
                                      <ext:ComboBox ID="cbxEquipname" runat="server" FieldLabel="产线" LabelAlign="Right" Editable="false">
                                        </ext:ComboBox>
                                    </Items>
                                </ext:Container>

                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                      <ext:TextField ID="txtusercode" runat="server" FieldLabel="人员编号" LabelAlign="Right" Editable="false">
                                        </ext:TextField>
                                      <ext:TextField ID="txtusername" runat="server" FieldLabel="人员名称" LabelAlign="Right" Editable="false">
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="pnlDetail" runat="server"  Title="人员出勤信息" Height="480" Region="Center" Frame="true" Layout="Fit"  MarginsSummary="0 5 5 5">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server" MarginsSummary="0 5 5 5">
                           
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="15" >
                                <Proxy>
                                    <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="WORK_DATE" Type="Date"/>
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="USER_CODE" />
                                                <ext:ModelField Name="USER_NAME" />
                                                <ext:ModelField Name="WORK_CODE" />
                                                <ext:ModelField Name="WORK_NAME" />
                                                <ext:ModelField Name="ONDUTY_DAY" />
                                                <ext:ModelField Name="ONDUTY_HOUR" />
                                                <ext:ModelField Name="CLASS"/>
                                                <ext:ModelField Name="REMARK" />
                                                <ext:ModelField Name="RECORD_USERNAME" />
                                                <ext:ModelField Name="DELETE_FLAG" />
                                                <ext:ModelField Name="RECORD_TIME" Type="Date" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                     
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModelDetail" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="OBJID" runat="server" Text="编号" DataIndex="OBJID" />
                                    <ext:DateColumn ID="DateColumn1" runat="server" Text="出勤日期" DataIndex="WORK_DATE" Flex="1" Format="yyyy-MM-dd" />
                                    <ext:Column ID="TOOLING_TYPE_NAME" runat="server" Text="产线" DataIndex="EQUIP_NAME"  />
                                    <ext:Column ID="TOOLING_TYPE" runat="server" Text="人员编号" DataIndex="USER_CODE"  />
                                    <ext:Column ID="IS_USED" runat="server" Text="人员名称" DataIndex="USER_NAME" Flex="1" />
                                    <ext:Column ID="STANDARD_WAGES" runat="server" Text="岗位编号" DataIndex="WORK_CODE" Flex="1" />
                                    <ext:Column ID="Column1" runat="server" Text="岗位名称" DataIndex="WORK_NAME" Flex="1" />
                                    <ext:Column ID="Column2" runat="server" Text="出勤天数" DataIndex="ONDUTY_DAY" Flex="1" />
                                    <ext:Column ID="Column3" runat="server" Text="出勤工时" DataIndex="ONDUTY_HOUR" Flex="1" />
                                    <ext:Column ID="Column4" runat="server" Text="班组" DataIndex="CLASS" Flex="1" />
                                    <ext:Column ID="Column5" runat="server" Text="备注" DataIndex="REMARK" Flex="1" />
                                    <ext:Column ID="Column6" runat="server" Text="操作人" DataIndex="RECORD_USERNAME" Flex="1" />
                                    <ext:DateColumn ID="RECORD_TIME" runat="server" Text="操作时间" DataIndex="RECORD_TIME" Flex="1" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:CommandColumn runat="server" Width="120" Text="操作" Align="Center">
                                        <Commands>
                                            <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
                                                <ToolTip Text="修改本条数据" />
                                            </ext:GridCommand>
                                            <ext:GridCommand Icon="Delete" CommandName="Delete" Text="删除">
                                                <ToolTip Text="删除本条数据" />
                                            </ext:GridCommand>
                                            <ext:GridCommand Icon="Accept" CommandName="Recover" Text="恢复本条数据" MinWidth="118">
                                                <ToolTip Text="恢复本条数据" />
                                            </ext:GridCommand>
                                        </Commands>
                                        <PrepareToolbar Fn="prepareToolbar" />
                                        <Listeners>
                                            <Command Handler="return commandcolumn_click (command, record);" />
                                        </Listeners>
                            </ext:CommandColumn>
                                </Columns>
                            </ColumnModel>   
                    <View>
                        <ext:GridView ID="GridView1" runat="server">
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
                    </Items>
                </ext:Panel> 
                   <ext:Window ID="winPlanImport" runat="server" Icon="MonitorEdit" Closable="true"
                    Title="选择导入文件" Width="360" Height="160" Resizable="false" Hidden="true" Modal="true"
                    BodyStyle="background-color:#fff;" BodyPadding="5" Layout="FitLayout">
                    <Items>
                        <ext:FormPanel ID="panelImport" runat="server" Flex="1" BodyPadding="5">
                            <Defaults>
                                <ext:Parameter Name="allowBlank" Value="false" Mode="Raw" />
                            </Defaults>
                            <FieldDefaults>
                                <CustomConfig>
                                    <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                                    <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                                </CustomConfig>
                            </FieldDefaults>
                            <Items>
                                <ext:FileUploadField runat="server" ID="fileUploadFieldExcel" EmptyText="选择导入的Excel文件"
                                    FieldLabel="导入计划文件" ButtonText="" Icon="PageExcel" AllowBlank="false" Width="320"
                                    LabelAlign="Right" />
                            </Items>
                        </ext:FormPanel>
                    </Items>
                    <Buttons>
                        <ext:Button ID="btnImportUpload" runat="server" Text="上传" Disabled="false">
                            <DirectEvents>
                                <Click OnEvent="btnImportUpload_Click" Before="Ext.Msg.wait('正在上传文件...', '上传中');"
                                    Failure="Ext.Msg.show({ 
                                                title   : '错误', 
                                                msg     : '上传文件处理失败', 
                                                minWidth: 200, 
                                                modal   : true, 
                                                icon    : Ext.Msg.ERROR, 
                                                buttons : Ext.Msg.OK 
                                        });">
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                        <ext:Button ID="btnImportReset" runat="server" Text="重置">
                            <Listeners>
                                <Click Handler="#{panelImport}.getForm().reset();" />
                            </Listeners>
                        </ext:Button>
                    </Buttons>
                </ext:Window>
              <ext:Window ID="winAddTooling" runat="server" Icon="MonitorAdd" Closable="true" Title="添加人员出勤信息"
                Width="400" Height="340" Resizable="false" Hidden="true" Modal="false" BodyStyle="background-color:#fff;"
                BodyPadding="5" Layout="Form">
                <Items>
                    <ext:FormPanel ID="FormPanel1" runat="server" BodyPadding="5">
                        <FieldDefaults>
                            <CustomConfig>
                                <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                                <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                            </CustomConfig>
                        </FieldDefaults>
                        <Items>
                            <ext:Container ID="Container10" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                <Items>
                                    <ext:Container ID="Container11" runat="server" Layout="FormLayout" ColumnWidth="1"
                                        Padding="5">
                                        <Items>
                                             <ext:DateField ID="addWorkDate" runat="server" FieldLabel="出勤日期" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                             <ext:TextField ID="addEquipName" runat="server" FieldLabel="产线" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                             <ext:TextField ID="addUsername" runat="server" FieldLabel="人员名称" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                             <ext:TextField ID="addWorkname" runat="server" FieldLabel="岗位名称" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                             <ext:TextField ID="addOndutyDay" runat="server" FieldLabel="出勤天数" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" Hidden="true" />
                                             <ext:TextField ID="addOndutyHour" runat="server" FieldLabel="出勤工时" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                              <ext:ComboBox ID="cbxclass22" runat="server" FieldLabel="班组" LabelAlign="left"
                                                    Editable="false">
                                                    <Items>
                                                        <ext:ListItem Text="甲" Value="甲">
                                                        </ext:ListItem>
                                                        <ext:ListItem Text="乙" Value="乙">
                                                        </ext:ListItem>
                                                        <ext:ListItem Text="丙" Value="丙">
                                                        </ext:ListItem>
                                                    </Items>
                                                   <%-- <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>--%>
                                                </ext:ComboBox>
                                             <ext:TextField ID="addRemark" runat="server" FieldLabel="备注" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                        </Items>
                                    </ext:Container>
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:FormPanel>
                </Items>
                <Buttons>
                    <ext:Button ID="btnAddDefectSave" runat="server" Text="确定" Icon="Accept">
                        <DirectEvents>
                            <Click OnEvent="btnAddDefectSave_Click">
                            </Click>
                        </DirectEvents>
                    </ext:Button>
                    <ext:Button ID="btnAddDefectCancel" runat="server" Text="取消" Icon="Cancel">
                        <Listeners>
                            <Click Handler=" App.winAddTooling.close(); return false;" />
                        </Listeners>
                    </ext:Button>
                </Buttons>
                <Listeners>
                    <Show Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).disable(true);}" />
                    <Hide Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).enable(true);}" />
                </Listeners>
            </ext:Window>
    
            <ext:Window ID="winUpdateDefect" runat="server" Icon="MonitorEdit" Closable="false"
                Title="修改人员出勤信息" Width="320" Height="340" Resizable="false" Hidden="true" Modal="false"
                BodyStyle="background-color:#fff;" BodyPadding="5" Layout="Form">
                <Items>
                    <ext:FormPanel ID="pnlEdit" runat="server" Flex="1" BodyPadding="5">
                        <FieldDefaults>
                            <CustomConfig>
                                <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                                <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                            </CustomConfig>
                        </FieldDefaults>
                        <Items>
                            <ext:Container ID="Container5" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                <Items>
                                    <ext:Container ID="Container6" runat="server" Layout="FormLayout" ColumnWidth="1"
                                        Padding="2">
                                        <Items>
                                             <ext:Hidden runat="server" ID="hiddenObjid" Text="0" />
                                             <ext:DateField ID="editWorkDate" runat="server" FieldLabel="出勤日期" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                             <ext:TextField ID="editEquipName" runat="server" FieldLabel="产线" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                             <ext:TextField ID="editUserCode" runat="server" FieldLabel="人员编号" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" Hidden="true"/>
                                             <ext:TextField ID="editWorkCode" runat="server" FieldLabel="岗位编号" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" Hidden="true"/>
                                             <ext:TextField ID="editOndutyDay" runat="server" FieldLabel="出勤天数" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true"  Hidden="true"/>
                                             <ext:TextField ID="editOndutyHour" runat="server" FieldLabel="出勤工时" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                             <ext:TextField ID="editClass" runat="server" FieldLabel="班组" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                             <ext:TextField ID="editRemark" runat="server" FieldLabel="备注" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                        </Items>
                                    </ext:Container>
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:FormPanel>
                </Items>
                <Buttons>
                    <ext:Button ID="btnModifyDetailSave" runat="server" Text="确定" Icon="Accept">
                        <DirectEvents>
                            <Click OnEvent="btnModifyDefectSave_Click">
                            </Click>
                        </DirectEvents>
                    </ext:Button>
                    <ext:Button ID="btnModifyDetailCancel" runat="server" Text="取消" Icon="Cancel">
                        <Listeners>
                            <Click Handler=" App.winUpdateDefect.close(); return false;" />
                        </Listeners>
                    </ext:Button>
                </Buttons>
                <Listeners>
                    <Show Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).disable(true);}" />
                    <Hide Handler="for(var i=0;i<#{vwUnit}.items.length;i++){#{vwUnit}.getComponent(i).enable(true);}" />
                </Listeners>
            </ext:Window>

        </Items>
        </ext:Viewport>
    </form>
</body>
</html>

