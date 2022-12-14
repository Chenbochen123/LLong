<%@ Page Language="C#" AutoEventWireup="true" CodeFile="HppMoldAlarm.aspx.cs" Inherits="Plugins_Semis_HppMoldAlarm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>先入先出处理记录</title>
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
            App.pnlList.store.reload();
            return false;
        }

        var commandcolumn_click = function (command, record) {
            commandcolumn_click_confirm(command, record);
            return false;
        };

        //区分删除操作，并进行二次确认操作
        var commandcolumn_click_confirm = function (command, record) {
            if (command.toLowerCase() == "edit") {
                Ext.Msg.confirm("提示", '您确定要解锁此条码吗？', function (btn) { commandcolumn_direct_editdefect(btn, record) });
            }
            return false;
        }; 

        var commandcolumn_direct_editdefect = function (btn, record) {
            if (btn != "yes") {
                return;
            }
            var carno = record.data.CARNO;
            App.direct.commandcolumn_direct_editdefect(carno, {
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
        <ext:ResourceManager ID="rmDefect" runat="server" />
        <ext:Viewport ID="vpDefect" runat="server" Layout="border">
            <Items>
                <ext:Panel ID="pnDefect" runat="server" Region="North">
                    <TopBar>
                        <ext:Toolbar runat="server" ID="tbDefect">
                            <Items>
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <Listeners>
                                        <Click Fn="pnlListFresh" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="tsBegin" />
                                <ext:ToolbarSeparator ID="tsEnd" />
                                <ext:Button runat="server" Icon="PageWhiteExcel" Text="导出" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                                <ext:ToolbarFill ID="tfEnd" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>
                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true"
                            Collapsible="false">
                            <Items>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txtcarno" runat="server" FieldLabel="条码号" MaxLength="25"
                                            LabelAlign="Right" />
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxtype" runat="server" FieldLabel="状态" LabelAlign="Right"
                                            Editable="false">
                                            <Items>
                                                <ext:ListItem Text="未处理" Value="0">
                                                </ext:ListItem>
                                                <ext:ListItem Text="已判级" Value="1">
                                                </ext:ListItem>
                                                <ext:ListItem Text="已解锁" Value="2">
                                                </ext:ListItem>
                                                <ext:ListItem Text="已领用" Value="3">
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
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5 ">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="50">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="CARNO">
                                            <Fields>
                                                <ext:ModelField Name="CARNO" />
                                                <ext:ModelField Name="STATE" />
                                                <ext:ModelField Name="RECORD_USER" />
                                                <ext:ModelField Name="UNLOCK_USER" />
                                                <ext:ModelField Name="RECORD_TIME" Type="Date" />
                                                <ext:ModelField Name="MASK_TIME" Type="Date" />
                                                <ext:ModelField Name="UNLOCK_TIME" Type="Date" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="YA_TIME" Type="Date" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="PASS_REASON" runat="server" Text="条码号" DataIndex="CARNO" Width="150" />
                                    <ext:Column ID="Column1" runat="server" Text="物料名称" DataIndex="MATERIAL_NAME" Width="150" />
                                    <ext:Column ID="REMARK" runat="server" Text="状态" DataIndex="STATE" Width="100" />
                                    <ext:DateColumn ID="DateColumn3" runat="server" Text="有效期" DataIndex="YA_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="USER_NAME" runat="server" Text="记录人" DataIndex="RECORD_USER" Width="100" />
                                    <ext:DateColumn ID="RECORD_TIME" runat="server" Text="记录时间" DataIndex="RECORD_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:Column ID="Column3" runat="server" Text="解锁人" DataIndex="UNLOCK_USER" Width="100" />
                                    <ext:DateColumn ID="DateColumn1" runat="server" Text="解锁时间" DataIndex="UNLOCK_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:DateColumn ID="DateColumn2" runat="server" Text="强制领料时间" DataIndex="MASK_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss" />
                                    <ext:CommandColumn ID="commandCol" runat="server" Width="100" Text="操作" Align="Center">
                                        <Commands>
                                            <ext:GridCommand Icon="TableEdit" CommandName="Edit" Text="解锁" />
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
    </form>
</body>
</html>
