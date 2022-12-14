<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CppOnErrorRecordBarcode.aspx.cs" Inherits="Plugins_Curing_Equip_CppOnErrorRecordBarcode" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>硫化异常停机首末件记录</title>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
  
    <script type="text/javascript">

        var pnlListFresh = function () {
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
                            <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                Padding="5">
                                <Items>
                                    <ext:FieldContainer ID="FieldContainer9" runat="server" Layout="HBoxLayout" FieldLabel="停机开始时间" LabelAlign="Right" >
                                        <Items>
                                            <ext:DateField ID="dStartDate" runat="server" Editable="false" AllowBlank="false" Format="yyyy-MM-dd" Margins="0 3 0 0" Width="100" LabelWidth="0" />
                                            <ext:TimeField ID="dStartTime" runat="server" Width="80" />
                                        </Items>
                                    </ext:FieldContainer>
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".33"
                                Padding="5">
                                <Items>
                                    <ext:FieldContainer ID="FieldContainer5" runat="server" Layout="HBoxLayout" FieldLabel="停机结束时间" LabelAlign="Right">
                                        <Items>
                                            <ext:DateField ID="dEndDate" runat="server" Editable="false" AllowBlank="false" Format="yyyy-MM-dd" Margins="0 3 0 0" Width="100" LabelWidth="0" />
                                            <ext:TimeField ID="dEndTime" runat="server" Width="80" />
                                        </Items>
                                    </ext:FieldContainer>
                                </Items>
                            </ext:Container>
                            <ext:Container ID="container3" runat="server" Layout="FormLayout" ColumnWidth=".25"
                                Padding="5">
                                <Items>
                                    <ext:TextField ID="txtEquipName" runat="server" FieldLabel="机台名称" LabelAlign="Right">
                                    </ext:TextField>
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:FormPanel>
                </Items>
            </ext:Panel>
            <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5 " >
                <Items>
                    <ext:GridPanel ID="pnlList" runat="server">
                        <Store>
                            <ext:Store ID="store" runat="server" PageSize="20">
                                <Proxy>
                                    <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                </Proxy>
                                <Model>
                                    <ext:Model ID="model" runat="server" IDProperty="OBJID">
                                        <Fields>
                                            <ext:ModelField Name="OBJID" />
                                            <ext:ModelField Name="EQUIP_NAME" />
                                            <ext:ModelField Name="LR" />
                                            <ext:ModelField Name="FIRST_BARCODE" />
                                            <ext:ModelField Name="FIRST_TIME"  Type="Date"/>
                                            <ext:ModelField Name="END_BARCODE" />
                                            <ext:ModelField Name="END_TIME" Type="Date"/>
                                            <ext:ModelField Name="STOP_REASON" />
                                            <ext:ModelField Name="ON_TIME" />
                                            <ext:ModelField Name="RECORD_TIME" Type="Date"/>
                                        </Fields>
                                    </ext:Model>
                                </Model>
                            </ext:Store>
                        </Store>
                        <ColumnModel ID="colModel" runat="server">
                            <Columns>
                                <ext:RowNumbererColumn ID="rowNumCol1" runat="server" Width="35" />
                                <ext:Column ID="EQUIP_NAME" runat="server" Text="机台名称" DataIndex="EQUIP_NAME" Width="120" />
                                <ext:Column ID="SHOW_NAME" runat="server" Text="左右模" DataIndex="LR" Width="120"/>
                                <ext:Column ID="Column1" runat="server" Text="首件条码" DataIndex="FIRST_BARCODE" Width="120"/>
                                <ext:DateColumn ID="DateColumn1" runat="server" Text="首件时间" DataIndex="FIRST_TIME" Width="160"  Format="yyyy-MM-dd HH:mm:ss"/>
                                <ext:Column ID="Column4" runat="server" Text="末件条码" DataIndex="END_BARCODE" Width="120"/>
                                <ext:DateColumn ID="DateColumn2" runat="server" Text="末件时间" DataIndex="END_TIME" Width="160"  Format="yyyy-MM-dd HH:mm:ss"/>
                                <ext:Column ID="Column2" runat="server" Text="停机原因" DataIndex="STOP_REASON" Width="160"/>
                                <ext:Column ID="Column3" runat="server" Text="停机时间" DataIndex="ON_TIME" Width="120"/>
                                <ext:DateColumn ID="LAST_TIME" runat="server" Text="记录时间" DataIndex="RECORD_TIME" Width="160"  Format="yyyy-MM-dd HH:mm:ss"/>
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
