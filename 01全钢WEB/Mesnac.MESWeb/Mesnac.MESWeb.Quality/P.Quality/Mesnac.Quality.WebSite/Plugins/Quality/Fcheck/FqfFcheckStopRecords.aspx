<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FqfFcheckStopRecords.aspx.cs" Inherits="Plugins_Quality_Fcheck_FqfFcheckStopRecords" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <style type="text/css">
        .x-grid-row-collapsed .x-grid-cell
        {
            background-color: #B0FFBA !important;
        }
    </style>
    <script type="text/javascript">

        var pnlListFresh = function () {
            if (App.txtBeginDate.getValue() > App.txtEndDate.getValue()) {
                Ext.Msg.alert('操作', '开始时间不能大于结束时间！');
                return false;
            }
            else {
                //if (App.txtBeginTime.getValue() > App.txtEndTime.getValue()) {
                //    Ext.Msg.alert('操作', '开始时间不能大于结束时间！');
                //    return false;
                //}
            }
            App.store.currentPage = 1;
            App.pageToolBar.doRefresh();
            return false;
        }

        var prepareToolbar = function (grid, toolbar, rowIndex, record) {

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
                            <ext:ToolbarSeparator ID="tsMiddle" />
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
                            <ext:ToolbarSpacer runat="server" ID="tspacerEnd" />
                            <ext:ToolbarFill ID="tfEnd" />
                        </Items>
                    </ext:Toolbar>
                </TopBar>
                <Items>
                    <ext:FormPanel ID="container_top" runat="server" Layout="ColumnLayout" AutoHeight="true"
                        Collapsible="false">
                        <Items>
                            <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                Padding="5">
                                <Items>
                                    <ext:FieldContainer runat="server" FieldLabel="开始时间" Layout="HBoxLayout" LabelAlign="Left">
                                        <Items>
                                            <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                            <ext:TimeField ID="txtBeginTime" runat="server" Width="80" Editable="true" />
                                        </Items>
                                    </ext:FieldContainer>
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                Padding="5">
                                <Items>
                                    <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Left">
                                        <Items>
                                            <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                            <ext:TimeField ID="txtEndTime" runat="server" Width="80" Editable="true" />
                                        </Items>
                                    </ext:FieldContainer>
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                Padding="5">
                                <Items>
                                    <ext:TextField ID="txtEquipName" runat="server" FieldLabel="机台名称" LabelAlign="Left" ></ext:TextField>
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:FormPanel>
                </Items>
            </ext:Panel>
            <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5 "
                Title="外检停机记录">
                <Items>
                    <ext:GridPanel ID="pnlList" runat="server">
                        <Store>
                            <ext:Store ID="store" runat="server" PageSize="10">
                                <Proxy>
                                    <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                </Proxy>
                                <Model>
                                    <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                        <Fields>
                                            <ext:ModelField Name="EQUIP_NAME" />
                                            <ext:ModelField Name="STOP_REASON" />
                                            <ext:ModelField Name="START_TIME" Type="Date"/>
                                            <ext:ModelField Name="START_USER" />
                                            <ext:ModelField Name="END_TIME" Type="Date"/>
                                            <ext:ModelField Name="END_USER" />    
                                            <ext:ModelField Name="MOULD" />         
                                            <ext:ModelField Name="DUMMY1" />   
                                            <ext:ModelField Name="MATERIAL_NAME" />                                        
                                        </Fields>
                                    </ext:Model>
                                </Model>
                            </ext:Store>
                        </Store>
                        <ColumnModel ID="colModel" runat="server">
                            <Columns>
                                <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                <ext:Column ID="EQUIP_NAME" runat="server" Text="机台名称" DataIndex="EQUIP_NAME" Width="160" />
                                <ext:Column ID="Column1" runat="server" Text="左右模" DataIndex="MOULD" Width="160" />
                                <ext:Column ID="Column2" runat="server" Text="胎号" DataIndex="DUMMY1" Width="100" />
                                <ext:Column ID="Column3" runat="server" Text="物料规格" DataIndex="MATERIAL_NAME" Width="240" />
                                <ext:Column ID="STOP_REASON" runat="server" Text="外检停机原因" DataIndex="STOP_REASON" Width="200" />
                                <ext:DateColumn ID="START_TIME" runat="server" Text="锁定开始时间" DataIndex="START_TIME" Width="160" Format="yyyy-MM-dd HH:mm:ss"/>
                                <ext:Column ID="START_USER" runat="server" Text="锁定人" DataIndex="START_USER" Width="100" />
                                <ext:DateColumn ID="END_TIME" runat="server" Text="解锁开始时间" DataIndex="END_TIME" Width="160" Format="yyyy-MM-dd HH:mm:ss"/>
                                <ext:Column ID="END_USER" runat="server" Text="解锁人" DataIndex="END_USER" Width="100" />
                            </Columns>
                        </ColumnModel>
                        <BottomBar>
                            <ext:PagingToolbar ID="pageToolBar" runat="server">
                                <Items>
                                    <ext:Label ID="Label1" runat="server" Text="每页条数:" Hidden="true"/>
                                    <ext:ToolbarSpacer ID="ToolbarSpacer1" runat="server" Width="10" />
                                    <ext:ComboBox ID="ComboBox1" runat="server" Width="80" Hidden="true">
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
                                            <Select Handler="#{pnlList}.store.pageSize = parseInt(this.getValue(), 10); #{pageToolBar}.doRefresh(); return false;" />
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
