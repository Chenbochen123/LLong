<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Wages_ReturnRubber.aspx.cs" Inherits="Plugins_Semis_Wages_Wages_ReturnRubber" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>返回胶明细维护</title>
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
                <ext:Panel ID="pnMoldingStorage" runat="server" Region="North" Height="90">
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
                                <ext:Button runat="server" Icon="PageExcel" Text="导出Excel" ID="btnExport">
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
                                        <ext:TextField ID="txtsap" runat="server" FieldLabel="物料SAP" LabelAlign="Right" Editable="false">
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>

                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                        <ext:DateField ID="enddate" runat="server" FieldLabel="结束日期" LabelAlign="Right" Editable="true">
                                        </ext:DateField>
                                      <ext:ComboBox ID="cbxEquipname" runat="server" FieldLabel="产线" LabelAlign="Right" Editable="false">
                                        </ext:ComboBox>
                                    </Items>
                                </ext:Container>

                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
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
                                      <ext:ComboBox ID="cbxreason" runat="server" FieldLabel="退回原因" LabelAlign="Right" Editable="false">
                                        </ext:ComboBox>
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="pnlDetail" runat="server" Title="返回胶明细" Height="500" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 5 5">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server" MarginsSummary="0 5 5 5">

                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="20">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="RETURN_DATE"  Type="Date" />
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="USER_NAME" />
                                                <ext:ModelField Name="CLASS" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="MINOR_TYPE_NAME" />
                                                <ext:ModelField Name="MATER_TYPE" />
                                                <ext:ModelField Name="WEIGHT" />
                                                <ext:ModelField Name="RETURN_REASON" />
                                                <ext:ModelField Name="CONFIRM_USER" />
                                                <ext:ModelField Name="REMARK" />
                                                <ext:ModelField Name="RECORD_TIME" Type="Date" />
                                                <ext:ModelField Name="RE_USERNAME" />
                                                <ext:ModelField Name="DELETE_FLAG" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>

                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModelDetail" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="OBJID" runat="server" Text="编号" DataIndex="OBJID" /> 
                                    <ext:DateColumn ID="DateColumn1" runat="server" Text="退库日期" DataIndex="RETURN_DATE" Flex="1" Format="yyyy-MM-dd" />
                                    <ext:Column ID="TOOLING_TYPE_NAME" runat="server" Text="产线" DataIndex="EQUIP_NAME" />
                                    <ext:Column ID="Column2" runat="server" Text="主机手" DataIndex="USER_NAME" />
                                    <ext:Column ID="Column5" runat="server" Text="班组" DataIndex="CLASS" />
                                    <ext:Column ID="TOOLING_TYPE" runat="server" Text="物料名称" DataIndex="MATERIAL_NAME" />
                                    <ext:Column ID="IS_USED" runat="server" Text="物料细类" DataIndex="MINOR_TYPE_NAME" Flex="1" />
                                    <ext:Column ID="STANDARD_WAGES" runat="server" Text="型号" DataIndex="MATER_TYPE" Flex="1" />
                                    <ext:Column ID="Column1" runat="server" Text="重量（KG）" DataIndex="WEIGHT" Flex="1" />
                                    <ext:Column ID="Column6" runat="server" Text="返回原因" DataIndex="RETURN_REASON" Flex="1" />
                                    <ext:Column ID="Column7" runat="server" Text="保管员确认" DataIndex="CONFIRM_USER" Flex="1" />
                                    <ext:Column ID="Column3" runat="server" Text="备注" DataIndex="REMARK" Flex="1" />
                                    <ext:DateColumn ID="RECORD_TIME" runat="server" Text="操作时间" DataIndex="RECORD_TIME" Flex="1" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="Column4" runat="server" Text="操作人" DataIndex="RE_USERNAME" Flex="1" />
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

                <ext:Window ID="winAddTooling" runat="server" Icon="MonitorAdd" Closable="true" Title="添加返回胶明细"
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
                                             <ext:DateField ID="addWorkDate" runat="server" FieldLabel="退库日期" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                                <ext:TextField ID="addEquipname" runat="server" FieldLabel="产线" LabelAlign="Left"
                                                    ReadOnly="false" Enabled="true" />
                                                <ext:TextField ID="addUsername" runat="server" FieldLabel="主机手" LabelAlign="Left"
                                                    ReadOnly="false" Enabled="true" />
                                                  <ext:ComboBox ID="addClass" runat="server" FieldLabel="班组" LabelAlign="left"
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
                                                <ext:TextField ID="addMatersap" runat="server" FieldLabel="物料SAP" LabelAlign="Left"
                                                    ReadOnly="false" Enabled="true" />
                                                <ext:TextField ID="addWeight" runat="server" FieldLabel="重量KG" LabelAlign="Left"
                                                    ReadOnly="false" Enabled="true" />
                                                <ext:TextField ID="addReason" runat="server" FieldLabel="退库原因" LabelAlign="Left"
                                                    ReadOnly="false" Enabled="true" />
                                                <ext:TextField ID="addOkUser" runat="server" FieldLabel="保管员确认" LabelAlign="Left"
                                                    ReadOnly="false" Enabled="true" />
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
                    Title="修改返回胶明细" Width="320" Height="340" Resizable="false" Hidden="true" Modal="false"
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
                                             <ext:DateField ID="eReturnDate" runat="server" FieldLabel="退库日期" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" Hidden="true"/>
                                                <ext:TextField ID="eEquipname" runat="server" FieldLabel="产线" LabelAlign="Left"
                                                    ReadOnly="false" Enabled="true" Hidden ="true"/>
                                                <ext:TextField ID="eUsername" runat="server" FieldLabel="主机手" LabelAlign="Left"
                                                    ReadOnly="false" Enabled="true" Hidden="true"/>
                                                  <ext:ComboBox ID="eClass" runat="server" FieldLabel="班组" LabelAlign="left"
                                                    Editable="false" Hidden="true">
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
                                                <ext:TextField ID="eMatersap" runat="server" FieldLabel="物料SAP" LabelAlign="Left"
                                                    ReadOnly="false" Enabled="true" Hidden="true"/>
                                                <ext:TextField ID="eWeight" runat="server" FieldLabel="重量KG" LabelAlign="Left"
                                                    ReadOnly="false" Enabled="true" />
                                                <ext:TextField ID="eReason" runat="server" FieldLabel="退库原因" LabelAlign="Left"
                                                    ReadOnly="false" Enabled="true" />
                                                <ext:TextField ID="eOkUser" runat="server" FieldLabel="保管员确认" LabelAlign="Left"
                                                    ReadOnly="false" Enabled="true"/>
                                                <ext:TextField ID="eRemark" runat="server" FieldLabel="备注" LabelAlign="Left"
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

            </Items>
        </ext:Viewport>
    </form>
</body>
</html>

