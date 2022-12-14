<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Wages_Work.aspx.cs" Inherits="Plugins_Semis_Wages_Wages_Work" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>岗位管理</title>
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
                                      <ext:TextField ID="txtWorkCode" runat="server" FieldLabel="岗位编号" LabelAlign="Right" Editable="true">
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>

                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                      <ext:TextField ID="txtWorkName" runat="server" FieldLabel="岗位名称" LabelAlign="Right" Editable="true">
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>

                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                      <ext:ComboBox ID="cbxEquipname" runat="server" FieldLabel="产线" LabelAlign="Right" Editable="false">
                                        </ext:ComboBox>
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="pnlDetail" runat="server"  Title="岗位信息" Height="500" Region="Center" Frame="true" Layout="Fit"  MarginsSummary="0 5 5 5">
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
                                                <ext:ModelField Name="WORK_CODE" />
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="USER_COUNT" />
                                                <ext:ModelField Name="WORK_NAME" />
                                                <ext:ModelField Name="STANDARD_WAGES" />
                                                <ext:ModelField Name="SKILL_BASE" />
                                                <ext:ModelField Name="BONUS_BASE" />
                                                <ext:ModelField Name="REMARK" />
                                                <ext:ModelField Name="RECORD_TIME" Type="Date"/>
                                                <ext:ModelField Name="USER_NAME" />
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
                                    <ext:Column ID="TOOLING_RFID_BARCODE" runat="server" Text="岗位编号" DataIndex="WORK_CODE"  />
                                    <ext:Column ID="TOOLING_TYPE_NAME" runat="server" Text="产线" DataIndex="EQUIP_NAME"  />
                                    <ext:Column ID="TOOLING_TYPE" runat="server" Text="定岗人数" DataIndex="USER_COUNT"  />
                                    <ext:Column ID="IS_USED" runat="server" Text="岗位名称" DataIndex="WORK_NAME" Flex="1" />
                                    <ext:Column ID="STANDARD_WAGES" runat="server" Text="标准岗位工资" DataIndex="STANDARD_WAGES" Flex="1"  Hidden="true"  />
                                    <ext:Column ID="Column1" runat="server" Text="技能工资基数" DataIndex="SKILL_BASE" Flex="1" />
                                    <ext:Column ID="Column2" runat="server" Text="奖金基数" DataIndex="BONUS_BASE" Flex="1" />
                                    <ext:Column ID="Column3" runat="server" Text="备注" DataIndex="REMARK" Flex="1" />
                                    <ext:DateColumn ID="RECORD_TIME" runat="server" Text="操作时间" DataIndex="RECORD_TIME" Flex="1" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="Column4" runat="server" Text="操作人" DataIndex="USER_NAME" Flex="1" />
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

              <ext:Window ID="winAddTooling" runat="server" Icon="MonitorAdd" Closable="true" Title="添加岗位信息"
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
                                             <ext:TextField ID="addWorkcode" runat="server" FieldLabel="岗位编号" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                             <ext:TextField ID="addEquipname" runat="server" FieldLabel="产线" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                             <ext:TextField ID="addUsercount" runat="server" FieldLabel="定岗人数" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                             <ext:TextField ID="addWorkname" runat="server" FieldLabel="岗位名称" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                             <ext:TextField ID="addStandardWages" runat="server" FieldLabel="标准岗位工资" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true"  Hidden="true" />
                                             <ext:TextField ID="addSkill" runat="server" FieldLabel="技能工资基数" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                             <ext:TextField ID="addBonusbase" runat="server" FieldLabel="奖金基数" LabelAlign="Left"
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
                Title="修改岗位信息" Width="320" Height="340" Resizable="false" Hidden="true" Modal="false"
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
                                             <ext:TextField ID="editWorkCode" runat="server" FieldLabel="岗位编号" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                             <ext:TextField ID="editEquipname" runat="server" FieldLabel="产线" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                             <ext:TextField ID="editUsercount" runat="server" FieldLabel="定岗人数" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                             <ext:TextField ID="editWorkname" runat="server" FieldLabel="岗位名称" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                             <ext:TextField ID="editStandardWages" runat="server" FieldLabel="标准岗位工资" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true"  Hidden="true" />
                                             <ext:TextField ID="editSkill" runat="server" FieldLabel="技能工资基数" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                             <ext:TextField ID="editBonusbase" runat="server" FieldLabel="奖金基数" LabelAlign="Left"
                                                ReadOnly="false" Enabled="true" />
                                             <ext:TextField ID="editremark" runat="server" FieldLabel="备注" LabelAlign="Left"
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

