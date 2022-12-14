<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CppDxStandard.aspx.cs" Inherits="Plugins_Curing_CppDxStandard" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>定型压力报警停机维护</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell {
            background-color: #B0FFBA !important;
        }
    </style>
    <script type="text/javascript">
        var pnlListFresh = function () {
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
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

        //点击修改按钮
        var commandcolumn_direct_edit = function (record) {
            var ObjId = record.data.OBJID;
            var min = record.data.MIN;
            var includemin = record.data.INCLUDEMIN1;
            var max = record.data.MAX;
            var includemax = record.data.INCLUDEMAX1;
            App.direct.commandcolumn_direct_edit(ObjId,min,includemin,max,includemax, {
                success: function (result) {
                },

                failure: function (errorMsg) {
                    Ext.Msg.alert('操作', errorMsg);
                }
            });
        }
    </script>
    
    <style type="text/css">
        .x-grid-row-collapsedYellow .x-grid-cell {
            background-color: #ffd800 !important;
        }

        .x-grid-row-collapsedRed .x-grid-cell {
            background-color: #ff0000 !important;
        }
    </style>
</head>
<body>    
    <form id="form1" runat="server">
        <ext:Hidden ID="hidden_update_objId" runat="server"></ext:Hidden>
        <asp:Button ID="btnExportSubmit" Style="display: none" runat="server" Text="Button"
        OnClick="btnExportSubmit_Click" />
        <ext:ResourceManager ID="rmQCRecord" runat="server" />
        <ext:Viewport ID="vpQCRecord" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnMEquipControl" runat="server" Region="North" Height="30">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbMEquipControl">
                            <Items>
                                <ext:ToolbarSeparator ID="ctl" />
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <Listeners>
                                        <Click Fn="pnlListFresh" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="ct3" />
                                <ext:Button runat="server" Icon="PageExcel" Text="导出" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="tsBegin" />
                                <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                                <ext:ToolbarFill ID="tfEnd" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                     <%--   <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            <Items>

                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="出库开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:FieldContainer runat="server" FieldLabel="出库结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        </Items>
                                </ext:Container>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtname" runat="server" FieldLabel="模具名称" LabelAlign="Right" Editable="true" >
                                        </ext:TextField>
                                        <ext:TextField ID="txtcode" runat="server" FieldLabel="模具编号" LabelAlign="Right" Editable="true" >
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtsize" runat="server" FieldLabel="规格" LabelAlign="Right" Editable="true" >
                                        </ext:TextField>
                                        <ext:TextField ID="txthuawen" runat="server" FieldLabel="花纹" LabelAlign="Right" Editable="true" >
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txttotalnum" runat="server" FieldLabel="累计次数" LabelAlign="Right" Editable="true" EmptyText="累计次数>=该值">
                                        </ext:TextField>
                                    </Items>
                                </ext:Container>
                            </Items>
                            <Listeners>
                                <ValidityChange Handler="#{btnSearch}.setDisabled(!valid);" />
                            </Listeners>
                        </ext:FormPanel>--%>
                    </Items>
                </ext:Panel>

                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5" Title="">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="100">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">                                            
                                            <Fields>                                                
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="ITEM" />
                                                <ext:ModelField Name="MIN" />
                                                <ext:ModelField Name="INCLUDEMIN1" />
                                                <ext:ModelField Name="MAX" />
                                                <ext:ModelField Name="INCLUDEMAX1" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">                              
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol" runat="server" Width="35" />
                                    <%--<ext:Column ID="OBJID" runat="server" Text="编号" DataIndex="OBJID" Width="100" Hidden="TRUE" />--%>
                                    <ext:Column ID="BLADDER_CODE" runat="server" Text="项目名称" Selectable="true" DataIndex="ITEM" Width="130" />
                                    <ext:Column ID="BUY_TYPE_NAME" runat="server" Text="最小值" Selectable="true" DataIndex="MIN" Width="80" />
                                    <ext:Column ID="TYPE_NEW_NAME" runat="server" Text="包含最小" DataIndex="INCLUDEMIN1" Width="80" />
                                    <ext:Column ID="SPEC_NAME" runat="server" Text="最大值" DataIndex="MAX" Width="80" />
                                    <ext:Column ID="BLADDER_SPEC" runat="server" Text="包含最大" DataIndex="INCLUDEMAX1" Width="80" />
                                    <ext:CommandColumn ID="commandCol" runat="server" Width="70" Text="操作" Align="Center">
                                        <Commands>
                                            <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="修改">
                                                <ToolTip Text="修改本条数据" />
                                            </ext:GridCommand>
                                            <ext:CommandSeparator />
                                        </Commands>
                                        <Listeners>
                                            <Command Handler="return commandcolumn_click(command, record);" />
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
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>
        <ext:Window ID="ModifyConfigWin" runat="server" Closable="false" Icon="Add" Title="修改信息"
            Width="400" Height="200" Hidden="true" Modal="false">
            <Items>
                <ext:FormPanel ID="FormPanel1" runat="server" BodyPadding="5">
                    <FieldDefaults>
                        <CustomConfig>
                            <ext:ConfigItem Name="LabelWidth" Value="80" Mode="Raw" />
                            <ext:ConfigItem Name="PreserveIndicatorIcon" Value="true" Mode="Raw" />
                        </CustomConfig>
                    </FieldDefaults>
                    <Items>
                        <ext:Container ID="Container14" runat="server" AutoHeight="true">
                            <Items>
                                <ext:FieldSet ID="FieldSet4" runat="server" Title="" Layout="AnchorLayout" DefaultAnchor="100%"
                                    Padding="5">
                                    <Items>
                                        <ext:Container ID="Container12" runat="server" Layout="HBoxLayout"  >
                                            <Items>
                                                <ext:TextField ID="txtmin" runat="server" FieldLabel="最小值" LabelAlign="Right" Editable="true">
                                                </ext:TextField>
                                            </Items>
                                        </ext:Container>

                                        
                                        <ext:Container ID="Container1" runat="server" Layout="HBoxLayout" >
                                            <Items>
                                                <ext:ComboBox ID="cbxmin" runat="server" FieldLabel="包含最小" LabelAlign="Right"
                                                    Editable="false">
                                                    <Items>
                                                        <ext:ListItem Text="是" Value="是">
                                                        </ext:ListItem>
                                                        <ext:ListItem Text="否" Value="否">
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
                                        <ext:Container ID="Container2" runat="server" Layout="HBoxLayout"  >
                                            <Items>
                                                <ext:TextField ID="txtmax" runat="server" FieldLabel="最大值" LabelAlign="Right" Editable="true">
                                                </ext:TextField>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="Container3" runat="server" Layout="HBoxLayout"  >
                                            <Items>
                                                <ext:ComboBox ID="cbxmax" runat="server" FieldLabel="包含最大" LabelAlign="Right"
                                                    Editable="false">
                                                    <Items>
                                                        <ext:ListItem Text="是" Value="是">
                                                        </ext:ListItem>
                                                        <ext:ListItem Text="否" Value="否">
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
                                    </Items>
                                </ext:FieldSet>
                            </Items>
                        </ext:Container>
                    </Items>
                    <Listeners>
                        <ValidityChange Handler="#{btnModifySave}.setDisabled(!valid);" />
                    </Listeners>
                </ext:FormPanel>
            </Items>
            <Buttons>
                <ext:Button ID="btnModifySave" runat="server" Text="确定" Icon="Accept" Disabled="true">
                    <DirectEvents>
                        <Click OnEvent="BtnModifySave_Click">
                            <EventMask ShowMask="true" Msg="Saving..." MinDelay="50" />
                        </Click>
                    </DirectEvents>
                </ext:Button>
                <ext:Button ID="btnModifyCancel" runat="server" Text="取消" Icon="Cancel">
                    <DirectEvents>
                        <Click OnEvent="BtnModifyCancel_Click">
                        </Click>
                    </DirectEvents>
                </ext:Button>
            </Buttons>
            <Listeners>
                <Show Handler="for(var i=0;i<#{Viewport1}.items.length;i++){#{Viewport1}.getComponent(i).disable(true);}" />
                <Hide Handler="for(var i=0;i<#{Viewport1}.items.length;i++){#{Viewport1}.getComponent(i).enable(true);}" />
            </Listeners>
        </ext:Window>
    </form>
</body>
</html>
