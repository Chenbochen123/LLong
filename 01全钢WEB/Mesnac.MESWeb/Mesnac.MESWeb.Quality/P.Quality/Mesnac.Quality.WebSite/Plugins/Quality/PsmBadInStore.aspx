<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PsmBadInStore.aspx.cs" Inherits="Plugins_Quality_PsmBadInStore" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>次废品扫描入库记录</title>
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
                                <ext:Container ID="container1" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                        <ext:FieldContainer runat="server" FieldLabel="开始时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtBeginDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtBeginTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:ComboBox ID="cbxGrade" runat="server" FieldLabel="品级" LabelAlign="right"
                                            Editable="false">
                                            <Items>
                                                <ext:ListItem Text="次品" Value="次品">
                                                </ext:ListItem>
                                                <ext:ListItem Text="废品" Value="废品">
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
                                        <ext:FieldContainer runat="server" FieldLabel="结束时间" Layout="HBoxLayout" LabelAlign="Right">
                                            <Items>
                                                <ext:DateField ID="txtEndDate" runat="server" Flex="1" Editable="false" />
                                                <ext:TimeField ID="txtEndTime" runat="server" Width="80" Editable="true" />
                                            </Items>
                                        </ext:FieldContainer>
                                        <ext:TextField ID="txtTyreNo" runat="server" FieldLabel="条码号" MaxLength="25"
                                            LabelAlign="Right" />
                                    </Items>
                                </ext:Container>
                                <ext:Container ID="container2" runat="server" Layout="FormLayout" ColumnWidth=".3"
                                    Padding="5">
                                    <Items>
                                        <ext:TextField ID="txtMaterialName" runat="server" FieldLabel="物料规格" MaxLength="25"
                                            LabelAlign="Right" />
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:FormPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel ID="Panel2" runat="server" Region="Center" Frame="true" Layout="Fit" MarginsSummary="0 5 0 5 "
                    Title="记录">
                    <Items>
                        <ext:GridPanel ID="pnlList" runat="server">
                            <Store>
                                <ext:Store ID="store" runat="server" PageSize="10">
                                    <Proxy>
                                        <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                                    </Proxy>
                                    <Model>
                                        <ext:Model ID="model" runat="server">
                                            <Fields>
                                                <ext:ModelField Name="TYRE_NO" />
                                                <ext:ModelField Name="MATERIAL_NAME" />
                                                <ext:ModelField Name="GRADENAME" />
                                                <ext:ModelField Name="DEFECT" />
                                                <ext:ModelField Name="USER_NAME" />
                                                <ext:ModelField Name="RECORD_TIME" />
                                                <ext:ModelField Name="BPM_BEGINTIME" />
                                                <ext:ModelField Name="BPM_ENDTIME" />
                                                <ext:ModelField Name="BPM_EQUIP" />
                                                <ext:ModelField Name="BPM_CLASS" />
                                                <ext:ModelField Name="CPP_EQUIP" />
                                                <ext:ModelField Name="CPP_LR" />
                                                <ext:ModelField Name="CPP_CLASS" />
                                                <ext:ModelField Name="CPP_BEGINTIME" />
                                                <ext:ModelField Name="CPP_ENDTIME" />
                                                <ext:ModelField Name="CPP_USER" />
                                                <ext:ModelField Name="WORKER1" />
                                                <ext:ModelField Name="WORKER2" />
                                                <ext:ModelField Name="WORKER3" />
                                            </Fields>
                                        </ext:Model>
                                    </Model>
                                </ext:Store>
                            </Store>
                            <ColumnModel ID="colModel" runat="server">
                                <Columns>
                                    <ext:RowNumbererColumn runat="server"></ext:RowNumbererColumn>
                                    <ext:Column ID="TYRE_NO" runat="server" Text="硫化号" DataIndex="TYRE_NO" Width="100" />
                                    <ext:Column ID="MATERIAL_NAME" runat="server" Text="物料规格" DataIndex="MATERIAL_NAME" Width="200" />
                                    <ext:Column ID="MOLDING_SHIFT_NAME" runat="server" Text="品级" DataIndex="GRADENAME" Width="80" />
                                    <ext:Column ID="MOLDING_CLASS_NAME" runat="server" Text="病疵" DataIndex="DEFECT" Width="200" />
                                    <ext:DateColumn ID="DateColumn1" runat="server" Text="成型开始时间" DataIndex="BPM_BEGINTIME" Format="yyyy-MM-dd HH:mm:ss" Width="160" />
                                    <ext:DateColumn ID="DateColumn2" runat="server" Text="成型结束时间" DataIndex="BPM_ENDTIME" Format="yyyy-MM-dd HH:mm:ss" Width="160" />
                                    <ext:Column ID="Column1" runat="server" Text="成型机台" DataIndex="BPM_EQUIP" Width="80" />
                                    <ext:Column ID="Column2" runat="server" Text="成型班组" DataIndex="BPM_CLASS" Width="80" />
                                    <ext:Column ID="Column3" runat="server" Text="成型主机" DataIndex="WORKER1" Width="80" />
                                    <ext:Column ID="Column4" runat="server" Text="成型副机" DataIndex="WORKER2" Width="80" />
                                    <ext:Column ID="Column5" runat="server" Text="成型帮车" DataIndex="WORKER3" Width="80" />
                                    <ext:Column ID="Column6" runat="server" Text="硫化机" DataIndex="CPP_EQUIP" Width="80" />
                                    <ext:Column ID="Column7" runat="server" Text="左右模" DataIndex="CPP_LR" Width="80" />
                                    <ext:Column ID="Column8" runat="server" Text="硫化班组" DataIndex="CPP_CLASS" Width="80" />
                                    <ext:DateColumn ID="DateColumn3" runat="server" Text="硫化开始时间" DataIndex="CPP_BEGINTIME" Format="yyyy-MM-dd HH:mm:ss" Width="160" />
                                    <ext:DateColumn ID="DateColumn4" runat="server" Text="硫化结束时间" DataIndex="CPP_ENDTIME" Format="yyyy-MM-dd HH:mm:ss" Width="160" />
                                    <ext:Column ID="Column9" runat="server" Text="硫化主机手" DataIndex="CPP_USER" Width="80" />
                                    <ext:Column ID="CURING_SHIFT_NAME" runat="server" Text="入库人" DataIndex="USER_NAME" Width="80" />
                                    <ext:DateColumn ID="F_RECORD_TIME" runat="server" Text="入库时间" DataIndex="RECORD_TIME" Format="yyyy-MM-dd HH:mm:ss" Width="160" />
                                </Columns>
                            </ColumnModel>
                        </ext:GridPanel>
                    </Items>
                </ext:Panel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
