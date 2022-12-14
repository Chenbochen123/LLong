<%@ Page Language="C#" AutoEventWireup="true" CodeFile="WagesEquipOnDuty.aspx.cs" Inherits="Plugins_Semis_Wages_WagesEquipOnDuty" %>

<%@ Register Assembly="Ext.Net" Namespace="Ext.Net" TagPrefix="ext" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>产线实际出勤</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript">

        //查询
        var search = function () {
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
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
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="btnSearch">
                                    <Listeners>
                                        <Click Fn="search">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator ID="ToolbarSeparator1" />
                                <ext:Button runat="server" Icon="PageExcel" Text="导出Excel" ID="btnExport">
                                    <ToolTips>
                                        <ext:ToolTip ID="ToolTip2" runat="server" Html="点击将查询结果导出到Excel中" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="$('#btnExportSubmit').click();">
                                        </Click>
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarFill ID="tfEnd" />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                    <Items>

                        <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true">
                            <Items>
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:DateField ID="begindate" runat="server" FieldLabel="开始日期" LabelAlign="Right" Editable="true">
                                        </ext:DateField>
                                    </Items>
                                </ext:Container>

                                <ext:Container ID="container4" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:DateField ID="enddate" runat="server" FieldLabel="结束日期" LabelAlign="Right" Editable="true">
                                        </ext:DateField>
                                    </Items>
                                </ext:Container>

                                <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                    Padding="5">
                                    <Items>
                                        <ext:ComboBox ID="cbxEquipname" runat="server" FieldLabel="产线" LabelAlign="Right" Editable="false">
                                        </ext:ComboBox>
                                    </Items>
                                </ext:Container>

                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25"
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

                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="pnlDetail" runat="server" Title="产线实际出勤" Height="500" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 5 5">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server" MarginsSummary="0 5 5 5">

                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="20">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server">
                                            <Fields>
                                                <ext:ModelField Name="WORK_DATE" Type="Date"/>
                                                <ext:ModelField Name="CLASS" />
                                                <ext:ModelField Name="EQUIP_NAME" />
                                                <ext:ModelField Name="REALNUM" />
                                                <ext:ModelField Name="REMARK" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>

                                </ext:Store>
                            </Store>
                            <ColumnModel ID="ColumnModelDetail" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                    <ext:DateColumn ID="DateColumn1" runat="server" Text="实际日期" DataIndex="WORK_DATE" Flex="1" Format="yyyy-MM-dd" />
                                    <ext:Column ID="TOOLING_RFID_BARCODE" runat="server" Text="班组" DataIndex="CLASS"  Flex="1"/>
                                    <ext:Column ID="TOOLING_TYPE_NAME" runat="server" Text="产线" DataIndex="EQUIP_NAME"  Flex="1"/>
                                    <ext:Column ID="TOOLING_TYPE" runat="server" Text="产线实际出勤" DataIndex="REALNUM" Flex="1" />
                                    <ext:Column ID="Column3" runat="server" Text="备注" DataIndex="REMARK" Flex="1" />
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

