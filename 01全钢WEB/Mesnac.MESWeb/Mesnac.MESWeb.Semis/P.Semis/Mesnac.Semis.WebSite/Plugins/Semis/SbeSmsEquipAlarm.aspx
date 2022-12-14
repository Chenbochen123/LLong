<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SbeSmsEquipAlarm.aspx.cs" Inherits="Plugins_Semis_SbeSmsEquipAlarm" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>设备报警采集</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />

    <script type="text/javascript">

        var pnlListFresh = function () {
            App.pageToolbar.doRefresh();
            return false;
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

                                <ext:Hidden runat="server" ID="hiddenName"></ext:Hidden>
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
                        <ext:Panel ID="pnlQuery" runat="server" AutoHeight="true">
                            <Items>
                                <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                                    <Items>
                                        <ext:Container ID="container_1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:FieldContainer runat="server" FieldLabel="开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                                    <Items>
                                                        <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                        <ext:TimeField ID="txtBeginTime" runat="server" Editable="true" />
                                                    </Items>
                                                </ext:FieldContainer></Items>
                                        </ext:Container>
                                        <ext:Container ID="container_2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                                    <Items>
                                                        <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                        <ext:TimeField ID="txtEndTime" runat="server" Editable="true" />
                                                    </Items>
                                                </ext:FieldContainer>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                 <ext:ComBoBox ID="cbxAlarm" runat="server" FieldLabel="报警名称" LabelAlign="Right" Editable="true"></ext:ComBoBox>
                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                <ext:ComboBox ID="cbxMold" runat="server" FieldLabel="工艺模块" LabelAlign="Right" OnDirectSelect="SelectChange"
                                                    Editable="false">
                                                    <Items>
                                                        <ext:ListItem Text="半制品" Value="1">
                                                        </ext:ListItem>
                                                        <ext:ListItem Text="成型" Value="2">
                                                        </ext:ListItem>
                                                    </Items>
                                                    <Triggers>
                                                        <ext:FieldTrigger Icon="Clear" Qtip="清空" />
                                                    </Triggers>
                                                    <Listeners>
                                                        <TriggerClick Handler="this.setValue('');" />
                                                    </Listeners>

                                                </ext:ComboBox>

                                            </Items>
                                        </ext:Container>
                                        <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                            Padding="5">
                                            <Items>
                                                 <ext:ComBoBox ID="cbxequip" runat="server" FieldLabel="设备名称" LabelAlign="Right" Editable="true"></ext:ComBoBox>
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:FormPanel>
                            </Items>
                        </ext:Panel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5 "
                    Title="">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="50">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                            <Fields>
                                                <ext:ModelField Name="OBJID" />
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="ALARM_NAME" />
                                                <ext:ModelField Name="ALARM_POSITION" />
                                                <ext:ModelField Name="ALARM_TIME" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:Column ID="DefectCode" runat="server" Text="主键" DataIndex="OBJID" Width="60" Visible="false" />
                                    <ext:Column ID="Column1" runat="server" Text="设备名称" DataIndex="EQUIP_NAME" Width="120" />
                                    <ext:Column ID="Column10" runat="server" Text="报警名称" DataIndex="ALARM_NAME" Width="250" />
                                    <ext:Column ID="Column11" runat="server" Text="报警位置" DataIndex="ALARM_POSITION" Width="250" />
                                    <ext:DateColumn ID="Column2" runat="server" Text="报警时间" DataIndex="ALARM_TIME" Width="150" Format="yyyy-MM-dd HH:mm:ss"  />
                                </Columns>
                            </ColumnModel>
                            <BottomBar>
                                <ext:PagingToolbar ID="pageToolbar" runat="server">
                                    <Items>
                                        <ext:Label ID="Label2" runat="server" Text="每页条数:" />
                                        <ext:ToolbarSpacer ID="ToolbarSpacer2" runat="server" Width="10" />
                                        <ext:ComboBox ID="ComboBox2" runat="server" Width="80">
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
                                                <Select Handler="#{pnlList}.store.pageSize = parseInt(this.getValue(), 10); #{pageToolbar}.doRefresh(); return false;" />
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
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
